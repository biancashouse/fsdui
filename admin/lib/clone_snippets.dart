import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui_admin/bh-apps.firebase_options.dart';

/// Deep equality for Firestore document data.
/// Handles nested Maps, Lists, and Firestore types (Timestamp, GeoPoint, etc.)
/// which do not implement toJson() and would crash jsonEncode.
bool _fsEqual(dynamic a, dynamic b) {
  if (a == b) return true;
  if (a is Map && b is Map) {
    if (a.length != b.length) return false;
    for (final key in a.keys) {
      if (!b.containsKey(key) || !_fsEqual(a[key], b[key])) return false;
    }
    return true;
  }
  if (a is List && b is List) {
    if (a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (!_fsEqual(a[i], b[i])) return false;
    }
    return true;
  }
  return false;
}

// main when using the flutter_content package
Future<void> main({bool useEmulator = false}) async {
  WidgetsFlutterBinding.ensureInitialized();

  fsdui.appName = 'clone-content';

  var fbOptions = BH_APPS_DefaultFirebaseOptions.currentPlatform;
  var modelRepo = FireStoreModelRepository(fbOptions);
  await modelRepo.possiblyInitFireStoreRelatedAPIs(useEmulator: false);
  AppInfoModel? appInfo = await modelRepo.getAppInfo();

  // Deep Copy /apps/* to /flutter-content/*
  // Firestore does not provide a built-in method for deep copying documents
  // and their subcollections directly...

  // Retrieve the data of the source document you wish to copy.
  DocumentReference sourceDocRef = FirebaseFirestore.instance
      .collection('flutter-content')
      .doc('biancashouse');
  DocumentSnapshot sourceDocSnap = await sourceDocRef.get();

  // Set the data of the new document /flutter-content/$appName
  DocumentReference newDocRef = FirebaseFirestore.instance
      .collection('flutter-content')
      .doc('biancashouse.com');

  DocumentSnapshot existingNewDoc = await newDocRef.get();

  if (!existingNewDoc.exists ||
      !_fsEqual(existingNewDoc.data(), sourceDocSnap.data())) {
    await newDocRef.set(sourceDocSnap.data());
    print('created target doc');
  } else {
    print('updating target doc');
  }

  // Iterate through the snippets collection of the source document and recursively
  // copy its documents to the target collection.
  // Get documents from the source subcollection
  QuerySnapshot snippets = await sourceDocRef.collection('snippets').get();
  for (QueryDocumentSnapshot snippetDoc in snippets.docs) {
    print('snippet: ${snippetDoc.id}');
    if (snippetDoc.id == 'we-create') {
      final snippetData = snippetDoc.data() as Map<String,dynamic>;
      final publishedVersionId = snippetData['publishedVersionId'];
      try {
        QuerySnapshot versions = await sourceDocRef
            .collection('snippets/${snippetDoc.id}/versions')
            .get();

        for (QueryDocumentSnapshot versionDoc in versions.docs) {
          if (versionDoc.id == publishedVersionId) {
            DocumentReference destVersionRef = newDocRef
                .collection('snippets')
                .doc(snippetDoc.id)
                .collection('versions')
                .doc(versionDoc.id);

            DocumentSnapshot existingVersion = await destVersionRef.get();
            if (!existingVersion.exists) {
              await destVersionRef.set(
                  versionDoc.data() as Map<String, dynamic>);
              //print('  copied version ${versionDoc.id}');
            } else {
              print('  version ${versionDoc.id} already exists, skipped');
            }
          }
        }

        DocumentReference destSnippetRef = newDocRef
            .collection('snippets')
            .doc(snippetDoc.id);

        DocumentSnapshot existingSnippet = await destSnippetRef.get();

        if (!existingSnippet.exists ||
            !_fsEqual(existingSnippet.data(), snippetDoc.data())) {
          await destSnippetRef.set(snippetDoc.data() as Map<String, dynamic>);
          print('  copied snippet doc');
        } else {
          print('  snippet doc unchanged, skipped');
        }
      } catch (e) {
        print('  ERROR processing snippet ${snippetDoc.id}: $e');
      }
    }
  }

  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Firestore Admin.',
      home: Material(
        child: Scaffold(
          appBar: AppBar(title: Text('Firestore Admin')),
          body: Padding(
            padding: const EdgeInsets.all(28.0),
            child: Text(appInfo.toString()),
          ),
        ),
      ),
    ),
  );
}

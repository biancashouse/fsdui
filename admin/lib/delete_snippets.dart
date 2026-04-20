import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';
import 'package:fsdui_admin/bh-apps.firebase_options.dart';

// Run with:
//   flutter run -t lib/delete_target.dart
//
// Deletes /flutter-content/biancashouse.com and ALL nested subcollections:
//   flutter-content/biancashouse.com
//     snippets/{snippetId}
//       versions/{versionId}

const _targetDoc = 'biancashouse.com';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var fbOptions = BH_APPS_DefaultFirebaseOptions.currentPlatform;
  var modelRepo = FireStoreModelRepository(fbOptions);
  await modelRepo.possiblyInitFireStoreRelatedAPIs(useEmulator: false);

  final db = FirebaseFirestore.instance;
  final rootRef = db.collection('flutter-content').doc(_targetDoc);

  final rootSnap = await rootRef.get();
  if (!rootSnap.exists) {
    print('Document flutter-content/$_targetDoc does not exist — nothing to delete.');
    _runApp('Nothing to delete.');
    return;
  }

  int deletedDocs = 0;

  // 1. Delete all versions inside each snippet, then the snippet itself.
  final snippets = await rootRef.collection('snippets').get();
  for (final snippetDoc in snippets.docs) {
    print('snippet: ${snippetDoc.id}');
    try {
      final versions = await snippetDoc.reference.collection('versions').get();
      // Delete versions in batches of 500 (Firestore batch limit).
      for (int i = 0; i < versions.docs.length; i += 500) {
        final batch = db.batch();
        final slice = versions.docs.skip(i).take(500);
        for (final v in slice) {
          batch.delete(v.reference);
          print('  deleting version ${v.id}');
        }
        await batch.commit();
        deletedDocs += slice.length;
      }
      await snippetDoc.reference.delete();
      print('  deleted snippet ${snippetDoc.id}');
      deletedDocs++;
    } catch (e) {
      print('  ERROR deleting snippet ${snippetDoc.id}: $e');
    }
  }

  // 2. Delete the root document last.
  await rootRef.delete();
  deletedDocs++;
  print('Deleted flutter-content/$_targetDoc  ($deletedDocs documents total).');

  _runApp('Deleted flutter-content/$_targetDoc\n$deletedDocs documents removed.');
}

void _runApp(String message) {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
      title: 'Firestore Admin — Delete',
      home: Scaffold(
        appBar: AppBar(title: const Text('Firestore Admin — Delete')),
        body: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Text(message, style: const TextStyle(fontSize: 18)),
        ),
      ),
    ),
  );
}

import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';

const kSource = 'biancashouse';
const kTarget = 'biancashouse.com';

class MigrationService {
  final _logLines = <String>[];
  final _logController = StreamController<String>.broadcast();

  Stream<String> get logStream => _logController.stream;

  List<String> get logLines => List.unmodifiable(_logLines);

  bool _running = false;

  bool get isRunning => _running;

  void _log(String message) {
    _logLines.add(message);
    _logController.add(message);
  }

  // ---------------------------------------------------------------------------
  // Entry point
  // ---------------------------------------------------------------------------

  Future<void> run() async {
    if (_running) return;
    _running = true;
    _logLines.clear();

    try {
      final db = FirebaseFirestore.instance;
      final sourceRef = db.collection('/flutter-content').doc(kSource);
      final targetRef = db.collection('/flutter-content').doc(kTarget);

      // 1. Copy top-level AppInfo document
      _log('Reading AppInfo from /flutter-content/$kSource ...');
      final appInfoDoc = await sourceRef.get();
      if (!appInfoDoc.exists) {
        _log('ERROR: /flutter-content/$kSource does not exist. Aborting.');
        return;
      }
      final appInfoData = Map<String, dynamic>.from(appInfoDoc.data()!);

      final snippetNames =
          (appInfoData['snippetNames'] as List?)?.cast<String>() ?? [];
      _log('Found ${snippetNames.length} snippets.');

      _log('Writing AppInfo to /flutter-content/$kTarget ...');
      await targetRef.set(appInfoData);

      // 2. Process each snippet
      int snippetsDone = 0;
      int versionsDone = 0;
      int skipped = 0;

      for (final snippetName in snippetNames) {
        _log('\n[$snippetName]');

        // if (snippetName != 'we-create') continue;

        final sourceSnippetRef = sourceRef
            .collection('snippets')
            .doc(snippetName);
        final targetSnippetRef = targetRef
            .collection('snippets')
            .doc(snippetName);

        // Read snippet info metadata
        final snippetInfoDoc = await sourceSnippetRef.get();
        if (!snippetInfoDoc.exists) {
          _log('  WARNING: snippet info missing — skipping.');
          skipped++;
          continue;
        }

        // Copy snippet info unchanged (version IDs, autoPublish, etc.)
        final snippetData = snippetInfoDoc.data() as Map<String, dynamic>;
        await targetSnippetRef.set(snippetData);

        final publishedVersionId = snippetData['publishedVersionId'];

        // Read every version doc from the versions subcollection
        final versionsSnap = await sourceSnippetRef
            .collection('versions')
            .get();
        _log('  ${versionsSnap.docs.length} version(s)');

        for (final versionDoc in versionsSnap.docs) {
          final versionId = versionDoc.id;
          if (versionId == publishedVersionId) {
            try {
              final raw = Map<String, dynamic>.from(versionDoc.data());

              final transformed = _transformVersionDoc(raw, snippetName);

              await targetSnippetRef
                  .collection('versions')
                  .doc(versionId)
                  .set(transformed);

              _log('  version $versionId — ok');
              versionsDone++;
            } catch (e) {
              print(e);
            }
          }
        }

        snippetsDone++;
      }

      _log(
        '\nDone. $snippetsDone snippet(s), $versionsDone version(s) migrated.'
        '${skipped > 0 ? ' $skipped skipped.' : ''}',
      );
    } catch (e, stack) {
      _log('ERROR: $e');
      _log(stack.toString());
    } finally {
      _running = false;
    }
  }

  // ---------------------------------------------------------------------------
  // Transformation
  // ---------------------------------------------------------------------------

  /// Entry point for transforming one version document.
  ///
  /// Old format: root is always a SnippetRootNode (SC) that wraps the real
  /// content in its `child`.  New format: the real root carries `name`/`tags`
  /// directly.
  Map<String, dynamic> _transformVersionDoc(
    Map<String, dynamic> doc,
    String snippetName,
  ) {
    if (doc['DK:sc'] == 'SnippetRootNode' || doc['sc'] == 'SnippetRootNode') {
      final rawTags = doc['tags'];
      final child = Map<String, dynamic>.from(doc['child'] as Map);

      // Recursively rename deprecated fields in the promoted subtree first,
      // so that a PollNode / TabBarNode / etc. at the root gets its own
      // type-specific name moved to the right field before we stamp the
      // snippet name onto `name`.
      final transformed = _transformNode(child);

      // Stamp snippet name onto the new root.
      transformed['name'] = snippetName;

      // Convert tags: was a plain String in old format, now List<String>?.
      if (rawTags is String && rawTags.isNotEmpty) {
        transformed['tags'] = [rawTags];
      } else if (rawTags is List && rawTags.isNotEmpty) {
        transformed['tags'] = List<String>.from(rawTags);
      }
      // Empty string / null → omit (leave as null).

      return transformed;
    }

    // Document was already in new format (no SnippetRootNode wrapper).
    return _transformNode(doc);
  }

  /// Recursively walks the node tree and applies all field renames.
  Map<String, dynamic> _transformNode(Map<String, dynamic> node) {
    _renameNodeFields(node);

    if (node['child'] is Map) {
      node['child'] = _transformNode(
        Map<String, dynamic>.from(node['child'] as Map),
      );
    }

    if (node['children'] is List) {
      node['children'] = (node['children'] as List).map((item) {
        if (item is Map) {
          return _transformNode(Map<String, dynamic>.from(item));
        }
        return item;
      }).toList();
    }

    return node;
  }

  /// Applies the per-node-type field renames that resulted from moving
  /// type-specific `name` properties to dedicated fields.
  void _renameNodeFields(Map<String, dynamic> node) {
    // PollNode: name -> pollName
    if (node['DK:mc'] == 'PollNode') {
      _moveField(node, from: 'name', to: 'pollName');
      return;
    }

    // FileNode: name -> fileName
    if (node['DK:cl'] == 'FileNode') {
      _moveField(node, from: 'name', to: 'fileName');
      return;
    }

    // TabBarNode: name -> tabBarName
    if (node['DK:mc'] == 'TabBarNode') {
      _moveField(node, from: 'name', to: 'tabBarName');
      return;
    }

    // GoogleDriveIFrameNode: name -> frameName
    if (node['DK:cl'] == 'GoogleDriveIFrameNode') {
      _moveField(node, from: 'name', to: 'frameName');
      return;
    }
  }

  /// Moves [from] → [to] only when [from] is present and [to] is absent,
  /// so that running the migration twice is idempotent.
  void _moveField(
    Map<String, dynamic> node, {
    required String from,
    required String to,
  }) {
    if (node.containsKey(from) && !node.containsKey(to)) {
      final value = node.remove(from);
      if (value != null) node[to] = value;
    }
  }
}

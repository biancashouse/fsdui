import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'bh-apps.firebase_options.dart';
import 'migration_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: BH_APPS_DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AdminApp());
}

class AdminApp extends StatelessWidget {
  const AdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'fsdui Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: const MigrationPage(),
    );
  }
}

// ---------------------------------------------------------------------------

class MigrationPage extends StatefulWidget {
  const MigrationPage({super.key});

  @override
  State<MigrationPage> createState() => _MigrationPageState();
}

class _MigrationPageState extends State<MigrationPage> {
  final _service = MigrationService();
  final _scrollController = ScrollController();
  final _logLines = <String>[];
  bool _done = false;
  StreamSubscription<String>? _logSub;

  @override
  void dispose() {
    _logSub?.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _runMigration() async {
    await _logSub?.cancel();
    setState(() {
      _logLines.clear();
      _done = false;
    });

    _logSub = _service.logStream.listen((line) {
      setState(() => _logLines.add(line));
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 150),
            curve: Curves.easeOut,
          );
        }
      });
    });

    await _service.run();

    setState(() => _done = true);
  }

  @override
  Widget build(BuildContext context) {
    final running = _service.isRunning;
    final hasLog = _logLines.isNotEmpty;

    return Scaffold(
      appBar: AppBar(title: const Text('fsdui Migration Tool')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Info card
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Source → Target',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '/flutter-content/$kSource  →  /flutter-content/$kTarget',
                      style: const TextStyle(fontFamily: 'monospace'),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Transforms applied to every snippet version:',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      '  • Remove SnippetRootNode wrapper; promote child to root with name/tags\n'
                      '  • PollNode.name              → pollName\n'
                      '  • FileNode.name              → fileName\n'
                      '  • TabBarNode.name            → tabBarName\n'
                      '  • GoogleDriveIFrameNode.name → frameName',
                      style: TextStyle(fontFamily: 'monospace', fontSize: 12),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Run button
            ElevatedButton.icon(
              onPressed: running ? null : _runMigration,
              icon: running
                  ? const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.play_arrow),
              label: Text(running
                  ? 'Running…'
                  : _done
                      ? 'Run Again'
                      : 'Run Migration'),
            ),
            const SizedBox(height: 16),

            // Log output
            if (hasLog)
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: _logLines.length,
                    itemBuilder: (context, i) {
                      final line = _logLines[i];
                      final isError = line.startsWith('ERROR');
                      final isWarning = line.startsWith('WARNING') ||
                          line.startsWith('  WARNING');
                      final isDone = line.startsWith('\nDone') ||
                          line.startsWith('Done');
                      return Text(
                        line,
                        style: TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 12,
                          color: isError
                              ? Colors.red[300]
                              : isWarning
                                  ? Colors.orange[300]
                                  : isDone
                                      ? Colors.green[300]
                                      : Colors.grey[300],
                        ),
                      );
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
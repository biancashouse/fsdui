import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fsdui/fsdui.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('hydrated_bloc demo'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign Out',
            onPressed: () =>
                context.read<AuthBloc>().add(const SignOutRequested()),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ── Auth state card ────────────────────────────────────────────
          BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              final user = authState.user;
              return _SectionCard(
                icon: Icons.person_outline,
                title: 'AuthBloc state (persisted)',
                color: colorScheme.primaryContainer,
                onColor: colorScheme.onPrimaryContainer,
                children: [
                  _StateRow(label: 'Auth status', value: user.status.name),
                  _StateRow(label: 'Email', value: user.email),
                  _StateRow(
                    label: 'appDescription',
                    value: user.appDescription.isEmpty
                        ? '(fetching…)'
                        : user.appDescription,
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 16),

          // ── App BLoC card ──────────────────────────────────────────────
          BlocBuilder<CAPIBloC, CAPIState>(
            builder: (context, appState) {
              return _SectionCard(
                icon: Icons.storage_outlined,
                title: 'AppBloc state (persisted)',
                color: colorScheme.secondaryContainer,
                onColor: colorScheme.onSecondaryContainer,
                children: [
                  Row(
                    children: [
                      Icon(Icons.add),
                      const SizedBox(width: 12),
                      const Text('blah'),
                    ],
                  ),
                ],
              );
            },
          ),

          const SizedBox(height: 16),

          // ── How-it-works info ──────────────────────────────────────────
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: colorScheme.tertiary),
                      const SizedBox(width: 8),
                      Text(
                        'How hydrated_bloc works',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              color: colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const _BulletPoint(
                    'HydratedBloc extends Bloc and adds fromJson / toJson.',
                  ),
                  const _BulletPoint(
                    'On every state change toJson writes state to disk.',
                  ),
                  const _BulletPoint(
                    'On startup fromJson rehydrates the last persisted state.',
                  ),
                  const _BulletPoint(
                    'Transient fields (isLoading, errorMessage) are excluded '
                    'from toJson so they always reset to defaults.',
                  ),
                  const _BulletPoint(
                    'Freezed provides immutable copyWith + JSON codegen.',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Helper widgets ─────────────────────────────────────────────────────────

class _SectionCard extends StatelessWidget {
  const _SectionCard({
    required this.icon,
    required this.title,
    required this.children,
    required this.color,
    required this.onColor,
  });

  final IconData icon;
  final String title;
  final List<Widget> children;
  final Color color;
  final Color onColor;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: onColor),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: onColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }
}

class _StateRow extends StatelessWidget {
  const _StateRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 130,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}

// class _EditableMessageRow extends StatelessWidget {
//   const _EditableMessageRow({required this.message});
//
//   final String message;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 6),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(
//             width: 130,
//             child: Text(
//               'Message:',
//               style: TextStyle(fontWeight: FontWeight.w600),
//             ),
//           ),
//           Expanded(child: Text(message)),
//           GestureDetector(
//             onTap: () {
//               final bloc = context.read<AppBloc>();
//               showDialog<void>(
//                 context: context,
//                 builder: (_) => _MessageEditDialog(
//                   initialMessage: message,
//                   onSave: (text) => bloc.add(MessageUpdated(text)),
//                 ),
//               );
//             },
//             child: const Icon(Icons.edit_outlined, size: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }

class _MessageEditDialog extends StatefulWidget {
  const _MessageEditDialog({
    required this.initialMessage,
    required this.onSave,
  });

  final String initialMessage;
  final ValueChanged<String> onSave;

  @override
  State<_MessageEditDialog> createState() => _MessageEditDialogState();
}

class _MessageEditDialogState extends State<_MessageEditDialog> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialMessage);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit message'),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: const InputDecoration(border: OutlineInputBorder()),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () {
            widget.onSave(_controller.text);
            Navigator.of(context).pop();
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

class _BulletPoint extends StatelessWidget {
  const _BulletPoint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';

class LoginScreenPasswordless extends StatefulWidget {
  final String gcrServerUrl;
  final ValueChanged<String> onSignedInF;

  const LoginScreenPasswordless({
    required this.gcrServerUrl,
    required this.onSignedInF,
    super.key,
  });

  @override
  State<LoginScreenPasswordless> createState() =>
      _LoginScreenPasswordlessState();
}

class _LoginScreenPasswordlessState extends State<LoginScreenPasswordless> {
  final _formKey = GlobalKey<FormState>();
  final _eaController = TextEditingController();

  @override
  void dispose() {
    _eaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.verified && state.ea != null) {
          fsdui.localStorage.write('vea', state.ea!);
          widget.onSignedInF(state.ea!);
          fsdui.dismiss("passwordless-stepper");
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: state.token == null
                    ? _buildStep1(context, colorScheme, state)
                    : _buildStep2(colorScheme, state),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStep1(
    BuildContext context,
    ColorScheme colorScheme,
    AuthState state,
  ) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.lock_outline_rounded, size: 56, color: colorScheme.primary),
          const SizedBox(height: 16),
          Text(
            'Passwordless sign-in — we\'ll email you a verify button',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: _eaController,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            autofocus: true,
            validator: (v) => (v?.isEmpty ?? true) ? 'Enter an email' : null,
            onFieldSubmitted: (_) => _submit(context),
          ),
          const SizedBox(height: 16),
          if (state.errorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                state.errorMessage!,
                style: TextStyle(color: colorScheme.onErrorContainer),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
          ],
          FilledButton(
            onPressed: state.isLoading ? null : () => _submit(context),
            child: state.isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Send verification email'),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2(ColorScheme colorScheme, AuthState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(Icons.mark_email_unread_outlined, size: 56, color: colorScheme.primary),
        const SizedBox(height: 16),
        Text(
          'Check your inbox',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: colorScheme.onSurface,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          'We sent a verification email to ${state.ea}.\nTap the button in that email and you\'ll be signed in automatically.',
          textAlign: TextAlign.center,
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 32),
        const Center(child: CircularProgressIndicator()),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            context.read<AuthBloc>().add(const SignOutRequested());
          },
          child: const Text('Use a different email'),
        ),
      ],
    );
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState?.validate() ?? false) {
      final ea = _eaController.text.trim();
      if (!fsdui.emailIsValid(ea)) return;
      if (fsdui.localStorage.read('vea') == ea) {
        fsdui.dismiss("passwordless-stepper");
        return;
      }
      context.read<AuthBloc>().add(
        GenerateTokenAndSendConfirmationEmail(
          ea: ea,
          gcrServerUrl: widget.gcrServerUrl,
          appName: fsdui.appName,
        ),
      );
    }
  }
}

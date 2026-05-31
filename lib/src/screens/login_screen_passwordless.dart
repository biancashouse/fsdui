import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  final eaController = TextEditingController(text: '');

  @override
  void dispose() {
    eaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(32),
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 400),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // ── Header ──────────────────────────────────────────
                      Icon(
                        Icons.lock_outline_rounded,
                        size: 56,
                        color: colorScheme.primary,
                      ),
                      const SizedBox(height: 16),
                      // Text(
                      //   fsdui.appName,
                      //   style: Theme.of(context).textTheme.headlineSmall
                      //       ?.copyWith(fontWeight: FontWeight.bold),
                      //   textAlign: TextAlign.center,
                      // ),
                      // const SizedBox(height: 8),
                      Text(
                        'Password-less Sign in: we\'ll send you a verification email',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),

                      // ── Email ────────────────────────────────────────────
                      TextFormField(
                        controller: eaController,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (v) =>
                            (v?.isEmpty ?? true) ? 'Enter an email' : null,
                      ),
                      const SizedBox(height: 16),

                      // ── Error ────────────────────────────────────────────
                      if (state.errorMessage != null) ...[
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            state.errorMessage!,
                            style: TextStyle(
                              color: colorScheme.onErrorContainer,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],

                      // ── Submit ───────────────────────────────────────────
                      FilledButton(
                        onPressed: state.isLoading
                            ? null
                            : () => _submit(context),
                        child: state.isLoading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text('Sign In'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // void _submit(BuildContext context) {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     context.read<AuthBloc>().add(
  //       PasswordlessSignInRequested(ea: eaController.text.trim()),
  //     );
  //   }
  // }

  bool _userHasAlreadyConfirmed() {
    return fsdui.localStorage.read('vea') == ea;
  }

  Future<void> _submit(BuildContext context) async {
    if (_formKey.currentState?.validate() ?? false) {
      if (fsdui.emailIsValid(eaController.text)) {
        if (_userHasAlreadyConfirmed()) {
          _showAlreadySignInToast();
          fsdui.dismiss("passwordless-stepper");
          return;
        }
        setState(() => _loading = true);
        final String? token =
            await PasswordlessStepper.cloudRunCreateTokenAndEmailVerificationLinkToUser(
              gcrServerUrl: widget.gcrServerUrl,
              userEa: eaController.text,
            );
        if (mounted) setState(() => _loading = false);
        if (token != null) {
          widget.parentState.setEaAndToken(
            eaController.text,
            token,
          );
        }
      }
    }
  }

  void _showAlreadySignInToast() {
    fsdui.showToastOverlay(
      removeAfterMs: 5000,
      calloutConfig: CalloutConfig(
        cId: "already-signed-in",
        gravity: Alignment.topCenter,
        decorationFillColors: ColorOrGradient.color(Colors.yellow),
        initialCalloutW: fsdui.scrW * .8,
        initialCalloutH: 40,
      ),
      calloutContent: Padding(
        padding: const EdgeInsets.all(10),
        child: fsdui.coloredText(
          'You are already signed in on this device.',
          color: Colors.blueAccent,
        ),
      ),
    );
  }
}

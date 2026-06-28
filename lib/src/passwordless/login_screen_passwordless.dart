import 'package:flutter/material.dart';
import 'package:fsdui/fsdui.dart';

import '../algc/model/m/string_encoder_decoder.dart';

class LoginScreenPasswordless extends StatefulWidget {
  // final ValueChanged<String> onSignedInF;

  const LoginScreenPasswordless({super.key});

  @override
  State<LoginScreenPasswordless> createState() =>
      _LoginScreenPasswordlessState();
}

class _LoginScreenPasswordlessState extends State<LoginScreenPasswordless>
    with StringEncoderDecoder {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _eaController;
  final _eaFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // autofocus: true is ignored inside overlays — request focus explicitly
    // after the overlay's focus scope is active.
    //
    // autofocus: true is silently ignored inside overlays because the overlay's FocusScope isn't the active one when Flutter
    //   processes the autofocus request on first build. The fix is a FocusNode + addPostFrameCallback — runs after the frame is fully
    //   laid out and the overlay's scope is active.

    if (fsdui.capiBloc.state.ea != null) {
      _eaController = TextEditingController(text: fsdui.capiBloc.state.ea!);
    } else {
      _eaController = TextEditingController();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _eaFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _eaController.dispose();
    _eaFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme
        .of(context)
        .colorScheme;

    return BlocConsumer<CAPIBloC, CAPIState>(
      listener: (context, state) {
        if ((state.verified ?? false) && state.ea != null) {
          fsdui.dismissAll();
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

  Widget _buildStep1(BuildContext context,
      ColorScheme colorScheme,
      CAPIState state,) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.lock_outline_rounded,
            size: 56,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text(
            'Passwordless sign-in — we\'ll email you a verify button',
            style: Theme
                .of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(
              color: colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          TextFormField(
            controller: _eaController,
            focusNode: _eaFocusNode,
            decoration: const InputDecoration(
              labelText: 'Email',
              prefixIcon: Icon(Icons.email_outlined),
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.emailAddress,
            validator: (v) => (v?.isEmpty ?? true) ? 'Enter an email' : null,
            onFieldSubmitted: (_) => _submit(context),
          ),
          const SizedBox(height: 16),
          if (state.authErrorMessage != null) ...[
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colorScheme.errorContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                state.authErrorMessage!,
                style: TextStyle(color: colorScheme.onErrorContainer),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
          ],
          FilledButton(
            onPressed: state.awaitingConfirmation ?? false
                ? null
                : () => _submit(context),
            child: state.awaitingConfirmation ?? false
                ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
                : state.ea != null
                ? const Text('Sign back in')
                : const Text('Send verification email'),
          ),
        ],
      ),
    );
  }

  Widget _buildStep2(ColorScheme colorScheme, CAPIState state) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          Icons.mark_email_unread_outlined,
          size: 56,
          color: colorScheme.primary,
        ),
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
          'We sent a verification email to ${state
              .ea}.\nTap the button in that email and you\'ll be signed in automatically.',
          textAlign: TextAlign.center,
          style: TextStyle(color: colorScheme.onSurfaceVariant),
        ),
        const SizedBox(height: 32),
        const Center(child: CircularProgressIndicator()),
        const SizedBox(height: 24),
        TextButton(
          onPressed: () {
            context.read<CAPIBloC>().add(const SignOutRequested());
          },
          child: const Text('or Use a different email.'),
        ),
      ],
    );
  }

  void _submit(BuildContext context) {
    final ea = removeDotsAndForceLowercase(_eaController.text.trim());
    final prevEa = fsdui.capiBloc.state.ea != null ? removeDotsAndForceLowercase(fsdui.capiBloc.state.ea!.trim()) : null;
    if (prevEa == ea) {
      // simply sign back in (applies to users who are editors)
      context.read<CAPIBloC>().add(SignBackIn());
    } else if (_formKey.currentState?.validate() ?? false) {
      if (!fsdui.emailIsValid(ea)) return;
      // if (fsdui.localStorage.read('vea') == ea) {
      //   fsdui.dismiss("passwordless-stepper");
      //   return;
      // }
      context.read<CAPIBloC>().add(
        GenerateTokenAndSendConfirmationEmail(appId: fsdui.appId, ea: ea),
      );
    }
  }
}

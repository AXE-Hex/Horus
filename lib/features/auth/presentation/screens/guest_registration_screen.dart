import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/router/route_guard.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/shared/widgets/app_button.dart';
import 'package:horus/shared/widgets/app_card.dart';
import 'package:horus/shared/widgets/app_text_field.dart';

class GuestRegistrationScreen extends ConsumerStatefulWidget {
  const GuestRegistrationScreen({super.key});

  @override
  ConsumerState<GuestRegistrationScreen> createState() =>
      _GuestRegistrationScreenState();
}

class _GuestRegistrationScreenState
    extends ConsumerState<GuestRegistrationScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirmation = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirmation.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    final localized = t.auth.guest_registration;
    if (_name.text.trim().isEmpty ||
        !isUniversityEmail(_email.text) ||
        _password.text.length < 12) {
      _show(localized.validation);
      return;
    }
    if (_password.text != _confirmation.text) {
      _show(localized.password_mismatch);
      return;
    }

    setState(() => _submitting = true);
    await ref
        .read(authControllerProvider.notifier)
        .signUp(
          email: _email.text,
          password: _password.text,
          fullName: _name.text.trim(),
        );
    if (!mounted) return;

    final auth = ref.read(authControllerProvider);
    if (auth.error == 'confirmation_required') {
      _show(localized.confirmation_required);
      setState(() => _submitting = false);
      return;
    }
    if (auth.error != null) {
      _show(
        auth.error == 'invalid_university_email'
            ? t.auth.login.invalid_email
            : localized.request_failed,
      );
      setState(() => _submitting = false);
      return;
    }
    if (auth.isAuthenticated) {
      context.go(resolveInitialDestination(auth));
    } else {
      context.go('/login');
    }
  }

  void _show(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context) {
    final copy = t.auth.guest_registration;
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: AppCard(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      copy.title,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      copy.subtitle,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    AppTextField(
                      label: copy.full_name,
                      controller: _name,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppTextField(
                      label: copy.email,
                      controller: _email,
                      hintText: t.auth.login.email_hint,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppTextField(
                      label: copy.password,
                      controller: _password,
                      obscureText: true,
                      textInputAction: TextInputAction.next,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    AppTextField(
                      label: copy.confirm_password,
                      controller: _confirmation,
                      obscureText: true,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (_) => _register(),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    AppButton(
                      text: copy.submit,
                      isLoading: _submitting,
                      onPressed: _register,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: Text(copy.already_have_account),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

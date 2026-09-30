import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/features/students/presentation/widgets/horus_identity_card.dart';

class DigitalIDScreen extends ConsumerWidget {
  const DigitalIDScreen({super.key, this.studentData = const {}});
  final Map<String, dynamic> studentData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);
    final profile = auth.profile;
    return Scaffold(
      appBar: AppBar(title: Text(t.students.smart_digital_id)),
      body: auth.isLoading
          ? const Center(child: CircularProgressIndicator())
          : profile == null || !auth.hasRole || profile.studentId == null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                child: Text(
                  t.students.id_unavailable,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          : Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 620),
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.xl),
                  children: [
                    Hero(
                      tag: 'digital_id_card',
                      child: Material(
                        color: Colors.transparent,
                        child: HorusIdentityCard(profile: profile),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Text(
                      t.students.horus_university,
                      style: Theme.of(context).textTheme.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

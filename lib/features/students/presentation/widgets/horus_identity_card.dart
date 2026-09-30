import 'package:flutter/material.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/models/profile_model.dart';
import 'package:horus/core/theme/app_colors.dart';
import 'package:horus/core/theme/app_spacing.dart';

class HorusIdentityCard extends StatelessWidget {
  const HorusIdentityCard({super.key, required this.profile});
  final ProfileModel profile;

  @override
  Widget build(BuildContext context) {
    final name = t.$meta.locale.languageCode == 'ar'
        ? (profile.fullNameAr ?? profile.fullName)
        : profile.fullName;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xxl),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.navy700, AppColors.navy950],
        ),
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: AppColors.gold400.withValues(alpha: .4)),
      ),
      child: DefaultTextStyle.merge(
        style: const TextStyle(color: Colors.white),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/images/Logo_dark.png',
              width: 156,
              height: 78,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text(
              name,
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(
              profile.roles.map((role) => role.displayName()).join(' · '),
              style: const TextStyle(color: AppColors.gold300),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Divider(color: Colors.white24),
            ),
            Text(
              t.students.student_id,
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: AppSpacing.xs),
            SelectableText(
              profile.studentId ?? '—',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

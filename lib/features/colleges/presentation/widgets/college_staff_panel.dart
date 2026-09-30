import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/features/profiles/data/repositories/profile_directory_repository.dart';
import 'package:horus/features/shared/presentation/widgets/horus_empty_state.dart';
import 'package:horus/shared/widgets/app_card.dart';

class CollegeStaffPanel extends ConsumerWidget {
  const CollegeStaffPanel({
    super.key,
    required this.collegeId,
    this.deanOnly = false,
  });
  final String? collegeId;
  final bool deanOnly;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (collegeId == null) return Text(t.academic.no_data);
    final staff = ref.watch(
      profileDirectoryProvider(
        ProfileDirectoryFilter(
          collegeId: collegeId,
          roles: deanOnly
              ? {UserRole.dean}
              : {
                  UserRole.dean,
                  UserRole.departmentHead,
                  UserRole.assistantHod,
                  UserRole.professor,
                  UserRole.lecturer,
                  UserRole.teachingAssistant,
                },
        ),
      ),
    );
    return staff.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, _) => Text(t.academic.error),
      data: (members) => members.isEmpty
          ? HorusEmptyState(
              icon: Icons.people_outline,
              title: t.academic.no_data,
            )
          : Column(
              children: [
                for (final member in members.take(deanOnly ? 1 : 6))
                  Padding(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    child: AppCard(
                      child: Row(
                        children: [
                          CircleAvatar(
                            foregroundImage: member.avatarUrl == null
                                ? null
                                : NetworkImage(member.avatarUrl!),
                            child: const Icon(Icons.person_outline),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.$meta.locale.languageCode == 'ar'
                                      ? member.fullNameAr ?? member.fullName
                                      : member.fullName,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  member.roles
                                      .map((role) => role.displayName())
                                      .join(' · '),
                                ),
                              ],
                            ),
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

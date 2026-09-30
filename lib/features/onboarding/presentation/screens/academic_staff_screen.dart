import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/core/auth/roles.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/profiles/data/repositories/profile_directory_repository.dart';

class AcademicStaffScreen extends ConsumerWidget {
  const AcademicStaffScreen({super.key, required this.collegeData});

  final Map<String, dynamic> collegeData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final collegeId = collegeData['id'] as String?;
    if (collegeId == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(t.colleges.details.staff),
          leading: BackButton(onPressed: () => context.pop()),
        ),
        body: Center(child: Text(t.academic.no_data)),
      );
    }
    final staff = ref.watch(
      profileDirectoryProvider(
        ProfileDirectoryFilter(
          collegeId: collegeId,
          roles: {
            UserRole.rector,
            UserRole.dean,
            UserRole.departmentHead,
            UserRole.assistantHod,
            UserRole.academicCoordinator,
            UserRole.professor,
            UserRole.lecturer,
            UserRole.teachingAssistant,
          },
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(t.colleges.details.staff),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: staff.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, _) => Center(child: Text(t.academic.error)),
        data: (profiles) => profiles.isEmpty
            ? Center(child: Text(t.academic.no_data))
            : ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: profiles.length,
                separatorBuilder: (_, _) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final profile = profiles[index];
                  final displayName = t.$meta.locale.languageCode == 'ar'
                      ? (profile.fullNameAr ?? profile.fullName)
                      : profile.fullName;
                  return Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        foregroundImage: profile.avatarUrl == null
                            ? null
                            : NetworkImage(profile.avatarUrl!),
                        child: profile.avatarUrl == null
                            ? const Icon(Icons.person_outline)
                            : null,
                      ),
                      title: Text(displayName),
                      subtitle: Text(
                        profile.roles
                            .map((role) => role.displayName())
                            .join(' · '),
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}

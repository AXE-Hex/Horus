import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/style_provider.dart';
import 'package:horus/features/academic/data/models/professor_profile_models.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:horus/features/academic/presentation/widgets/course_file_upload_dialog.dart';
import 'package:horus/features/academic/data/repositories/professor_repository.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/features/enrollment/presentation/providers/advisor_provider.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';

part 'professor_dashboard_header.dart';
part 'professor_dashboard_groups.dart';
part 'professor_dashboard_announcements.dart';
part 'professor_dashboard_actions.dart';
part 'professor_dashboard_management.dart';

class ProfessorDashboardScreen extends HookConsumerWidget {
  final ProfessorProfile? profile;

  const ProfessorDashboardScreen({super.key, this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileAsync = ref.watch(professorProfileProvider);
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final isGlass = ref.watch(styleControllerProvider).value == AppStyle.glass;

    return profileAsync.when(
      data: (profile) {
        if (profile == null) {
          return Scaffold(
            appBar: AppBar(title: Text(t.academic.course_management)),
            body: Center(child: Text(t.academic.no_data)),
          );
        }

        final body = CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            _ImmersiveHeader(profile: profile, isArabic: isArabic),
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 100),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 24),
                  _BentoStatsGrid(profile: profile, isArabic: isArabic),
                  if (profile.announcements.isNotEmpty) ...[
                    const SizedBox(height: 32),
                    _SectionHeader(
                      title: 'Announcements',
                      onTap: () {},
                      isArabic: isArabic,
                    ),
                    const SizedBox(height: 16),
                    _AnnouncementsList(profile: profile, isArabic: isArabic),
                  ],
                  const SizedBox(height: 32),
                  _SectionHeader(
                    title: t.academic.course_management,
                    onTap: () => context.push('/manage-groups', extra: profile),
                    isArabic: isArabic,
                  ),
                  const SizedBox(height: 16),
                  _GroupsBentoList(profile: profile, isArabic: isArabic),
                  const SizedBox(height: 32),
                  _QuickActionsPanel(profile: profile, isArabic: isArabic),
                  const SizedBox(height: 32),
                  _ManagementGrid(profile: profile, isArabic: isArabic),
                ]),
              ),
            ),
          ],
        );

        return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text(t.academic.error)),
    );
  }
}

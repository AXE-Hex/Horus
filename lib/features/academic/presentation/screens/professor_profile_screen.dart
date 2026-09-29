import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/security/axe_fingerprint.dart';
import 'package:horus/core/theme/style_provider.dart';
import 'package:horus/features/academic/data/models/professor_profile_models.dart';
import 'package:horus/features/shared/data/models/shared_records.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:intl/intl.dart';

part 'professor_profile_header.dart';
part 'professor_profile_announcements.dart';
part 'professor_profile_groups_files.dart';

class ProfessorProfileScreen extends ConsumerWidget {
  final ProfessorProfile profile;

  const ProfessorProfileScreen({super.key, required this.profile});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final theme = Theme.of(context);
    final color = theme.primaryColor;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildGlassSliverAppBar(context, isGlass, color),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildQuickActions(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildUrgentAnnouncements(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildTAsSection(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildGroupsSection(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildSharedFilesSection(context, isGlass, color, isArabic),
              const SizedBox(height: 24),
              _buildOfficeHoursSection(context, isGlass, color, isArabic),
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ],
    );

    return Semantics(
      identifier: Axe.axeSignature,
      container: true,
      child: isGlass
          ? GlassScaffold(body: content)
          : Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              body: content,
            ),
    );
  }
}

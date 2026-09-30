import 'package:horus/features/colleges/presentation/widgets/college_staff_panel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/constants/colleges_data.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/features/institutional/data/repositories/institutional_repository.dart';
import 'package:horus/core/auth/roles.dart';

part 'college_portal_overview.dart';
part 'college_portal_staff_sections.dart';
part 'college_portal_departments.dart';

class CollegePortalScreen extends ConsumerStatefulWidget {
  final StaticCollegeData college;

  const CollegePortalScreen({super.key, required this.college});

  @override
  ConsumerState<CollegePortalScreen> createState() =>
      _CollegePortalScreenState();
}

class _CollegePortalScreenState extends ConsumerState<CollegePortalScreen> {
  @override
  Widget build(BuildContext context) {
    const isGlass = false;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final college = widget.college;
    final title = isArabic ? college.nameAr : college.nameEn;
    final color = college.themeColor;

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        _buildSliverAppBar(context, college, title, color, isGlass),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildStatsGrid(college, color, isGlass, isArabic),
                const SizedBox(height: 32),
                _buildAboutSection(college, color, isGlass, isArabic),
                const SizedBox(height: 32),
                _buildDeanSection(college, color, isGlass, isArabic),
                const SizedBox(height: 32),
                _buildStaffSection(college, color, isGlass, isArabic),
                const SizedBox(height: 32),
                _buildDepartmentsSection(college, color, isGlass, isArabic),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ],
    );

    return Scaffold(body: content);
  }
}

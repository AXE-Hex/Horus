import 'package:horus/features/colleges/presentation/legacy_college_data.dart';
import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/style_provider.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:horus/features/academic/data/repositories/professor_repository.dart';

class AcademicStaffScreen extends ConsumerWidget {
  final Map<String, dynamic> collegeData;

  const AcademicStaffScreen({super.key, required this.collegeData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final color = collegeData['color'] as Color? ?? Colors.blue;

    final staffAsync = ref.watch(
      legacyCollegeStaffProvider(collegeData['id']?.toString() ?? ''),
    );
    if (staffAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (staffAsync.hasError) {
      return Scaffold(body: Center(child: Text(t.academic.error)));
    }
    final staff = [
      for (final member in staffAsync.value ?? [])
        {
          'id': member.id,
          'name': t.$meta.locale.languageCode == 'ar'
              ? (member.fullNameAr ?? member.fullName)
              : member.fullName,
          'role': member.roles.map((role) => role.displayName()).join(' · '),
          'dept': member.departmentId ?? '—',
          'generalRating': null,
          'curriculumRating': null,
        },
    ];

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 120,
          pinned: true,
          backgroundColor: isGlass ? Colors.transparent : color,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.chevronLeft, color: Colors.white),
            ),
            onPressed: () => context.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              t.colleges.details.staff,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            background: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [color, color.withValues(alpha: 0.8)],
                ),
              ),
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final member = staff[index];
              return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: _buildStaffListItem(
                      context,
                      ref,
                      member,
                      color,
                      isGlass,
                    ),
                  )
                  .animate()
                  .fadeIn(delay: (index * 50).ms)
                  .slideX(begin: 0.2, end: 0);
            }, childCount: staff.length),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: content) : Scaffold(body: content);
  }

  Widget _buildStaffListItem(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> member,
    Color color,
    bool isGlass,
  ) {
    final cardContent = Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Hero(
            tag: 'staff_${member['name']}',
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: color.withValues(alpha: 0.3),
                  width: 2,
                ),
              ),
              child: CircleAvatar(
                radius: 30,
                backgroundColor: color.withValues(alpha: 0.1),
                child: Icon(LucideIcons.user, size: 30, color: color),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  member['name']!,
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isGlass ? Colors.white : null,
                  ),
                ),
                Text(
                  member['role']!,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: color,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildRatingMini(
                      context,
                      LucideIcons.user,
                      member['generalRating'] as double?,
                      color,
                      isGlass,
                    ),
                    const SizedBox(width: 12),
                    _buildRatingMini(
                      context,
                      LucideIcons.bookOpen,
                      member['curriculumRating'] as double?,
                      Colors.orange,
                      isGlass,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Icon(
            LucideIcons.chevronRight,
            size: 18,
            color: isGlass
                ? Colors.white30
                : Colors.grey.withValues(alpha: 0.3),
          ),
        ],
      ),
    );

    final card = isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(20),
            padding: EdgeInsets.zero,
            child: cardContent,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: cardContent,
          );

    return InkWell(
      onTap: () async {
        HapticFeedback.mediumImpact();

        if (member['id'] != null) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (c) => const Center(child: CircularProgressIndicator()),
          );

          try {
            final profile = await ref
                .read(professorRepositoryProvider)
                .getFullProfessorProfile(member['id'] as String);
            if (context.mounted) {
              Navigator.pop(context);
              if (profile != null) {
                context.push('/professor-profile', extra: profile);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profile not found')),
                );
              }
            }
          } catch (e) {
            if (context.mounted) {
              Navigator.pop(context);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(t.academic.error)));
            }
          }
        } else {
          context.push('/staff-rating-detail', extra: member);
        }
      },
      borderRadius: BorderRadius.circular(20),
      child: card,
    );
  }

  Widget _buildRatingMini(
    BuildContext context,
    IconData icon,
    double? rating,
    Color color,
    bool isGlass,
  ) {
    return Row(
      children: [
        Icon(icon, size: 12, color: isGlass ? Colors.white70 : Colors.grey),
        const SizedBox(width: 4),
        Text(
          rating.toString(),
          style: GoogleFonts.outfit(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: isGlass ? Colors.white : null,
          ),
        ),
        const SizedBox(width: 2),
        const Icon(LucideIcons.star, size: 10, color: Colors.amber),
      ],
    );
  }
}

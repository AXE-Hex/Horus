// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CoursesScreen extends ConsumerWidget {
  const CoursesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    return DefaultTabController(
      length: 2,
      child: isGlass
          ? GlassScaffold(
              body: NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  GlassSliverAppBar(
                    backgroundColor: Colors.transparent,
                    elevation: 0,
                    leading: IconButton(
                      icon: const Icon(LucideIcons.arrowLeft),
                      onPressed: () => context.pop(),
                    ),
                    title: Text(
                      isArabic ? "المقررات الدراسية" : "Courses",
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    centerTitle: true,
                    pinned: true,
                    floating: true,
                    bottom: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).hintColor,
                      labelStyle: GoogleFonts.outfit(
                        fontWeight: FontWeight.bold,
                      ),
                      tabs: [
                        Tab(text: isArabic ? "المسجلة" : "Enrolled"),
                        Tab(text: isArabic ? "المتاحة" : "Available"),
                      ],
                    ),
                  ),
                ],
                body: TabBarView(
                  children: [
                    _buildCourseList(context, true, isGlass, isArabic),
                    _buildCourseList(context, false, isGlass, isArabic),
                  ],
                ),
              ),
            )
          : Scaffold(
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: const Icon(LucideIcons.arrowLeft),
                  onPressed: () => context.pop(),
                ),
                title: Text(
                  isArabic ? "المقررات الدراسية" : "Courses",
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                centerTitle: true,
                bottom: TabBar(
                  indicatorColor: Theme.of(context).primaryColor,
                  labelColor: Theme.of(context).primaryColor,
                  unselectedLabelColor: Theme.of(context).hintColor,
                  labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                  tabs: [
                    Tab(text: isArabic ? "المسجلة" : "Enrolled"),
                    Tab(text: isArabic ? "المتاحة" : "Available"),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  _buildCourseList(context, true, isGlass, isArabic),
                  _buildCourseList(context, false, isGlass, isArabic),
                ],
              ),
            ),
    );
  }

  Widget _buildCourseList(
    BuildContext context,
    bool isEnrolled,
    bool isGlass,
    bool isArabic,
  ) {
    final courses = isEnrolled
        ? [
            {
              'name': isArabic
                  ? 'الذكاء الاصطناعي CS402'
                  : 'CS402 Artificial Intelligence',
              'id': 'CS402',
              'credits': '3',
              'instructor': isArabic ? 'د/ سارة أحمد' : 'Dr. Sarah Ahmed',
            },
            {
              'name': isArabic
                  ? 'تفاضل متقدم MAT301'
                  : 'MAT301 Advanced Calculus',
              'id': 'MAT301',
              'credits': '4',
              'instructor': isArabic ? 'د/ روبرت سميث' : 'Dr. Robert Smith',
            },
            {
              'name': isArabic
                  ? 'أخلاقيات المهنة HUM210'
                  : 'HUM210 Professional Ethics',
              'id': 'HUM210',
              'credits': '2',
              'instructor': isArabic ? 'أ.م/ جون دو' : 'Prof. John Doe',
            },
          ]
        : [
            {
              'name': isArabic
                  ? 'تقنيات تعلم الآلة CS405'
                  : 'CS405 Machine Learning',
              'id': 'CS405',
              'credits': '3',
              'instructor': isArabic ? 'د/ آلان تورينج' : 'Dr. Alan Turing',
            },
            {
              'name': isArabic ? 'رؤية حاسوبية CS410' : 'CS410 Computer Vision',
              'id': 'CS410',
              'credits': '3',
              'instructor': isArabic ? 'د/ أدا لوفلايس' : 'Dr. Ada Lovelace',
            },
          ];

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: courses.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: _buildCourseCard(context, courses[index], isGlass, isArabic),
        );
      },
    );
  }

  Widget _buildCourseCard(
    BuildContext context,
    Map<String, String> course,
    bool isGlass,
    bool isArabic,
  ) {
    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  course['id']!,
                  style: GoogleFonts.shareTechMono(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    LucideIcons.clock,
                    size: 14,
                    color: Theme.of(context).hintColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${course['credits']} ${isArabic ? "ساعات" : "Credits"}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            course['name']!,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isGlass
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                LucideIcons.user,
                size: 14,
                color: Theme.of(context).hintColor,
              ),
              const SizedBox(width: 6),
              Text(
                course['instructor']!,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  color: isGlass ? Colors.white70 : Theme.of(context).hintColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(24),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 10,
                ),
              ],
              border: Border.all(color: Colors.black12),
            ),
            child: content,
          );
  }
}

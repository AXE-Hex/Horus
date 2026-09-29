import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/style_provider.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

part 'subject_scroller.dart';
part 'subject_layout_switcher.dart';
part 'subject_immersive_layout.dart';
part 'subject_analytical_layout.dart';
part 'subject_minimal_layout.dart';
part 'subject_result_components.dart';

class SubjectResultsScreen extends HookConsumerWidget {
  const SubjectResultsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final selectedSubject = useState(0);
    final selectedLayout = useState(0);

    final subjects = [
      {
        'name': t.academic.artificial_intelligence,
        'code': 'CS402',
        'totalScore': 92,
        'maxScore': 100,
        'grade': 'A',
        'color': const Color(0xFF6366F1),
        'components': [
          {
            'title': t.academic.coursework,
            'score': 18,
            'max': 20,
            'icon': LucideIcons.clipboardList,
            'color': const Color(0xFF10B981),
          },
          {
            'title': t.academic.midterm_exam,
            'score': 16,
            'max': 20,
            'icon': LucideIcons.pencil,
            'color': const Color(0xFFF59E0B),
          },
          {
            'title': t.academic.practical_project,
            'score': 9,
            'max': 10,
            'icon': LucideIcons.code2,
            'color': const Color(0xFFEC4899),
          },
          {
            'title': t.academic.final_exam,
            'score': 49,
            'max': 50,
            'icon': LucideIcons.graduationCap,
            'color': const Color(0xFF8B5CF6),
          },
        ],
      },
      {
        'name': t.academic.network_security,
        'code': 'CS305',
        'totalScore': 88,
        'maxScore': 100,
        'grade': 'A-',
        'color': const Color(0xFF10B981),
        'components': [
          {
            'title': t.academic.coursework,
            'score': 19,
            'max': 20,
            'icon': LucideIcons.clipboardList,
            'color': const Color(0xFF10B981),
          },
          {
            'title': t.academic.quiz_1,
            'score': 10,
            'max': 10,
            'icon': LucideIcons.zap,
            'color': const Color(0xFFF59E0B),
          },
          {
            'title': t.academic.quiz_2,
            'score': 8,
            'max': 10,
            'icon': LucideIcons.zap,
            'color': const Color(0xFFF59E0B),
          },
          {
            'title': t.academic.final_exam,
            'score': 51,
            'max': 60,
            'icon': LucideIcons.graduationCap,
            'color': const Color(0xFF6366F1),
          },
        ],
      },
      {
        'name': t.academic.web_programming,
        'code': 'CS204',
        'totalScore': 95,
        'maxScore': 100,
        'grade': 'A+',
        'color': const Color(0xFFEC4899),
        'components': [
          {
            'title': t.academic.code_review,
            'score': 20,
            'max': 20,
            'icon': LucideIcons.code2,
            'color': const Color(0xFF6366F1),
          },
          {
            'title': t.academic.frontend_ui,
            'score': 28,
            'max': 30,
            'icon': LucideIcons.layout,
            'color': const Color(0xFFEC4899),
          },
          {
            'title': t.academic.lab_final,
            'score': 47,
            'max': 50,
            'icon': LucideIcons.hardDrive,
            'color': const Color(0xFF10B981),
          },
        ],
      },
    ];

    final currentSubject = subjects[selectedSubject.value];

    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 100,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: Text(
            t.academic.results_analysis,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w900,
              fontSize: 22,
              color: Colors.white,
            ),
          ),
          actions: [
            _LayoutSwitcher(
              current: selectedLayout.value,
              onChanged: (val) => selectedLayout.value = val,
            ),
            const SizedBox(width: 8),
          ],
        ),
        SliverToBoxAdapter(
          child: _SubjectScroller(
            subjects: subjects,
            selectedIndex: selectedSubject.value,
            onChanged: (val) => selectedSubject.value = val,
            isArabic: isArabic,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          sliver: SliverToBoxAdapter(
            child: AnimatedSwitcher(
              duration: 400.ms,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: animation.drive(Tween(begin: 0.95, end: 1.0)),
                  child: child,
                ),
              ),
              child: _buildLayout(
                selectedLayout.value,
                currentSubject,
                isArabic,
              ),
            ),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildLayout(
    int layoutIndex,
    Map<String, dynamic> subject,
    bool isArabic,
  ) {
    switch (layoutIndex) {
      case 1:
        return _AnalyticalLayout(
          subject: subject,
          isArabic: isArabic,
          key: const ValueKey(1),
        );
      case 2:
        return _MinimalLayout(
          subject: subject,
          isArabic: isArabic,
          key: const ValueKey(2),
        );
      default:
        return _ImmersiveLayout(
          subject: subject,
          isArabic: isArabic,
          key: const ValueKey(0),
        );
    }
  }
}

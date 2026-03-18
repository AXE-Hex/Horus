import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

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

class _SubjectScroller extends StatelessWidget {
  final List<Map<String, dynamic>> subjects;
  final int selectedIndex;
  final Function(int) onChanged;
  final bool isArabic;

  const _SubjectScroller({
    required this.subjects,
    required this.selectedIndex,
    required this.onChanged,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: List.generate(subjects.length, (index) {
          final isSelected = index == selectedIndex;
          final color = subjects[index]['color'] as Color;
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: GestureDetector(
              onTap: () => onChanged(index),
              child: AnimatedContainer(
                duration: 300.ms,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: isSelected
                      ? color
                      : Colors.white.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? color
                        : Colors.white.withValues(alpha: 0.1),
                  ),
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: color.withValues(alpha: 0.3),
                            blurRadius: 12,
                          ),
                        ]
                      : null,
                ),
                child: Text(
                  subjects[index]['code'],
                  style: GoogleFonts.shareTechMono(
                    color: isSelected ? Colors.white : Colors.white60,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _LayoutSwitcher extends StatelessWidget {
  final int current;
  final Function(int) onChanged;

  const _LayoutSwitcher({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          final isSelected = current == index;
          IconData icon;
          switch (index) {
            case 1:
              icon = LucideIcons.barChart2;
              break;
            case 2:
              icon = LucideIcons.layoutGrid;
              break;
            default:
              icon = LucideIcons.circle;
              break;
          }
          return GestureDetector(
            onTap: () => onChanged(index),
            child: AnimatedContainer(
              duration: 200.ms,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white38,
                size: 18,
              ),
            ),
          );
        }),
      ),
    );
  }
}

class _ImmersiveLayout extends StatelessWidget {
  final Map<String, dynamic> subject;
  final bool isArabic;

  const _ImmersiveLayout({
    super.key,
    required this.subject,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final color = subject['color'] as Color;
    return Column(
      children: [
        GlassContainer(
          borderRadius: BorderRadius.circular(32),
          padding: const EdgeInsets.all(32),
          border: Border.all(color: color.withValues(alpha: 0.2)),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject['code'],
                        style: GoogleFonts.shareTechMono(
                          color: color,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        subject['name'],
                        style: GoogleFonts.outfit(
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  _buildGradeBadge(subject['grade'], color),
                ],
              ),
              const SizedBox(height: 32),
              _buildCircularProgress(
                subject['totalScore'],
                subject['maxScore'],
                color,
                isArabic,
              ),
              const SizedBox(height: 32),
              _buildInsights(isArabic),
            ],
          ),
        ),
        const SizedBox(height: 24),
        ...List.generate((subject['components'] as List).length, (index) {
          return _ComponentCard(
            component: subject['components'][index],
            isArabic: isArabic,
            index: index,
          );
        }),
      ],
    );
  }

  Widget _buildGradeBadge(String grade, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text(
        grade,
        style: GoogleFonts.outfit(
          fontSize: 24,
          fontWeight: FontWeight.w900,
          color: color,
        ),
      ),
    );
  }

  Widget _buildCircularProgress(int score, int max, Color color, bool isAr) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 140,
          height: 140,
          child: CircularProgressIndicator(
            value: score / max,
            strokeWidth: 10,
            backgroundColor: Colors.white.withValues(alpha: 0.05),
            valueColor: AlwaysStoppedAnimation<Color>(color),
          ),
        ),
        Column(
          children: [
            Text(
              score.toString(),
              style: GoogleFonts.shareTechMono(
                fontSize: 44,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              isAr ? 'من $max' : 'OUT OF $max',
              style: GoogleFonts.outfit(
                fontSize: 10,
                color: Colors.white38,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildInsights(bool isAr) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Row(
          children: [
            Icon(LucideIcons.trendingUp, size: 14, color: Colors.green),
            const SizedBox(width: 8),
            Text(
              isAr ? 'متفوق' : 'Exceeding',
              style: GoogleFonts.outfit(fontSize: 12, color: Colors.white60),
            ),
          ],
        ),
        Container(width: 1, height: 16, color: Colors.white10),
        Row(
          children: [
            Icon(LucideIcons.award, size: 14, color: Colors.amber),
            const SizedBox(width: 8),
            Text(
              isAr ? 'أفضل 5%' : 'Top 5%',
              style: GoogleFonts.outfit(fontSize: 12, color: Colors.white60),
            ),
          ],
        ),
      ],
    );
  }
}

class _AnalyticalLayout extends StatelessWidget {
  final Map<String, dynamic> subject;
  final bool isArabic;

  const _AnalyticalLayout({
    super.key,
    required this.subject,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final components = subject['components'] as List;

    return Column(
      children: [
        GlassContainer(
          borderRadius: BorderRadius.circular(28),
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.academic.performance_distribution,
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 24),
              ...components.map(
                (c) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            c['title'],
                            style: GoogleFonts.outfit(
                              fontSize: 14,
                              color: Colors.white70,
                            ),
                          ),
                          Text(
                            '${c['score']}/${c['max']}',
                            style: GoogleFonts.shareTechMono(
                              color: c['color'],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: c['score'] / c['max'],
                          minHeight: 6,
                          backgroundColor: Colors.white.withValues(alpha: 0.05),
                          valueColor: AlwaysStoppedAnimation<Color>(c['color']),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        _buildStatsGrid(subject, isArabic),
      ],
    );
  }

  Widget _buildStatsGrid(Map<String, dynamic> subject, bool isAr) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            label: isAr ? 'المجموع' : 'Total',
            value: '${subject['totalScore']}%',
            color: subject['color'],
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _StatCard(
            label: isAr ? 'التقدير' : 'Grade',
            value: subject['grade'],
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}

class _MinimalLayout extends StatelessWidget {
  final Map<String, dynamic> subject;
  final bool isArabic;

  const _MinimalLayout({
    super.key,
    required this.subject,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final color = subject['color'] as Color;
    final components = subject['components'] as List;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              subject['name'],
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w900,
                color: Colors.white,
              ),
            ),
            Text(
              subject['grade'],
              style: GoogleFonts.outfit(
                fontSize: 32,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 1.4,
          ),
          itemCount: components.length,
          itemBuilder: (context, index) {
            final c = components[index];
            return Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    c['title'],
                    style: GoogleFonts.outfit(
                      fontSize: 12,
                      color: Colors.white38,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${c['score']}/${c['max']}',
                    style: GoogleFonts.shareTechMono(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: c['color'],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ComponentCard extends StatelessWidget {
  final Map<String, dynamic> component;
  final bool isArabic;
  final int index;

  const _ComponentCard({
    required this.component,
    required this.isArabic,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final color = component['color'] as Color;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(24),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                component['icon'] as IconData,
                color: color,
                size: 20,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                component['title'],
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Text(
              '${component['score']} / ${component['max']}',
              style: GoogleFonts.shareTechMono(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                color: color,
              ),
            ),
          ],
        ),
      ).animate(delay: (index * 100).ms).fadeIn().slideX(begin: 0.1, end: 0),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 12,
              color: Colors.white38,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            value,
            style: GoogleFonts.shareTechMono(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

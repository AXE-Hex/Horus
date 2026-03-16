
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class CollegesScreen extends ConsumerStatefulWidget {
  final bool isOnboarding;

  const CollegesScreen({super.key, this.isOnboarding = true});

  @override
  ConsumerState<CollegesScreen> createState() => _CollegesScreenState();
}

class _CollegesScreenState extends ConsumerState<CollegesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  final List<Map<String, dynamic>> _colleges = [
    {
      'title': (Translations t) => t.colleges.applied_health_sciences,
      'image': 'assets/images/college_applied_health.png',
      'color': const Color(0xFF0D9488),
      'stats': {
        'students': '---',
        'academic_staff': '---',
        'teaching_assistants': '---',
        'published_articles': '---',
      },
      'departments': [
        'medical_laboratories_technology',
        'radiology_and_imaging_technology',
        'respiratory_care_technology',
        'dental_prosthetics_technology',
        'health_administration_and_informatics_technology',
      ],
    },
    {
      'title': (Translations t) => t.colleges.business_administration,
      'image': 'assets/images/college_business.png',
      'color': const Color(0xFF4F46E5),
      'stats': {
        'students': '---',
        'academic_staff': '---',
        'teaching_assistants': '---',
        'published_articles': '---',
      },
      'departments': [
        'accounting',
        'business_management',
        'economics',
        'marketing',
        'accounting_program_english',
        'business_administration_program_english',
      ],
    },
    {
      'title': (Translations t) => t.colleges.dentistry,
      'image': 'assets/images/college_dentistry.png',
      'color': const Color(0xFF14B8A6),
      'stats': {
        'students': '---',
        'academic_staff': '---',
        'teaching_assistants': '---',
        'published_articles': '---',
      },
      'departments': [
        'basic_sciences_in_dentistry',
        'basic_medical_and_clinical_sciences',
        'oral_and_maxillofacial_surgery',
        'orthodontics_and_pediatric_dentistry',
        'periodontics_and_oral_medicine',
        'prosthodontics',
        'conservative_dentistry_and_endodontics',
      ],
    },
    {
      'title': (Translations t) => t.colleges.engineering,
      'image': 'assets/images/college_engineering.png',
      'color': const Color(0xFFE11D48),
      'stats': {
        'students': '---',
        'academic_staff': '---',
        'teaching_assistants': '---',
        'published_articles': '---',
      },
      'departments': [
        'architectural_engineering',
        'basic_sciences',
        'civil_engineering',
        'mechanical_engineering',
        'electrical_engineering',
        'artificial_intelligence_engineering',
      ],
    },
    {
      'title': (Translations t) => t.colleges.fine_arts,
      'image': 'assets/images/college_fine_arts.png',
      'color': const Color(0xFF9333EA),
      'stats': {
        'students': '---',
        'academic_staff': '---',
        'teaching_assistants': '---',
        'published_articles': '---',
      },
      'departments': [
        'interior_design_and_architecture',
        'furniture_design_and_production_technology',
        'graphics_and_digital_arts',
        'animation_and_multimedia',
      ],
    },
    {
      'title': (Translations t) => t.colleges.human_medicine,
      'image': 'assets/images/college_medicine.png',
      'color': const Color(0xFFBE123C),
      'stats': {
        'students': '---',
        'academic_staff': '---',
        'teaching_assistants': '---',
        'published_articles': '---',
      },
      'departments': [
        'medical_education',
        'histology_and_cell_biology',
        'clinical_pharmacy',
        'human_anatomy_and_embryology',
        'medical_physiology',
        'medical_microbiology_and_immunology',
        'forensic_medicine_and_toxicology',
        'community_medicine_and_public_health',
        'biochemistry',
        'pathology',
      ],
    },
    {
      'title': (Translations t) => t.colleges.linguistics,
      'image': 'assets/images/college_linguistics.png',
      'color': const Color(0xFFF59E0B),
      'stats': {
        'students': '---',
        'academic_staff': '---',
        'teaching_assistants': '---',
        'published_articles': '---',
      },
      'departments': [
        'english_language_program',
        'german_language_program',
        'chinese_language_program',
        'french_department',
        'translation_department',
      ],
    },
    {
      'title': (Translations t) => t.colleges.pharmacy,
      'image': 'assets/images/college_pharmacy.png',
      'color': const Color(0xFF10B981),
      'stats': {
        'students': '---',
        'academic_staff': '---',
        'teaching_assistants': '---',
        'published_articles': '---',
      },
      'departments': [
        'pharmaceutical_chemistry',
        'pharmacology_and_biochemistry',
        'pharmacognosy',
        'microbiology_and_immunology',
        'pharmaceutical_technology',
        'pharmacy_practice',
      ],
    },
    {
      'title': (Translations t) => t.colleges.physical_therapy,
      'image': 'assets/images/college_physical_therapy.png',
      'color': const Color(0xFF0EA5E9),
      'stats': {
        'students': '---',
        'academic_staff': '---',
        'teaching_assistants': '---',
        'published_articles': '---',
      },
      'departments': [
        'basic_sciences_pt',
        'biomechanics',
        'pt_internal_medicine_and_geriatrics',
        'pt_womens_health',
        'pt_surgery_and_integumentary',
        'pt_orthopedics',
        'pt_neurology',
        'pt_pediatrics',
      ],
    },
    {
      'title': (Translations t) => t.colleges.ai,
      'image': 'assets/images/college_ai.png',
      'color': const Color(0xFF6366F1),
      'stats': {
        'students': '1,858',
        'academic_staff': '41',
        'teaching_assistants': '38',
        'published_articles': '16 +',
      },
      'departments': [
        'artificial_biomedical_computing',
        'artificial_cybersecurity',
        'ai_and_data_science',
        'ai_for_robotics',
        'smart_systems',
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onCollegeTap(Map<String, dynamic> college) {
    context.push('/college-details', extra: college);
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    Widget content = CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 60, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  t.onboarding.faculties_directory.title,
                  style: GoogleFonts.outfit(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isGlass
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ).animate().fadeIn().slideX(begin: -0.2),
                const SizedBox(height: 8),
                Text(
                  t.onboarding.faculties_directory.subtitle,
                  style: GoogleFonts.outfit(
                    fontSize: 16,
                    color: isGlass ? Colors.white70 : Colors.grey,
                  ),
                ).animate().fadeIn(delay: 200.ms).slideX(begin: -0.1),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 0.85,
            ),
            delegate: SliverChildBuilderDelegate((context, index) {
              final college = _colleges[index];
              return _buildCollegeCard(context, college, index, isGlass);
            }, childCount: _colleges.length),
          ),
        ),
      ],
    );

    if (widget.isOnboarding) {
      return isGlass ? GlassScaffold(body: content) : Scaffold(body: content);
    }
    return content;
  }

  Widget _buildCollegeCard(
    BuildContext context,
    Map<String, dynamic> college,
    int index,
    bool isGlass,
  ) {
    final color = college['color'] as Color;
    final image = college['image'] as String;
    final title = (college['title'] as String Function(Translations))(t);

    if (isGlass) {
      return GestureDetector(
        onTap: () => _onCollegeTap(college),
        child:
            GlassContainer(
                  borderRadius: BorderRadius.circular(30),
                  padding: EdgeInsets.zero,
                  child: Stack(
                    children: [

                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            color: Colors.black.withValues(alpha: 0.2),
                            colorBlendMode: BlendMode.darken,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: color.withValues(alpha: 0.1),
                                  child: Icon(
                                    LucideIcons.imageOff,
                                    color: color.withValues(alpha: 0.5),
                                    size: 40,
                                  ),
                                ),
                          ),
                        ),
                      ),

                      Positioned(
                        top: -20,
                        right: -20,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: color.withValues(alpha: 0.5),
                                blurRadius: 40,
                                spreadRadius: 10,
                              ),
                            ],
                          ),
                        ),
                      ),

                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.8),
                              ],
                            ),
                          ),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(delay: Duration(milliseconds: 100 * index))
                .moveY(begin: 30, end: 0, curve: Curves.easeOutQuart)
                .scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1)),
      );
    } else {

      return GestureDetector(
        onTap: () => _onCollegeTap(college),
        child:
            Container(
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 3,
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20),
                          ),
                          child: Image.asset(
                            image,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: color.withValues(alpha: 0.1),
                                  child: Icon(
                                    LucideIcons.imageOff,
                                    color: color.withValues(alpha: 0.5),
                                    size: 40,
                                  ),
                                ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            border: Border(
                              top: BorderSide(
                                color: color.withValues(alpha: 0.3),
                                width: 3,
                              ),
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .animate()
                .fadeIn(delay: Duration(milliseconds: 50 * index))
                .slideY(begin: 0.1, end: 0),
      );
    }
  }
}

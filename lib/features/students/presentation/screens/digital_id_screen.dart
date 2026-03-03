import 'dart:math' as math;
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/students/data/digital_id_theme_repository.dart';
import 'package:hue/features/students/domain/models/digital_id_theme.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class DigitalIDScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> studentData;

  const DigitalIDScreen({
    super.key,
    this.studentData = const {
      'name': 'Ahmed Mohamed',
      'id': '20230001',
      'college': 'ai',
      'specialization': 'artificial_cybersecurity',
      'gpa': '3.85',
      'level': '4',
    },
  });

  @override
  ConsumerState<DigitalIDScreen> createState() => _DigitalIDScreenState();
}

class _DigitalIDScreenState extends ConsumerState<DigitalIDScreen> {
  String? _overrideCollegeId;
  String? _overrideSpecId;

  final List<Map<String, dynamic>> _collegesData = [
    {
      'id': 'applied_health',
      'icon': LucideIcons.stethoscope,
      'nameEn': 'Applied Health',
      'nameAr': 'العلوم الصحية التطبيقية',
      'departments': [
        {
          'id': 'medical_laboratories_technology',
          'nameEn': 'Medical Labs',
          'nameAr': 'تكنولوجيا المختبرات الطبية',
        },
        {
          'id': 'radiology_and_imaging_technology',
          'nameEn': 'Radiology',
          'nameAr': 'تكنولوجيا الأشعة والتصوير الطبي',
        },
        {
          'id': 'respiratory_care_technology',
          'nameEn': 'Respiratory Care',
          'nameAr': 'تكنولوجيا الرعاية التنفسية',
        },
        {
          'id': 'dental_prosthetics_technology',
          'nameEn': 'Dental Prosthetics',
          'nameAr': 'تكنولوجيا الاستعاضة الصناعية للأسنان',
        },
        {
          'id': 'health_administration_and_informatics_technology',
          'nameEn': 'Health Admin',
          'nameAr': 'تكنولوجيا الإدارة الصحية والمعلوماتية',
        },
      ],
    },
    {
      'id': 'business',
      'icon': LucideIcons.briefcase,
      'nameEn': 'Business',
      'nameAr': 'إدارة الأعمال',
      'departments': [
        {'id': 'accounting', 'nameEn': 'Accounting', 'nameAr': 'المحاسبة'},
        {
          'id': 'business_management',
          'nameEn': 'Management',
          'nameAr': 'إدارة الأعمال',
        },
        {'id': 'economics', 'nameEn': 'Economics', 'nameAr': 'الاقتصاد'},
        {'id': 'marketing', 'nameEn': 'Marketing', 'nameAr': 'التسويق'},
        {
          'id': 'accounting_english',
          'nameEn': 'Accounting (EN)',
          'nameAr': 'برنامج المحاسبة (الإنجليزية)',
        },
        {
          'id': 'business_english',
          'nameEn': 'Business (EN)',
          'nameAr': 'برنامج إدارة الأعمال (الإنجليزية)',
        },
      ],
    },
    {
      'id': 'dentistry',
      'icon': LucideIcons.smile,
      'nameEn': 'Dentistry',
      'nameAr': 'طب الأسنان',
      'departments': [
        {
          'id': 'basic_dental_sciences',
          'nameEn': 'Basic Dental',
          'nameAr': 'العلوم الأساسية في طب الأسنان',
        },
        {
          'id': 'basic_medical_clinical_sciences',
          'nameEn': 'Clinical Sciences',
          'nameAr': 'العلوم الطبية والسريرية',
        },
        {
          'id': 'oral_maxillofacial_surgery',
          'nameEn': 'Oral Surgery',
          'nameAr': 'جراحة الفم والوجه والفكين',
        },
        {
          'id': 'orthodontics_pediatric_dentistry',
          'nameEn': 'Orthodontics',
          'nameAr': 'تقويم الأسنان وطب الأطفال',
        },
        {
          'id': 'periodontology_oral_medicine',
          'nameEn': 'Periodontology',
          'nameAr': 'طب أمراض اللثة والفم',
        },
        {
          'id': 'prosthodontics',
          'nameEn': 'Prosthodontics',
          'nameAr': 'الاستعاضة الصناعية',
        },
        {
          'id': 'conservative_endodontics',
          'nameEn': 'Endodontics',
          'nameAr': 'العلاج التحفظي وعلاج الجذور',
        },
      ],
    },
    {
      'id': 'engineering',
      'icon': LucideIcons.wrench,
      'nameEn': 'Engineering',
      'nameAr': 'الهندسة',
      'departments': [
        {
          'id': 'architectural_engineering',
          'nameEn': 'Architecture',
          'nameAr': 'الهندسة المعمارية',
        },
        {
          'id': 'basic_sciences_eng',
          'nameEn': 'Basic Sciences',
          'nameAr': 'العلوم الأساسية',
        },
        {
          'id': 'civil_engineering',
          'nameEn': 'Civil Eng',
          'nameAr': 'الهندسة المدنية',
        },
        {
          'id': 'mechanical_engineering',
          'nameEn': 'Mechanical Eng',
          'nameAr': 'الهندسة الميكانيكية',
        },
        {
          'id': 'electrical_engineering',
          'nameEn': 'Electrical Eng',
          'nameAr': 'الهندسة الكهربائية',
        },
        {
          'id': 'artificial_intelligence_engineering',
          'nameEn': 'AI Eng',
          'nameAr': 'هندسة الذكاء الاصطناعي',
        },
      ],
    },
    {
      'id': 'fine_arts',
      'icon': LucideIcons.palette,
      'nameEn': 'Fine Arts',
      'nameAr': 'الفنون الجميلة',
      'departments': [
        {
          'id': 'interior_design_architecture',
          'nameEn': 'Interior Design',
          'nameAr': 'التصميم الداخلي والعمارة',
        },
        {
          'id': 'furniture_design_production',
          'nameEn': 'Furniture Design',
          'nameAr': 'تكنولوجيا تصميم وإنتاج الأثاث',
        },
        {
          'id': 'graphic_digital_arts',
          'nameEn': 'Graphic Arts',
          'nameAr': 'الجرافيك والفنون الرقمية',
        },
        {
          'id': 'animation_multimedia',
          'nameEn': 'Animation',
          'nameAr': 'الرسوم المتحركة والوسائط المتعددة',
        },
      ],
    },
    {
      'id': 'medicine',
      'icon': LucideIcons.heartPulse,
      'nameEn': 'Medicine',
      'nameAr': 'الطب البشري',
      'departments': [
        {
          'id': 'medical_education',
          'nameEn': 'Med Education',
          'nameAr': 'التعليم الطبي',
        },
        {
          'id': 'histology_cell_biology',
          'nameEn': 'Histology',
          'nameAr': 'علم الأنسجة وبيولوجيا الخلية',
        },
        {
          'id': 'human_anatomy_embryology',
          'nameEn': 'Anatomy',
          'nameAr': 'التشريح البشري وعلم الأجنة',
        },
        {
          'id': 'medical_physiology',
          'nameEn': 'Physiology',
          'nameAr': 'الفسيولوجيا الطبية',
        },
        {
          'id': 'medical_microbiology_immunology',
          'nameEn': 'Microbiology',
          'nameAr': 'الميكروبيولوجيا والمناعة',
        },
        {
          'id': 'forensic_medicine_toxicology',
          'nameEn': 'Forensic',
          'nameAr': 'الطب الشرعي والسموم',
        },
        {
          'id': 'community_medicine_public_health',
          'nameEn': 'Public Health',
          'nameAr': 'طب المجتمع والصحة العامة',
        },
        {
          'id': 'biochemistry',
          'nameEn': 'Biochemistry',
          'nameAr': 'الكيمياء الحيوية',
        },
        {
          'id': 'pathology',
          'nameEn': 'Pathology',
          'nameAr': 'الباثولوجيا (علم الأمراض)',
        },
      ],
    },
    {
      'id': 'linguistics',
      'icon': LucideIcons.languages,
      'nameEn': 'Linguistics',
      'nameAr': 'الألسن والترجمة',
      'departments': [
        {
          'id': 'english_program',
          'nameEn': 'English',
          'nameAr': 'برنامج اللغة الإنجليزية',
        },
        {
          'id': 'german_program',
          'nameEn': 'German',
          'nameAr': 'برنامج اللغة الألمانية',
        },
        {
          'id': 'chinese_program',
          'nameEn': 'Chinese',
          'nameAr': 'برنامج اللغة الصينية',
        },
        {
          'id': 'french_department',
          'nameEn': 'French',
          'nameAr': 'قسم اللغة الفرنسية',
        },
        {
          'id': 'translation_department',
          'nameEn': 'Translation',
          'nameAr': 'قسم الترجمة',
        },
      ],
    },
    {
      'id': 'pharmacy',
      'icon': LucideIcons.pill,
      'nameEn': 'Pharmacy',
      'nameAr': 'الصيدلة',
      'departments': [
        {
          'id': 'clinical_pharmacy',
          'nameEn': 'Clinical Pharmacy',
          'nameAr': 'الصيدلة الإكلينيكية',
        },
        {
          'id': 'pharmaceutical_chemistry',
          'nameEn': 'Pharma Chem',
          'nameAr': 'الكيمياء الصيدلية',
        },
        {
          'id': 'pharmacology_biochemistry',
          'nameEn': 'Pharmacology',
          'nameAr': 'علم الأدوية والكيمياء الحيوية',
        },
        {
          'id': 'pharmacognosy',
          'nameEn': 'Pharmacognosy',
          'nameAr': 'العقاقير',
        },
        {
          'id': 'pharm_microbiology_immunology',
          'nameEn': 'Microbiology',
          'nameAr': 'الميكروبيولوجيا والمناعة',
        },
        {
          'id': 'pharmaceutical_technology',
          'nameEn': 'Pharma Tech',
          'nameAr': 'التكنولوجيا الصيدلية',
        },
        {
          'id': 'pharmacy_practice',
          'nameEn': 'Pharmacy Practice',
          'nameAr': 'الممارسة الصيدلية',
        },
      ],
    },
    {
      'id': 'physical_therapy',
      'icon': LucideIcons.activity,
      'nameEn': 'Physical Therapy',
      'nameAr': 'العلاج الطبيعي',
      'departments': [
        {
          'id': 'pt_basic_sciences',
          'nameEn': 'Basic Sciences',
          'nameAr': 'العلوم الأساسية للعلاج الطبيعي',
        },
        {
          'id': 'biomechanics',
          'nameEn': 'Biomechanics',
          'nameAr': 'الميكانيكا الحيوية',
        },
        {
          'id': 'pt_internal_medicine',
          'nameEn': 'Internal Med',
          'nameAr': 'العلاج الطبيعي للباطنة والمسنين',
        },
        {
          'id': 'pt_womens_health',
          'nameEn': 'Womens Health',
          'nameAr': 'العلاج الطبيعي لصحة المرأة',
        },
        {
          'id': 'pt_surgery_dermatology',
          'nameEn': 'Surgery/Derma',
          'nameAr': 'العلاج الطبيعي للجراحة والجلدية',
        },
        {
          'id': 'pt_orthopedics',
          'nameEn': 'Orthopedics',
          'nameAr': 'العلاج الطبيعي للعظام',
        },
        {
          'id': 'pt_neurology',
          'nameEn': 'Neurology',
          'nameAr': 'العلاج الطبيعي للجهاز العصبي',
        },
        {
          'id': 'pt_pediatrics',
          'nameEn': 'Pediatrics',
          'nameAr': 'العلاج الطبيعي للأطفال',
        },
      ],
    },
    {
      'id': 'ai',
      'icon': LucideIcons.bot,
      'nameEn': 'Artificial Intelligence',
      'nameAr': 'الذكاء الاصطناعي',
      'departments': [
        {
          'id': 'ai_biomedical_computing',
          'nameEn': 'Biomedical AI',
          'nameAr': 'الحوسبة الحيوية الطبية',
        },
        {
          'id': 'ai_cybersecurity',
          'nameEn': 'Cyber Security',
          'nameAr': 'الأمن السيبراني الذكي',
        },
        {
          'id': 'ai_data_science',
          'nameEn': 'Data Science',
          'nameAr': 'الذكاء الاصطناعي وعلوم البيانات',
        },
        {
          'id': 'ai_robotics',
          'nameEn': 'Robotics',
          'nameAr': 'الذكاء الاصطناعي للروبوتات',
        },
        {
          'id': 'ai_smart_systems',
          'nameEn': 'Smart Systems',
          'nameAr': 'الأنظمة الذكية',
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final effectiveCollegeId =
        _overrideCollegeId ?? widget.studentData['college']?.toString() ?? 'ai';
    final effectiveSpecId =
        _overrideSpecId ?? widget.studentData['specialization']?.toString();

    final studentDataWithOverride = Map<String, dynamic>.from(
      widget.studentData,
    );
    studentDataWithOverride['college'] = effectiveCollegeId;
    studentDataWithOverride['specialization'] = effectiveSpecId;

    return GlassScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => context.pop(),
        ),
        title: Text(
          t.students.smart_digital_id,
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
              .copyWith(
                color: Colors.white,
                letterSpacing: 1.5,
                fontWeight: FontWeight.w900,
              ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.share2, color: Colors.white),
            onPressed: () => _showShareDialog(context),
          ),
        ],
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.5,
            colors: [
              Colors.blueAccent.withValues(alpha: 0.1),
              Colors.transparent,
            ],
          ),
        ),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              _buildThemeSelector(isArabic),
              const SizedBox(height: 20),
              _Interactive3DCard(studentData: studentDataWithOverride),
              const SizedBox(height: 40),
              _buildSecurityStatus(isArabic),
              const SizedBox(height: 30),
              _buildActionGrid(context, isArabic),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThemeSelector(bool isArabic) {
    final selectedCollegeId =
        _overrideCollegeId ?? widget.studentData['college'];
    final selectedCollege = _collegesData.firstWhere(
      (c) => c['id'] == selectedCollegeId,
      orElse: () => _collegesData.last,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 55,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _collegesData.length,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final college = _collegesData[index];
              final isSelected = selectedCollegeId == college['id'];

              return GestureDetector(
                onTap: () => setState(() {
                  _overrideCollegeId = college['id'] as String;
                  _overrideSpecId = null;
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuint,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blueAccent.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.blueAccent
                          : Colors.white.withValues(alpha: 0.1),
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.blueAccent.withValues(alpha: 0.3),
                              blurRadius: 15,
                              spreadRadius: -5,
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        college['icon'] as IconData,
                        color: isSelected ? Colors.white : Colors.white38,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isArabic
                            ? college['nameAr'] as String
                            : college['nameEn'] as String,
                        style:
                            (isArabic
                                    ? GoogleFonts.tajawal()
                                    : GoogleFonts.outfit())
                                .copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white38,
                                  fontWeight: isSelected
                                      ? FontWeight.w900
                                      : FontWeight.w600,
                                  fontSize: 13,
                                ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildDepartmentSelector(isArabic, selectedCollege, selectedCollegeId),
      ],
    );
  }

  Widget _buildDepartmentSelector(
    bool isArabic,
    Map<String, dynamic> selectedCollege,
    dynamic selectedCollegeId,
  ) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        key: ValueKey(selectedCollegeId),
        height: 45,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: (selectedCollege['departments'] as List).length,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (_, _) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final dept = (selectedCollege['departments'] as List)[index];
            final isSelected =
                (_overrideSpecId ?? widget.studentData['specialization']) ==
                dept['id'];

            return GestureDetector(
              onTap: () =>
                  setState(() => _overrideSpecId = dept['id'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuint,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                child: Center(
                  child: Text(
                    isArabic
                        ? dept['nameAr'] as String
                        : dept['nameEn'] as String,
                    style:
                        (isArabic
                                ? GoogleFonts.tajawal()
                                : GoogleFonts.outfit())
                            .copyWith(
                              color: isSelected ? Colors.white : Colors.white24,
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSecurityStatus(bool isArabic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withValues(alpha: 0.1),
            blurRadius: 30,
            spreadRadius: -10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                duration: 1.seconds,
                begin: const Offset(1, 1),
                end: const Offset(1.5, 1.5),
              )
              .fadeOut(),
          const SizedBox(width: 16),
          Text(
            t.students.identity_active_secure,
            style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                .copyWith(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 2.0,
                ),
          ),
          const SizedBox(width: 12),
          const Icon(
            LucideIcons.shieldCheck,
            color: Colors.greenAccent,
            size: 18,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.5, end: 0);
  }

  Widget _buildActionGrid(BuildContext context, bool isArabic) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.6,
      children: [
        _buildActionCard(
          LucideIcons.nfc,
          t.students.nfc_pass,
          Colors.blueAccent,
          isArabic,
        ),
        _buildActionCard(
          LucideIcons.download,
          t.students.offline_copy,
          Colors.purpleAccent,
          isArabic,
        ),
        _buildActionCard(
          LucideIcons.history,
          t.students.access_logs,
          Colors.orangeAccent,
          isArabic,
        ),
        _buildActionCard(
          LucideIcons.settings,
          t.students.settings,
          Colors.tealAccent,
          isArabic,
        ),
      ],
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildActionCard(
    IconData icon,
    String label,
    Color color,
    bool isArabic,
  ) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(16),
      border: Border.all(color: color.withValues(alpha: 0.2)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color.withValues(alpha: 0.1), Colors.transparent],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            label,
            style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                .copyWith(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    ).animate().shimmer(
      delay: 2.seconds,
      duration: 1.5.seconds,
      color: color.withValues(alpha: 0.1),
    );
  }

  void _showShareDialog(BuildContext context) {
    // ... logic remains similar but with updated styling
    final isArabic = t.$meta.locale.languageCode == 'ar';
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              t.students.share_identity,
              style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                  .copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ShareOption(
                  icon: LucideIcons.download,
                  label: t.students.download,
                  color: Colors.blueAccent,
                ),
                _ShareOption(
                  icon: LucideIcons.copy,
                  label: t.students.copy,
                  color: Colors.orangeAccent,
                ),
                _ShareOption(
                  icon: LucideIcons.send,
                  label: t.students.send,
                  color: Colors.greenAccent,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class _Interactive3DCard extends StatefulWidget {
  final Map<String, dynamic> studentData;

  const _Interactive3DCard({required this.studentData});

  @override
  State<_Interactive3DCard> createState() => _Interactive3DCardState();
}

class _Interactive3DCardState extends State<_Interactive3DCard>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  // For 3D Tilt
  Offset _tilt = Offset.zero;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack),
    );
  }

  void _toggleFlip() {
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _isFlipped = !_isFlipped);
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFlip,
      onPanUpdate: (details) {
        setState(() {
          _tilt += Offset(details.delta.dx / 1000, details.delta.dy / 1000);
          _tilt = Offset(_tilt.dx.clamp(-0.2, 0.2), _tilt.dy.clamp(-0.2, 0.2));
        });
      },
      onPanEnd: (_) => setState(() => _tilt = Offset.zero),
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final angle = _flipAnimation.value * math.pi;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_tilt.dy)
              ..rotateY(_tilt.dx + angle),
            alignment: Alignment.center,
            child: angle < math.pi / 2
                ? _FrontCard(studentData: widget.studentData, tilt: _tilt)
                : Transform(
                    transform: Matrix4.identity()..rotateY(math.pi),
                    alignment: Alignment.center,
                    child: _BackCard(
                      studentData: widget.studentData,
                      tilt: _tilt,
                    ),
                  ),
          );
        },
      ).animate().scale(duration: 1.seconds, curve: Curves.elasticOut),
    );
  }
}

class _FrontCard extends StatelessWidget {
  final Map<String, dynamic> studentData;
  final Offset tilt;

  const _FrontCard({required this.studentData, required this.tilt});

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final seed =
        int.tryParse(
          studentData['id']?.toString().replaceAll(RegExp(r'[^0-9]'), '') ??
              '0',
        ) ??
        0;
    final theme = DigitalIDThemeRepository.getTheme(
      collegeId: studentData['college']?.toString() ?? '',
      specializationId: studentData['specialization']?.toString(),
    );

    return Container(
      height: 290,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: 0.3),
            blurRadius: 50,
            spreadRadius: -10,
            offset: Offset(tilt.dx * 100, tilt.dy * 100),
          ),
        ],
      ),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(32),
        blur: 40,
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.2),
          width: 1.5,
        ),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.primaryColor.withValues(alpha: 0.4),
            const Color(0xFF0F172A).withValues(alpha: 0.8),
          ],
        ),
        child: Stack(
          children: [
            _buildHolographicSweep(theme, tilt),
            _buildGridPattern(theme, seed),
            _buildContent(theme, isArabic, seed),
          ],
        ),
      ),
    );
  }

  Widget _buildHolographicSweep(DigitalIDTheme theme, Offset tilt) {
    return Positioned.fill(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          gradient: LinearGradient(
            begin: Alignment(tilt.dx - 1, tilt.dy - 1),
            end: Alignment(tilt.dx + 1, tilt.dy + 1),
            colors: [
              Colors.transparent,
              Colors.white.withValues(
                alpha: theme.designStyle == DigitalIDDesignStyle.cyber
                    ? 0.15
                    : 0.05,
              ),
              theme.secondaryColor.withValues(alpha: 0.15),
              Colors.white.withValues(
                alpha: theme.designStyle == DigitalIDDesignStyle.cyber
                    ? 0.15
                    : 0.05,
              ),
              Colors.transparent,
            ],
            stops: const [0.0, 0.4, 0.5, 0.6, 1.0],
          ),
        ),
      ),
    );
  }

  Widget _buildGridPattern(DigitalIDTheme theme, int seed) {
    if (theme.designStyle == DigitalIDDesignStyle.cyber) {
      return Positioned.fill(
        child: CustomPaint(
          painter: _CircuitPainter(
            theme.secondaryColor.withValues(alpha: 0.1),
            seed: seed,
          ),
        ),
      );
    }

    if (theme.designStyle == DigitalIDDesignStyle.organic) {
      return Positioned.fill(
        child: Opacity(opacity: 0.05, child: _OrganicPattern(seed: seed)),
      );
    }

    return Positioned.fill(
      child: Opacity(
        opacity: 0.05,
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: theme.designStyle == DigitalIDDesignStyle.classic
                ? 10
                : 20,
          ),
          itemBuilder: (context, index) {
            // Use seed to subtly vary the grid
            final isVisible = (math.Random(seed + index).nextDouble() > 0.2);
            if (!isVisible) return const SizedBox();

            return Container(
              margin: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 0.2),
                shape: theme.designStyle == DigitalIDDesignStyle.elegant
                    ? BoxShape.circle
                    : BoxShape.rectangle,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildContent(DigitalIDTheme theme, bool isArabic, int seed) {
    // Fetch base college theme for the name
    final collegeTheme = DigitalIDThemeRepository.getTheme(
      collegeId: studentData['college']?.toString() ?? '',
    );

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildBrand(isArabic, collegeTheme.name),
              _buildUniqueSignature(theme, seed),
              _buildSecurityChip(theme),
            ],
          ),
          const Spacer(),
          Row(
            children: [
              _buildAvatar(theme),
              const SizedBox(width: 24),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      studentData['name'] ?? 'Ahmed Mohamed',
                      style:
                          (isArabic
                                  ? GoogleFonts.tajawal()
                                  : GoogleFonts.outfit())
                              .copyWith(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                height: 1.1,
                                shadows:
                                    theme.designStyle ==
                                        DigitalIDDesignStyle.cyber
                                    ? [
                                        Shadow(
                                          color: theme.primaryColor.withValues(
                                            alpha: 0.5,
                                          ),
                                          blurRadius: 10,
                                        ),
                                      ]
                                    : null,
                              ),
                    ),
                    const SizedBox(height: 8),
                    if (studentData['specialization'] != null)
                      _buildDeptBadge(theme, isArabic),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          _buildInfoBar(isArabic, theme),
        ],
      ),
    );
  }

  Widget _buildUniqueSignature(DigitalIDTheme theme, int seed) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(8, (i) {
          final random = math.Random(seed + i);
          return Container(
            width: 2,
            height: random.nextDouble() * 10 + 2,
            margin: const EdgeInsets.symmetric(horizontal: 1),
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(
                alpha: 0.5 + random.nextDouble() * 0.5,
              ),
              borderRadius: BorderRadius.circular(1),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildBrand(bool isArabic, String collegeName) {
    return Row(
      children: [
        const Icon(LucideIcons.graduationCap, color: Colors.white, size: 24),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.students.horus_university_1,
              style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.cinzel())
                  .copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 12,
                    letterSpacing: isArabic ? 0 : 2,
                  ),
            ),
            Text(
              collegeName.toUpperCase(),
              style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                  .copyWith(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSecurityChip(DigitalIDTheme theme) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        shape: BoxShape.circle,
        border: Border.all(color: theme.secondaryColor.withValues(alpha: 0.3)),
      ),
      child: Icon(theme.patternIcon, color: theme.secondaryColor, size: 20),
    ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds);
  }

  Widget _buildAvatar(DigitalIDTheme theme) {
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          colors: [theme.primaryColor, theme.secondaryColor],
        ),
        boxShadow: [
          BoxShadow(
            color: theme.primaryColor.withValues(alpha: 0.5),
            blurRadius: 20,
          ),
        ],
      ),
      child: CircleAvatar(
        radius: 40,
        backgroundColor: const Color(0xFF0F172A),
        child: Icon(
          theme.designStyle == DigitalIDDesignStyle.cyber
              ? LucideIcons.userCheck
              : LucideIcons.user,
          color: Colors.white,
          size: 40,
        ),
      ),
    );
  }

  Widget _buildDeptBadge(DigitalIDTheme theme, bool isArabic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: theme.secondaryColor.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(
          theme.designStyle == DigitalIDDesignStyle.organic ? 20 : 8,
        ),
        border: Border.all(color: theme.secondaryColor.withValues(alpha: 0.3)),
      ),
      child: Text(
        theme.name.toUpperCase(),
        style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
            .copyWith(
              color: theme.secondaryColor,
              fontSize: 8,
              fontWeight: FontWeight.w900,
              letterSpacing: 1.2,
            ),
      ),
    );
  }

  Widget _buildInfoBar(bool isArabic, DigitalIDTheme theme) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(
          theme.designStyle == DigitalIDDesignStyle.cyber ? 8 : 16,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.05)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildInfoItem(
            t.students.id_no,
            studentData['id'] ?? '---',
            isArabic,
            theme: theme,
          ),
          _buildInfoItem(
            t.students.gpa,
            studentData['gpa'] ?? '---',
            isArabic,
            theme: theme,
          ),
          _buildInfoItem(
            t.students.level,
            studentData['level'] ?? '---',
            isArabic,
            theme: theme,
          ),
          _buildInfoItem(
            t.students.status,
            t.students.active,
            isArabic,
            theme: theme,
            color: Colors.greenAccent,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(
    String label,
    String value,
    bool isArabic, {
    required DigitalIDTheme theme,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
              .copyWith(
                color: Colors.white38,
                fontSize: 8,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
              .copyWith(
                color: color ?? Colors.white,
                fontSize: 13,
                fontWeight: FontWeight.w900,
                shadows: theme.designStyle == DigitalIDDesignStyle.cyber
                    ? [
                        Shadow(
                          color: (color ?? Colors.white).withValues(alpha: 0.5),
                          blurRadius: 5,
                        ),
                      ]
                    : null,
              ),
        ),
      ],
    );
  }
}

class _CircuitPainter extends CustomPainter {
  final Color color;
  final int seed;
  _CircuitPainter(this.color, {required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final random = math.Random(seed);
    final path = Path();
    for (var i = 0; i < 8; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      path.moveTo(x, 0);
      path.lineTo(x, y);
      path.lineTo(x + (random.nextBool() ? 20 : -20), y + 20);
      path.lineTo(x + (random.nextBool() ? 20 : -20), size.height);

      if (random.nextBool()) {
        canvas.drawCircle(Offset(x, y), 2, paint..style = PaintingStyle.fill);
        paint.style = PaintingStyle.stroke;
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CircuitPainter oldDelegate) =>
      oldDelegate.seed != seed;
}

class _OrganicPattern extends StatelessWidget {
  final int seed;
  const _OrganicPattern({required this.seed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(12, (index) {
        final r = math.Random(seed + index);
        return Positioned(
          left: r.nextDouble() * 300 - 50,
          top: r.nextDouble() * 300 - 50,
          child: Container(
            width: r.nextDouble() * 150 + 50,
            height: r.nextDouble() * 150 + 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 0.5,
              ),
            ),
          ),
        );
      }),
    );
  }
}

class _BackCard extends StatelessWidget {
  final Map<String, dynamic> studentData;
  final Offset tilt;

  const _BackCard({required this.studentData, required this.tilt});

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final theme = DigitalIDThemeRepository.getTheme(
      collegeId: studentData['college']?.toString() ?? '',
      specializationId: studentData['specialization']?.toString(),
    );

    return Container(
      height: 290,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 40,
            offset: Offset(tilt.dx * 50, tilt.dy * 50),
          ),
        ],
      ),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(32),
        blur: 40,
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          colors: [
            const Color(0xFF0F172A),
            theme.primaryColor.withValues(alpha: 0.5),
          ],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildQR(theme),
                  const SizedBox(height: 24),
                  Text(
                    t.students.scan_for_secure_access,
                    style:
                        (isArabic
                                ? GoogleFonts.tajawal()
                                : GoogleFonts.outfit())
                            .copyWith(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(
                    LucideIcons.shieldCheck,
                    color: Colors.white24,
                    size: 20,
                  ),
                  Text(
                    'ENCRYPTED VERIFICATION SYSTEM',
                    style: GoogleFonts.outfit(
                      color: Colors.white10,
                      fontSize: 8,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQR(DigitalIDTheme theme) {
    return Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(
                color: theme.secondaryColor.withValues(alpha: 0.3),
                blurRadius: 30,
                spreadRadius: 5,
              ),
            ],
          ),
          child: const Icon(LucideIcons.qrCode, color: Colors.black, size: 120),
        )
        .animate(onPlay: (c) => c.repeat())
        .shimmer(
          duration: 3.seconds,
          color: theme.secondaryColor.withValues(alpha: 0.2),
        );
  }
}

class _ShareOption extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  const _ShareOption({
    required this.icon,
    required this.label,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
            border: Border.all(color: color.withValues(alpha: 0.2)),
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
              .copyWith(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}

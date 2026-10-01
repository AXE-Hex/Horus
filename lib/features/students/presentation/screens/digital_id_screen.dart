import 'package:horus/core/router/back_navigation.dart';
import 'package:horus/features/colleges/presentation/legacy_college_data.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/features/academic/data/repositories/professor_repository.dart';
import 'dart:math' as math;

import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:horus/features/students/data/digital_id_theme_repository.dart';
import 'package:horus/features/students/domain/models/digital_id_theme.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'digital_id_screen_sections.dart';
part 'digital_id_card_interaction.dart';
part 'digital_id_card_front.dart';
part 'digital_id_card_patterns.dart';
part 'digital_id_card_back.dart';

class DigitalIDScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> studentData;

  const DigitalIDScreen({super.key, this.studentData = const {}});

  @override
  ConsumerState<DigitalIDScreen> createState() => _DigitalIDScreenState();
}

class _DigitalIDScreenState extends ConsumerState<DigitalIDScreen> {
  Map<String, dynamic> get _identityData {
    final auth = ref.watch(authControllerProvider);
    final profile = auth.profile;
    final summary = ref.watch(academicSummaryProvider).value;
    final college = ref
        .watch(legacyCollegeProvider(profile?.collegeId ?? ''))
        .value;
    final departments =
        ref
            .watch(legacyCollegeDepartmentsProvider(profile?.collegeId ?? ''))
            .value ??
        [];
    final department = departments
        .where((item) => item.id == profile?.departmentId)
        .firstOrNull;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    return {
      'collegeName': isArabic ? college?.nameAr ?? '—' : college?.nameEn ?? '—',
      'specializationName': isArabic
          ? department?.nameAr ?? '—'
          : department?.nameEn ?? '—',
      'name': t.$meta.locale.languageCode == 'ar'
          ? (profile?.fullNameAr ?? profile?.fullName ?? '—')
          : (profile?.fullName ?? '—'),
      'id': profile?.studentId ?? '—',
      'college': profile?.collegeId ?? '',
      'specialization': profile?.departmentId,
      'gpa': summary?.gpa?.toStringAsFixed(2) ?? '—',
      'level': '—',
    };
  }

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

  void _updateState(VoidCallback callback) => setState(callback);

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authControllerProvider);
    if (!auth.hasRole || auth.profile?.studentId == null) {
      return Scaffold(
        appBar: AppBar(title: Text(t.students.smart_digital_id)),
        body: Center(child: Text(t.students.id_unavailable)),
      );
    }
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final effectiveCollegeId =
        _overrideCollegeId ?? _identityData['college']?.toString() ?? '';
    final effectiveSpecId =
        _overrideSpecId ?? _identityData['specialization']?.toString();

    final studentDataWithOverride = Map<String, dynamic>.from(_identityData);
    studentDataWithOverride['college'] = effectiveCollegeId;
    studentDataWithOverride['specialization'] = effectiveSpecId;

    return GlassScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
          onPressed: () => context.backToHorus(),
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
              LayoutBuilder(
                builder: (context, constraints) => FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: math.max(400, constraints.maxWidth),
                    height: 290,
                    // A digital card is fixed artwork, like a printed ID.
                    child: MediaQuery.withNoTextScaling(
                      child: _Interactive3DCard(
                        studentData: studentDataWithOverride,
                      ),
                    ),
                  ),
                ),
              ),
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
}

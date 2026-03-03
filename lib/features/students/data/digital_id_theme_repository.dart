import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../domain/models/digital_id_theme.dart';

class DigitalIDThemeRepository {
  static final Map<String, DigitalIDTheme> _colleges = {
    'applied_health': _createTheme(
      'health',
      'Applied Health Sciences',
      const Color(0xFF0D9488),
      LucideIcons.stethoscope,
      style: DigitalIDDesignStyle.organic,
    ),
    'business': _createTheme(
      'biz',
      'Business Admin',
      const Color(0xFF4F46E5),
      LucideIcons.briefcase,
      style: DigitalIDDesignStyle.modern,
    ),
    'dentistry': _createTheme(
      'dent',
      'Dentistry',
      const Color(0xFF14B8A6),
      LucideIcons.smile,
      style: DigitalIDDesignStyle.organic,
    ),
    'engineering': _createTheme(
      'eng',
      'Engineering',
      const Color(0xFFE11D48),
      LucideIcons.wrench,
      style: DigitalIDDesignStyle.cyber,
    ),
    'fine_arts': _createTheme(
      'arts',
      'Fine Arts',
      const Color(0xFF9333EA),
      LucideIcons.palette,
      style: DigitalIDDesignStyle.elegant,
    ),
    'medicine': _createTheme(
      'med',
      'Human Medicine',
      const Color(0xFFBE123C),
      LucideIcons.heartPulse,
      style: DigitalIDDesignStyle.organic,
    ),
    'linguistics': _createTheme(
      'lang',
      'Languages & Translation',
      const Color(0xFFF59E0B),
      LucideIcons.languages,
      style: DigitalIDDesignStyle.modern,
    ),
    'pharmacy': _createTheme(
      'pharm',
      'Pharmacy',
      const Color(0xFF10B981),
      LucideIcons.pill,
      style: DigitalIDDesignStyle.organic,
    ),
    'physical_therapy': _createTheme(
      'pt',
      'Physical Therapy',
      const Color(0xFF0EA5E9),
      LucideIcons.activity,
      style: DigitalIDDesignStyle.organic,
    ),
    'ai': _createTheme(
      'ai',
      'Artificial Intelligence',
      const Color(0xFF6366F1),
      LucideIcons.bot,
      style: DigitalIDDesignStyle.cyber,
    ),
  };

  static final Map<String, DigitalIDTheme> _specializations = {
    // Applied Health
    'medical_laboratories_technology': _createSpec(
      'lab',
      'Medical Laboratories',
      const Color(0xFF0D9488),
      LucideIcons.microscope,
      style: DigitalIDDesignStyle.organic,
    ),
    'radiology_and_imaging_technology': _createSpec(
      'xray',
      'Radiology & Imaging',
      const Color(0xFF334155),
      LucideIcons.scan,
      style: DigitalIDDesignStyle.cyber,
    ),
    'respiratory_care_technology': _createSpec(
      'resp',
      'Respiratory Care',
      const Color(0xFF06B6D4),
      LucideIcons.activity,
      style: DigitalIDDesignStyle.organic,
    ),
    'dental_prosthetics_technology': _createSpec(
      'prosth',
      'Dental Prosthetics',
      const Color(0xFF8B5CF6),
      LucideIcons.smile,
      style: DigitalIDDesignStyle.organic,
    ),
    'health_administration_and_informatics_technology': _createSpec(
      'admin',
      'Health Admin',
      const Color(0xFF4F46E5),
      LucideIcons.clipboard,
      style: DigitalIDDesignStyle.modern,
    ),

    // Business
    'accounting': _createSpec(
      'acc',
      'Accounting',
      const Color(0xFF374151),
      LucideIcons.calculator,
      style: DigitalIDDesignStyle.modern,
    ),
    'business_management': _createSpec(
      'mgmt',
      'Management',
      const Color(0xFF1D4ED8),
      LucideIcons.users,
      style: DigitalIDDesignStyle.modern,
    ),
    'economics': _createSpec(
      'econ',
      'Economics',
      const Color(0xFF166534),
      LucideIcons.trendingUp,
      style: DigitalIDDesignStyle.modern,
    ),
    'marketing': _createSpec(
      'mkt',
      'Marketing',
      const Color(0xFFF97316),
      LucideIcons.megaphone,
      style: DigitalIDDesignStyle.elegant,
    ),
    'accounting_english': _createSpec(
      'acc_en',
      'Accounting (EN)',
      const Color(0xFF374151),
      LucideIcons.languages,
      style: DigitalIDDesignStyle.modern,
    ),
    'business_english': _createSpec(
      'biz_en',
      'Business (EN)',
      const Color(0xFFCA8A04),
      LucideIcons.languages,
      style: DigitalIDDesignStyle.modern,
    ),

    // Dentistry
    'basic_dental_sciences': _createSpec(
      'bds',
      'Basic Dental Sciences',
      const Color(0xFF14B8A6),
      LucideIcons.microscope,
      style: DigitalIDDesignStyle.organic,
    ),
    'basic_medical_clinical_sciences': _createSpec(
      'bmcs',
      'Clinical Sciences',
      const Color(0xFF0D9488),
      LucideIcons.stethoscope,
      style: DigitalIDDesignStyle.organic,
    ),
    'oral_maxillofacial_surgery': _createSpec(
      'oms',
      'Oral Surgery',
      const Color(0xFFBE123C),
      LucideIcons.scissors,
      style: DigitalIDDesignStyle.organic,
    ),
    'orthodontics_pediatric_dentistry': _createSpec(
      'ortho',
      'Orthodontics',
      const Color(0xFF8B5CF6),
      LucideIcons.smile,
      style: DigitalIDDesignStyle.organic,
    ),
    'periodontology_oral_medicine': _createSpec(
      'perio',
      'Periodontology',
      const Color(0xFF10B981),
      LucideIcons.activity,
      style: DigitalIDDesignStyle.organic,
    ),
    'prosthodontics': _createSpec(
      'prosth_dent',
      'Prosthodontics',
      const Color(0xFF6366F1),
      LucideIcons.smile,
      style: DigitalIDDesignStyle.organic,
    ),
    'conservative_endodontics': _createSpec(
      'endo',
      'Endodontics',
      const Color(0xFF06B6D4),
      LucideIcons.activity,
      style: DigitalIDDesignStyle.organic,
    ),

    // Engineering
    'architectural_engineering': _createSpec(
      'arch',
      'Architecture',
      const Color(0xFFD97706),
      LucideIcons.penTool,
      style: DigitalIDDesignStyle.elegant,
    ),
    'basic_sciences_eng': _createSpec(
      'base',
      'Basic Sciences',
      const Color(0xFF64748B),
      LucideIcons.atom,
      style: DigitalIDDesignStyle.classic,
    ),
    'civil_engineering': _createSpec(
      'civil',
      'Civil Engineering',
      const Color(0xFFEA580C),
      LucideIcons.hardHat,
      style: DigitalIDDesignStyle.classic,
    ),
    'mechanical_engineering': _createSpec(
      'mech',
      'Mechanical Eng',
      const Color(0xFF475569),
      LucideIcons.settings,
      style: DigitalIDDesignStyle.cyber,
    ),
    'electrical_engineering': _createSpec(
      'elec',
      'Electrical Eng',
      const Color(0xFF2563EB),
      LucideIcons.zap,
      style: DigitalIDDesignStyle.cyber,
    ),
    'artificial_intelligence_engineering': _createSpec(
      'ai_eng',
      'AI Engineering',
      const Color(0xFF6366F1),
      LucideIcons.bot,
      style: DigitalIDDesignStyle.cyber,
    ),

    // Fine Arts
    'interior_design_architecture': _createSpec(
      'interior',
      'Interior Design',
      const Color(0xFF9333EA),
      LucideIcons.home,
      style: DigitalIDDesignStyle.elegant,
    ),
    'furniture_design_production': _createSpec(
      'furn',
      'Furniture Design',
      const Color(0xFF7C3AED),
      LucideIcons.layout,
      style: DigitalIDDesignStyle.elegant,
    ),
    'graphic_digital_arts': _createSpec(
      'graphic',
      'Graphic Arts',
      const Color(0xFFD946EF),
      LucideIcons.image,
      style: DigitalIDDesignStyle.elegant,
    ),
    'animation_multimedia': _createSpec(
      'anim',
      'Animation',
      const Color(0xFFC026D3),
      LucideIcons.monitor,
      style: DigitalIDDesignStyle.elegant,
    ),

    // Medicine
    'medical_education': _createSpec(
      'med_edu',
      'Medical Education',
      const Color(0xFFBE123C),
      LucideIcons.graduationCap,
      style: DigitalIDDesignStyle.organic,
    ),
    'histology_cell_biology': _createSpec(
      'hist',
      'Histology',
      const Color(0xFFE11D48),
      LucideIcons.microscope,
      style: DigitalIDDesignStyle.organic,
    ),
    'human_anatomy_embryology': _createSpec(
      'anat',
      'Anatomy',
      const Color(0xFFFB7185),
      LucideIcons.accessibility,
      style: DigitalIDDesignStyle.organic,
    ),
    'medical_physiology': _createSpec(
      'phys',
      'Physiology',
      const Color(0xFFF43F5E),
      LucideIcons.activity,
      style: DigitalIDDesignStyle.organic,
    ),
    'medical_microbiology_immunology': _createSpec(
      'micro',
      'Microbiology',
      const Color(0xFF10B981),
      LucideIcons.bug,
      style: DigitalIDDesignStyle.organic,
    ),
    'forensic_medicine_toxicology': _createSpec(
      'foren',
      'Forensic Medicine',
      const Color(0xFF475569),
      LucideIcons.shield,
      style: DigitalIDDesignStyle.organic,
    ),
    'community_medicine_public_health': _createSpec(
      'pub',
      'Public Health',
      const Color(0xFF0369A1),
      LucideIcons.users,
      style: DigitalIDDesignStyle.organic,
    ),
    'biochemistry': _createSpec(
      'biochem',
      'Biochemistry',
      const Color(0xFF1D4ED8),
      LucideIcons.flaskConical,
      style: DigitalIDDesignStyle.organic,
    ),
    'pathology': _createSpec(
      'path',
      'Pathology',
      const Color(0xFF991B1B),
      LucideIcons.search,
      style: DigitalIDDesignStyle.organic,
    ),

    // Linguistics
    'english_program': _createSpec(
      'en',
      'English Program',
      const Color(0xFFF59E0B),
      LucideIcons.languages,
      style: DigitalIDDesignStyle.modern,
    ),
    'german_program': _createSpec(
      'de',
      'German Program',
      const Color(0xFFD97706),
      LucideIcons.languages,
      style: DigitalIDDesignStyle.modern,
    ),
    'chinese_program': _createSpec(
      'zh',
      'Chinese Program',
      const Color(0xFFB45309),
      LucideIcons.languages,
      style: DigitalIDDesignStyle.modern,
    ),
    'french_department': _createSpec(
      'fr',
      'French Dept',
      const Color(0xFF92400E),
      LucideIcons.languages,
      style: DigitalIDDesignStyle.modern,
    ),
    'translation_department': _createSpec(
      'trans',
      'Translation',
      const Color(0xFF78350F),
      LucideIcons.fileText,
      style: DigitalIDDesignStyle.modern,
    ),

    // Pharmacy
    'clinical_pharmacy': _createSpec(
      'clin',
      'Clinical Pharmacy',
      const Color(0xFF10B981),
      LucideIcons.clipboardList,
      style: DigitalIDDesignStyle.organic,
    ),
    'pharmaceutical_chemistry': _createSpec(
      'chem',
      'Pharma Chemistry',
      const Color(0xFF059669),
      LucideIcons.flaskConical,
      style: DigitalIDDesignStyle.organic,
    ),
    'pharmacology_biochemistry': _createSpec(
      'pharm_bio',
      'Pharmacology',
      const Color(0xFF047857),
      LucideIcons.activity,
      style: DigitalIDDesignStyle.organic,
    ),
    'pharmacognosy': _createSpec(
      'cogn',
      'Pharmacognosy',
      const Color(0xFF065F46),
      LucideIcons.leaf,
      style: DigitalIDDesignStyle.organic,
    ),
    'pharm_microbiology_immunology': _createSpec(
      'pharm_micro',
      'Pharma Micro',
      const Color(0xFF064E3B),
      LucideIcons.bug,
      style: DigitalIDDesignStyle.organic,
    ),
    'pharmaceutical_technology': _createSpec(
      'pharm_tech',
      'Pharma Tech',
      const Color(0xFF059669),
      LucideIcons.settings,
      style: DigitalIDDesignStyle.organic,
    ),
    'pharmacy_practice': _createSpec(
      'prac',
      'Pharmacy Practice',
      const Color(0xFF10B981),
      LucideIcons.clipboardCheck,
      style: DigitalIDDesignStyle.modern,
    ),

    // PT
    'pt_basic_sciences': _createSpec(
      'pt_base',
      'Basic Sciences',
      const Color(0xFF0EA5E9),
      LucideIcons.bookOpen,
      style: DigitalIDDesignStyle.organic,
    ),
    'biomechanics': _createSpec(
      'biomech',
      'Biomechanics',
      const Color(0xFF0284C7),
      LucideIcons.accessibility,
      style: DigitalIDDesignStyle.organic,
    ),
    'pt_internal_medicine': _createSpec(
      'pt_med',
      'Internal Medicine',
      const Color(0xFF0369A1),
      LucideIcons.activity,
      style: DigitalIDDesignStyle.organic,
    ),
    'pt_womens_health': _createSpec(
      'pt_women',
      'Women Health',
      const Color(0xFFBE123C),
      LucideIcons.heart,
      style: DigitalIDDesignStyle.organic,
    ),
    'pt_surgery_dermatology': _createSpec(
      'pt_surg',
      'Surgery/Derma',
      const Color(0xFF475569),
      LucideIcons.scissors,
      style: DigitalIDDesignStyle.organic,
    ),
    'pt_orthopedics': _createSpec(
      'pt_ortho',
      'Orthopedics',
      const Color(0xFF1D4ED8),
      LucideIcons.bone,
      style: DigitalIDDesignStyle.organic,
    ),
    'pt_neurology': _createSpec(
      'pt_neuro',
      'Neurology',
      const Color(0xFF6366F1),
      LucideIcons.brain,
      style: DigitalIDDesignStyle.organic,
    ),
    'pt_pediatrics': _createSpec(
      'pt_peds',
      'Pediatrics',
      const Color(0xFFF97316),
      LucideIcons.baby,
      style: DigitalIDDesignStyle.organic,
    ),

    // AI
    'ai_biomedical_computing': _createSpec(
      'biomp',
      'Biomedical Computing',
      const Color(0xFFEC4899),
      LucideIcons.activity,
      style: DigitalIDDesignStyle.cyber,
    ),
    'ai_cybersecurity': _createSpec(
      'sec',
      'Cyber Security',
      const Color(0xFF10B981),
      LucideIcons.shieldCheck,
      style: DigitalIDDesignStyle.cyber,
    ),
    'ai_data_science': _createSpec(
      'data',
      'Data Science',
      const Color(0xFF06B6D4),
      LucideIcons.database,
      style: DigitalIDDesignStyle.cyber,
    ),
    'ai_robotics': _createSpec(
      'bot',
      'Robotics',
      const Color(0xFFF59E0B),
      LucideIcons.bot,
      style: DigitalIDDesignStyle.cyber,
    ),
    'ai_smart_systems': _createSpec(
      'smart',
      'Smart Systems',
      const Color(0xFF8B5CF6),
      LucideIcons.cpu,
      style: DigitalIDDesignStyle.cyber,
    ),
  };

  static DigitalIDTheme getTheme({
    required String collegeId,
    String? specializationId,
  }) {
    final baseTheme = _colleges[collegeId.toLowerCase()] ?? _colleges['ai']!;

    if (specializationId != null) {
      final specTheme = _specializations[specializationId.toLowerCase()];
      if (specTheme != null) {
        return baseTheme.mergeWith(specTheme);
      }
    }

    return baseTheme;
  }

  static DigitalIDTheme _createTheme(
    String id,
    String name,
    Color color,
    IconData icon, {
    DigitalIDDesignStyle style = DigitalIDDesignStyle.modern,
  }) {
    return DigitalIDTheme(
      id: id,
      name: name,
      primaryColor: color,
      secondaryColor: color.withValues(alpha: 0.8),
      accentColor: Colors.white,
      gradientColors: [
        color.withValues(alpha: 0.5),
        const Color(0xFF0F172A).withValues(alpha: 0.9),
      ],
      patternIcon: icon,
      designStyle: style,
    );
  }

  static DigitalIDTheme _createSpec(
    String id,
    String name,
    Color accent,
    IconData icon, {
    DigitalIDDesignStyle style = DigitalIDDesignStyle.modern,
  }) {
    return DigitalIDTheme(
      id: id,
      name: name,
      primaryColor: accent,
      secondaryColor: accent.withValues(alpha: 0.6),
      accentColor: accent,
      gradientColors: [
        accent.withValues(alpha: 0.4),
        const Color(0xFF0F172A).withValues(alpha: 0.9),
      ],
      patternIcon: icon,
      designStyle: style,
    );
  }
}

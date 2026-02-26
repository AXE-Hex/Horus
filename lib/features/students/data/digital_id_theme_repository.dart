import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../domain/models/digital_id_theme.dart';

class DigitalIDThemeRepository {
  static final Map<String, DigitalIDTheme> _colleges = {
    'engineering': _createTheme(
      'eng',
      'Engineering',
      const Color(0xFFE11D48),
      LucideIcons.wrench,
    ),
    'civil_eng': _createTheme(
      'civil',
      'Civil Engineering',
      const Color(0xFFEA580C),
      LucideIcons.hardHat,
    ),
    'arch': _createTheme(
      'arch',
      'Architecture',
      const Color(0xFFD97706),
      LucideIcons.ruler,
    ),
    'mech': _createTheme(
      'mech',
      'Mechanical Eng',
      const Color(0xFF475569),
      LucideIcons.settings,
    ),
    'petroleum': _createTheme(
      'petro',
      'Petroleum Eng',
      const Color(0xFF0F172A),
      LucideIcons.flame,
    ),
    'electro': _createTheme(
      'electro',
      'Electronics',
      const Color(0xFF2563EB),
      LucideIcons.zap,
    ),
    'chem_eng': _createTheme(
      'chem_eng',
      'Chemical Eng',
      const Color(0xFF16A34A),
      LucideIcons.flaskConical,
    ),
    'mining': _createTheme(
      'mine',
      'Mining',
      const Color(0xFF78350F),
      LucideIcons.hammer,
    ),
    'aero': _createTheme(
      'aero',
      'Aerospace',
      const Color(0xFF0EA5E9),
      LucideIcons.plane,
    ),
    'marine': _createTheme(
      'marine',
      'Marine Eng',
      const Color(0xFF1E40AF),
      LucideIcons.anchor,
    ),

    'medicine': _createTheme(
      'med',
      'Medicine',
      const Color(0xFF0D9488),
      LucideIcons.stethoscope,
    ),
    'dentistry': _createTheme(
      'dent',
      'Dentistry',
      const Color(0xFF14B8A6),
      LucideIcons.smile,
    ),
    'pharmacy': _createTheme(
      'pharm',
      'Pharmacy',
      const Color(0xFF059669),
      LucideIcons.pill,
    ),
    'nursing': _createTheme(
      'nurse',
      'Nursing',
      const Color(0xFFEC4899),
      LucideIcons.heart,
    ),
    'vet': _createTheme(
      'vet',
      'Veterinary',
      const Color(0xFF84CC16),
      LucideIcons.dog,
    ),
    'therapy': _createTheme(
      'physio',
      'Physiotherapy',
      const Color(0xFF6366F1),
      LucideIcons.activity,
    ),
    'pub_health': _createTheme(
      'pubh',
      'Public Health',
      const Color(0xFF06B6D4),
      LucideIcons.globe,
    ),
    'radiology': _createTheme(
      'xray',
      'Radiology',
      const Color(0xFF334155),
      LucideIcons.scan,
    ),
    'biomed': _createTheme(
      'bio',
      'Biomedical',
      const Color(0xFFBE185D),
      LucideIcons.dna,
    ),
    'optometry': _createTheme(
      'eyes',
      'Optometry',
      const Color(0xFF3B82F6),
      LucideIcons.eye,
    ),

    'ai': _createTheme(
      'ai',
      'AI & Robotics',
      const Color(0xFF2563EB),
      LucideIcons.bot,
    ),
    'cs': _createTheme(
      'cs',
      'Computer Science',
      const Color(0xFF4F46E5),
      LucideIcons.code,
    ),
    'it': _createTheme(
      'it',
      'Info Tech',
      const Color(0xFF06B6D4),
      LucideIcons.wifi,
    ),
    'science': _createTheme(
      'sci',
      'General Science',
      const Color(0xFF0891B2),
      LucideIcons.flaskConical,
    ),
    'math': _createTheme(
      'math',
      'Mathematics',
      const Color(0xFF1E3A8A),
      LucideIcons.functionSquare,
    ),
    'physics': _createTheme(
      'phys',
      'Physics',
      const Color(0xFF5B21B6),
      LucideIcons.atom,
    ),
    'chem': _createTheme(
      'chem',
      'Chemistry',
      const Color(0xFFBE123C),
      LucideIcons.flaskRound,
    ),
    'bio': _createTheme(
      'bio',
      'Biology',
      const Color(0xFF15803D),
      LucideIcons.leaf,
    ),
    'geo': _createTheme(
      'geo',
      'Geology',
      const Color(0xFFA16207),
      LucideIcons.mountain,
    ),
    'astro': _createTheme(
      'astro',
      'Astronomy',
      const Color(0xFF172554),
      LucideIcons.star,
    ),

    'arts': _createTheme(
      'arts',
      'Fine Arts',
      const Color(0xFFD946EF),
      LucideIcons.palette,
    ),
    'law': _createTheme(
      'law',
      'Law',
      const Color(0xFF1E293B),
      LucideIcons.scale,
    ),
    'history': _createTheme(
      'hist',
      'History',
      const Color(0xFF7C2D12),
      LucideIcons.scroll,
    ),
    'lang': _createTheme(
      'lang',
      'Languages',
      const Color(0xFFC026D3),
      LucideIcons.languages,
    ),
    'psych': _createTheme(
      'psych',
      'Psychology',
      const Color(0xFF8B5CF6),
      LucideIcons.brain,
    ),
    'soc': _createTheme(
      'soc',
      'Sociology',
      const Color(0xFF4338CA),
      LucideIcons.users,
    ),
    'music': _createTheme(
      'music',
      'Music',
      const Color(0xFFE11D48),
      LucideIcons.music,
    ),
    'theater': _createTheme(
      'act',
      'Theater',
      const Color(0xFF9F1239),
      LucideIcons.clapperboard,
    ),
    'philosophy': _createTheme(
      'phil',
      'Philosophy',
      const Color(0xFF57534E),
      LucideIcons.bookOpen,
    ),
    'theo': _createTheme(
      'theo',
      'Theology',
      const Color(0xFF451A03),
      LucideIcons.church,
    ),

    'business': _createTheme(
      'biz',
      'Business Admin',
      const Color(0xFFCA8A04),
      LucideIcons.briefcase,
    ),
    'econ': _createTheme(
      'econ',
      'Economics',
      const Color(0xFF166534),
      LucideIcons.trendingUp,
    ),
    'finance': _createTheme(
      'fin',
      'Finance',
      const Color(0xFF15803D),
      LucideIcons.dollarSign,
    ),
    'marketing': _createTheme(
      'mkt',
      'Marketing',
      const Color(0xFFF97316),
      LucideIcons.megaphone,
    ),
    'accounting': _createTheme(
      'acc',
      'Accounting',
      const Color(0xFF374151),
      LucideIcons.calculator,
    ),
    'hr': _createTheme(
      'hr',
      'Human Resources',
      const Color(0xFFDB2777),
      LucideIcons.userCheck,
    ),
    'mgmt': _createTheme(
      'mgmt',
      'Management',
      const Color(0xFF1D4ED8),
      LucideIcons.users,
    ),
    'supply': _createTheme(
      'log',
      'Logistics',
      const Color(0xFFB45309),
      LucideIcons.truck,
    ),
    'hotel': _createTheme(
      'hotel',
      'Hospitality',
      const Color(0xFF0D9488),
      LucideIcons.coffee,
    ),
    'tourism': _createTheme(
      'tour',
      'Tourism',
      const Color(0xFF0EA5E9),
      LucideIcons.plane,
    ),

    'agri': _createTheme(
      'agri',
      'Agriculture',
      const Color(0xFF65A30D),
      LucideIcons.wheat,
    ),
    'food': _createTheme(
      'food',
      'Food Science',
      const Color(0xFFEA580C),
      LucideIcons.utensils,
    ),
    'sport': _createTheme(
      'sport',
      'Sports Science',
      const Color(0xFFDC2626),
      LucideIcons.medal,
    ),
    'edu': _createTheme(
      'edu',
      'Education',
      const Color(0xFF2DD4BF),
      LucideIcons.book,
    ),
    'media': _createTheme(
      'media',
      'Media',
      const Color(0xFF8B5CF6),
      LucideIcons.tv,
    ),
  };

  static final Map<String, DigitalIDTheme> _specializations = {
    'cyber_security': _createSpec(
      'sec',
      'Cyber Security',
      const Color(0xFF00FF94),
      LucideIcons.shieldCheck,
    ),
    'data_science': _createSpec(
      'data',
      'Data Science',
      const Color(0xFF00E5FF),
      LucideIcons.database,
    ),
    'blockchain': _createSpec(
      'chain',
      'Blockchain',
      const Color(0xFFFFD700),
      LucideIcons.link,
    ),
    'cloud': _createSpec(
      'cloud',
      'Cloud Comp',
      const Color(0xFF60A5FA),
      LucideIcons.cloud,
    ),
    'iot': _createSpec('iot', 'IoT', const Color(0xFFFF4081), LucideIcons.wifi),
    'gamedev': _createSpec(
      'game',
      'Game Dev',
      const Color(0xFFA855F7),
      LucideIcons.gamepad2,
    ),
    'frontend': _createSpec(
      'web',
      'Web Dev',
      const Color(0xFFF97316),
      LucideIcons.layout,
    ),
    'backend': _createSpec(
      'server',
      'Backend Dev',
      const Color(0xFF10B981),
      LucideIcons.server,
    ),
    'mobile': _createSpec(
      'app',
      'Mobile Dev',
      const Color(0xFF3B82F6),
      LucideIcons.smartphone,
    ),
    'devops': _createSpec(
      'ops',
      'DevOps',
      const Color(0xFF64748B),
      LucideIcons.infinity,
    ),

    'surgery': _createSpec(
      'surg',
      'Surgery',
      const Color(0xFFEF4444),
      LucideIcons.scissors,
    ),
    'neuro': _createSpec(
      'neuro',
      'Neurology',
      const Color(0xFF8B5CF6),
      LucideIcons.brain,
    ),
    'cardio': _createSpec(
      'heart',
      'Cardiology',
      const Color(0xFFBE123C),
      LucideIcons.heartPulse,
    ),
    'ortho': _createSpec(
      'bone',
      'Orthopedics',
      const Color(0xFFFB923C),
      LucideIcons.bone,
    ),
    'pediatrics': _createSpec(
      'kids',
      'Pediatrics',
      const Color(0xFFF472B6),
      LucideIcons.baby,
    ),
    'dermatology': _createSpec(
      'skin',
      'Dermatology',
      const Color(0xFFFCA5A5),
      LucideIcons.sun,
    ),
    'psychiatry': _createSpec(
      'mind',
      'Psychiatry',
      const Color(0xFF6366F1),
      LucideIcons.messageCircle,
    ),
    'pathology': _createSpec(
      'labs',
      'Pathology',
      const Color(0xFF14B8A6),
      LucideIcons.microscope,
    ),
    'er': _createSpec(
      'er',
      'Emergency',
      const Color(0xFFDC2626),
      LucideIcons.siren,
    ),

    'medical_education': _createSpec(
      'med_edu',
      'Med Education',
      const Color(0xFF3B82F6),
      LucideIcons.bookOpen,
    ),
    'histology_and_cell_biology': _createSpec(
      'cell',
      'Histology',
      const Color(0xFFEC4899),
      LucideIcons.microscope,
    ),
    'clinical_pharmacy': _createSpec(
      'clin_pharm',
      'Clinical Pharm',
      const Color(0xFF10B981),
      LucideIcons.pill,
    ),
    'human_anatomy_and_embryology': _createSpec(
      'anatomy',
      'Anatomy',
      const Color(0xFFEF4444),
      LucideIcons.accessibility,
    ),
    'medical_physiology': _createSpec(
      'physio_med',
      'Physiology',
      const Color(0xFFF59E0B),
      LucideIcons.activity,
    ),
    'medical_microbiology_and_immunology': _createSpec(
      'micro',
      'Microbiology',
      const Color(0xFF8B5CF6),
      LucideIcons.bug,
    ),
    'forensic_medicine_and_toxicology': _createSpec(
      'forensic',
      'Forensic Med',
      const Color(0xFF64748B),
      LucideIcons.search,
    ),
    'community_medicine_and_public_health': _createSpec(
      'pub_health_med',
      'Public Health',
      const Color(0xFF06B6D4),
      LucideIcons.globe,
    ),
    'biochemistry': _createSpec(
      'biochem',
      'Biochemistry',
      const Color(0xFFEAB308),
      LucideIcons.flaskConical,
    ),

    'genetics': _createSpec(
      'dna',
      'Genetics',
      const Color(0xFFD946EF),
      LucideIcons.dna,
    ),

    'basic_sciences': _createSpec(
      'basic_sci',
      'Basic Sciences',
      const Color(0xFF64748B),
      LucideIcons.bookOpen,
    ),
    'biomechanics': _createSpec(
      'biomech',
      'Biomechanics',
      const Color(0xFFEA580C),
      LucideIcons.settings,
    ),
    'pt_internal_medicine': _createSpec(
      'pt_int',
      'PT Internal',
      const Color(0xFF0D9488),
      LucideIcons.heartPulse,
    ),
    'pt_womens_health': _createSpec(
      'pt_women',
      'Women\'s Health',
      const Color(0xFFEC4899),
      LucideIcons.heart,
    ),
    'pt_surgery': _createSpec(
      'pt_surg',
      'PT Surgery',
      const Color(0xFFEF4444),
      LucideIcons.plus,
    ),
    'pt_orthopedics': _createSpec(
      'pt_ortho',
      'PT Ortho',
      const Color(0xFFF59E0B),
      LucideIcons.bone,
    ),
    'pt_neurology': _createSpec(
      'pt_neuro',
      'PT Neuro',
      const Color(0xFF8B5CF6),
      LucideIcons.brain,
    ),
    'pt_pediatrics': _createSpec(
      'pt_ped',
      'PT Pediatrics',
      const Color(0xFF06B6D4),
      LucideIcons.baby,
    ),

    'accounting_program_english': _createSpec(
      'acc_eng',
      'Accounting (EN)',
      const Color(0xFF374151),
      LucideIcons.calculator,
    ),
    'business_administration_program_english': _createSpec(
      'biz_eng',
      'Business (EN)',
      const Color(0xFFCA8A04),
      LucideIcons.briefcase,
    ),

    'interior_design_and_architecture': _createSpec(
      'interior',
      'Interior Arch',
      const Color(0xFFD946EF),
      LucideIcons.armchair,
    ),
    'furniture_design_and_production_technology': _createSpec(
      'furniture',
      'Furniture Des',
      const Color(0xFFA16207),
      LucideIcons.sofa,
    ),
    'graphics_and_digital_arts': _createSpec(
      'digital_art',
      'Digital Arts',
      const Color(0xFFEC4899),
      LucideIcons.palette,
    ),
    'animation_and_multimedia': _createSpec(
      'anim_multi',
      'Animation',
      const Color(0xFF8B5CF6),
      LucideIcons.film,
    ),

    'english_language_program': _createSpec(
      'english_prog',
      'English Prog',
      const Color(0xFFEF4444),
      LucideIcons.languages,
    ),
    'german_language_program': _createSpec(
      'german_prog',
      'German Prog',
      const Color(0xFFF59E0B),
      LucideIcons.languages,
    ),
    'chinese_language_program': _createSpec(
      'chinese_prog',
      'Chinese Prog',
      const Color(0xFFDC2626),
      LucideIcons.languages,
    ),

    'basic_sciences_in_dentistry': _createSpec(
      'dent_basic',
      'Basic Dent',
      const Color(0xFF64748B),
      LucideIcons.book,
    ),
    'basic_medical_and_clinical_sciences': _createSpec(
      'dent_med',
      'Clinical Sci',
      const Color(0xFF0D9488),
      LucideIcons.stethoscope,
    ),
    'oral_and_maxillofacial_surgery': _createSpec(
      'oral_surg',
      'Oral Surgery',
      const Color(0xFFEF4444),
      LucideIcons.skull,
    ),
    'orthodontics_and_pediatric_dentistry': _createSpec(
      'ortho_ped',
      'Ortho/Pediatrics',
      const Color(0xFFF472B6),
      LucideIcons.smile,
    ),
    'periodontics_and_oral_medicine': _createSpec(
      'perio',
      'Periodontics',
      const Color(0xFFF59E0B),
      LucideIcons.activity,
    ),
    'prosthodontics': _createSpec(
      'prosth',
      'Prosthodontics',
      const Color(0xFF3B82F6),
      LucideIcons.settings,
    ),
    'conservative_dentistry_and_endodontics': _createSpec(
      'endo',
      'Endodontics',
      const Color(0xFF8B5CF6),
      LucideIcons.shieldCheck,
    ),

    'pharmaceutical_chemistry': _createSpec(
      'pharm_chem',
      'Pharm Chem',
      const Color(0xFF059669),
      LucideIcons.flaskConical,
    ),
    'pharmacology_and_biochemistry': _createSpec(
      'pharma_bio',
      'Pharmacology',
      const Color(0xFF10B981),
      LucideIcons.dna,
    ),
    'pharmacognosy': _createSpec(
      'cognosy',
      'Pharmacognosy',
      const Color(0xFF84CC16),
      LucideIcons.leaf,
    ),
    'microbiology_and_immunology': _createSpec(
      'pharm_micro',
      'Microbiology',
      const Color(0xFF6366F1),
      LucideIcons.bug,
    ),
    'pharmaceutical_technology': _createSpec(
      'pharm_tech',
      'Pharm Tech',
      const Color(0xFF06B6D4),
      LucideIcons.settings,
    ),
    'pharmacy_practice': _createSpec(
      'pharm_prac',
      'Pharmacy Prac',
      const Color(0xFF3B82F6),
      LucideIcons.userCheck,
    ),

    'architectural_engineering': _createSpec(
      'arch_eng',
      'Arch Eng',
      const Color(0xFFD97706),
      LucideIcons.ruler,
    ),
    'basic_sciences_engineering': _createSpec(
      'basic_eng',
      'Basic Sci',
      const Color(0xFF64748B),
      LucideIcons.bookOpen,
    ),
    'civil_engineering': _createSpec(
      'civil_eng',
      'Civil Eng',
      const Color(0xFFEA580C),
      LucideIcons.hardHat,
    ),
    'mechanical_engineering': _createSpec(
      'mech_eng',
      'Mech Eng',
      const Color(0xFF475569),
      LucideIcons.settings,
    ),
    'electrical_engineering': _createSpec(
      'elec_eng',
      'Elec Eng',
      const Color(0xFF2563EB),
      LucideIcons.zap,
    ),
    'artificial_intelligence_engineering': _createSpec(
      'ai_eng',
      'AI Eng',
      const Color(0xFF7C3AED),
      LucideIcons.bot,
    ),

    'medical_laboratories_technology': _createSpec(
      'med_lab',
      'Med Labs',
      const Color(0xFF0D9488),
      LucideIcons.microscope,
    ),
    'radiology_and_imaging_technology': _createSpec(
      'rad_tech',
      'Radiology Tech',
      const Color(0xFF334155),
      LucideIcons.scan,
    ),
    'respiratory_care_technology': _createSpec(
      'resp_care',
      'Respiratory',
      const Color(0xFF06B6D4),
      LucideIcons.activity,
    ),
    'dental_prosthetics_technology': _createSpec(
      'dent_tech',
      'Dental Tech',
      const Color(0xFF8B5CF6),
      LucideIcons.smile,
    ),
    'health_administration_and_informatics_technology': _createSpec(
      'health_admin',
      'Health Admin',
      const Color(0xFF4F46E5),
      LucideIcons.clipboard,
    ),

    'smart_systems': _createSpec(
      'smart',
      'Smart Systems',
      const Color(0xFF8B5CF6),
      LucideIcons.cpu,
    ),
    'biomedical_computing': _createSpec(
      'biomp',
      'Biomedical Comp',
      const Color(0xFFEC4899),
      LucideIcons.activity,
    ),
    'artificial_cybersecurity': _createSpec(
      'ai_sec',
      'AI Security',
      const Color(0xFF10B981),
      LucideIcons.shieldCheck,
    ),
    'ai_robotics': _createSpec(
      'ai_bot',
      'AI Robotics',
      const Color(0xFFF59E0B),
      LucideIcons.bot,
    ),
    'ai_data_science': _createSpec(
      'ai_data',
      'AI Data Sci',
      const Color(0xFF06B6D4),
      LucideIcons.database,
    ),

    'robotics': _createSpec(
      'bot',
      'Robotics',
      const Color(0xFF94A3B8),
      LucideIcons.bot,
    ),
    'structures': _createSpec(
      'build',
      'Structures',
      const Color(0xFFF59E0B),
      LucideIcons.building,
    ),
    'power': _createSpec(
      'pow',
      'Power Sys',
      const Color(0xFFEAB308),
      LucideIcons.zap,
    ),
    'telecom': _createSpec(
      'sig',
      'Telecoms',
      const Color(0xFF3B82F6),
      LucideIcons.radioTower,
    ),
    'nano': _createSpec(
      'nano',
      'Nanotech',
      const Color(0xFFA855F7),
      LucideIcons.atom,
    ),
    'enviro': _createSpec(
      'eco',
      'Environmental',
      const Color(0xFF22C55E),
      LucideIcons.leaf,
    ),
    'material': _createSpec(
      'mat',
      'Materials',
      const Color(0xFF64748B),
      LucideIcons.layers,
    ),
    'automotive': _createSpec(
      'car',
      'Automotive',
      const Color(0xFFEF4444),
      LucideIcons.car,
    ),
    'urban': _createSpec(
      'city',
      'Urban Plan',
      const Color(0xFF06B6D4),
      LucideIcons.map,
    ),
    'hvac': _createSpec(
      'air',
      'HVAC',
      const Color(0xFF93C5FD),
      LucideIcons.thermometer,
    ),

    'criminal': _createSpec(
      'crime',
      'Criminal Law',
      const Color(0xFF1E293B),
      LucideIcons.gavel,
    ),
    'corporate': _createSpec(
      'corp',
      'Corporate Law',
      const Color(0xFF475569),
      LucideIcons.briefcase,
    ),
    'human_rights': _createSpec(
      'rights',
      'Human Rights',
      const Color(0xFF0EA5E9),
      LucideIcons.users,
    ),
    'intl_rel': _createSpec(
      'world',
      'Intl Relations',
      const Color(0xFF6366F1),
      LucideIcons.globe,
    ),
    'journalism': _createSpec(
      'news',
      'Journalism',
      const Color(0xFFF59E0B),
      LucideIcons.newspaper,
    ),
    'graphic_design': _createSpec(
      'art',
      'Graphic Design',
      const Color(0xFFEC4899),
      LucideIcons.penTool,
    ),
    'animation': _createSpec(
      'anim',
      'Animation',
      const Color(0xFFA855F7),
      LucideIcons.film,
    ),
    'film': _createSpec(
      'movie',
      'Filmmaking',
      const Color(0xFF1F2937),
      LucideIcons.video,
    ),
    'marketing_strat': _createSpec(
      'strat',
      'Strategy',
      const Color(0xFF10B981),
      LucideIcons.target,
    ),
    'finance_tech': _createSpec(
      'fintech',
      'FinTech',
      const Color(0xFF3B82F6),
      LucideIcons.wallet,
    ),
  };

  static DigitalIDTheme getTheme({
    required String collegeId,
    String? specializationId,
  }) {
    final baseTheme =
        _colleges[collegeId.toLowerCase()] ?? _colleges['engineering']!;

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
    IconData icon,
  ) {
    return DigitalIDTheme(
      id: id,
      name: name,
      primaryColor: color,
      secondaryColor: color.withValues(alpha: 0.8),
      accentColor: Colors.white,
      gradientColors: [
        color.withValues(alpha: 0.4),
        const Color(0xFF0F172A).withValues(alpha: 0.8),
      ],
      patternIcon: icon,
    );
  }

  static DigitalIDTheme _createSpec(
    String id,
    String name,
    Color accent,
    IconData icon,
  ) {
    return DigitalIDTheme(
      id: id,
      name: name,
      primaryColor: accent,
      secondaryColor: accent.withValues(alpha: 0.6),
      accentColor: accent,
      gradientColors: [
        accent.withValues(alpha: 0.3),
        const Color(0xFF0F172A).withValues(alpha: 0.8),
      ],
      patternIcon: icon,
    );
  }
}

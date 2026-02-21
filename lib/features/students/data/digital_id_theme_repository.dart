import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../domain/models/digital_id_theme.dart';

class DigitalIDThemeRepository {
  // ===========================================================================
  // COLLEGE THEMES (BASE LAYERS) - 50+ DESIGNS
  // ===========================================================================

  static final Map<String, DigitalIDTheme> _colleges = {
    // ENGINEERING CLUSTER
    'engineering': _createTheme(
      'eng',
      'Engineering',
      const Color(0xFFE11D48),
      LucideIcons.wrench,
    ), // Rose
    'civil_eng': _createTheme(
      'civil',
      'Civil Engineering',
      const Color(0xFFEA580C),
      LucideIcons.hardHat,
    ), // Orange
    'arch': _createTheme(
      'arch',
      'Architecture',
      const Color(0xFFD97706),
      LucideIcons.ruler,
    ), // Amber
    'mech': _createTheme(
      'mech',
      'Mechanical Eng',
      const Color(0xFF475569),
      LucideIcons.settings,
    ), // Slate
    'petroleum': _createTheme(
      'petro',
      'Petroleum Eng',
      const Color(0xFF0F172A),
      LucideIcons.flame,
    ), // Dark Slate
    'electro': _createTheme(
      'electro',
      'Electronics',
      const Color(0xFF2563EB),
      LucideIcons.zap,
    ), // Blue
    'chem_eng': _createTheme(
      'chem_eng',
      'Chemical Eng',
      const Color(0xFF16A34A),
      LucideIcons.flaskConical,
    ), // Green
    'mining': _createTheme(
      'mine',
      'Mining',
      const Color(0xFF78350F),
      LucideIcons.hammer,
    ), // Brown
    'aero': _createTheme(
      'aero',
      'Aerospace',
      const Color(0xFF0EA5E9),
      LucideIcons.plane,
    ), // Sky
    'marine': _createTheme(
      'marine',
      'Marine Eng',
      const Color(0xFF1E40AF),
      LucideIcons.anchor,
    ), // Dark Blue
    // 🟢 MEDICAL CLUSTER
    'medicine': _createTheme(
      'med',
      'Medicine',
      const Color(0xFF0D9488),
      LucideIcons.stethoscope,
    ), // Teal
    'dentistry': _createTheme(
      'dent',
      'Dentistry',
      const Color(0xFF14B8A6),
      LucideIcons.smile,
    ), // Teal Light
    'pharmacy': _createTheme(
      'pharm',
      'Pharmacy',
      const Color(0xFF059669),
      LucideIcons.pill,
    ), // Emerald
    'nursing': _createTheme(
      'nurse',
      'Nursing',
      const Color(0xFFEC4899),
      LucideIcons.heart,
    ), // Pink
    'vet': _createTheme(
      'vet',
      'Veterinary',
      const Color(0xFF84CC16),
      LucideIcons.dog,
    ), // Lime
    'therapy': _createTheme(
      'physio',
      'Physiotherapy',
      const Color(0xFF6366F1),
      LucideIcons.activity,
    ), // Indigo
    'pub_health': _createTheme(
      'pubh',
      'Public Health',
      const Color(0xFF06B6D4),
      LucideIcons.globe,
    ), // Cyan
    'radiology': _createTheme(
      'xray',
      'Radiology',
      const Color(0xFF334155),
      LucideIcons.scan,
    ), // Slate
    'biomed': _createTheme(
      'bio',
      'Biomedical',
      const Color(0xFFBE185D),
      LucideIcons.dna,
    ), // Pink
    'optometry': _createTheme(
      'eyes',
      'Optometry',
      const Color(0xFF3B82F6),
      LucideIcons.eye,
    ), // Blue
    // 🔵 SCIENCE & TECH CLUSTER
    'ai': _createTheme(
      'ai',
      'AI & Robotics',
      const Color(0xFF2563EB),
      LucideIcons.bot,
    ), // Blue
    'cs': _createTheme(
      'cs',
      'Computer Science',
      const Color(0xFF4F46E5),
      LucideIcons.code,
    ), // Indigo
    'it': _createTheme(
      'it',
      'Info Tech',
      const Color(0xFF06B6D4),
      LucideIcons.wifi,
    ), // Cyan
    'science': _createTheme(
      'sci',
      'General Science',
      const Color(0xFF0891B2),
      LucideIcons.flaskConical,
    ), // Cyan
    'math': _createTheme(
      'math',
      'Mathematics',
      const Color(0xFF1E3A8A),
      LucideIcons.functionSquare,
    ), // Dark Blue
    'physics': _createTheme(
      'phys',
      'Physics',
      const Color(0xFF5B21B6),
      LucideIcons.atom,
    ), // Violet
    'chem': _createTheme(
      'chem',
      'Chemistry',
      const Color(0xFFBE123C),
      LucideIcons.flaskRound,
    ), // Rose
    'bio': _createTheme(
      'bio',
      'Biology',
      const Color(0xFF15803D),
      LucideIcons.leaf,
    ), // Green
    'geo': _createTheme(
      'geo',
      'Geology',
      const Color(0xFFA16207),
      LucideIcons.mountain,
    ), // Yellow
    'astro': _createTheme(
      'astro',
      'Astronomy',
      const Color(0xFF172554),
      LucideIcons.star,
    ), // Midnight
    // 🟣 HUMANITIES & ARTS
    'arts': _createTheme(
      'arts',
      'Fine Arts',
      const Color(0xFFD946EF),
      LucideIcons.palette,
    ), // Fuchsia
    'law': _createTheme(
      'law',
      'Law',
      const Color(0xFF1E293B),
      LucideIcons.scale,
    ), // Slate
    'history': _createTheme(
      'hist',
      'History',
      const Color(0xFF7C2D12),
      LucideIcons.scroll,
    ), // Orange Dark
    'lang': _createTheme(
      'lang',
      'Languages',
      const Color(0xFFC026D3),
      LucideIcons.languages,
    ), // Purple
    'psych': _createTheme(
      'psych',
      'Psychology',
      const Color(0xFF8B5CF6),
      LucideIcons.brain,
    ), // Violet
    'soc': _createTheme(
      'soc',
      'Sociology',
      const Color(0xFF4338CA),
      LucideIcons.users,
    ), // Indigo
    'music': _createTheme(
      'music',
      'Music',
      const Color(0xFFE11D48),
      LucideIcons.music,
    ), // Rose
    'theater': _createTheme(
      'act',
      'Theater',
      const Color(0xFF9F1239),
      LucideIcons.clapperboard,
    ), // Rose Dark
    'philosophy': _createTheme(
      'phil',
      'Philosophy',
      const Color(0xFF57534E),
      LucideIcons.bookOpen,
    ), // Stone
    'theo': _createTheme(
      'theo',
      'Theology',
      const Color(0xFF451A03),
      LucideIcons.church,
    ), // Amber Dark
    // 🟠 BUSINESS & ECON
    'business': _createTheme(
      'biz',
      'Business Admin',
      const Color(0xFFCA8A04),
      LucideIcons.briefcase,
    ), // Yellow
    'econ': _createTheme(
      'econ',
      'Economics',
      const Color(0xFF166534),
      LucideIcons.trendingUp,
    ), // Green
    'finance': _createTheme(
      'fin',
      'Finance',
      const Color(0xFF15803D),
      LucideIcons.dollarSign,
    ), // Green
    'marketing': _createTheme(
      'mkt',
      'Marketing',
      const Color(0xFFF97316),
      LucideIcons.megaphone,
    ), // Orange
    'accounting': _createTheme(
      'acc',
      'Accounting',
      const Color(0xFF374151),
      LucideIcons.calculator,
    ), // Gray
    'hr': _createTheme(
      'hr',
      'Human Resources',
      const Color(0xFFDB2777),
      LucideIcons.userCheck,
    ), // Pink
    'mgmt': _createTheme(
      'mgmt',
      'Management',
      const Color(0xFF1D4ED8),
      LucideIcons.users,
    ), // Blue
    'supply': _createTheme(
      'log',
      'Logistics',
      const Color(0xFFB45309),
      LucideIcons.truck,
    ), // Amber
    'hotel': _createTheme(
      'hotel',
      'Hospitality',
      const Color(0xFF0D9488),
      LucideIcons.coffee,
    ), // Teal
    'tourism': _createTheme(
      'tour',
      'Tourism',
      const Color(0xFF0EA5E9),
      LucideIcons.plane,
    ), // Sky
    // 🔴 AGRICULTURE & OTHERS
    'agri': _createTheme(
      'agri',
      'Agriculture',
      const Color(0xFF65A30D),
      LucideIcons.wheat,
    ), // Lime
    'food': _createTheme(
      'food',
      'Food Science',
      const Color(0xFFEA580C),
      LucideIcons.utensils,
    ), // Orange
    'sport': _createTheme(
      'sport',
      'Sports Science',
      const Color(0xFFDC2626),
      LucideIcons.medal,
    ), // Red
    'edu': _createTheme(
      'edu',
      'Education',
      const Color(0xFF2DD4BF),
      LucideIcons.book,
    ), // Teal
    'media': _createTheme(
      'media',
      'Media',
      const Color(0xFF8B5CF6),
      LucideIcons.tv,
    ), // Violet
  };

  // ===========================================================================
  // SPECIALIZATION THEMES (OVERLAY LAYERS) - 40+ DESIGNS
  // ===========================================================================

  static final Map<String, DigitalIDTheme> _specializations = {
    // 💻 TECH SPECS
    'cyber_security': _createSpec(
      'sec',
      'Cyber Security',
      const Color(0xFF00FF94),
      LucideIcons.shieldCheck,
    ), // Neon Green
    'data_science': _createSpec(
      'data',
      'Data Science',
      const Color(0xFF00E5FF),
      LucideIcons.database,
    ), // Neon Cyan
    'blockchain': _createSpec(
      'chain',
      'Blockchain',
      const Color(0xFFFFD700),
      LucideIcons.link,
    ), // Gold
    'cloud': _createSpec(
      'cloud',
      'Cloud Comp',
      const Color(0xFF60A5FA),
      LucideIcons.cloud,
    ), // Soft Blue
    'iot': _createSpec(
      'iot',
      'IoT',
      const Color(0xFFFF4081),
      LucideIcons.wifi,
    ), // Pink
    'gamedev': _createSpec(
      'game',
      'Game Dev',
      const Color(0xFFA855F7),
      LucideIcons.gamepad2,
    ), // Purple
    'frontend': _createSpec(
      'web',
      'Web Dev',
      const Color(0xFFF97316),
      LucideIcons.layout,
    ), // Orange
    'backend': _createSpec(
      'server',
      'Backend Dev',
      const Color(0xFF10B981),
      LucideIcons.server,
    ), // Emerald
    'mobile': _createSpec(
      'app',
      'Mobile Dev',
      const Color(0xFF3B82F6),
      LucideIcons.smartphone,
    ), // Blue
    'devops': _createSpec(
      'ops',
      'DevOps',
      const Color(0xFF64748B),
      LucideIcons.infinity,
    ), // Slate
    // 🏥 MED SPECS
    'surgery': _createSpec(
      'surg',
      'Surgery',
      const Color(0xFFEF4444),
      LucideIcons.scissors,
    ), // Red
    'neuro': _createSpec(
      'neuro',
      'Neurology',
      const Color(0xFF8B5CF6),
      LucideIcons.brain,
    ), // Violet
    'cardio': _createSpec(
      'heart',
      'Cardiology',
      const Color(0xFFBE123C),
      LucideIcons.heartPulse,
    ), // Rose
    'ortho': _createSpec(
      'bone',
      'Orthopedics',
      const Color(0xFFFB923C),
      LucideIcons.bone,
    ), // Orange
    'pediatrics': _createSpec(
      'kids',
      'Pediatrics',
      const Color(0xFFF472B6),
      LucideIcons.baby,
    ), // Pink
    'dermatology': _createSpec(
      'skin',
      'Dermatology',
      const Color(0xFFFCA5A5),
      LucideIcons.sun,
    ), // Light Red
    'psychiatry': _createSpec(
      'mind',
      'Psychiatry',
      const Color(0xFF6366F1),
      LucideIcons.messageCircle,
    ), // Indigo
    'pathology': _createSpec(
      'labs',
      'Pathology',
      const Color(0xFF14B8A6),
      LucideIcons.microscope,
    ), // Teal
    'er': _createSpec(
      'er',
      'Emergency',
      const Color(0xFFDC2626),
      LucideIcons.siren,
    ), // Red
    // 🩺 NEW MEDICAL SPECS
    'medical_education': _createSpec(
      'med_edu',
      'Med Education',
      const Color(0xFF3B82F6),
      LucideIcons.bookOpen,
    ), // Blue
    'histology_and_cell_biology': _createSpec(
      'cell',
      'Histology',
      const Color(0xFFEC4899),
      LucideIcons.microscope,
    ), // Pink
    'clinical_pharmacy': _createSpec(
      'clin_pharm',
      'Clinical Pharm',
      const Color(0xFF10B981),
      LucideIcons.pill,
    ), // Green
    'human_anatomy_and_embryology': _createSpec(
      'anatomy',
      'Anatomy',
      const Color(0xFFEF4444),
      LucideIcons.accessibility,
    ), // Red
    'medical_physiology': _createSpec(
      'physio_med',
      'Physiology',
      const Color(0xFFF59E0B),
      LucideIcons.activity,
    ), // Amber
    'medical_microbiology_and_immunology': _createSpec(
      'micro',
      'Microbiology',
      const Color(0xFF8B5CF6),
      LucideIcons.bug,
    ), // Purple
    'forensic_medicine_and_toxicology': _createSpec(
      'forensic',
      'Forensic Med',
      const Color(0xFF64748B),
      LucideIcons.search,
    ), // Slate
    'community_medicine_and_public_health': _createSpec(
      'pub_health_med',
      'Public Health',
      const Color(0xFF06B6D4),
      LucideIcons.globe,
    ), // Cyan
    'biochemistry': _createSpec(
      'biochem',
      'Biochemistry',
      const Color(0xFFEAB308),
      LucideIcons.flaskConical,
    ), // Yellow

    'genetics': _createSpec(
      'dna',
      'Genetics',
      const Color(0xFFD946EF),
      LucideIcons.dna,
    ), // Fuchsia
    // 💆 PHYSICAL THERAPY SPECS
    'basic_sciences': _createSpec(
      'basic_sci',
      'Basic Sciences',
      const Color(0xFF64748B),
      LucideIcons.bookOpen,
    ), // Slate
    'biomechanics': _createSpec(
      'biomech',
      'Biomechanics',
      const Color(0xFFEA580C),
      LucideIcons.settings,
    ), // Orange
    'pt_internal_medicine': _createSpec(
      'pt_int',
      'PT Internal',
      const Color(0xFF0D9488),
      LucideIcons.heartPulse,
    ), // Teal
    'pt_womens_health': _createSpec(
      'pt_women',
      'Women\'s Health',
      const Color(0xFFEC4899),
      LucideIcons.heart,
    ), // Pink
    'pt_surgery': _createSpec(
      'pt_surg',
      'PT Surgery',
      const Color(0xFFEF4444),
      LucideIcons.plus,
    ), // Red
    'pt_orthopedics': _createSpec(
      'pt_ortho',
      'PT Ortho',
      const Color(0xFFF59E0B),
      LucideIcons.bone,
    ), // Amber
    'pt_neurology': _createSpec(
      'pt_neuro',
      'PT Neuro',
      const Color(0xFF8B5CF6),
      LucideIcons.brain,
    ), // Violet
    'pt_pediatrics': _createSpec(
      'pt_ped',
      'PT Pediatrics',
      const Color(0xFF06B6D4),
      LucideIcons.baby,
    ), // Cyan
    // 💼 BUSINESS SPECS
    'accounting_program_english': _createSpec(
      'acc_eng',
      'Accounting (EN)',
      const Color(0xFF374151),
      LucideIcons.calculator,
    ), // Gray
    'business_administration_program_english': _createSpec(
      'biz_eng',
      'Business (EN)',
      const Color(0xFFCA8A04),
      LucideIcons.briefcase,
    ), // Yellow
    // 🎨 FINE ARTS SPECS
    'interior_design_and_architecture': _createSpec(
      'interior',
      'Interior Arch',
      const Color(0xFFD946EF),
      LucideIcons.armchair,
    ), // Fuchsia
    'furniture_design_and_production_technology': _createSpec(
      'furniture',
      'Furniture Des',
      const Color(0xFFA16207),
      LucideIcons.sofa,
    ), // Brown
    'graphics_and_digital_arts': _createSpec(
      'digital_art',
      'Digital Arts',
      const Color(0xFFEC4899),
      LucideIcons.palette,
    ), // Pink
    'animation_and_multimedia': _createSpec(
      'anim_multi',
      'Animation',
      const Color(0xFF8B5CF6),
      LucideIcons.film,
    ), // Violet
    // 🗣️ TRANSLATION SPECS
    'english_language_program': _createSpec(
      'english_prog',
      'English Prog',
      const Color(0xFFEF4444),
      LucideIcons.languages,
    ), // Red
    'german_language_program': _createSpec(
      'german_prog',
      'German Prog',
      const Color(0xFFF59E0B),
      LucideIcons.languages,
    ), // Amber
    'chinese_language_program': _createSpec(
      'chinese_prog',
      'Chinese Prog',
      const Color(0xFFDC2626),
      LucideIcons.languages,
    ), // Dark Red
    // 🦷 DENTISTRY SPECS
    'basic_sciences_in_dentistry': _createSpec(
      'dent_basic',
      'Basic Dent',
      const Color(0xFF64748B),
      LucideIcons.book,
    ), // Slate
    'basic_medical_and_clinical_sciences': _createSpec(
      'dent_med',
      'Clinical Sci',
      const Color(0xFF0D9488),
      LucideIcons.stethoscope,
    ), // Teal
    'oral_and_maxillofacial_surgery': _createSpec(
      'oral_surg',
      'Oral Surgery',
      const Color(0xFFEF4444),
      LucideIcons.skull,
    ), // Red
    'orthodontics_and_pediatric_dentistry': _createSpec(
      'ortho_ped',
      'Ortho/Pediatrics',
      const Color(0xFFF472B6),
      LucideIcons.smile,
    ), // Pink
    'periodontics_and_oral_medicine': _createSpec(
      'perio',
      'Periodontics',
      const Color(0xFFF59E0B),
      LucideIcons.activity,
    ), // Amber
    'prosthodontics': _createSpec(
      'prosth',
      'Prosthodontics',
      const Color(0xFF3B82F6),
      LucideIcons.settings,
    ), // Blue
    'conservative_dentistry_and_endodontics': _createSpec(
      'endo',
      'Endodontics',
      const Color(0xFF8B5CF6),
      LucideIcons.shieldCheck,
    ), // Violet
    // 💊 PHARMACY SPECS
    'pharmaceutical_chemistry': _createSpec(
      'pharm_chem',
      'Pharm Chem',
      const Color(0xFF059669),
      LucideIcons.flaskConical,
    ), // Emerald
    'pharmacology_and_biochemistry': _createSpec(
      'pharma_bio',
      'Pharmacology',
      const Color(0xFF10B981),
      LucideIcons.dna,
    ), // Green
    'pharmacognosy': _createSpec(
      'cognosy',
      'Pharmacognosy',
      const Color(0xFF84CC16),
      LucideIcons.leaf,
    ), // Lime
    'microbiology_and_immunology': _createSpec(
      'pharm_micro',
      'Microbiology',
      const Color(0xFF6366F1),
      LucideIcons.bug,
    ), // Indigo
    'pharmaceutical_technology': _createSpec(
      'pharm_tech',
      'Pharm Tech',
      const Color(0xFF06B6D4),
      LucideIcons.settings,
    ), // Cyan
    'pharmacy_practice': _createSpec(
      'pharm_prac',
      'Pharmacy Prac',
      const Color(0xFF3B82F6),
      LucideIcons.userCheck,
    ), // Blue
    // ⚙️ ENGINEERING SPECS
    'architectural_engineering': _createSpec(
      'arch_eng',
      'Arch Eng',
      const Color(0xFFD97706),
      LucideIcons.ruler,
    ), // Amber
    'basic_sciences_engineering': _createSpec(
      'basic_eng',
      'Basic Sci',
      const Color(0xFF64748B),
      LucideIcons.bookOpen,
    ), // Slate
    'civil_engineering': _createSpec(
      'civil_eng',
      'Civil Eng',
      const Color(0xFFEA580C),
      LucideIcons.hardHat,
    ), // Orange
    'mechanical_engineering': _createSpec(
      'mech_eng',
      'Mech Eng',
      const Color(0xFF475569),
      LucideIcons.settings,
    ), // Slate
    'electrical_engineering': _createSpec(
      'elec_eng',
      'Elec Eng',
      const Color(0xFF2563EB),
      LucideIcons.zap,
    ), // Blue
    'artificial_intelligence_engineering': _createSpec(
      'ai_eng',
      'AI Eng',
      const Color(0xFF7C3AED),
      LucideIcons.bot,
    ), // Violet
    // 🏥 HEALTH TECH SPECS
    'medical_laboratories_technology': _createSpec(
      'med_lab',
      'Med Labs',
      const Color(0xFF0D9488),
      LucideIcons.microscope,
    ), // Teal
    'radiology_and_imaging_technology': _createSpec(
      'rad_tech',
      'Radiology Tech',
      const Color(0xFF334155),
      LucideIcons.scan,
    ), // Slate
    'respiratory_care_technology': _createSpec(
      'resp_care',
      'Respiratory',
      const Color(0xFF06B6D4),
      LucideIcons.activity,
    ), // Cyan
    'dental_prosthetics_technology': _createSpec(
      'dent_tech',
      'Dental Tech',
      const Color(0xFF8B5CF6),
      LucideIcons.smile,
    ), // Violet
    'health_administration_and_informatics_technology': _createSpec(
      'health_admin',
      'Health Admin',
      const Color(0xFF4F46E5),
      LucideIcons.clipboard,
    ), // Indigo
    // 🧠 AI SPECIALIZATIONS
    'smart_systems': _createSpec(
      'smart',
      'Smart Systems',
      const Color(0xFF8B5CF6),
      LucideIcons.cpu,
    ), // Violet
    'biomedical_computing': _createSpec(
      'biomp',
      'Biomedical Comp',
      const Color(0xFFEC4899),
      LucideIcons.activity,
    ), // Pink
    'artificial_cybersecurity': _createSpec(
      'ai_sec',
      'AI Security',
      const Color(0xFF10B981),
      LucideIcons.shieldCheck,
    ), // Emerald
    'ai_robotics': _createSpec(
      'ai_bot',
      'AI Robotics',
      const Color(0xFFF59E0B),
      LucideIcons.bot,
    ), // Amber
    'ai_data_science': _createSpec(
      'ai_data',
      'AI Data Sci',
      const Color(0xFF06B6D4),
      LucideIcons.database,
    ), // Cyan
    // 🏗️ ENG SPECS
    'robotics': _createSpec(
      'bot',
      'Robotics',
      const Color(0xFF94A3B8),
      LucideIcons.bot,
    ), // Silver
    'structures': _createSpec(
      'build',
      'Structures',
      const Color(0xFFF59E0B),
      LucideIcons.building,
    ), // Amber
    'power': _createSpec(
      'pow',
      'Power Sys',
      const Color(0xFFEAB308),
      LucideIcons.zap,
    ), // Yellow
    'telecom': _createSpec(
      'sig',
      'Telecoms',
      const Color(0xFF3B82F6),
      LucideIcons.radioTower,
    ), // Blue
    'nano': _createSpec(
      'nano',
      'Nanotech',
      const Color(0xFFA855F7),
      LucideIcons.atom,
    ), // Purple
    'enviro': _createSpec(
      'eco',
      'Environmental',
      const Color(0xFF22C55E),
      LucideIcons.leaf,
    ), // Green
    'material': _createSpec(
      'mat',
      'Materials',
      const Color(0xFF64748B),
      LucideIcons.layers,
    ), // Slate
    'automotive': _createSpec(
      'car',
      'Automotive',
      const Color(0xFFEF4444),
      LucideIcons.car,
    ), // Red
    'urban': _createSpec(
      'city',
      'Urban Plan',
      const Color(0xFF06B6D4),
      LucideIcons.map,
    ), // Cyan
    'hvac': _createSpec(
      'air',
      'HVAC',
      const Color(0xFF93C5FD),
      LucideIcons.thermometer,
    ), // Light Blue
    // ⚖️ LAW & ARTS SPECS
    'criminal': _createSpec(
      'crime',
      'Criminal Law',
      const Color(0xFF1E293B),
      LucideIcons.gavel,
    ), // Dark
    'corporate': _createSpec(
      'corp',
      'Corporate Law',
      const Color(0xFF475569),
      LucideIcons.briefcase,
    ), // Slate
    'human_rights': _createSpec(
      'rights',
      'Human Rights',
      const Color(0xFF0EA5E9),
      LucideIcons.users,
    ), // Sky
    'intl_rel': _createSpec(
      'world',
      'Intl Relations',
      const Color(0xFF6366F1),
      LucideIcons.globe,
    ), // Indigo
    'journalism': _createSpec(
      'news',
      'Journalism',
      const Color(0xFFF59E0B),
      LucideIcons.newspaper,
    ), // Amber
    'graphic_design': _createSpec(
      'art',
      'Graphic Design',
      const Color(0xFFEC4899),
      LucideIcons.penTool,
    ), // Pink
    'animation': _createSpec(
      'anim',
      'Animation',
      const Color(0xFFA855F7),
      LucideIcons.film,
    ), // Purple
    'film': _createSpec(
      'movie',
      'Filmmaking',
      const Color(0xFF1F2937),
      LucideIcons.video,
    ), // Dark Gray
    'marketing_strat': _createSpec(
      'strat',
      'Strategy',
      const Color(0xFF10B981),
      LucideIcons.target,
    ), // Green
    'finance_tech': _createSpec(
      'fintech',
      'FinTech',
      const Color(0xFF3B82F6),
      LucideIcons.wallet,
    ), // Blue
  };

  /// 🏭 THEME FACTORY
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

  // --- Helpers ---

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
      secondaryColor: color.withValues(alpha: 0.7),
      accentColor: Colors.white,
      gradientColors: [
        color.withValues(alpha: 0.9),
        const Color(0xFF0F172A).withValues(alpha: 0.95), // Dark Slate base
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
      primaryColor:
          accent, // In specs, primary becomes the accent/overlay color
      secondaryColor: accent.withValues(alpha: 0.5),
      accentColor: accent,
      gradientColors: [], // Not used for independent spec themes
      patternIcon: icon,
    );
  }
}

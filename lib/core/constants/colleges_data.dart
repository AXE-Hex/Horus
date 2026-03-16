import 'package:flutter/material.dart';

class StaticCollegeData {
  final String id;
  final String nameEn;
  final String nameAr;
  final String imagePath;
  final Color themeColor;
  final String established;

  // Sections
  final CollegeSection about;
  final DeanInfo dean;
  final CollegeStats stats;
  final List<String> departmentsAr;
  final List<String> departmentsEn;

  const StaticCollegeData({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.imagePath,
    required this.themeColor,
    required this.established,
    required this.about,
    required this.dean,
    required this.stats,
    required this.departmentsAr,
    required this.departmentsEn,
  });
}

class CollegeSection {
  final String originsAr;
  final String originsEn;
  final String visionAr;
  final String visionEn;
  final String missionAr;
  final String missionEn;
  final List<String> goalsAr;
  final List<String> goalsEn;

  const CollegeSection({
    required this.originsAr,
    required this.originsEn,
    required this.visionAr,
    required this.visionEn,
    required this.missionAr,
    required this.missionEn,
    required this.goalsAr,
    required this.goalsEn,
  });
}

class DeanInfo {
  final String nameAr;
  final String nameEn;
  final String titleAr;
  final String titleEn;
  final String bioAr;
  final String bioEn;
  final String? imagePath;

  const DeanInfo({
    required this.nameAr,
    required this.nameEn,
    required this.titleAr,
    required this.titleEn,
    required this.bioAr,
    required this.bioEn,
    this.imagePath,
  });
}

class CollegeStats {
  final int students;
  final int faculty;
  final int assistantStaff;
  final int researchPapers;

  const CollegeStats({
    required this.students,
    required this.faculty,
    required this.assistantStaff,
    required this.researchPapers,
  });
}

final List<StaticCollegeData> allColleges = [
  StaticCollegeData(
    id: 'dentistry',
    nameEn: 'Faculty of Dentistry',
    nameAr: 'كلية طب الفم والأسنان',
    imagePath: 'assets/images/colleges/dentistry.jpg',
    themeColor: const Color(0xFF0D9488),
    established: '2013',
    about: const CollegeSection(
      originsAr:
          'تعد الكلية واحدة من المؤسسات الرائدة في تعليم طب الأسنان في المنطقة، تهدف إلى إعداد أطباء أكفاء متميزين علمياً ومهارياً.',
      originsEn:
          'The faculty is one of the leading institutions in dental education in the region, aiming to prepare scientifically and skillfully distinguished competent doctors.',
      visionAr:
          'ريادة تعليم طب الأسنان والبحث العلمي على المستويين المحلي والدولي.',
      visionEn:
          'Leadership in dental education and scientific research at the local and international levels.',
      missionAr:
          'تقديم برامج تعليمية وبحثية متميزة تلبي احتياجات المجتمع وتواكب التطور العالمي.',
      missionEn:
          'Providing distinguished educational and research programs that meet community needs and keep pace with global developments.',
      goalsAr: [
        'تطوير المهارات السريرية للطلاب',
        'تشجيع البحث العلمي المبتكر',
        'خدمة المجتمع المحيط',
      ],
      goalsEn: [
        'Develop clinical skills for students',
        'Encourage innovative scientific research',
        'Serve the surrounding community',
      ],
    ),
    dean: const DeanInfo(
      nameAr: 'د. أشرف فوزي جودة',
      nameEn: 'Dr. Ashraf Fawzy Gouda',
      titleAr: 'عميد الكلية',
      titleEn: 'Dean of the Faculty',
      bioAr:
          'أستاذ متميز في جراحة الفم والوجة والفكين، قاد الكلية لسنوات من التميز الأكاديمي.',
      bioEn:
          'Distinguished professor of oral and maxillofacial surgery, led the faculty for years of academic excellence.',
    ),
    stats: const CollegeStats(
      students: 2450,
      faculty: 120,
      assistantStaff: 85,
      researchPapers: 340,
    ),
    departmentsAr: [
      'قسم جراحة الفم والوجة والفكين',
      'قسم التقويم وطب أسنان الأطفال',
      'قسم أمراض اللثة وطب الفم',
    ],
    departmentsEn: [
      'Oral and Maxillofacial Surgery',
      'Orthodontics and Pediatric Dentistry',
      'Periodontics and Oral Medicine',
    ],
  ),
  StaticCollegeData(
    id: 'pharmacy',
    nameEn: 'Faculty of Pharmacy',
    nameAr: 'كلية الصيدلة',
    imagePath: 'assets/images/colleges/pharmacy.jpg',
    themeColor: const Color(0xFF4F46E5),
    established: '2013',
    about: const CollegeSection(
      originsAr:
          'تسعى الكلية للتميز في مجال العلوم الصيدلية وتخريج صيادلة مؤهلين للمنافسة في سوق العمل.',
      originsEn:
          'The college strives for excellence in pharmaceutical sciences and graduating pharmacists qualified to compete in the labor market.',
      visionAr: 'أن تكون الكلية مركزاً عالمياً للبحث والتعليم الصيدلي.',
      visionEn:
          'To be an international center for pharmaceutical research and education.',
      missionAr: 'توفير بيئة تعليمية محفزة للإبداع والابتكار في مجال الدواء.',
      missionEn:
          'Providing a stimulating educational environment for creativity and innovation in the field of medicine.',
      goalsAr: [
        'تحسين جودة التعليم الصيدلي',
        'دعم مشاريع البحث الدوائي',
        'تحقيق المعايير الأكاديمية الدولية',
      ],
      goalsEn: [
        'Improve the quality of pharmaceutical education',
        'Support drug research projects',
        'Achieve international academic standards',
      ],
    ),
    dean: const DeanInfo(
      nameAr: 'د. سحر محمد البارون',
      nameEn: 'Dr. Sahar Mohamed El-Baron',
      titleAr: 'عميد الكلية',
      titleEn: 'Dean of the Faculty',
      bioAr:
          'خبيرة في الكيمياء الحيوية، لها مساهمات بحثية واسعة في مجالات الصيدلة المختلفة.',
      bioEn:
          'Expert in biochemistry, with extensive research contributions in various pharmaceutical fields.',
    ),
    stats: const CollegeStats(
      students: 1800,
      faculty: 95,
      assistantStaff: 60,
      researchPapers: 280,
    ),
    departmentsAr: [
      'قسم الكيمياء الصيدلية',
      'قسم العقاقير',
      'قسم الصيدلة الإكلينيكية',
    ],
    departmentsEn: [
      'Pharmaceutical Chemistry',
      'Pharmacognosy',
      'Clinical Pharmacy',
    ],
  ),
  StaticCollegeData(
    id: 'engineering',
    nameEn: 'Faculty of Engineering',
    nameAr: 'كلية الهندسة',
    imagePath: 'assets/images/colleges/engineering.jpg',
    themeColor: const Color(0xFFE11D48),
    established: '2014',
    about: const CollegeSection(
      originsAr: 'تأسست لتكون منارة للعلوم الهندسية والتكنولوجيا المتقدمة.',
      originsEn:
          'Established to be a beacon for engineering sciences and advanced technology.',
      visionAr: 'الريادة في الابتكار والحلول الهندسية المستدامة.',
      visionEn:
          'Leadership in innovation and sustainable engineering solutions.',
      missionAr:
          'تخريج مهندسين قادرين على محاكاة احتياجات الثورة الصناعية الرابعة.',
      missionEn:
          'Graduating engineers capable of simulating the needs of the fourth industrial revolution.',
      goalsAr: [
        'تعزيز الشراكات الصناعية',
        'توفير تدريب ميداني متقدم',
        'التميز في هندسة الذكاء الاصطناعي',
      ],
      goalsEn: [
        'Enhance industrial partnerships',
        'Provide advanced field training',
        'Excellence in AI Engineering',
      ],
    ),
    dean: const DeanInfo(
      nameAr: 'د. خالد محمد عطيه',
      nameEn: 'Dr. Khaled Mohamed Attia',
      titleAr: 'عميد الكلية',
      titleEn: 'Dean of the Faculty',
      bioAr:
          'أستاذ مرموق في العمارة، يركز على دمج التكنولوجيا في التصميم المعاصر.',
      bioEn:
          'Prestigious professor of architecture, focusing on integrating technology into contemporary design.',
    ),
    stats: const CollegeStats(
      students: 2100,
      faculty: 110,
      assistantStaff: 70,
      researchPapers: 450,
    ),
    departmentsAr: [
      'قسم الهندسة المعمارية',
      'قسم الهندسة المدنية',
      'قسم هندسة الذكاء الاصطناعي',
    ],
    departmentsEn: [
      'Architectural Engineering',
      'Civil Engineering',
      'AI Engineering',
    ],
  ),
  StaticCollegeData(
    id: 'pt',
    nameEn: 'Faculty of Physical Therapy',
    nameAr: 'كلية العلاج الطبيعي',
    imagePath: 'assets/images/colleges/pt.jpg',
    themeColor: const Color(0xFF10B981),
    established: '2014',
    about: const CollegeSection(
      originsAr: 'أكبر كلية علاج طبيعي في الدلتا، مجهزة بأحدث معامل التأهيل.',
      originsEn:
          'The largest faculty of physical therapy in the Delta, equipped with the latest rehabilitation laboratories.',
      visionAr: 'الوصول للعالمية في خدمات التأهيل والبحث العلمي الحركي.',
      visionEn:
          'Reach global levels in rehabilitation services and kinetic scientific research.',
      missionAr:
          'إعداد أخصائي متميز في التشخيص والعلاج الحركي وفقاً للمعايير العالمية.',
      missionEn:
          'Preparing a distinguished specialist in diagnosis and movement therapy according to international standards.',
      goalsAr: [
        'تطوير برامج التأهيل الرياضي',
        'تعزيز دور العيادات الخارجية',
        'الارتقاء بالبحث العلمي الإكلينيكي',
      ],
      goalsEn: [
        'Develop sports rehabilitation programs',
        'Enhance the role of outpatient clinics',
        'Raise the level of clinical scientific research',
      ],
    ),
    dean: const DeanInfo(
      nameAr: 'د. نجوى محمود البارون',
      nameEn: 'Dr. Nagwa Mahmoud El-Baron',
      titleAr: 'عميد الكلية',
      titleEn: 'Dean of the Faculty',
      bioAr:
          'رائدة في مجال العلاج الطبيعي للأعصاب، قادت الكلية لتحقيق طفرة في الخدمات العلاجية.',
      bioEn:
          'Pioneer in neurological physical therapy, led the faculty to achieve a breakthrough in therapeutic services.',
    ),
    stats: const CollegeStats(
      students: 3200,
      faculty: 140,
      assistantStaff: 100,
      researchPapers: 520,
    ),
    departmentsAr: [
      'قسم الميكانيكا الحيوية',
      'قسم العلاج الطبيعي لأمراض العظام',
      'قسم العلاج الطبيعي للأعصاب',
    ],
    departmentsEn: ['Biomechanics', 'Orthopedic PT', 'Neurological PT'],
  ),
  StaticCollegeData(
    id: 'business',
    nameEn: 'Faculty of Business',
    nameAr: 'كلية إدارة الأعمال',
    imagePath: 'assets/images/colleges/business.jpg',
    themeColor: const Color(0xFFF59E0B),
    established: '2015',
    about: const CollegeSection(
      originsAr: 'كلية عصرية تهدف لتشكيل قادة المستقبل في عالم المال والأعمال.',
      originsEn:
          'A modern faculty aiming to shape future leaders in the world of finance and business.',
      visionAr: 'أن نكون الخيار الأول لتعليم الأعمال في مصر.',
      visionEn: 'To be the first choice for business education in Egypt.',
      missionAr: 'دمج النظرية بالتطبيق العملي من خلال شراكات مع قطاع الأعمال.',
      missionEn:
          'Integrating theory with practical application through partnerships with the business sector.',
      goalsAr: [
        'دعم ريادة الأعمال',
        'تطوير المهارات القيادية',
        'تحقيق التحول الرقمي الإداري',
      ],
      goalsEn: [
        'Support entrepreneurship',
        'Develop leadership skills',
        'Achieve administrative digital transformation',
      ],
    ),
    dean: const DeanInfo(
      nameAr: 'د. جمال عياد',
      nameEn: 'Dr. Gamal Ayad',
      titleAr: 'عميد الكلية',
      titleEn: 'Dean of the Faculty',
      bioAr:
          'خبير في الاقتصاد والإدارة، عمل مستشاراً للعديد من المؤسسات المالية الكبرى.',
      bioEn:
          'Expert in economics and management, served as a consultant for many major financial institutions.',
    ),
    stats: const CollegeStats(
      students: 1500,
      faculty: 75,
      assistantStaff: 45,
      researchPapers: 210,
    ),
    departmentsAr: ['قسم المحاسبة', 'قسم إدارة الأعمال', 'قسم الاقتصاد'],
    departmentsEn: ['Accounting', 'Business Management', 'Economics'],
  ),
  StaticCollegeData(
    id: 'arts',
    nameEn: 'Faculty of Fine Arts',
    nameAr: 'كلية الفنون الجميلة',
    imagePath: 'assets/images/colleges/arts.jpg',
    themeColor: const Color(0xFF9333EA),
    established: '2022',
    about: const CollegeSection(
      originsAr: 'أحدث كليات الجامعة، تعنى بالإبداع البصري والتصميم المعاصر.',
      originsEn:
          'The university\'s newest faculty, focused on visual creativity and contemporary design.',
      visionAr: 'مرجع فني رائد يجمع بين الأصالة والحداثة.',
      visionEn:
          'A leading artistic reference combining authenticity and modernity.',
      missionAr:
          'تحفيز الخيال وتوفير مساحات إبداعية للفنانين والمصممين الواعدين.',
      missionEn:
          'Stimulating imagination and providing creative spaces for promising artists and designers.',
      goalsAr: [
        'تعزيز الذوق الفني العام',
        'المشاركة في المعارض الدولية',
        'دمج التكنولوجيا في الفنون الرقمية',
      ],
      goalsEn: [
        'Enhance general artistic taste',
        'Participate in international exhibitions',
        'Integrate technology into digital arts',
      ],
    ),
    dean: const DeanInfo(
      nameAr: 'د. إبراهيم محمد أحمد',
      nameEn: 'Dr. Ibrahim Mohamed Ahmed',
      titleAr: 'عميد الكلية',
      titleEn: 'Dean of the Faculty',
      bioAr: 'فنان تشكيلي مرموق، له أعمال معروضة في كبرى المتاحف والمعارض.',
      bioEn:
          'Distinguished visual artist, with works exhibited in major museums and galleries.',
    ),
    stats: const CollegeStats(
      students: 800,
      faculty: 40,
      assistantStaff: 30,
      researchPapers: 50,
    ),
    departmentsAr: [
      'برنامج العمارة الداخلية',
      'برنامج الجرافيك والفنون الرقمية',
      'برنامج الرسوم المتحركة',
    ],
    departmentsEn: [
      'Interior Architecture',
      'Graphics and Digital Arts',
      'Animation',
    ],
  ),
  StaticCollegeData(
    id: 'medicine',
    nameEn: 'Faculty of Human Medicine',
    nameAr: 'كلية الطب البشري',
    imagePath: 'assets/images/colleges/medicine.jpg',
    themeColor: const Color(0xFFEF4444),
    established: '2024',
    about: const CollegeSection(
      originsAr:
          'نبض الجامعة الطبي، تسعى لإعداد أطباء بأعلى المستويات الكلينيكية.',
      originsEn:
          'The medical pulse of the university, aiming to prepare doctors with the highest clinical levels.',
      visionAr:
          'الريادة والتميز في التعليم الطبي والرعاية الصحية بجمهورية مصر العربية.',
      visionEn:
          'Leadership and excellence in medical education and healthcare in the Arab Republic of Egypt.',
      missionAr: 'تخريج أطباء أكفاء وباحثين متميزين ذو أخلاقيات مهنية عالية.',
      missionEn:
          'Graduating competent doctors and distinguished researchers with high professional ethics.',
      goalsAr: [
        'توفير تدريب طبي متميز',
        'تطوير البحث العلمي الطبي',
        'تحسين جودة حياة المجتمع',
      ],
      goalsEn: [
        'Provide distinguished medical training',
        'Develop medical scientific research',
        'Improve society\'s quality of life',
      ],
    ),
    dean: const DeanInfo(
      nameAr: 'د. مسعد سليمان غيث',
      nameEn: 'Dr. Mosaad Soliman Ghaith',
      titleAr: 'عميد الكلية',
      titleEn: 'Dean of the Faculty',
      bioAr:
          'أستاذ جراحة الأوعية الدموية، وأحد أبرز الاستشاريين في المجال الطبي.',
      bioEn:
          'Professor of vascular surgery, and one of the most prominent consultants in the medical field.',
    ),
    stats: const CollegeStats(
      students: 1200,
      faculty: 150,
      assistantStaff: 120,
      researchPapers: 600,
    ),
    departmentsAr: [
      'قسم التشريح البشري',
      'قسم الكيمياء الحيوية',
      'قسم علم الأمراض',
    ],
    departmentsEn: ['Human Anatomy', 'Biochemistry', 'Pathology'],
  ),
  StaticCollegeData(
    id: 'health',
    nameEn: 'Faculty of Health Sciences',
    nameAr: 'كلية تكنولوجيا العلوم الصحية',
    imagePath: 'assets/images/colleges/health.jpg',
    themeColor: const Color(0xFF14B8A6),
    established: '2019',
    about: const CollegeSection(
      originsAr: 'تجمع بين التكنولوجيا والطب لتوفير كوادر تقنية طبية متخصصة.',
      originsEn:
          'Combines technology and medicine to provide specialized medical technical cadres.',
      visionAr: 'أن نكون الرواد في تكنولوجيا الرعاية الصحية الذكية.',
      visionEn: 'To be the pioneers in smart healthcare technology.',
      missionAr: 'توفير تعليم تقني عالي الجودة يدعم المنظومة الصحية.',
      missionEn:
          'Providing high-quality technical education that supports the health system.',
      goalsAr: [
        'تحديث المعامل التكنولوجية',
        'تطوير مهارات التشخيص بالصور',
        'تعزيز الرعاية التنفسية',
      ],
      goalsEn: [
        'Update technological labs',
        'Develop imaging diagnosis skills',
        'Enhance respiratory care',
      ],
    ),
    dean: const DeanInfo(
      nameAr: 'د. إبراهيم الجندي',
      nameEn: 'Dr. Ibrahim El-Gendy',
      titleAr: 'عميد الكلية',
      titleEn: 'Dean of the Faculty',
      bioAr:
          'خبير في تكنولوجيا المختبرات، كرس حياته لتطوير مناهج التعليم الصحي التقني.',
      bioEn:
          'Expert in laboratory technology, dedicated his life to developing technical health education curricula.',
    ),
    stats: const CollegeStats(
      students: 1100,
      faculty: 50,
      assistantStaff: 40,
      researchPapers: 120,
    ),
    departmentsAr: [
      'تكنولوجيا المختبرات الطبية',
      'تكنولوجيا الأشعة والتصوير',
      'تكنولوجيا الرعاية التنفسية',
    ],
    departmentsEn: [
      'Medical Lab Tech',
      'Radiology and Imaging',
      'Respiratory Care',
    ],
  ),
  StaticCollegeData(
    id: 'ai',
    nameEn: 'Faculty of Artificial Intelligence',
    nameAr: 'كلية الذكاء الاصطناعي',
    imagePath: 'assets/images/colleges/ai.jpg',
    themeColor: const Color(0xFF0EA5E9),
    established: '2024',
    about: const CollegeSection(
      originsAr: 'مركز الابتكار الرقمي، ترسم مستقبل التكنولوجيا في المنطقة.',
      originsEn:
          'The Digital Innovation Hub, mapping the future of technology in the region.',
      visionAr: 'صناعة عقول تبني المستقبل الذكي.',
      visionEn: 'Building minds that create the smart future.',
      missionAr:
          'تمكين الطلاب من أدوات الذكاء الاصطناعي لحل مشكلات العالم الحقيقي.',
      missionEn:
          'Empowering students with AI tools to solve real-world problems.',
      goalsAr: [
        'بناء أنظمة ذكية مبتكرة',
        'تعزيز الأمن السيبراني',
        'تطوير أبحاث الروبوتات',
      ],
      goalsEn: [
        'Build innovative smart systems',
        'Enhance cybersecurity',
        'Develop robotics research',
      ],
    ),
    dean: const DeanInfo(
      nameAr: 'د. أشرف فوزي',
      nameEn: 'Dr. Ashraf Fawzy',
      titleAr: 'المشرف على الكلية',
      titleEn: 'Faculty Supervisor',
      bioAr:
          'خبير في علوم الحاسب والذكاء الاصطناعي، يتبنى رؤية طموحة للتحول الرقمي.',
      bioEn:
          'Expert in computer science and AI, adopts an ambitious vision for digital transformation.',
    ),
    stats: const CollegeStats(
      students: 600,
      faculty: 35,
      assistantStaff: 25,
      researchPapers: 45,
    ),
    departmentsAr: [
      'الحوسبة الطبية الحيوية',
      'الأمن السيبراني',
      'روبوتات وذكاء اصطناعي',
    ],
    departmentsEn: ['Biomedical Computing', 'Cybersecurity', 'Robotics and AI'],
  ),
  StaticCollegeData(
    id: 'linguistics',
    nameEn: 'Faculty of Linguistics',
    nameAr: 'كلية الألسن والترجمة',
    imagePath: 'assets/images/colleges/linguistics.jpg',
    themeColor: const Color(0xFF6366F1),
    established: '2024',
    about: const CollegeSection(
      originsAr: 'جسر التواصل الحضاري، تعنى بدراسة اللغات والترجمة.',
      originsEn:
          'The bridge of cultural communication, concerned with the study of languages and translation.',
      visionAr: 'التميز في اكتساب اللغات والتبادل الثقافي.',
      visionEn: 'Excellence in language acquisition and cultural exchange.',
      missionAr: 'إعداد مترجمين وكوادر لغوية قادرة على المنافسة دولياً.',
      missionEn:
          'Preparing translators and linguistic cadres capable of competing internationally.',
      goalsAr: [
        'تطوير مختبرات اللغات',
        'تعزيز مهارات الترجمة الفورية',
        'دعم تعلم اللغات الأجنبية',
      ],
      goalsEn: [
        'Develop language labs',
        'Enhance simultaneous translation skills',
        'Support foreign language learning',
      ],
    ),
    dean: const DeanInfo(
      nameAr: 'د. ليلى عبد المعطي',
      nameEn: 'Dr. Laila Abdel Moaty',
      titleAr: 'عميد الكلية',
      titleEn: 'Dean of the Faculty',
      bioAr:
          'أكاديمية مرموقة في مجال اللغويات، تتقن عدة لغات ولها دراسات في الأدب المقارن.',
      bioEn:
          'Distinguished academic in linguisitcs, masters several languages and has studies in comparative literature.',
    ),
    stats: const CollegeStats(
      students: 500,
      faculty: 30,
      assistantStaff: 20,
      researchPapers: 35,
    ),
    departmentsAr: [
      'قسم اللغة الإنجليزية',
      'قسم اللغة الألمانية',
      'قسم اللغة الصينية',
    ],
    departmentsEn: [
      'English Department',
      'German Department',
      'Chinese Department',
    ],
  ),
];

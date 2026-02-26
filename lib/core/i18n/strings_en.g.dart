
part of 'strings.g.dart';

typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {

	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	Translations({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.en,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	@override final TranslationMetadata<AppLocale, Translations> $meta;

	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	late final TranslationsCommonEn common = TranslationsCommonEn.internal(_root);
	late final TranslationsWelcomeEn welcome = TranslationsWelcomeEn.internal(_root);
	late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn.internal(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn.internal(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn.internal(_root);
	late final TranslationsFeedEn feed = TranslationsFeedEn.internal(_root);
	late final TranslationsDashboardEn dashboard = TranslationsDashboardEn.internal(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn.internal(_root);
	late final TranslationsCollegesEn colleges = TranslationsCollegesEn.internal(_root);
	late final TranslationsTranscriptEn transcript = TranslationsTranscriptEn.internal(_root);
	late final TranslationsAcademicProgressEn academic_progress = TranslationsAcademicProgressEn.internal(_root);
	late final TranslationsGradesEn grades = TranslationsGradesEn.internal(_root);
	late final TranslationsSubjectResultsEn subject_results = TranslationsSubjectResultsEn.internal(_root);
	late final TranslationsActionPlanEn action_plan = TranslationsActionPlanEn.internal(_root);
	late final TranslationsCoursesEn courses = TranslationsCoursesEn.internal(_root);
	late final TranslationsScheduleEn schedule = TranslationsScheduleEn.internal(_root);
	late final TranslationsExamScheduleEn exam_schedule = TranslationsExamScheduleEn.internal(_root);
	late final TranslationsAttendanceEn attendance = TranslationsAttendanceEn.internal(_root);
	late final TranslationsRegistrationEn registration = TranslationsRegistrationEn.internal(_root);
	late final TranslationsPaymentEn payment = TranslationsPaymentEn.internal(_root);
	late final TranslationsInvoicesEn invoices = TranslationsInvoicesEn.internal(_root);
	late final TranslationsNotificationsEn notifications = TranslationsNotificationsEn.internal(_root);
	late final TranslationsSupportEn support = TranslationsSupportEn.internal(_root);
	late final TranslationsSecurityEn security = TranslationsSecurityEn.internal(_root);
	late final TranslationsTutorialsEn tutorials = TranslationsTutorialsEn.internal(_root);
	late final TranslationsForumsEn forums = TranslationsForumsEn.internal(_root);
	late final TranslationsAdministrationEn administration = TranslationsAdministrationEn.internal(_root);
	late final TranslationsProfessorEn professor = TranslationsProfessorEn.internal(_root);
	late final TranslationsRolesEn roles = TranslationsRolesEn.internal(_root);
}

class TranslationsCommonEn {
	TranslationsCommonEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get close => 'Close';

	String get cancel => 'Cancel';

	String get confirm => 'Confirm';

	String get save => 'Save';

	String get back => 'Back';
}

class TranslationsWelcomeEn {
	TranslationsWelcomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Welcome To Hue';

	String get subtitle => 'Light up your world with meaningful connections.';

	String get get_started => 'Get Started';

	String get have_account => 'I already have an account';
}

class TranslationsOnboardingEn {
	TranslationsOnboardingEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	late final TranslationsOnboardingLanguageEn language = TranslationsOnboardingLanguageEn.internal(_root);
	late final TranslationsOnboardingFacultiesDirectoryEn faculties_directory = TranslationsOnboardingFacultiesDirectoryEn.internal(_root);
	late final TranslationsOnboardingStyleEn style = TranslationsOnboardingStyleEn.internal(_root);
	late final TranslationsOnboardingThemeEn theme = TranslationsOnboardingThemeEn.internal(_root);
}

class TranslationsAuthEn {
	TranslationsAuthEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	late final TranslationsAuthLoginEn login = TranslationsAuthLoginEn.internal(_root);
	late final TranslationsAuthForgotPasswordEn forgot_password = TranslationsAuthForgotPasswordEn.internal(_root);
}

class TranslationsHomeEn {
	TranslationsHomeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	late final TranslationsHomeTabsEn tabs = TranslationsHomeTabsEn.internal(_root);
}

class TranslationsFeedEn {
	TranslationsFeedEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get likes => 'likes';

	String get caption_sample => 'This is a sample caption for post';

	String get hours_ago => 'hours ago';
}

class TranslationsDashboardEn {
	TranslationsDashboardEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	late final TranslationsDashboardIdCardEn id_card = TranslationsDashboardIdCardEn.internal(_root);
	late final TranslationsDashboardSectionsEn sections = TranslationsDashboardSectionsEn.internal(_root);
	late final TranslationsDashboardItemsEn items = TranslationsDashboardItemsEn.internal(_root);
	late final TranslationsDashboardLabelsEn labels = TranslationsDashboardLabelsEn.internal(_root);
}

class TranslationsSettingsEn {
	TranslationsSettingsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Settings';

	late final TranslationsSettingsSectionsEn sections = TranslationsSettingsSectionsEn.internal(_root);
	late final TranslationsSettingsTilesEn tiles = TranslationsSettingsTilesEn.internal(_root);
	late final TranslationsSettingsMessagesEn messages = TranslationsSettingsMessagesEn.internal(_root);
}

class TranslationsCollegesEn {
	TranslationsCollegesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	late final TranslationsCollegesDetailsEn details = TranslationsCollegesDetailsEn.internal(_root);

	String get applied_health_sciences => 'Faculty of Applied Health Sciences';

	String get business_administration => 'Faculty of Business Administration';

	String get dentistry => 'Faculty of Dentistry';

	String get engineering => 'Faculty of Engineering';

	String get fine_arts => 'Faculty of Fine Arts';

	String get human_medicine => 'Faculty of Human Medicine';

	String get linguistics => 'Faculty of Linguistics & Translation';

	String get pharmacy => 'Faculty of Pharmacy';

	String get physical_therapy => 'Faculty of Physical Therapy';

	String get ai => 'Faculty of Artificial Intelligence';

	late final TranslationsCollegesDepartmentsEn departments = TranslationsCollegesDepartmentsEn.internal(_root);
}

class TranslationsTranscriptEn {
	TranslationsTranscriptEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Academic Transcript';

	late final TranslationsTranscriptOverviewEn overview = TranslationsTranscriptOverviewEn.internal(_root);
	late final TranslationsTranscriptSemesterEn semester = TranslationsTranscriptSemesterEn.internal(_root);
	late final TranslationsTranscriptCourseEn course = TranslationsTranscriptCourseEn.internal(_root);
}

class TranslationsAcademicProgressEn {
	TranslationsAcademicProgressEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Academic Progress';

	String get completion => 'Degree Completion';

	String get total_credits => 'Total Credits';

	late final TranslationsAcademicProgressCategoriesEn categories = TranslationsAcademicProgressCategoriesEn.internal(_root);
	late final TranslationsAcademicProgressStatusEn status = TranslationsAcademicProgressStatusEn.internal(_root);
}

class TranslationsGradesEn {
	TranslationsGradesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Semester Grades';

	String get summary => 'Grade Summary';

	String get cumulative_gpa => 'Cumulative GPA';

	String get gpa => 'Semester GPA';

	String get credits => 'Credits';

	String get grade_point => 'Grade Point';

	String get letter_grade => 'Letter Grade';
}

class TranslationsSubjectResultsEn {
	TranslationsSubjectResultsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Subject Results';

	String get midterm => 'Midterm';

	String get kFinal => 'Final Exam';

	String get practical => 'Practical/Lab';

	String get activities => 'Semester Activities';

	String get total => 'Total Score';
}

class TranslationsActionPlanEn {
	TranslationsActionPlanEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Degree Action Plan';

	String get roadmap => 'Course Roadmap';

	String get year_1 => 'Freshman Year';

	String get year_2 => 'Sophomore Year';

	String get year_3 => 'Junior Year';

	String get year_4 => 'Senior Year';
}

class TranslationsCoursesEn {
	TranslationsCoursesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'My Courses';

	String get enrolled => 'Enrolled';

	String get available => 'Available';

	String get instructor => 'Instructor';

	String get schedule => 'Schedule';
}

class TranslationsScheduleEn {
	TranslationsScheduleEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Weekly Schedule';

	String get daily_title => 'Daily Schedule';

	String get no_lectures => 'No lectures today';

	String get time => 'Time';

	String get room => 'Room';

	String get monday => 'Monday';

	String get tuesday => 'Tuesday';

	String get wednesday => 'Wednesday';

	String get thursday => 'Thursday';

	String get friday => 'Friday';

	String get saturday => 'Saturday';

	String get sunday => 'Sunday';

	String get instructor => 'Instructor';

	String get doctor => 'Dr.';

	String get type_lecture => 'Lecture';

	String get type_section => 'Section';

	String get status_active => 'Upcoming';

	String get status_started => 'Now';

	String get status_cancelled => 'Cancelled';

	String get status_online => 'Online';

	String get status_substitute => 'Substitute';

	String get morning => 'Morning';

	String get afternoon => 'Afternoon';

	String get evening => 'Evening';

	String get all_periods => 'All Periods';

	String get floor => 'Floor';

	String get direction => 'Direction';

	String get east => 'East';

	String get west => 'West';

	String get south => 'South';

	String get north => 'North';
}

class TranslationsExamScheduleEn {
	TranslationsExamScheduleEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Exam Schedule';

	String get date => 'Date';

	String get duration => 'Duration';

	String get seat => 'Seat Number';
}

class TranslationsAttendanceEn {
	TranslationsAttendanceEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Attendance Statistics';

	String get present => 'Present';

	String get absent => 'Absent';

	String get late => 'Late';

	String get ratio => 'Attendance Ratio';

	late final TranslationsAttendanceSubjectsEn subjects = TranslationsAttendanceSubjectsEn.internal(_root);
}

class TranslationsRegistrationEn {
	TranslationsRegistrationEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Course Registration';

	String get submit => 'Submit Registration';

	String get enrolled_credits => 'Enrolled Credits';

	String get step1_title => 'Step 1: Choose Main Group';

	String get step1_subtitle => 'Select the main group you wish to register for this semester.';

	String group_label({required Object group}) => 'Group ${group}';

	String get main_cohort => 'Main cohort registration';

	String get step2_title => 'Step 2: Choose Sub-section';

	String step2_subtitle({required Object group}) => 'Selected Group: ${group}. Now select your practical sub-section.';

	String section_label({required Object section}) => 'Section ${section}';

	String get labs_sessions => 'Labs and practical sessions';

	String get step3_title => 'Step 3: Confirm Registration';

	String get review => 'Review Selections';

	String get semester => 'Semester';

	String get group => 'Group';

	String get section => 'Section';

	String get auto_registered => 'Courses to be automatically registered:';

	String credits_count({required Object credits}) => '${credits} CR';

	String get confirm_final => 'Confirm Final Registration';

	String get already_registered_title => 'Already Registered!';

	String success_message({required Object group, required Object section}) => 'You have successfully registered for this semester.\nGroup: ${group} | Section: ${section}';

	String get back_home => 'Back to Home';

	String get registration_success => 'Registration Successful!';

	String error_loading({required Object error}) => 'Error: ${error}\n\nTap to retry';
}

class TranslationsPaymentEn {
	TranslationsPaymentEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Tuition Payment';

	String get outstanding => 'Outstanding Balance';

	String get pay_now => 'Pay Now';

	String get methods => 'Payment Methods';

	String get university_guaranteed => 'University Guaranteed Methods';

	String get credit_debit => 'Credit / Debit Card';

	String get fawry => 'Fawry / E-Payment';

	String get bank_transfer => 'Bank Transfer';

	String currency({required Object amount}) => '${amount} EGP';
}

class TranslationsInvoicesEn {
	TranslationsInvoicesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Financial Invoices';

	String get history => 'Payment History';

	String get unpaid => 'Unpaid';

	String get paid => 'Paid';

	String get id => 'Invoice ID';

	String get date => 'Date';

	String get amount => 'Amount';

	String get status => 'Status';
}

class TranslationsNotificationsEn {
	TranslationsNotificationsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Notifications';

	String get empty => 'No new notifications';
}

class TranslationsSupportEn {
	TranslationsSupportEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Support & Help';

	String get contact_us => 'Contact Us';
}

class TranslationsSecurityEn {
	TranslationsSecurityEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Security';

	String get biometrics => 'Biometrics';

	String get sessions => 'Active Sessions';
}

class TranslationsTutorialsEn {
	TranslationsTutorialsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Tutorials & Guides';
}

class TranslationsForumsEn {
	TranslationsForumsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Forums';
}

class TranslationsAdministrationEn {
	TranslationsAdministrationEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Student Management';

	String get stats => 'System Stats';

	String get users => 'Users';

	String get reports => 'Reports';
}

class TranslationsProfessorEn {
	TranslationsProfessorEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get dashboard_title => 'Professor Dashboard';

	String welcome_back_name({required Object name}) => 'Welcome back, ${name}';

	String active_tas_count({required Object count}) => '${count} Active TAs';

	String total_students_count({required Object count}) => '${count} Total Students';

	String uploaded_files_count({required Object count}) => '${count} Uploaded Files';

	String weekly_slots_count({required Object count}) => '${count} Weekly Slots';

	String announcement_to({required Object count}) => 'Announce to ${count}';

	String get preparing_announcement => 'Preparing Announcement...';

	String get no_groups => 'No Groups Available';

	String get select_all => 'Select All';

	String get deselect_all => 'Deselect All';

	String selected_count({required Object count}) => '${count} Selected';

	String action_clicked({required Object action}) => 'Clicked: ${action}';

	String activating({required Object target}) => 'Activating: ${target}';

	String get add_new_ta => 'Add New TA';

	String get no_available_tas => 'No available TAs';

	String get no_active_tas => 'No Active TAs';

	String added({required Object name}) => 'Added: ${name}';

	String removed({required Object name}) => 'Removed: ${name}';

	String get add => 'Add';

	String get urgent => 'Urgent';

	String get upload => 'Upload';

	String get message => 'Message';

	String get downloading => 'Downloading...';

	String get walk_in => 'Walk-in';

	String joined({required Object name}) => 'Joined: ${name}';

	String get join => 'Join';

	late final TranslationsProfessorStatsEn stats = TranslationsProfessorStatsEn.internal(_root);
	late final TranslationsProfessorQuickActionsEn quick_actions = TranslationsProfessorQuickActionsEn.internal(_root);
	late final TranslationsProfessorProfileEn profile = TranslationsProfessorProfileEn.internal(_root);
}

class TranslationsRolesEn {
	TranslationsRolesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	late final TranslationsRolesCategoriesEn categories = TranslationsRolesCategoriesEn.internal(_root);
	late final TranslationsRolesNamesEn names = TranslationsRolesNamesEn.internal(_root);
	late final TranslationsRolesDescriptionsEn descriptions = TranslationsRolesDescriptionsEn.internal(_root);
}

class TranslationsOnboardingLanguageEn {
	TranslationsOnboardingLanguageEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Choose your language';

	String get subtitle => 'اختر لغتك المفضلة';

	String get english => 'English';

	String get arabic => 'العربية';

	String get german => 'Deutsch';

	String get chinese => '中文';

	String get hint => 'You can change this later in settings\nيمكنك تغيير هذا لاحقاً في الإعدادات';
}

class TranslationsOnboardingFacultiesDirectoryEn {
	TranslationsOnboardingFacultiesDirectoryEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Our Faculties';

	String get subtitle => 'Discover Horus University portal.';
}

class TranslationsOnboardingStyleEn {
	TranslationsOnboardingStyleEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Choose your style';

	String get subtitle => 'Select the interface design you prefer';

	late final TranslationsOnboardingStyleClassicEn classic = TranslationsOnboardingStyleClassicEn.internal(_root);
	late final TranslationsOnboardingStyleGlassEn glass = TranslationsOnboardingStyleGlassEn.internal(_root);
}

class TranslationsOnboardingThemeEn {
	TranslationsOnboardingThemeEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Choose a theme';

	String get subtitle => 'Light or dark, your choice';

	String get light => 'Light';

	String get dark => 'Dark';
}

class TranslationsAuthLoginEn {
	TranslationsAuthLoginEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get welcome => 'Welcome Back';

	String get subtitle => 'Sign in to continue';

	String get email => 'Email';

	String get password => 'Password';

	String get forgot_password => 'Forgot Password?';

	String get submit => 'Login';

	String get guest => 'Browse as Guest';
}

class TranslationsAuthForgotPasswordEn {
	TranslationsAuthForgotPasswordEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Forgot Password';

	String get subtitle => 'Choose a recovery method';

	String get method_admin => 'Visit Administration';

	String get method_online => 'Online Request';

	String get admin_instructions => 'Please visit the student affairs office to reset your password. Bring your valid university ID.';

	String get phone_label => 'Phone Number';

	String get upload_id => 'Upload ID Photo';

	String get upload_id_hint => 'Tap to upload a clear photo of your university ID';

	String get submit => 'Submit Request';

	String get back => 'Back to Login';

	String get error_empty_phone => 'Please enter your phone number';

	String get error_empty_email => 'Please enter your email';

	String get error_no_id => 'Please upload your ID photo';

	String get success => 'Request submitted successfully';

	String get id_uploaded => 'ID Uploaded';
}

class TranslationsHomeTabsEn {
	TranslationsHomeTabsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get home => 'Home';

	String get colleges => 'Colleges';

	String get student => 'Student';

	String get admin => 'Admin';

	String get search => 'Search';

	String get notifications => 'Notifications';

	String get profile => 'Profile';
}

class TranslationsDashboardIdCardEn {
	TranslationsDashboardIdCardEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get student_name => 'Student Name';

	String get college => 'College';

	String get id => 'Student ID';

	String get gpa => 'GPA';

	String get level => 'Level';

	String get verified => 'Verified';
}

class TranslationsDashboardSectionsEn {
	TranslationsDashboardSectionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get academic => 'Academic';

	String get enrollment => 'Enrollment';

	String get utilities => 'Utilities';
}

class TranslationsDashboardItemsEn {
	TranslationsDashboardItemsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get digital_id => 'Digital ID';

	String get transcript => 'Transcript';

	String get progress => 'Progress';

	String get action_plan => 'Action Plan';

	String get subject_result => 'Subject Result';

	String get grades => 'Grades';

	String get courses => 'Courses';

	String get registration => 'Registration';

	String get invoices => 'Unpaid Invoices';

	String get payment => 'Payment';

	String get tutorials => 'Tutorials';

	String get security => 'Security';

	String get forums => 'Forums';

	String get support => 'Support';

	String get notifications => 'Notifications';

	String get no_lectures => 'No lectures found';
}

class TranslationsDashboardLabelsEn {
	TranslationsDashboardLabelsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get university_name => 'Horus University';

	String get id_short => 'ID';

	String get gpa_short => 'GPA';

	String get level_short => 'LVL';
}

class TranslationsSettingsSectionsEn {
	TranslationsSettingsSectionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get account => 'Account';

	String get display => 'Display';

	String get notifications => 'Notifications';

	String get about => 'About';
}

class TranslationsSettingsTilesEn {
	TranslationsSettingsTilesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get edit_profile => 'Edit Profile';

	String get change_password => 'Change Password';

	String get dark_mode => 'Dark Mode';

	String get language => 'Language';

	String get ui_style => 'UI Style';

	String get app_notifications => 'App Notifications';

	String get about_app => 'About App';

	String get privacy_policy => 'Privacy Policy';

	String get logout => 'Logout';
}

class TranslationsSettingsMessagesEn {
	TranslationsSettingsMessagesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get switching_theme => 'Switching Theme...';

	String get changing_language => 'Changing Language...';

	String get rebuilding_design => 'Rebuilding Design System...';
}

class TranslationsCollegesDetailsEn {
	TranslationsCollegesDetailsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get dean => 'Dean of College';

	String get staff => 'Academic Staff';

	String get view_all => 'View All';

	String get departments => 'Departments';

	String get explore_majors => 'Explore available majors';

	String get majors => 'Majors';

	String get dean_title => 'The Dean';

	String get staff_member => 'Staff Member';

	String get vice_dean => 'Vice Dean';

	String get head_of_dept => 'Head of Dept';

	String get assoc_prof => 'Assoc. Prof';

	String get academic_statistics => 'Academic Statistics';

	String get students => 'Students';

	String get academic_staff => 'Academic Staff';

	String get teaching_assistants => 'Teaching Assistants';

	String get published_articles => 'Published Articles';
}

class TranslationsCollegesDepartmentsEn {
	TranslationsCollegesDepartmentsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get medical_laboratories_technology => 'Medical Laboratories Technology';

	String get radiology_and_imaging_technology => 'Radiology and Imaging Technology';

	String get respiratory_care_technology => 'Respiratory Care Technology';

	String get dental_prosthetics_technology => 'Dental Prosthetics Technology';

	String get health_administration_and_informatics_technology => 'Health Administration and Informatics Technology';

	String get accounting => 'Accounting';

	String get business_management => 'Business Management';

	String get economics => 'Economics';

	String get marketing => 'Marketing';

	String get accounting_program_english => 'Accounting Program (English)';

	String get business_administration_program_english => 'Business Administration Program (English)';

	String get basic_sciences_in_dentistry => 'Basic Sciences in Dentistry';

	String get basic_medical_and_clinical_sciences => 'Basic Medical and Clinical Sciences';

	String get oral_and_maxillofacial_surgery => 'Oral and Maxillofacial Surgery';

	String get orthodontics_and_pediatric_dentistry => 'Orthodontics and Pediatric Dentistry';

	String get periodontics_and_oral_medicine => 'Periodontics and Oral Medicine';

	String get prosthodontics => 'Prosthodontics';

	String get conservative_dentistry_and_endodontics => 'Conservative Dentistry and Endodontics';

	String get architectural_engineering => 'Architectural Engineering';

	String get basic_sciences => 'Basic Sciences';

	String get civil_engineering => 'Civil Engineering';

	String get mechanical_engineering => 'Mechanical Engineering';

	String get electrical_engineering => 'Electrical Engineering';

	String get artificial_intelligence_engineering => 'Artificial Intelligence Engineering';

	String get interior_design_and_architecture => 'Interior Design and Architecture';

	String get furniture_design_and_production_technology => 'Furniture Design and Production Technology';

	String get graphics_and_digital_arts => 'Graphics and Digital Arts';

	String get animation_and_multimedia => 'Animation and Multimedia';

	String get medical_education => 'Medical Education';

	String get histology_and_cell_biology => 'Histology and Cell Biology';

	String get clinical_pharmacy => 'Clinical Pharmacy';

	String get human_anatomy_and_embryology => 'Human Anatomy and Embryology';

	String get medical_physiology => 'Medical Physiology';

	String get medical_microbiology_and_immunology => 'Medical Microbiology and Immunology';

	String get forensic_medicine_and_toxicology => 'Forensic Medicine and Toxicology';

	String get community_medicine_and_public_health => 'Community Medicine and Public Health';

	String get biochemistry => 'Biochemistry';

	String get pathology => 'Pathology';

	String get english_language_program => 'English Language Program';

	String get german_language_program => 'German Language Program';

	String get chinese_language_program => 'Chinese Language Program';

	String get french_department => 'French Department';

	String get translation_department => 'Translation Department';

	String get pharmaceutical_chemistry => 'Pharmaceutical Chemistry';

	String get pharmacology_and_biochemistry => 'Pharmacology and Biochemistry';

	String get pharmacognosy => 'Pharmacognosy';

	String get microbiology_and_immunology => 'Microbiology and Immunology';

	String get pharmaceutical_technology => 'Pharmaceutical Technology';

	String get pharmacy_practice => 'Pharmacy Practice';

	String get basic_sciences_pt => 'Basic Sciences';

	String get biomechanics => 'Biomechanics';

	String get pt_internal_medicine_and_geriatrics => 'PT for Internal Medicine and Geriatrics';

	String get pt_womens_health => 'PT for Women\'s Health';

	String get pt_surgery_and_integumentary => 'PT for Surgery and Integumentary';

	String get pt_orthopedics => 'PT for Orthopedics';

	String get pt_neurology => 'PT for Neurology';

	String get pt_pediatrics => 'PT for Pediatrics';

	String get artificial_biomedical_computing => 'Artificial Biomedical Computing';

	String get artificial_cybersecurity => 'Cyber Security';

	String get ai_and_data_science => 'AI and Data Science';

	String get ai_for_robotics => 'AI for Robotics';

	String get smart_systems => 'Smart Systems';
}

class TranslationsTranscriptOverviewEn {
	TranslationsTranscriptOverviewEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get gpa => 'Cumulative GPA';

	String get credits => 'Earned Credits';

	String get standing => 'Standing';

	String get active => 'Good Standing';
}

class TranslationsTranscriptSemesterEn {
	TranslationsTranscriptSemesterEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get fall => 'Fall Semester';

	String get spring => 'Spring Semester';

	String get summer => 'Summer Session';
}

class TranslationsTranscriptCourseEn {
	TranslationsTranscriptCourseEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get grade => 'Grade';

	String get credits => 'Credits';

	late final TranslationsTranscriptCourseStatusEn status = TranslationsTranscriptCourseStatusEn.internal(_root);
}

class TranslationsAcademicProgressCategoriesEn {
	TranslationsAcademicProgressCategoriesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get university_name => 'Horus University';

	String get faculty => 'Faculty Requirements';

	String get major => 'Major Requirements';

	String get electives => 'Electives';
}

class TranslationsAcademicProgressStatusEn {
	TranslationsAcademicProgressStatusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get completed => 'Completed';

	String get in_progress => 'In Progress';

	String get remaining => 'Remaining';

	String get requirement_met => 'Requirement Met';
}

class TranslationsAttendanceSubjectsEn {
	TranslationsAttendanceSubjectsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get ai => 'Artificial Intelligence';

	String get machine_learning => 'Machine Learning';

	String get ethics => 'Ethics in IT';

	String get calculus => 'Advanced Calculus';
}

class TranslationsProfessorStatsEn {
	TranslationsProfessorStatsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get groups => 'Groups';

	String get students => 'Total Students';

	String get tas => 'Teaching Assistants';

	String get rating => 'Rating';

	String get shared_files => 'Shared Files';

	String get office_hours => 'Office Hours';
}

class TranslationsProfessorQuickActionsEn {
	TranslationsProfessorQuickActionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get urgent => 'Urgent';

	String get upload => 'Upload';

	String get message => 'Message';

	String get action_clicked => 'Clicked';
}

class TranslationsProfessorProfileEn {
	TranslationsProfessorProfileEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get urgent_announcements => 'Urgent Announcements';

	String get teaching_assistants => 'Teaching Assistants';

	String get shared_resources => 'Shared Resources';

	String get office_hours => 'Office Hours';
}

class TranslationsRolesCategoriesEn {
	TranslationsRolesCategoriesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get admin_it => 'Admin & IT';

	String get academic_leadership => 'Academic Leadership';

	String get teaching_staff => 'Teaching Staff';

	String get student_affairs => 'Student Affairs';

	String get student_roles => 'Student Roles';

	String get facilities_security => 'Facilities & Security';

	String get external_roles => 'External Roles';
}

class TranslationsRolesNamesEn {
	TranslationsRolesNamesEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get super_admin => 'Super Admin';

	String get admin => 'Administrator';

	String get it_support => 'IT Support';

	String get financial_auditor => 'Financial Auditor';

	String get rector => 'Rector / President';

	String get dean => 'Dean';

	String get department_head => 'Department Head';

	String get academic_coordinator => 'Academic Coordinator';

	String get professor => 'Professor / Instructor';

	String get lecturer => 'Lecturer';

	String get teaching_assistant => 'Teaching Assistant';

	String get registrar_officer => 'Registrar Officer';

	String get academic_advisor => 'Academic Advisor';

	String get librarian => 'Librarian';

	String get freshman => 'Freshman';

	String get regular_student => 'Regular Student';

	String get student => 'Student';

	String get class_representative => 'Class Representative';

	String get alumni => 'Alumni';

	String get dorm_supervisor => 'Dorm Supervisor';

	String get security_officer => 'Security Officer';

	String get guest => 'Guest';

	String get parent => 'Parent / Guardian';

	String get recruiter => 'Recruiter';
}

class TranslationsRolesDescriptionsEn {
	TranslationsRolesDescriptionsEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get super_admin => 'Full control over the entire system';

	String get admin => 'System administrator with high privileges';

	String get it_support => 'Technical system support and maintenance';

	String get financial_auditor => 'Oversees financial records and invoices';

	String get rector => 'University president with full academic oversight';

	String get dean => 'Head of a college/faculty';

	String get department_head => 'Head of an academic department';

	String get academic_coordinator => 'Coordinates academic programs and scheduling';

	String get professor => 'Faculty member who teaches and manages courses';

	String get lecturer => 'Teaches courses without full professor privileges';

	String get teaching_assistant => 'Assists professors with grading, labs, and tutorials';

	String get registrar_officer => 'Manages student enrollment and registration';

	String get academic_advisor => 'Guides students through academic planning';

	String get librarian => 'Manages library resources and materials';

	String get freshman => 'First-year student with limited system access';

	String get regular_student => 'Full student with all standard academic privileges';

	String get student => 'General student role';

	String get class_representative => 'Student leader who represents the class body';

	String get alumni => 'Graduated student with limited access';

	String get dorm_supervisor => 'Manages student dormitory operations';

	String get security_officer => 'Campus security and access control';

	String get guest => 'Temporary visitor with minimal access';

	String get parent => 'Can view linked student progress and grades';

	String get recruiter => 'External recruitment organization';
}

class TranslationsOnboardingStyleClassicEn {
	TranslationsOnboardingStyleClassicEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Classic';

	String get desc => 'Clean, simple, and familiar Material Design';
}

class TranslationsOnboardingStyleGlassEn {
	TranslationsOnboardingStyleGlassEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get title => 'Glass';

	String get desc => 'Modern, translucent, and vibrant aesthetics';
}

class TranslationsTranscriptCourseStatusEn {
	TranslationsTranscriptCourseStatusEn.internal(this._root);

	final Translations _root; // ignore: unused_field

	String get completed => 'Completed';

	String get transferred => 'Transferred';
}

extension on Translations {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.close' => 'Close',
			'common.cancel' => 'Cancel',
			'common.confirm' => 'Confirm',
			'common.save' => 'Save',
			'common.back' => 'Back',
			'welcome.title' => 'Welcome To Hue',
			'welcome.subtitle' => 'Light up your world with meaningful connections.',
			'welcome.get_started' => 'Get Started',
			'welcome.have_account' => 'I already have an account',
			'onboarding.language.title' => 'Choose your language',
			'onboarding.language.subtitle' => 'اختر لغتك المفضلة',
			'onboarding.language.english' => 'English',
			'onboarding.language.arabic' => 'العربية',
			'onboarding.language.german' => 'Deutsch',
			'onboarding.language.chinese' => '中文',
			'onboarding.language.hint' => 'You can change this later in settings\nيمكنك تغيير هذا لاحقاً في الإعدادات',
			'onboarding.faculties_directory.title' => 'Our Faculties',
			'onboarding.faculties_directory.subtitle' => 'Discover Horus University portal.',
			'onboarding.style.title' => 'Choose your style',
			'onboarding.style.subtitle' => 'Select the interface design you prefer',
			'onboarding.style.classic.title' => 'Classic',
			'onboarding.style.classic.desc' => 'Clean, simple, and familiar Material Design',
			'onboarding.style.glass.title' => 'Glass',
			'onboarding.style.glass.desc' => 'Modern, translucent, and vibrant aesthetics',
			'onboarding.theme.title' => 'Choose a theme',
			'onboarding.theme.subtitle' => 'Light or dark, your choice',
			'onboarding.theme.light' => 'Light',
			'onboarding.theme.dark' => 'Dark',
			'auth.login.welcome' => 'Welcome Back',
			'auth.login.subtitle' => 'Sign in to continue',
			'auth.login.email' => 'Email',
			'auth.login.password' => 'Password',
			'auth.login.forgot_password' => 'Forgot Password?',
			'auth.login.submit' => 'Login',
			'auth.login.guest' => 'Browse as Guest',
			'auth.forgot_password.title' => 'Forgot Password',
			'auth.forgot_password.subtitle' => 'Choose a recovery method',
			'auth.forgot_password.method_admin' => 'Visit Administration',
			'auth.forgot_password.method_online' => 'Online Request',
			'auth.forgot_password.admin_instructions' => 'Please visit the student affairs office to reset your password. Bring your valid university ID.',
			'auth.forgot_password.phone_label' => 'Phone Number',
			'auth.forgot_password.upload_id' => 'Upload ID Photo',
			'auth.forgot_password.upload_id_hint' => 'Tap to upload a clear photo of your university ID',
			'auth.forgot_password.submit' => 'Submit Request',
			'auth.forgot_password.back' => 'Back to Login',
			'auth.forgot_password.error_empty_phone' => 'Please enter your phone number',
			'auth.forgot_password.error_empty_email' => 'Please enter your email',
			'auth.forgot_password.error_no_id' => 'Please upload your ID photo',
			'auth.forgot_password.success' => 'Request submitted successfully',
			'auth.forgot_password.id_uploaded' => 'ID Uploaded',
			'home.tabs.home' => 'Home',
			'home.tabs.colleges' => 'Colleges',
			'home.tabs.student' => 'Student',
			'home.tabs.admin' => 'Admin',
			'home.tabs.search' => 'Search',
			'home.tabs.notifications' => 'Notifications',
			'home.tabs.profile' => 'Profile',
			'feed.likes' => 'likes',
			'feed.caption_sample' => 'This is a sample caption for post',
			'feed.hours_ago' => 'hours ago',
			'dashboard.id_card.student_name' => 'Student Name',
			'dashboard.id_card.college' => 'College',
			'dashboard.id_card.id' => 'Student ID',
			'dashboard.id_card.gpa' => 'GPA',
			'dashboard.id_card.level' => 'Level',
			'dashboard.id_card.verified' => 'Verified',
			'dashboard.sections.academic' => 'Academic',
			'dashboard.sections.enrollment' => 'Enrollment',
			'dashboard.sections.utilities' => 'Utilities',
			'dashboard.items.digital_id' => 'Digital ID',
			'dashboard.items.transcript' => 'Transcript',
			'dashboard.items.progress' => 'Progress',
			'dashboard.items.action_plan' => 'Action Plan',
			'dashboard.items.subject_result' => 'Subject Result',
			'dashboard.items.grades' => 'Grades',
			'dashboard.items.courses' => 'Courses',
			'dashboard.items.registration' => 'Registration',
			'dashboard.items.invoices' => 'Unpaid Invoices',
			'dashboard.items.payment' => 'Payment',
			'dashboard.items.tutorials' => 'Tutorials',
			'dashboard.items.security' => 'Security',
			'dashboard.items.forums' => 'Forums',
			'dashboard.items.support' => 'Support',
			'dashboard.items.notifications' => 'Notifications',
			'dashboard.items.no_lectures' => 'No lectures found',
			'dashboard.labels.university_name' => 'Horus University',
			'dashboard.labels.id_short' => 'ID',
			'dashboard.labels.gpa_short' => 'GPA',
			'dashboard.labels.level_short' => 'LVL',
			'settings.title' => 'Settings',
			'settings.sections.account' => 'Account',
			'settings.sections.display' => 'Display',
			'settings.sections.notifications' => 'Notifications',
			'settings.sections.about' => 'About',
			'settings.tiles.edit_profile' => 'Edit Profile',
			'settings.tiles.change_password' => 'Change Password',
			'settings.tiles.dark_mode' => 'Dark Mode',
			'settings.tiles.language' => 'Language',
			'settings.tiles.ui_style' => 'UI Style',
			'settings.tiles.app_notifications' => 'App Notifications',
			'settings.tiles.about_app' => 'About App',
			'settings.tiles.privacy_policy' => 'Privacy Policy',
			'settings.tiles.logout' => 'Logout',
			'settings.messages.switching_theme' => 'Switching Theme...',
			'settings.messages.changing_language' => 'Changing Language...',
			'settings.messages.rebuilding_design' => 'Rebuilding Design System...',
			'colleges.details.dean' => 'Dean of College',
			'colleges.details.staff' => 'Academic Staff',
			'colleges.details.view_all' => 'View All',
			'colleges.details.departments' => 'Departments',
			'colleges.details.explore_majors' => 'Explore available majors',
			'colleges.details.majors' => 'Majors',
			'colleges.details.dean_title' => 'The Dean',
			'colleges.details.staff_member' => 'Staff Member',
			'colleges.details.vice_dean' => 'Vice Dean',
			'colleges.details.head_of_dept' => 'Head of Dept',
			'colleges.details.assoc_prof' => 'Assoc. Prof',
			'colleges.details.academic_statistics' => 'Academic Statistics',
			'colleges.details.students' => 'Students',
			'colleges.details.academic_staff' => 'Academic Staff',
			'colleges.details.teaching_assistants' => 'Teaching Assistants',
			'colleges.details.published_articles' => 'Published Articles',
			'colleges.applied_health_sciences' => 'Faculty of Applied Health Sciences',
			'colleges.business_administration' => 'Faculty of Business Administration',
			'colleges.dentistry' => 'Faculty of Dentistry',
			'colleges.engineering' => 'Faculty of Engineering',
			'colleges.fine_arts' => 'Faculty of Fine Arts',
			'colleges.human_medicine' => 'Faculty of Human Medicine',
			'colleges.linguistics' => 'Faculty of Linguistics & Translation',
			'colleges.pharmacy' => 'Faculty of Pharmacy',
			'colleges.physical_therapy' => 'Faculty of Physical Therapy',
			'colleges.ai' => 'Faculty of Artificial Intelligence',
			'colleges.departments.medical_laboratories_technology' => 'Medical Laboratories Technology',
			'colleges.departments.radiology_and_imaging_technology' => 'Radiology and Imaging Technology',
			'colleges.departments.respiratory_care_technology' => 'Respiratory Care Technology',
			'colleges.departments.dental_prosthetics_technology' => 'Dental Prosthetics Technology',
			'colleges.departments.health_administration_and_informatics_technology' => 'Health Administration and Informatics Technology',
			'colleges.departments.accounting' => 'Accounting',
			'colleges.departments.business_management' => 'Business Management',
			'colleges.departments.economics' => 'Economics',
			'colleges.departments.marketing' => 'Marketing',
			'colleges.departments.accounting_program_english' => 'Accounting Program (English)',
			'colleges.departments.business_administration_program_english' => 'Business Administration Program (English)',
			'colleges.departments.basic_sciences_in_dentistry' => 'Basic Sciences in Dentistry',
			'colleges.departments.basic_medical_and_clinical_sciences' => 'Basic Medical and Clinical Sciences',
			'colleges.departments.oral_and_maxillofacial_surgery' => 'Oral and Maxillofacial Surgery',
			'colleges.departments.orthodontics_and_pediatric_dentistry' => 'Orthodontics and Pediatric Dentistry',
			'colleges.departments.periodontics_and_oral_medicine' => 'Periodontics and Oral Medicine',
			'colleges.departments.prosthodontics' => 'Prosthodontics',
			'colleges.departments.conservative_dentistry_and_endodontics' => 'Conservative Dentistry and Endodontics',
			'colleges.departments.architectural_engineering' => 'Architectural Engineering',
			'colleges.departments.basic_sciences' => 'Basic Sciences',
			'colleges.departments.civil_engineering' => 'Civil Engineering',
			'colleges.departments.mechanical_engineering' => 'Mechanical Engineering',
			'colleges.departments.electrical_engineering' => 'Electrical Engineering',
			'colleges.departments.artificial_intelligence_engineering' => 'Artificial Intelligence Engineering',
			'colleges.departments.interior_design_and_architecture' => 'Interior Design and Architecture',
			'colleges.departments.furniture_design_and_production_technology' => 'Furniture Design and Production Technology',
			'colleges.departments.graphics_and_digital_arts' => 'Graphics and Digital Arts',
			'colleges.departments.animation_and_multimedia' => 'Animation and Multimedia',
			'colleges.departments.medical_education' => 'Medical Education',
			'colleges.departments.histology_and_cell_biology' => 'Histology and Cell Biology',
			'colleges.departments.clinical_pharmacy' => 'Clinical Pharmacy',
			'colleges.departments.human_anatomy_and_embryology' => 'Human Anatomy and Embryology',
			'colleges.departments.medical_physiology' => 'Medical Physiology',
			'colleges.departments.medical_microbiology_and_immunology' => 'Medical Microbiology and Immunology',
			'colleges.departments.forensic_medicine_and_toxicology' => 'Forensic Medicine and Toxicology',
			'colleges.departments.community_medicine_and_public_health' => 'Community Medicine and Public Health',
			'colleges.departments.biochemistry' => 'Biochemistry',
			'colleges.departments.pathology' => 'Pathology',
			'colleges.departments.english_language_program' => 'English Language Program',
			'colleges.departments.german_language_program' => 'German Language Program',
			'colleges.departments.chinese_language_program' => 'Chinese Language Program',
			'colleges.departments.french_department' => 'French Department',
			'colleges.departments.translation_department' => 'Translation Department',
			'colleges.departments.pharmaceutical_chemistry' => 'Pharmaceutical Chemistry',
			'colleges.departments.pharmacology_and_biochemistry' => 'Pharmacology and Biochemistry',
			'colleges.departments.pharmacognosy' => 'Pharmacognosy',
			'colleges.departments.microbiology_and_immunology' => 'Microbiology and Immunology',
			'colleges.departments.pharmaceutical_technology' => 'Pharmaceutical Technology',
			'colleges.departments.pharmacy_practice' => 'Pharmacy Practice',
			'colleges.departments.basic_sciences_pt' => 'Basic Sciences',
			'colleges.departments.biomechanics' => 'Biomechanics',
			'colleges.departments.pt_internal_medicine_and_geriatrics' => 'PT for Internal Medicine and Geriatrics',
			'colleges.departments.pt_womens_health' => 'PT for Women\'s Health',
			'colleges.departments.pt_surgery_and_integumentary' => 'PT for Surgery and Integumentary',
			'colleges.departments.pt_orthopedics' => 'PT for Orthopedics',
			'colleges.departments.pt_neurology' => 'PT for Neurology',
			'colleges.departments.pt_pediatrics' => 'PT for Pediatrics',
			'colleges.departments.artificial_biomedical_computing' => 'Artificial Biomedical Computing',
			'colleges.departments.artificial_cybersecurity' => 'Cyber Security',
			'colleges.departments.ai_and_data_science' => 'AI and Data Science',
			'colleges.departments.ai_for_robotics' => 'AI for Robotics',
			'colleges.departments.smart_systems' => 'Smart Systems',
			'transcript.title' => 'Academic Transcript',
			'transcript.overview.gpa' => 'Cumulative GPA',
			'transcript.overview.credits' => 'Earned Credits',
			'transcript.overview.standing' => 'Standing',
			'transcript.overview.active' => 'Good Standing',
			'transcript.semester.fall' => 'Fall Semester',
			'transcript.semester.spring' => 'Spring Semester',
			'transcript.semester.summer' => 'Summer Session',
			'transcript.course.grade' => 'Grade',
			'transcript.course.credits' => 'Credits',
			'transcript.course.status.completed' => 'Completed',
			'transcript.course.status.transferred' => 'Transferred',
			'academic_progress.title' => 'Academic Progress',
			'academic_progress.completion' => 'Degree Completion',
			'academic_progress.total_credits' => 'Total Credits',
			'academic_progress.categories.university_name' => 'Horus University',
			'academic_progress.categories.faculty' => 'Faculty Requirements',
			'academic_progress.categories.major' => 'Major Requirements',
			'academic_progress.categories.electives' => 'Electives',
			'academic_progress.status.completed' => 'Completed',
			'academic_progress.status.in_progress' => 'In Progress',
			'academic_progress.status.remaining' => 'Remaining',
			'academic_progress.status.requirement_met' => 'Requirement Met',
			'grades.title' => 'Semester Grades',
			'grades.summary' => 'Grade Summary',
			'grades.cumulative_gpa' => 'Cumulative GPA',
			'grades.gpa' => 'Semester GPA',
			'grades.credits' => 'Credits',
			'grades.grade_point' => 'Grade Point',
			'grades.letter_grade' => 'Letter Grade',
			'subject_results.title' => 'Subject Results',
			'subject_results.midterm' => 'Midterm',
			'subject_results.kFinal' => 'Final Exam',
			'subject_results.practical' => 'Practical/Lab',
			'subject_results.activities' => 'Semester Activities',
			'subject_results.total' => 'Total Score',
			'action_plan.title' => 'Degree Action Plan',
			'action_plan.roadmap' => 'Course Roadmap',
			'action_plan.year_1' => 'Freshman Year',
			'action_plan.year_2' => 'Sophomore Year',
			'action_plan.year_3' => 'Junior Year',
			'action_plan.year_4' => 'Senior Year',
			'courses.title' => 'My Courses',
			'courses.enrolled' => 'Enrolled',
			'courses.available' => 'Available',
			'courses.instructor' => 'Instructor',
			'courses.schedule' => 'Schedule',
			'schedule.title' => 'Weekly Schedule',
			'schedule.daily_title' => 'Daily Schedule',
			'schedule.no_lectures' => 'No lectures today',
			'schedule.time' => 'Time',
			'schedule.room' => 'Room',
			'schedule.monday' => 'Monday',
			'schedule.tuesday' => 'Tuesday',
			'schedule.wednesday' => 'Wednesday',
			'schedule.thursday' => 'Thursday',
			'schedule.friday' => 'Friday',
			'schedule.saturday' => 'Saturday',
			'schedule.sunday' => 'Sunday',
			'schedule.instructor' => 'Instructor',
			'schedule.doctor' => 'Dr.',
			'schedule.type_lecture' => 'Lecture',
			'schedule.type_section' => 'Section',
			'schedule.status_active' => 'Upcoming',
			'schedule.status_started' => 'Now',
			'schedule.status_cancelled' => 'Cancelled',
			'schedule.status_online' => 'Online',
			'schedule.status_substitute' => 'Substitute',
			'schedule.morning' => 'Morning',
			'schedule.afternoon' => 'Afternoon',
			'schedule.evening' => 'Evening',
			'schedule.all_periods' => 'All Periods',
			'schedule.floor' => 'Floor',
			'schedule.direction' => 'Direction',
			'schedule.east' => 'East',
			'schedule.west' => 'West',
			'schedule.south' => 'South',
			'schedule.north' => 'North',
			'exam_schedule.title' => 'Exam Schedule',
			'exam_schedule.date' => 'Date',
			'exam_schedule.duration' => 'Duration',
			'exam_schedule.seat' => 'Seat Number',
			'attendance.title' => 'Attendance Statistics',
			'attendance.present' => 'Present',
			'attendance.absent' => 'Absent',
			'attendance.late' => 'Late',
			'attendance.ratio' => 'Attendance Ratio',
			'attendance.subjects.ai' => 'Artificial Intelligence',
			'attendance.subjects.machine_learning' => 'Machine Learning',
			'attendance.subjects.ethics' => 'Ethics in IT',
			'attendance.subjects.calculus' => 'Advanced Calculus',
			'registration.title' => 'Course Registration',
			'registration.submit' => 'Submit Registration',
			'registration.enrolled_credits' => 'Enrolled Credits',
			'registration.step1_title' => 'Step 1: Choose Main Group',
			'registration.step1_subtitle' => 'Select the main group you wish to register for this semester.',
			'registration.group_label' => ({required Object group}) => 'Group ${group}',
			'registration.main_cohort' => 'Main cohort registration',
			'registration.step2_title' => 'Step 2: Choose Sub-section',
			'registration.step2_subtitle' => ({required Object group}) => 'Selected Group: ${group}. Now select your practical sub-section.',
			'registration.section_label' => ({required Object section}) => 'Section ${section}',
			'registration.labs_sessions' => 'Labs and practical sessions',
			'registration.step3_title' => 'Step 3: Confirm Registration',
			'registration.review' => 'Review Selections',
			'registration.semester' => 'Semester',
			'registration.group' => 'Group',
			'registration.section' => 'Section',
			'registration.auto_registered' => 'Courses to be automatically registered:',
			'registration.credits_count' => ({required Object credits}) => '${credits} CR',
			'registration.confirm_final' => 'Confirm Final Registration',
			'registration.already_registered_title' => 'Already Registered!',
			'registration.success_message' => ({required Object group, required Object section}) => 'You have successfully registered for this semester.\nGroup: ${group} | Section: ${section}',
			'registration.back_home' => 'Back to Home',
			'registration.registration_success' => 'Registration Successful!',
			'registration.error_loading' => ({required Object error}) => 'Error: ${error}\n\nTap to retry',
			'payment.title' => 'Tuition Payment',
			'payment.outstanding' => 'Outstanding Balance',
			'payment.pay_now' => 'Pay Now',
			'payment.methods' => 'Payment Methods',
			'payment.university_guaranteed' => 'University Guaranteed Methods',
			'payment.credit_debit' => 'Credit / Debit Card',
			'payment.fawry' => 'Fawry / E-Payment',
			'payment.bank_transfer' => 'Bank Transfer',
			'payment.currency' => ({required Object amount}) => '${amount} EGP',
			'invoices.title' => 'Financial Invoices',
			'invoices.history' => 'Payment History',
			'invoices.unpaid' => 'Unpaid',
			'invoices.paid' => 'Paid',
			'invoices.id' => 'Invoice ID',
			'invoices.date' => 'Date',
			'invoices.amount' => 'Amount',
			'invoices.status' => 'Status',
			'notifications.title' => 'Notifications',
			'notifications.empty' => 'No new notifications',
			'support.title' => 'Support & Help',
			'support.contact_us' => 'Contact Us',
			'security.title' => 'Security',
			'security.biometrics' => 'Biometrics',
			'security.sessions' => 'Active Sessions',
			'tutorials.title' => 'Tutorials & Guides',
			'forums.title' => 'Forums',
			'administration.title' => 'Student Management',
			'administration.stats' => 'System Stats',
			'administration.users' => 'Users',
			'administration.reports' => 'Reports',
			'professor.dashboard_title' => 'Professor Dashboard',
			'professor.welcome_back_name' => ({required Object name}) => 'Welcome back, ${name}',
			'professor.active_tas_count' => ({required Object count}) => '${count} Active TAs',
			'professor.total_students_count' => ({required Object count}) => '${count} Total Students',
			'professor.uploaded_files_count' => ({required Object count}) => '${count} Uploaded Files',
			'professor.weekly_slots_count' => ({required Object count}) => '${count} Weekly Slots',
			'professor.announcement_to' => ({required Object count}) => 'Announce to ${count}',
			'professor.preparing_announcement' => 'Preparing Announcement...',
			'professor.no_groups' => 'No Groups Available',
			'professor.select_all' => 'Select All',
			'professor.deselect_all' => 'Deselect All',
			'professor.selected_count' => ({required Object count}) => '${count} Selected',
			'professor.action_clicked' => ({required Object action}) => 'Clicked: ${action}',
			'professor.activating' => ({required Object target}) => 'Activating: ${target}',
			'professor.add_new_ta' => 'Add New TA',
			'professor.no_available_tas' => 'No available TAs',
			'professor.no_active_tas' => 'No Active TAs',
			'professor.added' => ({required Object name}) => 'Added: ${name}',
			'professor.removed' => ({required Object name}) => 'Removed: ${name}',
			'professor.add' => 'Add',
			'professor.urgent' => 'Urgent',
			'professor.upload' => 'Upload',
			'professor.message' => 'Message',
			'professor.downloading' => 'Downloading...',
			'professor.walk_in' => 'Walk-in',
			'professor.joined' => ({required Object name}) => 'Joined: ${name}',
			'professor.join' => 'Join',
			'professor.stats.groups' => 'Groups',
			'professor.stats.students' => 'Total Students',
			'professor.stats.tas' => 'Teaching Assistants',
			'professor.stats.rating' => 'Rating',
			'professor.stats.shared_files' => 'Shared Files',
			'professor.stats.office_hours' => 'Office Hours',
			'professor.quick_actions.urgent' => 'Urgent',
			'professor.quick_actions.upload' => 'Upload',
			'professor.quick_actions.message' => 'Message',
			'professor.quick_actions.action_clicked' => 'Clicked',
			'professor.profile.urgent_announcements' => 'Urgent Announcements',
			'professor.profile.teaching_assistants' => 'Teaching Assistants',
			'professor.profile.shared_resources' => 'Shared Resources',
			'professor.profile.office_hours' => 'Office Hours',
			'roles.categories.admin_it' => 'Admin & IT',
			'roles.categories.academic_leadership' => 'Academic Leadership',
			'roles.categories.teaching_staff' => 'Teaching Staff',
			'roles.categories.student_affairs' => 'Student Affairs',
			'roles.categories.student_roles' => 'Student Roles',
			'roles.categories.facilities_security' => 'Facilities & Security',
			'roles.categories.external_roles' => 'External Roles',
			'roles.names.super_admin' => 'Super Admin',
			'roles.names.admin' => 'Administrator',
			'roles.names.it_support' => 'IT Support',
			'roles.names.financial_auditor' => 'Financial Auditor',
			'roles.names.rector' => 'Rector / President',
			'roles.names.dean' => 'Dean',
			'roles.names.department_head' => 'Department Head',
			'roles.names.academic_coordinator' => 'Academic Coordinator',
			'roles.names.professor' => 'Professor / Instructor',
			'roles.names.lecturer' => 'Lecturer',
			'roles.names.teaching_assistant' => 'Teaching Assistant',
			'roles.names.registrar_officer' => 'Registrar Officer',
			'roles.names.academic_advisor' => 'Academic Advisor',
			'roles.names.librarian' => 'Librarian',
			'roles.names.freshman' => 'Freshman',
			'roles.names.regular_student' => 'Regular Student',
			'roles.names.student' => 'Student',
			'roles.names.class_representative' => 'Class Representative',
			'roles.names.alumni' => 'Alumni',
			'roles.names.dorm_supervisor' => 'Dorm Supervisor',
			'roles.names.security_officer' => 'Security Officer',
			'roles.names.guest' => 'Guest',
			'roles.names.parent' => 'Parent / Guardian',
			'roles.names.recruiter' => 'Recruiter',
			'roles.descriptions.super_admin' => 'Full control over the entire system',
			'roles.descriptions.admin' => 'System administrator with high privileges',
			'roles.descriptions.it_support' => 'Technical system support and maintenance',
			'roles.descriptions.financial_auditor' => 'Oversees financial records and invoices',
			'roles.descriptions.rector' => 'University president with full academic oversight',
			'roles.descriptions.dean' => 'Head of a college/faculty',
			'roles.descriptions.department_head' => 'Head of an academic department',
			'roles.descriptions.academic_coordinator' => 'Coordinates academic programs and scheduling',
			'roles.descriptions.professor' => 'Faculty member who teaches and manages courses',
			'roles.descriptions.lecturer' => 'Teaches courses without full professor privileges',
			'roles.descriptions.teaching_assistant' => 'Assists professors with grading, labs, and tutorials',
			'roles.descriptions.registrar_officer' => 'Manages student enrollment and registration',
			'roles.descriptions.academic_advisor' => 'Guides students through academic planning',
			'roles.descriptions.librarian' => 'Manages library resources and materials',
			'roles.descriptions.freshman' => 'First-year student with limited system access',
			'roles.descriptions.regular_student' => 'Full student with all standard academic privileges',
			'roles.descriptions.student' => 'General student role',
			'roles.descriptions.class_representative' => 'Student leader who represents the class body',
			'roles.descriptions.alumni' => 'Graduated student with limited access',
			'roles.descriptions.dorm_supervisor' => 'Manages student dormitory operations',
			'roles.descriptions.security_officer' => 'Campus security and access control',
			'roles.descriptions.guest' => 'Temporary visitor with minimal access',
			'roles.descriptions.parent' => 'Can view linked student progress and grades',
			'roles.descriptions.recruiter' => 'External recruitment organization',
			_ => null,
		};
	}
}

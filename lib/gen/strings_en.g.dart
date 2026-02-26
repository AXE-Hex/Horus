///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

part of 'strings.g.dart';

// Path: <root>
typedef TranslationsEn = Translations; // ignore: unused_element
class Translations with BaseTranslations<AppLocale, Translations> {
	/// Returns the current translations of the given [context].
	///
	/// Usage:
	/// final t = Translations.of(context);
	static Translations of(BuildContext context) => InheritedLocaleData.of<AppLocale, Translations>(context).translations;

	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
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

	/// Metadata for the translations of <en>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	dynamic operator[](String key) => $meta.getTranslation(key);

	late final Translations _root = this; // ignore: unused_field

	Translations $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => Translations(meta: meta ?? this.$meta);

	// Translations
	late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
	late final TranslationsWelcomeEn welcome = TranslationsWelcomeEn._(_root);
	late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn._(_root);
	late final TranslationsAuthEn auth = TranslationsAuthEn._(_root);
	late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
	late final TranslationsFeedEn feed = TranslationsFeedEn._(_root);
	late final TranslationsDashboardEn dashboard = TranslationsDashboardEn._(_root);
	late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
	late final TranslationsCollegesEn colleges = TranslationsCollegesEn._(_root);
	late final TranslationsTranscriptEn transcript = TranslationsTranscriptEn._(_root);
	late final TranslationsAcademicProgressEn academic_progress = TranslationsAcademicProgressEn._(_root);
	late final TranslationsGradesEn grades = TranslationsGradesEn._(_root);
	late final TranslationsSubjectResultsEn subject_results = TranslationsSubjectResultsEn._(_root);
	late final TranslationsActionPlanEn action_plan = TranslationsActionPlanEn._(_root);
	late final TranslationsCoursesEn courses = TranslationsCoursesEn._(_root);
	late final TranslationsScheduleEn schedule = TranslationsScheduleEn._(_root);
	late final TranslationsExamScheduleEn exam_schedule = TranslationsExamScheduleEn._(_root);
	late final TranslationsAttendanceEn attendance = TranslationsAttendanceEn._(_root);
	late final TranslationsRegistrationEn registration = TranslationsRegistrationEn._(_root);
	late final TranslationsPaymentEn payment = TranslationsPaymentEn._(_root);
	late final TranslationsInvoicesEn invoices = TranslationsInvoicesEn._(_root);
	late final TranslationsNotificationsEn notifications = TranslationsNotificationsEn._(_root);
	late final TranslationsSupportEn support = TranslationsSupportEn._(_root);
	late final TranslationsSecurityEn security = TranslationsSecurityEn._(_root);
	late final TranslationsTutorialsEn tutorials = TranslationsTutorialsEn._(_root);
	late final TranslationsForumsEn forums = TranslationsForumsEn._(_root);
	late final TranslationsAdministrationEn administration = TranslationsAdministrationEn._(_root);
	late final TranslationsProfessorEn professor = TranslationsProfessorEn._(_root);
	late final TranslationsRolesEn roles = TranslationsRolesEn._(_root);
}

// Path: common
class TranslationsCommonEn {
	TranslationsCommonEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Back'
	String get back => 'Back';
}

// Path: welcome
class TranslationsWelcomeEn {
	TranslationsWelcomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome To Hue'
	String get title => 'Welcome To Hue';

	/// en: 'Light up your world with meaningful connections.'
	String get subtitle => 'Light up your world with meaningful connections.';

	/// en: 'Get Started'
	String get get_started => 'Get Started';

	/// en: 'I already have an account'
	String get have_account => 'I already have an account';
}

// Path: onboarding
class TranslationsOnboardingEn {
	TranslationsOnboardingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsOnboardingLanguageEn language = TranslationsOnboardingLanguageEn._(_root);
	late final TranslationsOnboardingFacultiesDirectoryEn faculties_directory = TranslationsOnboardingFacultiesDirectoryEn._(_root);
	late final TranslationsOnboardingStyleEn style = TranslationsOnboardingStyleEn._(_root);
	late final TranslationsOnboardingThemeEn theme = TranslationsOnboardingThemeEn._(_root);
}

// Path: auth
class TranslationsAuthEn {
	TranslationsAuthEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsAuthLoginEn login = TranslationsAuthLoginEn._(_root);
	late final TranslationsAuthForgotPasswordEn forgot_password = TranslationsAuthForgotPasswordEn._(_root);
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeTabsEn tabs = TranslationsHomeTabsEn._(_root);
}

// Path: feed
class TranslationsFeedEn {
	TranslationsFeedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'likes'
	String get likes => 'likes';

	/// en: 'This is a sample caption for post'
	String get caption_sample => 'This is a sample caption for post';

	/// en: 'hours ago'
	String get hours_ago => 'hours ago';
}

// Path: dashboard
class TranslationsDashboardEn {
	TranslationsDashboardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsDashboardIdCardEn id_card = TranslationsDashboardIdCardEn._(_root);
	late final TranslationsDashboardSectionsEn sections = TranslationsDashboardSectionsEn._(_root);
	late final TranslationsDashboardItemsEn items = TranslationsDashboardItemsEn._(_root);
	late final TranslationsDashboardLabelsEn labels = TranslationsDashboardLabelsEn._(_root);
}

// Path: settings
class TranslationsSettingsEn {
	TranslationsSettingsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Settings'
	String get title => 'Settings';

	late final TranslationsSettingsSectionsEn sections = TranslationsSettingsSectionsEn._(_root);
	late final TranslationsSettingsTilesEn tiles = TranslationsSettingsTilesEn._(_root);
	late final TranslationsSettingsMessagesEn messages = TranslationsSettingsMessagesEn._(_root);
}

// Path: colleges
class TranslationsCollegesEn {
	TranslationsCollegesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsCollegesDetailsEn details = TranslationsCollegesDetailsEn._(_root);

	/// en: 'Faculty of Applied Health Sciences'
	String get applied_health_sciences => 'Faculty of Applied Health Sciences';

	/// en: 'Faculty of Business Administration'
	String get business_administration => 'Faculty of Business Administration';

	/// en: 'Faculty of Dentistry'
	String get dentistry => 'Faculty of Dentistry';

	/// en: 'Faculty of Engineering'
	String get engineering => 'Faculty of Engineering';

	/// en: 'Faculty of Fine Arts'
	String get fine_arts => 'Faculty of Fine Arts';

	/// en: 'Faculty of Human Medicine'
	String get human_medicine => 'Faculty of Human Medicine';

	/// en: 'Faculty of Linguistics & Translation'
	String get linguistics => 'Faculty of Linguistics & Translation';

	/// en: 'Faculty of Pharmacy'
	String get pharmacy => 'Faculty of Pharmacy';

	/// en: 'Faculty of Physical Therapy'
	String get physical_therapy => 'Faculty of Physical Therapy';

	/// en: 'Faculty of Artificial Intelligence'
	String get ai => 'Faculty of Artificial Intelligence';

	late final TranslationsCollegesDepartmentsEn departments = TranslationsCollegesDepartmentsEn._(_root);
}

// Path: transcript
class TranslationsTranscriptEn {
	TranslationsTranscriptEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Academic Transcript'
	String get title => 'Academic Transcript';

	late final TranslationsTranscriptOverviewEn overview = TranslationsTranscriptOverviewEn._(_root);
	late final TranslationsTranscriptSemesterEn semester = TranslationsTranscriptSemesterEn._(_root);
	late final TranslationsTranscriptCourseEn course = TranslationsTranscriptCourseEn._(_root);
}

// Path: academic_progress
class TranslationsAcademicProgressEn {
	TranslationsAcademicProgressEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Academic Progress'
	String get title => 'Academic Progress';

	/// en: 'Degree Completion'
	String get completion => 'Degree Completion';

	/// en: 'Total Credits'
	String get total_credits => 'Total Credits';

	late final TranslationsAcademicProgressCategoriesEn categories = TranslationsAcademicProgressCategoriesEn._(_root);
	late final TranslationsAcademicProgressStatusEn status = TranslationsAcademicProgressStatusEn._(_root);
}

// Path: grades
class TranslationsGradesEn {
	TranslationsGradesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Semester Grades'
	String get title => 'Semester Grades';

	/// en: 'Grade Summary'
	String get summary => 'Grade Summary';

	/// en: 'Cumulative GPA'
	String get cumulative_gpa => 'Cumulative GPA';

	/// en: 'Semester GPA'
	String get gpa => 'Semester GPA';

	/// en: 'Credits'
	String get credits => 'Credits';

	/// en: 'Grade Point'
	String get grade_point => 'Grade Point';

	/// en: 'Letter Grade'
	String get letter_grade => 'Letter Grade';
}

// Path: subject_results
class TranslationsSubjectResultsEn {
	TranslationsSubjectResultsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Subject Results'
	String get title => 'Subject Results';

	/// en: 'Midterm'
	String get midterm => 'Midterm';

	/// en: 'Final Exam'
	String get kFinal => 'Final Exam';

	/// en: 'Practical/Lab'
	String get practical => 'Practical/Lab';

	/// en: 'Semester Activities'
	String get activities => 'Semester Activities';

	/// en: 'Total Score'
	String get total => 'Total Score';
}

// Path: action_plan
class TranslationsActionPlanEn {
	TranslationsActionPlanEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Degree Action Plan'
	String get title => 'Degree Action Plan';

	/// en: 'Course Roadmap'
	String get roadmap => 'Course Roadmap';

	/// en: 'Freshman Year'
	String get year_1 => 'Freshman Year';

	/// en: 'Sophomore Year'
	String get year_2 => 'Sophomore Year';

	/// en: 'Junior Year'
	String get year_3 => 'Junior Year';

	/// en: 'Senior Year'
	String get year_4 => 'Senior Year';
}

// Path: courses
class TranslationsCoursesEn {
	TranslationsCoursesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'My Courses'
	String get title => 'My Courses';

	/// en: 'Enrolled'
	String get enrolled => 'Enrolled';

	/// en: 'Available'
	String get available => 'Available';

	/// en: 'Instructor'
	String get instructor => 'Instructor';

	/// en: 'Schedule'
	String get schedule => 'Schedule';
}

// Path: schedule
class TranslationsScheduleEn {
	TranslationsScheduleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Weekly Schedule'
	String get title => 'Weekly Schedule';

	/// en: 'Daily Schedule'
	String get daily_title => 'Daily Schedule';

	/// en: 'No lectures today'
	String get no_lectures => 'No lectures today';

	/// en: 'Time'
	String get time => 'Time';

	/// en: 'Room'
	String get room => 'Room';

	/// en: 'Monday'
	String get monday => 'Monday';

	/// en: 'Tuesday'
	String get tuesday => 'Tuesday';

	/// en: 'Wednesday'
	String get wednesday => 'Wednesday';

	/// en: 'Thursday'
	String get thursday => 'Thursday';

	/// en: 'Friday'
	String get friday => 'Friday';

	/// en: 'Saturday'
	String get saturday => 'Saturday';

	/// en: 'Sunday'
	String get sunday => 'Sunday';

	/// en: 'Instructor'
	String get instructor => 'Instructor';

	/// en: 'Dr.'
	String get doctor => 'Dr.';

	/// en: 'Lecture'
	String get type_lecture => 'Lecture';

	/// en: 'Section'
	String get type_section => 'Section';

	/// en: 'Upcoming'
	String get status_active => 'Upcoming';

	/// en: 'Now'
	String get status_started => 'Now';

	/// en: 'Cancelled'
	String get status_cancelled => 'Cancelled';

	/// en: 'Online'
	String get status_online => 'Online';

	/// en: 'Substitute'
	String get status_substitute => 'Substitute';

	/// en: 'Morning'
	String get morning => 'Morning';

	/// en: 'Afternoon'
	String get afternoon => 'Afternoon';

	/// en: 'Evening'
	String get evening => 'Evening';

	/// en: 'All Periods'
	String get all_periods => 'All Periods';

	/// en: 'Floor'
	String get floor => 'Floor';

	/// en: 'Direction'
	String get direction => 'Direction';

	/// en: 'East'
	String get east => 'East';

	/// en: 'West'
	String get west => 'West';

	/// en: 'South'
	String get south => 'South';

	/// en: 'North'
	String get north => 'North';
}

// Path: exam_schedule
class TranslationsExamScheduleEn {
	TranslationsExamScheduleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Exam Schedule'
	String get title => 'Exam Schedule';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Seat Number'
	String get seat => 'Seat Number';
}

// Path: attendance
class TranslationsAttendanceEn {
	TranslationsAttendanceEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Attendance Statistics'
	String get title => 'Attendance Statistics';

	/// en: 'Present'
	String get present => 'Present';

	/// en: 'Absent'
	String get absent => 'Absent';

	/// en: 'Late'
	String get late => 'Late';

	/// en: 'Attendance Ratio'
	String get ratio => 'Attendance Ratio';

	late final TranslationsAttendanceSubjectsEn subjects = TranslationsAttendanceSubjectsEn._(_root);
}

// Path: registration
class TranslationsRegistrationEn {
	TranslationsRegistrationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Course Registration'
	String get title => 'Course Registration';

	/// en: 'Submit Registration'
	String get submit => 'Submit Registration';

	/// en: 'Enrolled Credits'
	String get enrolled_credits => 'Enrolled Credits';

	/// en: 'Step 1: Choose Main Group'
	String get step1_title => 'Step 1: Choose Main Group';

	/// en: 'Select the main group you wish to register for this semester.'
	String get step1_subtitle => 'Select the main group you wish to register for this semester.';

	/// en: 'Group ${group}'
	String group_label({required Object group}) => 'Group ${group}';

	/// en: 'Main cohort registration'
	String get main_cohort => 'Main cohort registration';

	/// en: 'Step 2: Choose Sub-section'
	String get step2_title => 'Step 2: Choose Sub-section';

	/// en: 'Selected Group: ${group}. Now select your practical sub-section.'
	String step2_subtitle({required Object group}) => 'Selected Group: ${group}. Now select your practical sub-section.';

	/// en: 'Section ${section}'
	String section_label({required Object section}) => 'Section ${section}';

	/// en: 'Labs and practical sessions'
	String get labs_sessions => 'Labs and practical sessions';

	/// en: 'Step 3: Confirm Registration'
	String get step3_title => 'Step 3: Confirm Registration';

	/// en: 'Review Selections'
	String get review => 'Review Selections';

	/// en: 'Semester'
	String get semester => 'Semester';

	/// en: 'Group'
	String get group => 'Group';

	/// en: 'Section'
	String get section => 'Section';

	/// en: 'Courses to be automatically registered:'
	String get auto_registered => 'Courses to be automatically registered:';

	/// en: '${credits} CR'
	String credits_count({required Object credits}) => '${credits} CR';

	/// en: 'Confirm Final Registration'
	String get confirm_final => 'Confirm Final Registration';

	/// en: 'Already Registered!'
	String get already_registered_title => 'Already Registered!';

	/// en: 'You have successfully registered for this semester. Group: ${group} | Section: ${section}'
	String success_message({required Object group, required Object section}) => 'You have successfully registered for this semester.\nGroup: ${group} | Section: ${section}';

	/// en: 'Back to Home'
	String get back_home => 'Back to Home';

	/// en: 'Registration Successful!'
	String get registration_success => 'Registration Successful!';

	/// en: 'Error: ${error} Tap to retry'
	String error_loading({required Object error}) => 'Error: ${error}\n\nTap to retry';
}

// Path: payment
class TranslationsPaymentEn {
	TranslationsPaymentEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Tuition Payment'
	String get title => 'Tuition Payment';

	/// en: 'Outstanding Balance'
	String get outstanding => 'Outstanding Balance';

	/// en: 'Pay Now'
	String get pay_now => 'Pay Now';

	/// en: 'Payment Methods'
	String get methods => 'Payment Methods';

	/// en: 'University Guaranteed Methods'
	String get university_guaranteed => 'University Guaranteed Methods';

	/// en: 'Credit / Debit Card'
	String get credit_debit => 'Credit / Debit Card';

	/// en: 'Fawry / E-Payment'
	String get fawry => 'Fawry / E-Payment';

	/// en: 'Bank Transfer'
	String get bank_transfer => 'Bank Transfer';

	/// en: '${amount} EGP'
	String currency({required Object amount}) => '${amount} EGP';
}

// Path: invoices
class TranslationsInvoicesEn {
	TranslationsInvoicesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Financial Invoices'
	String get title => 'Financial Invoices';

	/// en: 'Payment History'
	String get history => 'Payment History';

	/// en: 'Unpaid'
	String get unpaid => 'Unpaid';

	/// en: 'Paid'
	String get paid => 'Paid';

	/// en: 'Invoice ID'
	String get id => 'Invoice ID';

	/// en: 'Date'
	String get date => 'Date';

	/// en: 'Amount'
	String get amount => 'Amount';

	/// en: 'Status'
	String get status => 'Status';
}

// Path: notifications
class TranslationsNotificationsEn {
	TranslationsNotificationsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get title => 'Notifications';

	/// en: 'No new notifications'
	String get empty => 'No new notifications';
}

// Path: support
class TranslationsSupportEn {
	TranslationsSupportEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Support & Help'
	String get title => 'Support & Help';

	/// en: 'Contact Us'
	String get contact_us => 'Contact Us';
}

// Path: security
class TranslationsSecurityEn {
	TranslationsSecurityEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Security'
	String get title => 'Security';

	/// en: 'Biometrics'
	String get biometrics => 'Biometrics';

	/// en: 'Active Sessions'
	String get sessions => 'Active Sessions';
}

// Path: tutorials
class TranslationsTutorialsEn {
	TranslationsTutorialsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Tutorials & Guides'
	String get title => 'Tutorials & Guides';
}

// Path: forums
class TranslationsForumsEn {
	TranslationsForumsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Forums'
	String get title => 'Forums';
}

// Path: administration
class TranslationsAdministrationEn {
	TranslationsAdministrationEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Student Management'
	String get title => 'Student Management';

	/// en: 'System Stats'
	String get stats => 'System Stats';

	/// en: 'Users'
	String get users => 'Users';

	/// en: 'Reports'
	String get reports => 'Reports';
}

// Path: professor
class TranslationsProfessorEn {
	TranslationsProfessorEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Professor Dashboard'
	String get dashboard_title => 'Professor Dashboard';

	/// en: 'Welcome back, ${name}'
	String welcome_back_name({required Object name}) => 'Welcome back, ${name}';

	/// en: '${count} Active TAs'
	String active_tas_count({required Object count}) => '${count} Active TAs';

	/// en: '${count} Total Students'
	String total_students_count({required Object count}) => '${count} Total Students';

	/// en: '${count} Uploaded Files'
	String uploaded_files_count({required Object count}) => '${count} Uploaded Files';

	/// en: '${count} Weekly Slots'
	String weekly_slots_count({required Object count}) => '${count} Weekly Slots';

	/// en: 'Announce to ${count}'
	String announcement_to({required Object count}) => 'Announce to ${count}';

	/// en: 'Preparing Announcement...'
	String get preparing_announcement => 'Preparing Announcement...';

	/// en: 'No Groups Available'
	String get no_groups => 'No Groups Available';

	/// en: 'Select All'
	String get select_all => 'Select All';

	/// en: 'Deselect All'
	String get deselect_all => 'Deselect All';

	/// en: '${count} Selected'
	String selected_count({required Object count}) => '${count} Selected';

	/// en: 'Clicked: ${action}'
	String action_clicked({required Object action}) => 'Clicked: ${action}';

	/// en: 'Activating: ${target}'
	String activating({required Object target}) => 'Activating: ${target}';

	/// en: 'Add New TA'
	String get add_new_ta => 'Add New TA';

	/// en: 'No available TAs'
	String get no_available_tas => 'No available TAs';

	/// en: 'No Active TAs'
	String get no_active_tas => 'No Active TAs';

	/// en: 'Added: ${name}'
	String added({required Object name}) => 'Added: ${name}';

	/// en: 'Removed: ${name}'
	String removed({required Object name}) => 'Removed: ${name}';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Urgent'
	String get urgent => 'Urgent';

	/// en: 'Upload'
	String get upload => 'Upload';

	/// en: 'Message'
	String get message => 'Message';

	/// en: 'Downloading...'
	String get downloading => 'Downloading...';

	/// en: 'Walk-in'
	String get walk_in => 'Walk-in';

	/// en: 'Joined: ${name}'
	String joined({required Object name}) => 'Joined: ${name}';

	/// en: 'Join'
	String get join => 'Join';

	late final TranslationsProfessorStatsEn stats = TranslationsProfessorStatsEn._(_root);
	late final TranslationsProfessorQuickActionsEn quick_actions = TranslationsProfessorQuickActionsEn._(_root);
	late final TranslationsProfessorProfileEn profile = TranslationsProfessorProfileEn._(_root);
}

// Path: roles
class TranslationsRolesEn {
	TranslationsRolesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsRolesCategoriesEn categories = TranslationsRolesCategoriesEn._(_root);
	late final TranslationsRolesNamesEn names = TranslationsRolesNamesEn._(_root);
	late final TranslationsRolesDescriptionsEn descriptions = TranslationsRolesDescriptionsEn._(_root);
}

// Path: onboarding.language
class TranslationsOnboardingLanguageEn {
	TranslationsOnboardingLanguageEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose your language'
	String get title => 'Choose your language';

	/// en: 'اختر لغتك المفضلة'
	String get subtitle => 'اختر لغتك المفضلة';

	/// en: 'English'
	String get english => 'English';

	/// en: 'العربية'
	String get arabic => 'العربية';

	/// en: 'Deutsch'
	String get german => 'Deutsch';

	/// en: '中文'
	String get chinese => '中文';

	/// en: 'You can change this later in settings يمكنك تغيير هذا لاحقاً في الإعدادات'
	String get hint => 'You can change this later in settings\nيمكنك تغيير هذا لاحقاً في الإعدادات';
}

// Path: onboarding.faculties_directory
class TranslationsOnboardingFacultiesDirectoryEn {
	TranslationsOnboardingFacultiesDirectoryEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Our Faculties'
	String get title => 'Our Faculties';

	/// en: 'Discover Horus University portal.'
	String get subtitle => 'Discover Horus University portal.';
}

// Path: onboarding.style
class TranslationsOnboardingStyleEn {
	TranslationsOnboardingStyleEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose your style'
	String get title => 'Choose your style';

	/// en: 'Select the interface design you prefer'
	String get subtitle => 'Select the interface design you prefer';

	late final TranslationsOnboardingStyleClassicEn classic = TranslationsOnboardingStyleClassicEn._(_root);
	late final TranslationsOnboardingStyleGlassEn glass = TranslationsOnboardingStyleGlassEn._(_root);
}

// Path: onboarding.theme
class TranslationsOnboardingThemeEn {
	TranslationsOnboardingThemeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Choose a theme'
	String get title => 'Choose a theme';

	/// en: 'Light or dark, your choice'
	String get subtitle => 'Light or dark, your choice';

	/// en: 'Light'
	String get light => 'Light';

	/// en: 'Dark'
	String get dark => 'Dark';
}

// Path: auth.login
class TranslationsAuthLoginEn {
	TranslationsAuthLoginEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Welcome Back'
	String get welcome => 'Welcome Back';

	/// en: 'Sign in to continue'
	String get subtitle => 'Sign in to continue';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Forgot Password?'
	String get forgot_password => 'Forgot Password?';

	/// en: 'Login'
	String get submit => 'Login';

	/// en: 'Browse as Guest'
	String get guest => 'Browse as Guest';
}

// Path: auth.forgot_password
class TranslationsAuthForgotPasswordEn {
	TranslationsAuthForgotPasswordEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Forgot Password'
	String get title => 'Forgot Password';

	/// en: 'Choose a recovery method'
	String get subtitle => 'Choose a recovery method';

	/// en: 'Visit Administration'
	String get method_admin => 'Visit Administration';

	/// en: 'Online Request'
	String get method_online => 'Online Request';

	/// en: 'Please visit the student affairs office to reset your password. Bring your valid university ID.'
	String get admin_instructions => 'Please visit the student affairs office to reset your password. Bring your valid university ID.';

	/// en: 'Phone Number'
	String get phone_label => 'Phone Number';

	/// en: 'Upload ID Photo'
	String get upload_id => 'Upload ID Photo';

	/// en: 'Tap to upload a clear photo of your university ID'
	String get upload_id_hint => 'Tap to upload a clear photo of your university ID';

	/// en: 'Submit Request'
	String get submit => 'Submit Request';

	/// en: 'Back to Login'
	String get back => 'Back to Login';

	/// en: 'Please enter your phone number'
	String get error_empty_phone => 'Please enter your phone number';

	/// en: 'Please enter your email'
	String get error_empty_email => 'Please enter your email';

	/// en: 'Please upload your ID photo'
	String get error_no_id => 'Please upload your ID photo';

	/// en: 'Request submitted successfully'
	String get success => 'Request submitted successfully';

	/// en: 'ID Uploaded'
	String get id_uploaded => 'ID Uploaded';
}

// Path: home.tabs
class TranslationsHomeTabsEn {
	TranslationsHomeTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Colleges'
	String get colleges => 'Colleges';

	/// en: 'Student'
	String get student => 'Student';

	/// en: 'Admin'
	String get admin => 'Admin';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'Profile'
	String get profile => 'Profile';
}

// Path: dashboard.id_card
class TranslationsDashboardIdCardEn {
	TranslationsDashboardIdCardEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Student Name'
	String get student_name => 'Student Name';

	/// en: 'College'
	String get college => 'College';

	/// en: 'Student ID'
	String get id => 'Student ID';

	/// en: 'GPA'
	String get gpa => 'GPA';

	/// en: 'Level'
	String get level => 'Level';

	/// en: 'Verified'
	String get verified => 'Verified';
}

// Path: dashboard.sections
class TranslationsDashboardSectionsEn {
	TranslationsDashboardSectionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Academic'
	String get academic => 'Academic';

	/// en: 'Enrollment'
	String get enrollment => 'Enrollment';

	/// en: 'Utilities'
	String get utilities => 'Utilities';
}

// Path: dashboard.items
class TranslationsDashboardItemsEn {
	TranslationsDashboardItemsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Digital ID'
	String get digital_id => 'Digital ID';

	/// en: 'Transcript'
	String get transcript => 'Transcript';

	/// en: 'Progress'
	String get progress => 'Progress';

	/// en: 'Action Plan'
	String get action_plan => 'Action Plan';

	/// en: 'Subject Result'
	String get subject_result => 'Subject Result';

	/// en: 'Grades'
	String get grades => 'Grades';

	/// en: 'Courses'
	String get courses => 'Courses';

	/// en: 'Registration'
	String get registration => 'Registration';

	/// en: 'Unpaid Invoices'
	String get invoices => 'Unpaid Invoices';

	/// en: 'Payment'
	String get payment => 'Payment';

	/// en: 'Tutorials'
	String get tutorials => 'Tutorials';

	/// en: 'Security'
	String get security => 'Security';

	/// en: 'Forums'
	String get forums => 'Forums';

	/// en: 'Support'
	String get support => 'Support';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'No lectures found'
	String get no_lectures => 'No lectures found';
}

// Path: dashboard.labels
class TranslationsDashboardLabelsEn {
	TranslationsDashboardLabelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Horus University'
	String get university_name => 'Horus University';

	/// en: 'ID'
	String get id_short => 'ID';

	/// en: 'GPA'
	String get gpa_short => 'GPA';

	/// en: 'LVL'
	String get level_short => 'LVL';
}

// Path: settings.sections
class TranslationsSettingsSectionsEn {
	TranslationsSettingsSectionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Account'
	String get account => 'Account';

	/// en: 'Display'
	String get display => 'Display';

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'About'
	String get about => 'About';
}

// Path: settings.tiles
class TranslationsSettingsTilesEn {
	TranslationsSettingsTilesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Edit Profile'
	String get edit_profile => 'Edit Profile';

	/// en: 'Change Password'
	String get change_password => 'Change Password';

	/// en: 'Dark Mode'
	String get dark_mode => 'Dark Mode';

	/// en: 'Language'
	String get language => 'Language';

	/// en: 'UI Style'
	String get ui_style => 'UI Style';

	/// en: 'App Notifications'
	String get app_notifications => 'App Notifications';

	/// en: 'About App'
	String get about_app => 'About App';

	/// en: 'Privacy Policy'
	String get privacy_policy => 'Privacy Policy';

	/// en: 'Logout'
	String get logout => 'Logout';
}

// Path: settings.messages
class TranslationsSettingsMessagesEn {
	TranslationsSettingsMessagesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Switching Theme...'
	String get switching_theme => 'Switching Theme...';

	/// en: 'Changing Language...'
	String get changing_language => 'Changing Language...';

	/// en: 'Rebuilding Design System...'
	String get rebuilding_design => 'Rebuilding Design System...';
}

// Path: colleges.details
class TranslationsCollegesDetailsEn {
	TranslationsCollegesDetailsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Dean of College'
	String get dean => 'Dean of College';

	/// en: 'Academic Staff'
	String get staff => 'Academic Staff';

	/// en: 'View All'
	String get view_all => 'View All';

	/// en: 'Departments'
	String get departments => 'Departments';

	/// en: 'Explore available majors'
	String get explore_majors => 'Explore available majors';

	/// en: 'Majors'
	String get majors => 'Majors';

	/// en: 'The Dean'
	String get dean_title => 'The Dean';

	/// en: 'Staff Member'
	String get staff_member => 'Staff Member';

	/// en: 'Vice Dean'
	String get vice_dean => 'Vice Dean';

	/// en: 'Head of Dept'
	String get head_of_dept => 'Head of Dept';

	/// en: 'Assoc. Prof'
	String get assoc_prof => 'Assoc. Prof';

	/// en: 'Academic Statistics'
	String get academic_statistics => 'Academic Statistics';

	/// en: 'Students'
	String get students => 'Students';

	/// en: 'Academic Staff'
	String get academic_staff => 'Academic Staff';

	/// en: 'Teaching Assistants'
	String get teaching_assistants => 'Teaching Assistants';

	/// en: 'Published Articles'
	String get published_articles => 'Published Articles';
}

// Path: colleges.departments
class TranslationsCollegesDepartmentsEn {
	TranslationsCollegesDepartmentsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Medical Laboratories Technology'
	String get medical_laboratories_technology => 'Medical Laboratories Technology';

	/// en: 'Radiology and Imaging Technology'
	String get radiology_and_imaging_technology => 'Radiology and Imaging Technology';

	/// en: 'Respiratory Care Technology'
	String get respiratory_care_technology => 'Respiratory Care Technology';

	/// en: 'Dental Prosthetics Technology'
	String get dental_prosthetics_technology => 'Dental Prosthetics Technology';

	/// en: 'Health Administration and Informatics Technology'
	String get health_administration_and_informatics_technology => 'Health Administration and Informatics Technology';

	/// en: 'Accounting'
	String get accounting => 'Accounting';

	/// en: 'Business Management'
	String get business_management => 'Business Management';

	/// en: 'Economics'
	String get economics => 'Economics';

	/// en: 'Marketing'
	String get marketing => 'Marketing';

	/// en: 'Accounting Program (English)'
	String get accounting_program_english => 'Accounting Program (English)';

	/// en: 'Business Administration Program (English)'
	String get business_administration_program_english => 'Business Administration Program (English)';

	/// en: 'Basic Sciences in Dentistry'
	String get basic_sciences_in_dentistry => 'Basic Sciences in Dentistry';

	/// en: 'Basic Medical and Clinical Sciences'
	String get basic_medical_and_clinical_sciences => 'Basic Medical and Clinical Sciences';

	/// en: 'Oral and Maxillofacial Surgery'
	String get oral_and_maxillofacial_surgery => 'Oral and Maxillofacial Surgery';

	/// en: 'Orthodontics and Pediatric Dentistry'
	String get orthodontics_and_pediatric_dentistry => 'Orthodontics and Pediatric Dentistry';

	/// en: 'Periodontics and Oral Medicine'
	String get periodontics_and_oral_medicine => 'Periodontics and Oral Medicine';

	/// en: 'Prosthodontics'
	String get prosthodontics => 'Prosthodontics';

	/// en: 'Conservative Dentistry and Endodontics'
	String get conservative_dentistry_and_endodontics => 'Conservative Dentistry and Endodontics';

	/// en: 'Architectural Engineering'
	String get architectural_engineering => 'Architectural Engineering';

	/// en: 'Basic Sciences'
	String get basic_sciences => 'Basic Sciences';

	/// en: 'Civil Engineering'
	String get civil_engineering => 'Civil Engineering';

	/// en: 'Mechanical Engineering'
	String get mechanical_engineering => 'Mechanical Engineering';

	/// en: 'Electrical Engineering'
	String get electrical_engineering => 'Electrical Engineering';

	/// en: 'Artificial Intelligence Engineering'
	String get artificial_intelligence_engineering => 'Artificial Intelligence Engineering';

	/// en: 'Interior Design and Architecture'
	String get interior_design_and_architecture => 'Interior Design and Architecture';

	/// en: 'Furniture Design and Production Technology'
	String get furniture_design_and_production_technology => 'Furniture Design and Production Technology';

	/// en: 'Graphics and Digital Arts'
	String get graphics_and_digital_arts => 'Graphics and Digital Arts';

	/// en: 'Animation and Multimedia'
	String get animation_and_multimedia => 'Animation and Multimedia';

	/// en: 'Medical Education'
	String get medical_education => 'Medical Education';

	/// en: 'Histology and Cell Biology'
	String get histology_and_cell_biology => 'Histology and Cell Biology';

	/// en: 'Clinical Pharmacy'
	String get clinical_pharmacy => 'Clinical Pharmacy';

	/// en: 'Human Anatomy and Embryology'
	String get human_anatomy_and_embryology => 'Human Anatomy and Embryology';

	/// en: 'Medical Physiology'
	String get medical_physiology => 'Medical Physiology';

	/// en: 'Medical Microbiology and Immunology'
	String get medical_microbiology_and_immunology => 'Medical Microbiology and Immunology';

	/// en: 'Forensic Medicine and Toxicology'
	String get forensic_medicine_and_toxicology => 'Forensic Medicine and Toxicology';

	/// en: 'Community Medicine and Public Health'
	String get community_medicine_and_public_health => 'Community Medicine and Public Health';

	/// en: 'Biochemistry'
	String get biochemistry => 'Biochemistry';

	/// en: 'Pathology'
	String get pathology => 'Pathology';

	/// en: 'English Language Program'
	String get english_language_program => 'English Language Program';

	/// en: 'German Language Program'
	String get german_language_program => 'German Language Program';

	/// en: 'Chinese Language Program'
	String get chinese_language_program => 'Chinese Language Program';

	/// en: 'French Department'
	String get french_department => 'French Department';

	/// en: 'Translation Department'
	String get translation_department => 'Translation Department';

	/// en: 'Pharmaceutical Chemistry'
	String get pharmaceutical_chemistry => 'Pharmaceutical Chemistry';

	/// en: 'Pharmacology and Biochemistry'
	String get pharmacology_and_biochemistry => 'Pharmacology and Biochemistry';

	/// en: 'Pharmacognosy'
	String get pharmacognosy => 'Pharmacognosy';

	/// en: 'Microbiology and Immunology'
	String get microbiology_and_immunology => 'Microbiology and Immunology';

	/// en: 'Pharmaceutical Technology'
	String get pharmaceutical_technology => 'Pharmaceutical Technology';

	/// en: 'Pharmacy Practice'
	String get pharmacy_practice => 'Pharmacy Practice';

	/// en: 'Basic Sciences'
	String get basic_sciences_pt => 'Basic Sciences';

	/// en: 'Biomechanics'
	String get biomechanics => 'Biomechanics';

	/// en: 'PT for Internal Medicine and Geriatrics'
	String get pt_internal_medicine_and_geriatrics => 'PT for Internal Medicine and Geriatrics';

	/// en: 'PT for Women's Health'
	String get pt_womens_health => 'PT for Women\'s Health';

	/// en: 'PT for Surgery and Integumentary'
	String get pt_surgery_and_integumentary => 'PT for Surgery and Integumentary';

	/// en: 'PT for Orthopedics'
	String get pt_orthopedics => 'PT for Orthopedics';

	/// en: 'PT for Neurology'
	String get pt_neurology => 'PT for Neurology';

	/// en: 'PT for Pediatrics'
	String get pt_pediatrics => 'PT for Pediatrics';

	/// en: 'Artificial Biomedical Computing'
	String get artificial_biomedical_computing => 'Artificial Biomedical Computing';

	/// en: 'Cyber Security'
	String get artificial_cybersecurity => 'Cyber Security';

	/// en: 'AI and Data Science'
	String get ai_and_data_science => 'AI and Data Science';

	/// en: 'AI for Robotics'
	String get ai_for_robotics => 'AI for Robotics';

	/// en: 'Smart Systems'
	String get smart_systems => 'Smart Systems';
}

// Path: transcript.overview
class TranslationsTranscriptOverviewEn {
	TranslationsTranscriptOverviewEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Cumulative GPA'
	String get gpa => 'Cumulative GPA';

	/// en: 'Earned Credits'
	String get credits => 'Earned Credits';

	/// en: 'Standing'
	String get standing => 'Standing';

	/// en: 'Good Standing'
	String get active => 'Good Standing';
}

// Path: transcript.semester
class TranslationsTranscriptSemesterEn {
	TranslationsTranscriptSemesterEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Fall Semester'
	String get fall => 'Fall Semester';

	/// en: 'Spring Semester'
	String get spring => 'Spring Semester';

	/// en: 'Summer Session'
	String get summer => 'Summer Session';
}

// Path: transcript.course
class TranslationsTranscriptCourseEn {
	TranslationsTranscriptCourseEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Grade'
	String get grade => 'Grade';

	/// en: 'Credits'
	String get credits => 'Credits';

	late final TranslationsTranscriptCourseStatusEn status = TranslationsTranscriptCourseStatusEn._(_root);
}

// Path: academic_progress.categories
class TranslationsAcademicProgressCategoriesEn {
	TranslationsAcademicProgressCategoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Horus University'
	String get university_name => 'Horus University';

	/// en: 'Faculty Requirements'
	String get faculty => 'Faculty Requirements';

	/// en: 'Major Requirements'
	String get major => 'Major Requirements';

	/// en: 'Electives'
	String get electives => 'Electives';
}

// Path: academic_progress.status
class TranslationsAcademicProgressStatusEn {
	TranslationsAcademicProgressStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'In Progress'
	String get in_progress => 'In Progress';

	/// en: 'Remaining'
	String get remaining => 'Remaining';

	/// en: 'Requirement Met'
	String get requirement_met => 'Requirement Met';
}

// Path: attendance.subjects
class TranslationsAttendanceSubjectsEn {
	TranslationsAttendanceSubjectsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Artificial Intelligence'
	String get ai => 'Artificial Intelligence';

	/// en: 'Machine Learning'
	String get machine_learning => 'Machine Learning';

	/// en: 'Ethics in IT'
	String get ethics => 'Ethics in IT';

	/// en: 'Advanced Calculus'
	String get calculus => 'Advanced Calculus';
}

// Path: professor.stats
class TranslationsProfessorStatsEn {
	TranslationsProfessorStatsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Groups'
	String get groups => 'Groups';

	/// en: 'Total Students'
	String get students => 'Total Students';

	/// en: 'Teaching Assistants'
	String get tas => 'Teaching Assistants';

	/// en: 'Rating'
	String get rating => 'Rating';

	/// en: 'Shared Files'
	String get shared_files => 'Shared Files';

	/// en: 'Office Hours'
	String get office_hours => 'Office Hours';
}

// Path: professor.quick_actions
class TranslationsProfessorQuickActionsEn {
	TranslationsProfessorQuickActionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Urgent'
	String get urgent => 'Urgent';

	/// en: 'Upload'
	String get upload => 'Upload';

	/// en: 'Message'
	String get message => 'Message';

	/// en: 'Clicked'
	String get action_clicked => 'Clicked';
}

// Path: professor.profile
class TranslationsProfessorProfileEn {
	TranslationsProfessorProfileEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Urgent Announcements'
	String get urgent_announcements => 'Urgent Announcements';

	/// en: 'Teaching Assistants'
	String get teaching_assistants => 'Teaching Assistants';

	/// en: 'Shared Resources'
	String get shared_resources => 'Shared Resources';

	/// en: 'Office Hours'
	String get office_hours => 'Office Hours';
}

// Path: roles.categories
class TranslationsRolesCategoriesEn {
	TranslationsRolesCategoriesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Admin & IT'
	String get admin_it => 'Admin & IT';

	/// en: 'Academic Leadership'
	String get academic_leadership => 'Academic Leadership';

	/// en: 'Teaching Staff'
	String get teaching_staff => 'Teaching Staff';

	/// en: 'Student Affairs'
	String get student_affairs => 'Student Affairs';

	/// en: 'Student Roles'
	String get student_roles => 'Student Roles';

	/// en: 'Facilities & Security'
	String get facilities_security => 'Facilities & Security';

	/// en: 'External Roles'
	String get external_roles => 'External Roles';
}

// Path: roles.names
class TranslationsRolesNamesEn {
	TranslationsRolesNamesEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Super Admin'
	String get super_admin => 'Super Admin';

	/// en: 'Administrator'
	String get admin => 'Administrator';

	/// en: 'IT Support'
	String get it_support => 'IT Support';

	/// en: 'Financial Auditor'
	String get financial_auditor => 'Financial Auditor';

	/// en: 'Rector / President'
	String get rector => 'Rector / President';

	/// en: 'Dean'
	String get dean => 'Dean';

	/// en: 'Department Head'
	String get department_head => 'Department Head';

	/// en: 'Academic Coordinator'
	String get academic_coordinator => 'Academic Coordinator';

	/// en: 'Professor / Instructor'
	String get professor => 'Professor / Instructor';

	/// en: 'Lecturer'
	String get lecturer => 'Lecturer';

	/// en: 'Teaching Assistant'
	String get teaching_assistant => 'Teaching Assistant';

	/// en: 'Registrar Officer'
	String get registrar_officer => 'Registrar Officer';

	/// en: 'Academic Advisor'
	String get academic_advisor => 'Academic Advisor';

	/// en: 'Librarian'
	String get librarian => 'Librarian';

	/// en: 'Freshman'
	String get freshman => 'Freshman';

	/// en: 'Regular Student'
	String get regular_student => 'Regular Student';

	/// en: 'Student'
	String get student => 'Student';

	/// en: 'Class Representative'
	String get class_representative => 'Class Representative';

	/// en: 'Alumni'
	String get alumni => 'Alumni';

	/// en: 'Dorm Supervisor'
	String get dorm_supervisor => 'Dorm Supervisor';

	/// en: 'Security Officer'
	String get security_officer => 'Security Officer';

	/// en: 'Guest'
	String get guest => 'Guest';

	/// en: 'Parent / Guardian'
	String get parent => 'Parent / Guardian';

	/// en: 'Recruiter'
	String get recruiter => 'Recruiter';
}

// Path: roles.descriptions
class TranslationsRolesDescriptionsEn {
	TranslationsRolesDescriptionsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Full control over the entire system'
	String get super_admin => 'Full control over the entire system';

	/// en: 'System administrator with high privileges'
	String get admin => 'System administrator with high privileges';

	/// en: 'Technical system support and maintenance'
	String get it_support => 'Technical system support and maintenance';

	/// en: 'Oversees financial records and invoices'
	String get financial_auditor => 'Oversees financial records and invoices';

	/// en: 'University president with full academic oversight'
	String get rector => 'University president with full academic oversight';

	/// en: 'Head of a college/faculty'
	String get dean => 'Head of a college/faculty';

	/// en: 'Head of an academic department'
	String get department_head => 'Head of an academic department';

	/// en: 'Coordinates academic programs and scheduling'
	String get academic_coordinator => 'Coordinates academic programs and scheduling';

	/// en: 'Faculty member who teaches and manages courses'
	String get professor => 'Faculty member who teaches and manages courses';

	/// en: 'Teaches courses without full professor privileges'
	String get lecturer => 'Teaches courses without full professor privileges';

	/// en: 'Assists professors with grading, labs, and tutorials'
	String get teaching_assistant => 'Assists professors with grading, labs, and tutorials';

	/// en: 'Manages student enrollment and registration'
	String get registrar_officer => 'Manages student enrollment and registration';

	/// en: 'Guides students through academic planning'
	String get academic_advisor => 'Guides students through academic planning';

	/// en: 'Manages library resources and materials'
	String get librarian => 'Manages library resources and materials';

	/// en: 'First-year student with limited system access'
	String get freshman => 'First-year student with limited system access';

	/// en: 'Full student with all standard academic privileges'
	String get regular_student => 'Full student with all standard academic privileges';

	/// en: 'General student role'
	String get student => 'General student role';

	/// en: 'Student leader who represents the class body'
	String get class_representative => 'Student leader who represents the class body';

	/// en: 'Graduated student with limited access'
	String get alumni => 'Graduated student with limited access';

	/// en: 'Manages student dormitory operations'
	String get dorm_supervisor => 'Manages student dormitory operations';

	/// en: 'Campus security and access control'
	String get security_officer => 'Campus security and access control';

	/// en: 'Temporary visitor with minimal access'
	String get guest => 'Temporary visitor with minimal access';

	/// en: 'Can view linked student progress and grades'
	String get parent => 'Can view linked student progress and grades';

	/// en: 'External recruitment organization'
	String get recruiter => 'External recruitment organization';
}

// Path: onboarding.style.classic
class TranslationsOnboardingStyleClassicEn {
	TranslationsOnboardingStyleClassicEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Classic'
	String get title => 'Classic';

	/// en: 'Clean, simple, and familiar Material Design'
	String get desc => 'Clean, simple, and familiar Material Design';
}

// Path: onboarding.style.glass
class TranslationsOnboardingStyleGlassEn {
	TranslationsOnboardingStyleGlassEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Glass'
	String get title => 'Glass';

	/// en: 'Modern, translucent, and vibrant aesthetics'
	String get desc => 'Modern, translucent, and vibrant aesthetics';
}

// Path: transcript.course.status
class TranslationsTranscriptCourseStatusEn {
	TranslationsTranscriptCourseStatusEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Transferred'
	String get transferred => 'Transferred';
}

/// The flat map containing all translations for locale <en>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
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

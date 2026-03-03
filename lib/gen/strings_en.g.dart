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
	late final TranslationsAcademicEn academic = TranslationsAcademicEn._(_root);
	late final TranslationsAdminEn admin = TranslationsAdminEn._(_root);
	late final TranslationsEnrollmentEn enrollment = TranslationsEnrollmentEn._(_root);
	late final TranslationsSharedEn shared = TranslationsSharedEn._(_root);
	late final TranslationsStudentsEn students = TranslationsStudentsEn._(_root);
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

	/// en: 'Student Portal'
	String get student_portal => 'Student Portal';

	/// en: 'Welcome to the Smart University'
	String get welcome_to_the_smart_universit => 'Welcome to the Smart University';

	/// en: 'I already have an account'
	String get i_already_have_an_account => 'I already have an account';
}

// Path: onboarding
class TranslationsOnboardingEn {
	TranslationsOnboardingEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Onboarding'
	String get title => 'Onboarding';

	late final TranslationsOnboardingLanguageEn language = TranslationsOnboardingLanguageEn._(_root);

	/// en: 'Choose Your Language'
	String get choose_language => 'Choose Your Language';

	/// en: 'You can change this later in Settings'
	String get you_can_change_this_later_in_s => 'You can change this later in Settings';

	/// en: 'Choose Your App Style'
	String get choose_app_style => 'Choose Your App Style';

	/// en: 'You can switch styles later in Settings'
	String get you_can_switch_styles_later_in => 'You can switch styles later in Settings';

	/// en: 'Choose Your Theme'
	String get choose_app_theme => 'Choose Your Theme';

	/// en: 'Select the lighting that suits you best'
	String get select_the_lighting_that_suits => 'Select the lighting that suits you best';

	/// en: 'Classic'
	String get classic_solid => 'Classic';

	/// en: 'High-performance flat solid colors'
	String get high_performance_flat_solid_co => 'High-performance flat solid colors';

	/// en: 'Modern Glass'
	String get modern_glass => 'Modern Glass';

	/// en: 'Premium frosted glass blur effect'
	String get premium_frosted_glass_blur_eff => 'Premium frosted glass blur effect';

	/// en: 'Almost there! Just one more step.'
	String get almost_there_just_one_more_ste => 'Almost there! Just one more step.';

	/// en: 'Recommended'
	String get recommended => 'Recommended';

	/// en: 'Light Mode'
	String get light_mode => 'Light Mode';

	/// en: 'Dark Mode'
	String get dark_mode => 'Dark Mode';

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

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Choose Account Recovery Method'
	String get choose_account_recovery_method => 'Choose Account Recovery Method';
}

// Path: home
class TranslationsHomeEn {
	TranslationsHomeEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations
	late final TranslationsHomeTabsEn tabs = TranslationsHomeTabsEn._(_root);

	/// en: 'Home'
	String get home => 'Home';

	/// en: 'Colleges'
	String get colleges => 'Colleges';

	/// en: 'Student'
	String get student => 'Student';

	/// en: 'Professor'
	String get prof => 'Professor';

	/// en: 'Admin'
	String get admin => 'Admin';

	/// en: 'Admin Portal'
	String get admin_portal => 'Admin Portal';

	/// en: 'Faculty Portal'
	String get faculty_portal => 'Faculty Portal';

	/// en: 'Student Portal'
	String get student_portal => 'Student Portal';
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

	/// en: 'User'
	String get user => 'User';

	/// en: 'About App'
	String get about_app => 'About App';

	/// en: 'Horus University'
	String get university => 'Horus University';

	/// en: 'Horus University - Egypt'
	String get horus_university => 'Horus University - Egypt';

	/// en: 'Developer'
	String get developer => 'Developer';

	/// en: 'Platform'
	String get platform => 'Platform';

	/// en: 'Backend'
	String get backend => 'Backend';

	/// en: 'HUE Portal is a comprehensive smart university management system.'
	String get hue_portal_is_a_comprehensive_ => 'HUE Portal is a comprehensive smart university management system.';

	/// en: 'Change Password'
	String get change_password => 'Change Password';

	/// en: 'Please fill all fields'
	String get please_fill_all_fields => 'Please fill all fields';

	/// en: 'Password must be at least 6 characters'
	String get password_must_be_at_least_6_ch => 'Password must be at least 6 characters';

	/// en: 'Passwords do not match'
	String get passwords_do_not_match => 'Passwords do not match';

	/// en: 'Password changed successfully'
	String get password_changed_successfully => 'Password changed successfully';

	/// en: 'Enter your new password below'
	String get enter_your_new_password => 'Enter your new password below';

	/// en: 'New Password'
	String get new_password => 'New Password';

	/// en: 'Confirm Password'
	String get confirm_password => 'Confirm Password';

	/// en: 'Privacy Policy'
	String get privacy_policy => 'Privacy Policy';

	/// en: 'Last updated: February 2026'
	String get last_updated_february_2026 => 'Last updated: February 2026';

	/// en: 'Edit Profile'
	String get edit_profile => 'Edit Profile';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Full Name'
	String get full_name => 'Full Name';

	/// en: 'Email'
	String get email => 'Email';

	/// en: 'Phone'
	String get phone => 'Phone';

	/// en: 'Bio'
	String get bio => 'Bio';

	/// en: 'Role'
	String get role => 'Role';

	/// en: 'Update your info and contact details'
	String get update_your_info_and_contact_d => 'Update your info and contact details';

	/// en: 'Change password and security level'
	String get change_password_and_security_l => 'Change password and security level';

	/// en: 'Forgot Password'
	String get forgot_password => 'Forgot Password';

	/// en: 'Send password recovery link to your email'
	String get send_password_recovery_link_to => 'Send password recovery link to your email';

	/// en: 'Toggle between dark and light mode'
	String get toggle_between_dark_and_light_ => 'Toggle between dark and light mode';

	/// en: 'Current: Glass Design'
	String get current_glass_design => 'Current: Glass Design';

	/// en: 'Current: Classic Design'
	String get current_classic_design => 'Current: Classic Design';

	/// en: 'Switch Style'
	String get switch_style => 'Switch Style';

	/// en: 'Control the types of incoming notifications'
	String get control_the_types_of_incoming_ => 'Control the types of incoming notifications';

	/// en: 'Send a test notification'
	String get send_a_test_notification => 'Send a test notification';

	/// en: 'Test notification sent successfully!'
	String get test_notification_successful => 'Test notification sent successfully!';

	/// en: 'Battery Saver Mode'
	String get battery_saver_mode => 'Battery Saver Mode';

	/// en: 'Disable complex visual effects for better performance'
	String get disable_complex_visual_effects => 'Disable complex visual effects for better performance';

	/// en: 'Help & Support Center'
	String get help_support_center => 'Help & Support Center';

	/// en: 'Contact us to resolve any issue'
	String get contact_us_to_resolve_any_issu => 'Contact us to resolve any issue';

	/// en: 'Version details and developer info'
	String get version_details_and_developers => 'Version details and developer info';

	/// en: 'Terms and rules for data usage'
	String get terms_and_rules_for_data_usage => 'Terms and rules for data usage';

	/// en: 'Select App Language'
	String get select_app_language => 'Select App Language';

	/// en: 'Deutsch'
	String get deutsch => 'Deutsch';

	/// en: 'Dynamic'
	String get dynamic_val => 'Dynamic';

	/// en: 'Switch'
	String get kSwitch => 'Switch';

	/// en: 'Switch'
	String get switch_label => 'Switch';
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

	late final TranslationsAdministrationAuditLogsEn audit_logs = TranslationsAdministrationAuditLogsEn._(_root);
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

// Path: academic
class TranslationsAcademicEn {
	TranslationsAcademicEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Academic Progress'
	String get academic_progress => 'Academic Progress';

	/// en: 'University Requirements'
	String get university_requirements => 'University Requirements';

	/// en: 'Faculty Requirements'
	String get faculty_requirements => 'Faculty Requirements';

	/// en: 'Major Requirements'
	String get major_requirements => 'Major Requirements';

	/// en: 'Electives'
	String get electives => 'Electives';

	/// en: 'Completed'
	String get completed => 'Completed';

	/// en: 'Remaining'
	String get remaining => 'Remaining';

	/// en: 'Academic Transcript'
	String get transcript_title => 'Academic Transcript';

	/// en: 'Grades'
	String get grades_title => 'Grades';

	/// en: 'My Courses'
	String get courses_title => 'My Courses';

	/// en: 'Degree Action Plan'
	String get action_plan_title => 'Degree Action Plan';

	/// en: 'Subject Results'
	String get subject_results_title => 'Subject Results';

	/// en: 'Attendance'
	String get attendance_title => 'Attendance';

	/// en: 'Schedule'
	String get schedule_title => 'Schedule';

	/// en: 'Exam Schedule'
	String get exam_schedule_title => 'Exam Schedule';

	/// en: 'Professor Dashboard'
	String get professor_dashboard => 'Professor Dashboard';

	/// en: 'All Students'
	String get all_students => 'All Students';

	/// en: 'Groups'
	String get groups => 'Groups';

	/// en: 'Teaching Assistants'
	String get tas => 'Teaching Assistants';

	/// en: 'No Groups'
	String get no_groups => 'No Groups';

	/// en: 'Office Hours'
	String get office_hours => 'Office Hours';

	/// en: 'Chat'
	String get chat => 'Chat';

	/// en: 'Courses'
	String get courses => 'Courses';

	/// en: 'Assignments'
	String get assignments => 'Assignments';

	/// en: 'Feedback'
	String get feedback => 'Feedback';

	/// en: 'View All'
	String get view_all => 'View All';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Inactive'
	String get inactive => 'Inactive';

	/// en: 'Add TA'
	String get add_ta => 'Add TA';

	/// en: 'Remove TA'
	String get remove_ta => 'Remove TA';

	/// en: 'Send Message'
	String get send_message => 'Send Message';

	/// en: 'Urgent Announcement'
	String get urgent_announcement => 'Urgent Announcement';

	/// en: 'Upload File'
	String get upload_file => 'Upload File';

	/// en: 'Section'
	String get section => 'Section';

	/// en: 'Group'
	String get group_label => 'Group';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Manage Groups'
	String get manage_groups => 'Manage Groups';

	/// en: 'Manage TAs'
	String get manage_tas => 'Manage TAs';

	/// en: 'Profile'
	String get profile => 'Profile';

	/// en: 'Semester Grades'
	String get semester_grades => 'Semester Grades';

	/// en: 'Grade Summary'
	String get grade_summary => 'Grade Summary';

	/// en: 'GPA'
	String get gpa => 'GPA';

	/// en: 'Credits'
	String get credits => 'Credits';

	/// en: 'Midterm'
	String get midterm => 'Midterm';

	/// en: 'Final Exam'
	String get kFinal => 'Final Exam';

	/// en: 'Practical'
	String get practical => 'Practical';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Year 1'
	String get year_1 => 'Year 1';

	/// en: 'Year 2'
	String get year_2 => 'Year 2';

	/// en: 'Year 3'
	String get year_3 => 'Year 3';

	/// en: 'Year 4'
	String get year_4 => 'Year 4';

	/// en: 'Enrolled'
	String get enrolled => 'Enrolled';

	/// en: 'Available'
	String get available => 'Available';

	/// en: 'Instructor'
	String get instructor => 'Instructor';

	/// en: 'Schedule'
	String get schedule_info => 'Schedule';

	/// en: 'Time'
	String get time => 'Time';

	/// en: 'Room'
	String get room => 'Room';

	/// en: 'Duration'
	String get duration => 'Duration';

	/// en: 'Seat'
	String get seat => 'Seat';

	/// en: 'Exam Date'
	String get exam_date => 'Exam Date';

	/// en: 'Present'
	String get present => 'Present';

	/// en: 'Absent'
	String get absent => 'Absent';

	/// en: 'Late'
	String get late => 'Late';

	/// en: 'Ratio'
	String get ratio => 'Ratio';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'No data available'
	String get no_data => 'No data available';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Search'
	String get search => 'Search';

	/// en: 'Filter'
	String get filter => 'Filter';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Add'
	String get add => 'Add';

	/// en: 'Remove'
	String get remove => 'Remove';

	/// en: 'Send'
	String get send => 'Send';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Academic Journey'
	String get academic_journey => 'Academic Journey';

	/// en: 'Academic Results'
	String get academic_results => 'Academic Results';

	/// en: 'Excellent'
	String get academic_standing_excellent => 'Excellent';

	/// en: 'Across All Groups'
	String get across_all_groups => 'Across All Groups';

	/// en: 'Degree Action Plan'
	String get action_plan => 'Degree Action Plan';

	/// en: 'Add New TA'
	String get add_new_ta => 'Add New TA';

	/// en: 'Add to Calendar'
	String get add_to_calendar => 'Add to Calendar';

	/// en: 'Added Successfully'
	String get added_successfully => 'Added Successfully';

	/// en: 'Advanced Learning'
	String get advanced_learning => 'Advanced Learning';

	/// en: 'Advanced Mathematics'
	String get advanced_mathematics => 'Advanced Mathematics';

	/// en: 'Advisor Assignment'
	String get advisor_assignment => 'Advisor Assignment';

	/// en: 'Algorithms'
	String get algorithms => 'Algorithms';

	/// en: 'Are you sure you want to remove this TA?'
	String get are_you_sure_you_want_to_remov => 'Are you sure you want to remove this TA?';

	/// en: 'Artificial Intelligence'
	String get artificial_intelligence => 'Artificial Intelligence';

	/// en: 'Calculus I'
	String get calculus_i => 'Calculus I';

	/// en: 'Clicked'
	String get clicked => 'Clicked';

	/// en: 'Code Review'
	String get code_review => 'Code Review';

	/// en: 'Computer Organization'
	String get comp_organization => 'Computer Organization';

	/// en: 'Completed'
	String get completed_1 => 'Completed';

	/// en: 'Completion Rate'
	String get completion_rate => 'Completion Rate';

	/// en: 'Computer Programming'
	String get computer_programming => 'Computer Programming';

	/// en: 'Confirm Removal'
	String get confirm_removal => 'Confirm Removal';

	/// en: 'Course Management'
	String get course_management => 'Course Management';

	/// en: 'Coursework'
	String get coursework => 'Coursework';

	/// en: 'Credits'
	String get credits_1 => 'Credits';

	/// en: 'CS402 Artificial Intelligence'
	String get cs402_artificial_intelligence => 'CS402 Artificial Intelligence';

	/// en: 'CS405 Machine Learning'
	String get cs405_machine_learning => 'CS405 Machine Learning';

	/// en: 'CS410 Computer Vision'
	String get cs410_computer_vision => 'CS410 Computer Vision';

	/// en: 'Cumulative GPA'
	String get cumulative_gpa => 'Cumulative GPA';

	/// en: 'd MMMM'
	String get d_mmmm => 'd MMMM';

	/// en: 'Data Structures'
	String get data_structures => 'Data Structures';

	/// en: 'Database Systems'
	String get database_systems => 'Database Systems';

	/// en: 'Days'
	String get days => 'Days';

	/// en: 'Deep Learning'
	String get deep_learning => 'Deep Learning';

	/// en: 'Dr. Ada Lovelace'
	String get dr_ada_lovelace => 'Dr. Ada Lovelace';

	/// en: 'Dr. Alan Turing'
	String get dr_alan_turing => 'Dr. Alan Turing';

	/// en: 'Dr. Robert Smith'
	String get dr_robert_smith => 'Dr. Robert Smith';

	/// en: 'Dr. Sarah Ahmed'
	String get dr_sarah_ahmed => 'Dr. Sarah Ahmed';

	/// en: 'English Composition'
	String get english_composition => 'English Composition';

	/// en: 'Ethics in IT'
	String get ethics_in_it => 'Ethics in IT';

	/// en: 'Exam Schedule'
	String get exam_schedule => 'Exam Schedule';

	/// en: 'Fall 2023'
	String get fall_2023 => 'Fall 2023';

	/// en: 'Field Internship'
	String get field_internship => 'Field Internship';

	/// en: 'File Title'
	String get file_title => 'File Title';

	/// en: 'File will be uploaded to cloud storage'
	String get file_will_be_uploaded_to_cloud => 'File will be uploaded to cloud storage';

	/// en: 'Final Exam'
	String get final_exam => 'Final Exam';

	/// en: 'Foundational Skills'
	String get foundational_skills => 'Foundational Skills';

	/// en: 'Frontend UI'
	String get frontend_ui => 'Frontend UI';

	/// en: 'General Physics'
	String get general_physics => 'General Physics';

	/// en: 'Graduation Mastery'
	String get graduation_mastery => 'Graduation Mastery';

	/// en: 'Graduation Progress'
	String get graduation_progress => 'Graduation Progress';

	/// en: 'Graduation Project'
	String get graduation_project => 'Graduation Project';

	/// en: 'Hall 1'
	String get hall_1 => 'Hall 1';

	/// en: 'Hall 4'
	String get hall_4 => 'Hall 4';

	/// en: 'Hours'
	String get hours => 'Hours';

	/// en: 'HUM210 Professional Ethics'
	String get hum210_professional_ethics => 'HUM210 Professional Ethics';

	/// en: 'Intro to AI'
	String get intro_to_ai => 'Intro to AI';

	/// en: 'Intro to Programming'
	String get intro_to_programming => 'Intro to Programming';

	/// en: 'Joined'
	String get joined => 'Joined';

	/// en: 'Lab 12'
	String get lab_12 => 'Lab 12';

	/// en: 'Lab Final'
	String get lab_final => 'Lab Final';

	/// en: 'Lecture'
	String get lecture => 'Lecture';

	/// en: 'Lecture Hall 2'
	String get lecture_hall_2 => 'Lecture Hall 2';

	/// en: 'Linear Algebra'
	String get linear_algebra => 'Linear Algebra';

	/// en: 'Live'
	String get live => 'Live';

	/// en: 'Live Now'
	String get live_now => 'Live Now';

	/// en: 'Logic Design'
	String get logic_design => 'Logic Design';

	/// en: 'Machine Learning'
	String get machine_learning => 'Machine Learning';

	/// en: 'MAT301 Advanced Calculus'
	String get mat301_advanced_calculus => 'MAT301 Advanced Calculus';

	/// en: 'Mathematics'
	String get mathematics => 'Mathematics';

	/// en: 'Members'
	String get members => 'Members';

	/// en: 'Messages'
	String get messages => 'Messages';

	/// en: 'Midterm Exam'
	String get midterm_exam => 'Midterm Exam';

	/// en: 'Mins'
	String get mins => 'Mins';

	/// en: 'Network Security'
	String get network_security => 'Network Security';

	/// en: 'Next Exam In'
	String get next_exam_in => 'Next Exam In';

	/// en: 'No Available TAs Currently'
	String get no_available_tas_currently => 'No Available TAs Currently';

	/// en: 'No Exams on This Day'
	String get no_exams_on_this_day => 'No Exams on This Day';

	/// en: 'No TAs Assigned Yet'
	String get no_tas_assigned_yet => 'No TAs Assigned Yet';

	/// en: 'Overall Attendance'
	String get overall_attendance => 'Overall Attendance';

	/// en: 'Overall Progress'
	String get overall_progress => 'Overall Progress';

	/// en: 'Performance Distribution'
	String get performance_distribution => 'Performance Distribution';

	/// en: 'Points'
	String get points => 'Points';

	/// en: 'Practical Project'
	String get practical_project => 'Practical Project';

	/// en: 'Prof. John Doe'
	String get prof_john_doe => 'Prof. John Doe';

	/// en: 'Programming Basics'
	String get programming_basics => 'Programming Basics';

	/// en: 'Progress'
	String get progress => 'Progress';

	/// en: 'Psychology'
	String get psychology => 'Psychology';

	/// en: 'Quick Actions'
	String get quick_actions => 'Quick Actions';

	/// en: 'Quiz 1'
	String get quiz_1 => 'Quiz 1';

	/// en: 'Quiz 2'
	String get quiz_2 => 'Quiz 2';

	/// en: 'Rank'
	String get rank => 'Rank';

	/// en: 'Rating'
	String get rating => 'Rating';

	/// en: 'Registration Requests'
	String get registration_requests => 'Registration Requests';

	/// en: 'Removed Successfully'
	String get removed_successfully => 'Removed Successfully';

	/// en: 'Results Analysis'
	String get results_analysis => 'Results Analysis';

	/// en: 'Score'
	String get score => 'Score';

	/// en: 'Select a TA from the list to add'
	String get select_a_ta_from_the_list_to_a => 'Select a TA from the list to add';

	/// en: 'Sessions This Week'
	String get sessions_this_week => 'Sessions This Week';

	/// en: 'Shared Files'
	String get shared_files => 'Shared Files';

	/// en: 'Sophomore'
	String get sophomore => 'Sophomore';

	/// en: 'Specialization Projects'
	String get specialization_projects => 'Specialization Projects';

	/// en: 'Spring 2024'
	String get spring_2024 => 'Spring 2024';

	/// en: 'Start by adding the first TA for your course'
	String get start_by_adding_the_first_ta_f => 'Start by adding the first TA for your course';

	/// en: 'Students'
	String get students => 'Students';

	/// en: 'Summer 2024'
	String get summer_2024 => 'Summer 2024';

	/// en: 'TA Team Chat'
	String get ta_team_chat => 'TA Team Chat';

	/// en: 'Total Students'
	String get total_students => 'Total Students';

	/// en: 'Track Project I'
	String get track_project_i => 'Track Project I';

	/// en: 'Type a message...'
	String get type_a_message => 'Type a message...';

	/// en: 'Upload'
	String get upload => 'Upload';

	/// en: 'Upload Files'
	String get upload_files => 'Upload Files';

	/// en: 'Upload New File'
	String get upload_new_file => 'Upload New File';

	/// en: 'Uploaded Successfully'
	String get uploaded_successfully => 'Uploaded Successfully';

	/// en: 'Urgent News'
	String get urgent_news => 'Urgent News';

	/// en: 'Web Programming'
	String get web_programming => 'Web Programming';
}

// Path: admin
class TranslationsAdminEn {
	TranslationsAdminEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'EEEE, MMMM dd, yyyy'
	String get eeee_mmmm_dd_yyyy => 'EEEE, MMMM dd, yyyy';

	/// en: 'en'
	String get en => 'en';

	/// en: 'SYSTEM ONLINE'
	String get system_online => 'SYSTEM ONLINE';

	/// en: 'Admin Command Center'
	String get admin_command_center => 'Admin Command Center';

	/// en: 'Admin'
	String get admin => 'Admin';

	/// en: 'Live Statistics'
	String get live_statistics => 'Live Statistics';

	/// en: 'Students'
	String get students => 'Students';

	/// en: 'Staff'
	String get staff => 'Staff';

	/// en: 'Faculty'
	String get faculty => 'Faculty';

	/// en: 'Leadership'
	String get leadership => 'Leadership';

	/// en: 'Admin & IT'
	String get admin_it => 'Admin & IT';

	/// en: 'System Modules'
	String get system_modules => 'System Modules';

	/// en: 'Users'
	String get users => 'Users';

	/// en: 'Manage all accounts'
	String get manage_all_accounts => 'Manage all accounts';

	/// en: 'Colleges'
	String get colleges => 'Colleges';

	/// en: 'Manage faculties'
	String get manage_faculties => 'Manage faculties';

	/// en: 'Departments'
	String get departments => 'Departments';

	/// en: 'Academic departments'
	String get academic_departments => 'Academic departments';

	/// en: 'Professors'
	String get professors => 'Professors';

	/// en: 'Faculty members'
	String get faculty_members => 'Faculty members';

	/// en: 'Roles'
	String get roles => 'Roles';

	/// en: 'Permission management'
	String get permission_management => 'Permission management';

	/// en: 'Audit Logs'
	String get audit_logs => 'Audit Logs';

	/// en: 'System activity log'
	String get system_activity_log => 'System activity log';

	/// en: 'System Settings'
	String get system_settings => 'System Settings';

	/// en: 'Platform configuration'
	String get platform_configuration => 'Platform configuration';

	/// en: 'Performance'
	String get performance => 'Performance';

	/// en: 'Server health metrics'
	String get server_health_metrics => 'Server health metrics';

	/// en: 'System Pulse'
	String get system_pulse => 'System Pulse';

	/// en: 'Server'
	String get server => 'Server';

	/// en: 'Online'
	String get online => 'Online';

	/// en: 'Latency'
	String get latency => 'Latency';

	/// en: 'Database'
	String get database => 'Database';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'REALTIME LATENCY (MS)'
	String get realtime_latency_ms => 'REALTIME LATENCY (MS)';

	/// en: 'Role Breakdown'
	String get role_breakdown => 'Role Breakdown';

	/// en: 'Teaching Staff'
	String get teaching_staff => 'Teaching Staff';

	/// en: 'Academic Leadership'
	String get academic_leadership => 'Academic Leadership';

	/// en: 'Student Affairs'
	String get student_affairs => 'Student Affairs';

	/// en: 'Total Users'
	String get total_users => 'Total Users';

	/// en: 'System Health'
	String get system_health => 'System Health';

	/// en: 'Quick Actions'
	String get quick_actions => 'Quick Actions';

	/// en: 'Management'
	String get management => 'Management';

	/// en: 'Add User'
	String get add_user => 'Add User';

	/// en: 'Export Data'
	String get export_data => 'Export Data';

	/// en: 'Send Announcement'
	String get send_announcement => 'Send Announcement';

	/// en: 'Backup System'
	String get backup_system => 'Backup System';

	/// en: 'User Management'
	String get user_management => 'User Management';

	/// en: 'User List'
	String get user_list => 'User List';

	/// en: 'All'
	String get filter_all => 'All';

	/// en: 'Students'
	String get filter_students => 'Students';

	/// en: 'Staff'
	String get filter_staff => 'Staff';

	/// en: 'Admin'
	String get filter_admin => 'Admin';

	/// en: 'Search users...'
	String get search_users => 'Search users...';

	/// en: 'No users found'
	String get no_users => 'No users found';

	/// en: '${count} users'
	String user_count({required Object count}) => '${count} users';

	/// en: 'Student Management'
	String get student_management => 'Student Management';

	/// en: 'Staff Management'
	String get staff_management => 'Staff Management';

	/// en: 'Faculty Management'
	String get faculty_management => 'Faculty Management';

	/// en: 'Leadership Management'
	String get leadership_management => 'Leadership Management';

	/// en: 'Admin & IT Management'
	String get admin_it_management => 'Admin & IT Management';

	/// en: 'College Management'
	String get college_management => 'College Management';

	/// en: 'Department Management'
	String get department_management => 'Department Management';

	/// en: 'Professor Management'
	String get professor_management => 'Professor Management';

	/// en: 'Role Management'
	String get role_management => 'Role Management';

	/// en: 'Audit Log Management'
	String get audit_log_management => 'Audit Log Management';

	/// en: 'System Configuration'
	String get system_configuration => 'System Configuration';

	/// en: 'Add College'
	String get add_college => 'Add College';

	/// en: 'Add Department'
	String get add_department => 'Add Department';

	/// en: 'Edit College'
	String get edit_college => 'Edit College';

	/// en: 'Edit Department'
	String get edit_department => 'Edit Department';

	/// en: 'Delete College'
	String get delete_college => 'Delete College';

	/// en: 'Delete Department'
	String get delete_department => 'Delete Department';

	/// en: 'College Name'
	String get college_name => 'College Name';

	/// en: 'Department Name'
	String get department_name => 'Department Name';

	/// en: 'Dean Name'
	String get dean_name => 'Dean Name';

	/// en: 'Head Name'
	String get head_name => 'Head Name';

	/// en: 'Students'
	String get student_count => 'Students';

	/// en: 'Staff'
	String get staff_count => 'Staff';

	/// en: 'TAs'
	String get ta_count => 'TAs';

	/// en: 'Action'
	String get action => 'Action';

	/// en: 'Timestamp'
	String get timestamp => 'Timestamp';

	/// en: 'User'
	String get user => 'User';

	/// en: 'Details'
	String get details => 'Details';

	/// en: 'Filter by action'
	String get filter_by_action => 'Filter by action';

	/// en: 'Filter by date'
	String get filter_by_date => 'Filter by date';

	/// en: 'No audit logs found'
	String get no_logs => 'No audit logs found';

	/// en: 'System Version'
	String get system_version => 'System Version';

	/// en: 'Maintenance Mode'
	String get maintenance_mode => 'Maintenance Mode';

	/// en: 'Backup Schedule'
	String get backup_schedule => 'Backup Schedule';

	/// en: 'Email Server'
	String get email_server => 'Email Server';

	/// en: 'Storage Quota'
	String get storage_quota => 'Storage Quota';

	/// en: 'Security Level'
	String get security_level => 'Security Level';

	/// en: 'Log Retention'
	String get log_retention => 'Log Retention';

	/// en: 'Session Timeout'
	String get session_timeout => 'Session Timeout';

	/// en: 'Save Settings'
	String get save_settings => 'Save Settings';

	/// en: 'Reset to Defaults'
	String get reset_defaults => 'Reset to Defaults';

	/// en: 'Name'
	String get user_name => 'Name';

	/// en: 'Email'
	String get user_email => 'Email';

	/// en: 'Phone'
	String get user_phone => 'Phone';

	/// en: 'Role'
	String get user_role => 'Role';

	/// en: 'Department'
	String get user_department => 'Department';

	/// en: 'College'
	String get user_college => 'College';

	/// en: 'Status'
	String get user_status => 'Status';

	/// en: 'Created'
	String get user_created => 'Created';

	/// en: 'User updated successfully'
	String get user_updated => 'User updated successfully';

	/// en: 'Add New User'
	String get add_new_user => 'Add New User';

	/// en: 'Edit User'
	String get edit_user => 'Edit User';

	/// en: 'Delete User'
	String get delete_user => 'Delete User';

	/// en: 'Save'
	String get save_user => 'Save';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Full Name'
	String get name_label => 'Full Name';

	/// en: 'Email Address'
	String get email_label => 'Email Address';

	/// en: 'Phone Number'
	String get phone_label => 'Phone Number';

	/// en: 'Select Role'
	String get role_label => 'Select Role';

	/// en: 'Department'
	String get department_label => 'Department';

	/// en: 'College'
	String get college_label => 'College';

	/// en: 'Password'
	String get password_label => 'Password';

	/// en: 'Confirm Password'
	String get confirm_password_label => 'Confirm Password';

	/// en: 'Student'
	String get category_student => 'Student';

	/// en: 'Staff'
	String get category_staff => 'Staff';

	/// en: 'Faculty'
	String get category_faculty => 'Faculty';

	/// en: 'Leadership'
	String get category_leadership => 'Leadership';

	/// en: 'Admin'
	String get category_admin => 'Admin';

	/// en: 'No departments available'
	String get no_departments => 'No departments available';

	/// en: 'No colleges available'
	String get no_colleges => 'No colleges available';

	/// en: 'Select a role'
	String get select_role => 'Select a role';

	/// en: 'Select a department'
	String get select_department => 'Select a department';

	/// en: 'Select a college'
	String get select_college => 'Select a college';

	/// en: 'User added successfully'
	String get user_added => 'User added successfully';

	/// en: 'User deleted successfully'
	String get user_deleted => 'User deleted successfully';

	/// en: 'Confirm Delete'
	String get confirm_delete => 'Confirm Delete';

	/// en: 'Are you sure you want to delete this user?'
	String get confirm_delete_message => 'Are you sure you want to delete this user?';

	/// en: 'Error loading data'
	String get error_loading => 'Error loading data';

	/// en: 'Error saving data'
	String get error_saving => 'Error saving data';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Academic Department'
	String get academic_department => 'Academic Department';

	/// en: 'Academic Departments'
	String get academic_departments_1 => 'Academic Departments';

	/// en: 'Academic Leaders'
	String get academic_leaders => 'Academic Leaders';

	/// en: 'Academic Warnings'
	String get academic_warnings => 'Academic Warnings';

	/// en: 'Account Status'
	String get account_status => 'Account Status';

	/// en: 'Account Verification'
	String get account_verification => 'Account Verification';

	/// en: 'Actor'
	String get actor => 'Actor';

	/// en: 'Add Report'
	String get add_report => 'Add Report';

	/// en: 'Admins'
	String get admins => 'Admins';

	/// en: 'Advanced Management'
	String get advanced_management => 'Advanced Management';

	/// en: 'All'
	String get all => 'All';

	/// en: 'All Levels'
	String get all_levels => 'All Levels';

	/// en: 'All Systems Operational'
	String get all_systems_operational => 'All Systems Operational';

	/// en: 'Apply Filters'
	String get apply_filters => 'Apply Filters';

	/// en: 'Are you sure you want to delete this user?'
	String get are_you_sure_you_want_to_delet => 'Are you sure you want to delete this user?';

	/// en: 'Assign'
	String get assign => 'Assign';

	/// en: 'Assign Dean'
	String get assign_dean => 'Assign Dean';

	/// en: 'Assign Department Head'
	String get assign_department_head => 'Assign Department Head';

	/// en: 'Attached Report'
	String get attached_report => 'Attached Report';

	/// en: 'Ban User'
	String get ban_user => 'Ban User';

	/// en: 'Banned'
	String get banned => 'Banned';

	/// en: 'Change'
	String get change => 'Change';

	/// en: 'Change Dean'
	String get change_dean => 'Change Dean';

	/// en: 'Changes Saved Successfully'
	String get changes_saved_successfully => 'Changes Saved Successfully';

	/// en: 'College'
	String get college => 'College';

	/// en: 'College Dean'
	String get college_dean => 'College Dean';

	/// en: 'College Details'
	String get college_details => 'College Details';

	/// en: 'Colleges Management'
	String get colleges_management => 'Colleges Management';

	/// en: 'Coming Soon'
	String get coming_soon => 'Coming Soon';

	/// en: 'Deactivated'
	String get deactivated => 'Deactivated';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Department Details'
	String get department_details => 'Department Details';

	/// en: 'Department Projects'
	String get department_projects => 'Department Projects';

	/// en: 'Departments Management'
	String get departments_management => 'Departments Management';

	/// en: 'Email Address'
	String get email_address => 'Email Address';

	/// en: 'Entity'
	String get entity => 'Entity';

	/// en: 'Error: {error}'
	String get error_snapshoterror => 'Error: {error}';

	/// en: 'Faculty Members'
	String get faculty_members_1 => 'Faculty Members';

	/// en: 'Failed to Load Data'
	String get failed_to_load_data => 'Failed to Load Data';

	/// en: 'Filter Users'
	String get filter_users => 'Filter Users';

	/// en: 'Full Name'
	String get full_name => 'Full Name';

	/// en: 'Head of Department'
	String get head_of_department => 'Head of Department';

	/// en: 'Incidents'
	String get incidents => 'Incidents';

	/// en: 'Leadership Statistics'
	String get leadership_stats => 'Leadership Statistics';

	/// en: 'Level {level}'
	String get level_level => 'Level {level}';

	/// en: 'Manage Tags'
	String get manage_tags => 'Manage Tags';

	/// en: 'Min. 6 characters'
	String get min_6_chars => 'Min. 6 characters';

	/// en: 'National ID'
	String get national_id => 'National ID';

	/// en: 'Nationality'
	String get nationality => 'Nationality';

	/// en: 'No About Text Available'
	String get no_about_text_available => 'No About Text Available';

	/// en: 'No Colleges Found'
	String get no_colleges_found => 'No Colleges Found';

	/// en: 'No Dean Assigned'
	String get no_dean_assigned => 'No Dean Assigned';

	/// en: 'No Departments Found'
	String get no_departments_found => 'No Departments Found';

	/// en: 'No Departments in This College'
	String get no_departments_in_this_college => 'No Departments in This College';

	/// en: 'No Description Available'
	String get no_description_available => 'No Description Available';

	/// en: 'No Faculty Records Found'
	String get no_faculty_records_found => 'No Faculty Records Found';

	/// en: 'No Head Assigned'
	String get no_head_assigned => 'No Head Assigned';

	/// en: 'No Logs Found'
	String get no_logs_found => 'No Logs Found';

	/// en: 'No Matching Students Found'
	String get no_matching_students_found => 'No Matching Students Found';

	/// en: 'No Projects Added Yet'
	String get no_projects_added_yet => 'No Projects Added Yet';

	/// en: 'No settings found in the database'
	String get no_settings_found_in_the_datab => 'No settings found in the database';

	/// en: 'No Users Found'
	String get no_users_found => 'No Users Found';

	/// en: 'Office'
	String get office => 'Office';

	/// en: 'Password'
	String get password => 'Password';

	/// en: 'Pending Registration'
	String get pending_reg => 'Pending Registration';

	/// en: 'Permanently Delete User'
	String get permanently_delete_user => 'Permanently Delete User';

	/// en: 'Phone Number'
	String get phone_number => 'Phone Number';

	/// en: 'Please assign a dean for this college'
	String get please_assign_a_dean_for_the_c => 'Please assign a dean for this college';

	/// en: 'Please assign a head for this department'
	String get please_assign_a_head_for_the_d => 'Please assign a head for this department';

	/// en: 'Roles Management'
	String get roles_management => 'Roles Management';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Save Changes'
	String get save_changes => 'Save Changes';

	/// en: 'Search by name, email, phone or ID...'
	String get search_by_name_email_phone_id => 'Search by name, email, phone or ID...';

	/// en: 'Search doctor name...'
	String get search_doctor_name => 'Search doctor name...';

	/// en: 'Search staff member...'
	String get search_staff_member => 'Search staff member...';

	/// en: 'Search student or ID...'
	String get search_student_or_id => 'Search student or ID...';

	/// en: 'Select'
	String get select => 'Select';

	/// en: 'Select role'
	String get select_role_in_widgetinitialca => 'Select role';

	/// en: 'Select Role / Permission'
	String get select_role_permission => 'Select Role / Permission';

	/// en: 'Separate tags with commas'
	String get separate_tags_with_commas => 'Separate tags with commas';

	/// en: 'Servers'
	String get servers => 'Servers';

	/// en: 'Student ID'
	String get student_id => 'Student ID';

	/// en: 'System Technical Status'
	String get system_technical_status => 'System Technical Status';

	/// en: 'tag1, tag2'
	String get tag1_tag2 => 'tag1, tag2';

	/// en: 'Teaching Assistants'
	String get teaching_assistants => 'Teaching Assistants';

	/// en: 'Total Staff'
	String get total_staff => 'Total Staff';

	/// en: 'Total Students'
	String get total_students => 'Total Students';

	/// en: 'Unverified'
	String get unverified => 'Unverified';

	/// en: 'User Roles & Ranks'
	String get user_roles_ranks => 'User Roles & Ranks';

	/// en: 'Verification'
	String get verification => 'Verification';

	/// en: 'Verified'
	String get verified => 'Verified';

	/// en: 'Warning Level'
	String get warning_level => 'Warning Level';

	/// en: 'You can manage professors and more here'
	String get you_can_manage_professors_and_ => 'You can manage professors and more here';
}

// Path: enrollment
class TranslationsEnrollmentEn {
	TranslationsEnrollmentEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Course Registration'
	String get registration_title => 'Course Registration';

	/// en: 'Financial Invoices'
	String get invoices_title => 'Financial Invoices';

	/// en: 'Tuition Payment'
	String get payment_title => 'Tuition Payment';

	/// en: 'Academic Advisor'
	String get advisor => 'Academic Advisor';

	/// en: 'Advisor Approval'
	String get advisor_approval => 'Advisor Approval';

	/// en: 'Dean Advisor Assignment'
	String get dean_assignment => 'Dean Advisor Assignment';

	/// en: 'Approve'
	String get approve => 'Approve';

	/// en: 'Reject'
	String get reject => 'Reject';

	/// en: 'Pending'
	String get pending => 'Pending';

	/// en: 'Approved'
	String get approved => 'Approved';

	/// en: 'Rejected'
	String get rejected => 'Rejected';

	/// en: 'Student Name'
	String get student_name => 'Student Name';

	/// en: 'Student ID'
	String get student_id => 'Student ID';

	/// en: 'College'
	String get college => 'College';

	/// en: 'Department'
	String get department => 'Department';

	/// en: 'Semester'
	String get semester => 'Semester';

	/// en: 'Credits'
	String get credits => 'Credits';

	/// en: 'Group'
	String get group => 'Group';

	/// en: 'Section'
	String get section => 'Section';

	/// en: 'Registration Date'
	String get registration_date => 'Registration Date';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'No requests found'
	String get no_requests => 'No requests found';

	/// en: 'Search students...'
	String get search_students => 'Search students...';

	/// en: 'All'
	String get filter_all => 'All';

	/// en: 'Pending'
	String get filter_pending => 'Pending';

	/// en: 'Approved'
	String get filter_approved => 'Approved';

	/// en: 'Rejected'
	String get filter_rejected => 'Rejected';

	/// en: 'Approve All'
	String get approve_all => 'Approve All';

	/// en: 'View Details'
	String get view_details => 'View Details';

	/// en: 'Advisor Name'
	String get advisor_name => 'Advisor Name';

	/// en: 'Assign'
	String get assign => 'Assign';

	/// en: 'Unassign'
	String get unassign => 'Unassign';

	/// en: 'Assigned'
	String get assigned => 'Assigned';

	/// en: 'Unassigned'
	String get unassigned => 'Unassigned';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Registration approved successfully'
	String get success_approve => 'Registration approved successfully';

	/// en: 'Registration rejected'
	String get success_reject => 'Registration rejected';

	/// en: 'Advisor assigned successfully'
	String get success_assign => 'Advisor assigned successfully';

	/// en: 'Error loading data'
	String get error_loading => 'Error loading data';

	/// en: 'Invoice ID'
	String get invoice_id => 'Invoice ID';

	/// en: 'Date'
	String get invoice_date => 'Date';

	/// en: 'Amount'
	String get invoice_amount => 'Amount';

	/// en: 'Status'
	String get invoice_status => 'Status';

	/// en: 'Paid'
	String get invoice_paid => 'Paid';

	/// en: 'Unpaid'
	String get invoice_unpaid => 'Unpaid';

	/// en: 'Overdue'
	String get invoice_overdue => 'Overdue';

	/// en: 'Pay Now'
	String get pay_now => 'Pay Now';

	/// en: 'Payment Method'
	String get payment_method => 'Payment Method';

	/// en: 'Credit Card'
	String get credit_card => 'Credit Card';

	/// en: 'Fawry'
	String get fawry => 'Fawry';

	/// en: 'Bank Transfer'
	String get bank_transfer => 'Bank Transfer';

	/// en: 'Payment successful'
	String get payment_success => 'Payment successful';

	/// en: 'Payment failed'
	String get payment_error => 'Payment failed';

	/// en: 'Outstanding Balance'
	String get outstanding_balance => 'Outstanding Balance';

	/// en: 'Total Paid'
	String get total_paid => 'Total Paid';

	/// en: 'No invoices found'
	String get no_invoices => 'No invoices found';

	/// en: 'Tuition Fee'
	String get tuition_fee => 'Tuition Fee';

	/// en: 'Registration Fee'
	String get registration_fee => 'Registration Fee';

	/// en: 'Late Fee'
	String get late_fee => 'Late Fee';

	/// en: 'Total'
	String get total => 'Total';

	/// en: 'Semester ${semester}'
	String semester_label({required Object semester}) => 'Semester ${semester}';

	/// en: 'Academic Year'
	String get academic_year => 'Academic Year';

	/// en: 'Submit Request'
	String get submit_request => 'Submit Request';

	/// en: 'Request submitted successfully'
	String get request_submitted => 'Request submitted successfully';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Academic Advisor'
	String get academic_advisor => 'Academic Advisor';

	/// en: 'Advisor Assignment'
	String get advisor_assignment => 'Advisor Assignment';

	/// en: 'Advisor: {name}'
	String get advisor_requestadvisorfullname => 'Advisor: {name}';

	/// en: 'Advisor Updated Successfully'
	String get advisor_updated_successfully => 'Advisor Updated Successfully';

	/// en: 'Approved'
	String get approved_1 => 'Approved';

	/// en: 'Approved — Courses Registered'
	String get approved_courses_registered => 'Approved — Courses Registered';

	/// en: 'Awaiting Advisor Review'
	String get awaiting_advisor_review => 'Awaiting Advisor Review';

	/// en: 'Choose Schedules'
	String get choose_schedules => 'Choose Schedules';

	/// en: 'Confirm & Submit'
	String get confirm_submit => 'Confirm & Submit';

	/// en: 'CR'
	String get cr => 'CR';

	/// en: 'Dormitory Fee'
	String get dormitory_fee => 'Dormitory Fee';

	/// en: 'Download'
	String get download => 'Download';

	/// en: 'Due'
	String get due => 'Due';

	/// en: 'Error Loading Summary'
	String get error_loading_summary => 'Error Loading Summary';

	/// en: 'Exam Fee'
	String get exam_fee => 'Exam Fee';

	/// en: 'Failed to Load Invoices'
	String get failed_to_load_invoices => 'Failed to Load Invoices';

	/// en: 'Financial Portal'
	String get financial_portal => 'Financial Portal';

	/// en: 'Financial Summary'
	String get financial_summary => 'Financial Summary';

	/// en: 'Help'
	String get help => 'Help';

	/// en: 'History'
	String get history => 'History';

	/// en: 'Invoices'
	String get invoices => 'Invoices';

	/// en: 'Library Fee'
	String get library_fee => 'Library Fee';

	/// en: 'Manage your tuition and payments'
	String get manage_your_tuition_and_paymen => 'Manage your tuition and payments';

	/// en: 'MMM dd, yyyy'
	String get mmm_dd_yyyy => 'MMM dd, yyyy';

	/// en: 'My Invoices'
	String get my_invoices => 'My Invoices';

	/// en: 'Next: Pick Schedules'
	String get next_pick_schedules => 'Next: Pick Schedules';

	/// en: 'No Advisor'
	String get no_advisor => 'No Advisor';

	/// en: 'No Invoices Found'
	String get no_invoices_found => 'No Invoices Found';

	/// en: 'No Requests Found'
	String get no_requests_found => 'No Requests Found';

	/// en: 'No schedules available for this course'
	String get no_schedules_available_for_thi => 'No schedules available for this course';

	/// en: 'No Students Found'
	String get no_students_found => 'No Students Found';

	/// en: 'Notes (Optional)'
	String get notes_optional => 'Notes (Optional)';

	/// en: 'Other'
	String get other => 'Other';

	/// en: 'Overdue'
	String get overdue => 'Overdue';

	/// en: 'Paid'
	String get paid => 'Paid';

	/// en: 'Partial'
	String get partial => 'Partial';

	/// en: 'Pay'
	String get pay => 'Pay';

	/// en: 'Pending Review'
	String get pending_review => 'Pending Review';

	/// en: 'Preparing PDF Statement...'
	String get preparing_pdf_statement => 'Preparing PDF Statement...';

	/// en: 'Registration Requests'
	String get registration_requests => 'Registration Requests';

	/// en: 'Remaining'
	String get remaining => 'Remaining';

	/// en: 'Request Rejected'
	String get request_rejected => 'Request Rejected';

	/// en: 'Requested Courses'
	String get requested_courses => 'Requested Courses';

	/// en: 'Re-Register'
	String get reregister => 'Re-Register';

	/// en: 'Review Final Timetable'
	String get review_final_timetable => 'Review Final Timetable';

	/// en: 'Review Registration'
	String get review_registration => 'Review Registration';

	/// en: 'Room'
	String get room => 'Room';

	/// en: 'Sec'
	String get sec => 'Sec';

	/// en: 'Select the subjects you want to register'
	String get select_the_subjects_you_want_t => 'Select the subjects you want to register';

	/// en: 'Select Your Courses'
	String get select_your_courses => 'Select Your Courses';

	/// en: 'Selected Schedule Summary'
	String get selected_schedule_summary => 'Selected Schedule Summary';

	/// en: 'Semester: {semester}'
	String get semester_requestsemester => 'Semester: {semester}';

	/// en: 'Sub'
	String get sub => 'Sub';

	/// en: '{count} Overdue'
	String get summaryoverduecount_overdue => '{count} Overdue';

	/// en: 'Total Invoices'
	String get total_invoices => 'Total Invoices';

	/// en: 'Unassigned Only'
	String get unassigned_only => 'Unassigned Only';

	/// en: 'Unpaid'
	String get unpaid => 'Unpaid';

	/// en: 'Withdrawn'
	String get withdrawn => 'Withdrawn';

	/// en: 'You have successfully registered your courses!'
	String get you_have_successfully_register => 'You have successfully registered your courses!';

	/// en: 'Your account is clear. No invoices found.'
	String get your_account_is_clearnno_invoi => 'Your account is clear. No invoices found.';
}

// Path: shared
class TranslationsSharedEn {
	TranslationsSharedEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Notifications'
	String get notifications => 'Notifications';

	/// en: 'No Notifications Yet'
	String get no_notifications_yet => 'No Notifications Yet';

	/// en: 'No new notifications'
	String get notifications_empty => 'No new notifications';

	/// en: 'Security Settings'
	String get security_title => 'Security Settings';

	/// en: 'Biometrics'
	String get biometrics_title => 'Biometrics';

	/// en: 'Fingerprint'
	String get fingerprint => 'Fingerprint';

	/// en: 'Face ID'
	String get face_id => 'Face ID';

	/// en: 'Enable Biometrics'
	String get enable_biometrics => 'Enable Biometrics';

	/// en: 'Active Sessions'
	String get sessions_title => 'Active Sessions';

	/// en: 'Current Session'
	String get current_session => 'Current Session';

	/// en: 'End Session'
	String get end_session => 'End Session';

	/// en: 'End All Sessions'
	String get end_all_sessions => 'End All Sessions';

	/// en: 'Device'
	String get device => 'Device';

	/// en: 'Location'
	String get location => 'Location';

	/// en: 'Last Active'
	String get last_active => 'Last Active';

	/// en: 'Support & Help'
	String get support_title => 'Support & Help';

	/// en: 'Contact Us'
	String get contact_us => 'Contact Us';

	/// en: 'Email Us'
	String get email_us => 'Email Us';

	/// en: 'Call Us'
	String get call_us => 'Call Us';

	/// en: 'WhatsApp'
	String get whatsapp => 'WhatsApp';

	/// en: 'FAQ'
	String get faq => 'FAQ';

	/// en: 'Report an Issue'
	String get report_issue => 'Report an Issue';

	/// en: 'Tutorials & Guides'
	String get tutorials_title => 'Tutorials & Guides';

	/// en: 'Forums'
	String get forums_title => 'Forums';

	/// en: 'Create Post'
	String get create_post => 'Create Post';

	/// en: 'Search forums...'
	String get search_forums => 'Search forums...';

	/// en: 'No posts found'
	String get no_posts => 'No posts found';

	/// en: 'Loading...'
	String get transition_title => 'Loading...';

	/// en: 'Coming Soon'
	String get placeholder_title => 'Coming Soon';

	/// en: 'This section is under development'
	String get placeholder_subtitle => 'This section is under development';

	/// en: 'Coming Soon'
	String get coming_soon => 'Coming Soon';

	/// en: 'This feature is under development'
	String get under_development => 'This feature is under development';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Close'
	String get close => 'Close';

	/// en: 'Cancel'
	String get cancel => 'Cancel';

	/// en: 'Confirm'
	String get confirm => 'Confirm';

	/// en: 'Save'
	String get save => 'Save';

	/// en: 'Delete'
	String get delete => 'Delete';

	/// en: 'Edit'
	String get edit => 'Edit';

	/// en: 'Active Sessions'
	String get active_sessions => 'Active Sessions';

	/// en: 'Authentication'
	String get authentication => 'Authentication';

	/// en: 'Biometric Login'
	String get biometric_login => 'Biometric Login';

	/// en: 'Call Hotline'
	String get call_hotline => 'Call Hotline';

	/// en: 'Change Password'
	String get change_password => 'Change Password';

	/// en: 'Device Management'
	String get device_management => 'Device Management';

	/// en: 'Email Support'
	String get email_support => 'Email Support';

	/// en: 'Financial Aid'
	String get financial_aid => 'Financial Aid';

	/// en: 'Forums'
	String get forums => 'Forums';

	/// en: 'IT Support'
	String get it_support => 'IT Support';

	/// en: 'Library'
	String get library => 'Library';

	/// en: 'Log Out'
	String get logout => 'Log Out';

	/// en: 'Manage logged-in devices'
	String get manage_logged_in_devices => 'Manage logged-in devices';

	/// en: 'Members'
	String get members => 'Members';

	/// en: 'Please Wait...'
	String get please_wait => 'Please Wait...';

	/// en: 'Protect account with 2FA'
	String get protect_account_with_2fa => 'Protect account with 2FA';

	/// en: 'Security'
	String get security => 'Security';

	/// en: 'Student Affairs'
	String get student_affairs => 'Student Affairs';

	/// en: 'Support'
	String get support => 'Support';

	/// en: 'This feature is under development'
	String get this_feature_is_under_developm => 'This feature is under development';

	/// en: 'Threads'
	String get threads => 'Threads';

	/// en: 'Tutorials'
	String get tutorials => 'Tutorials';

	/// en: 'Two-Factor Authentication'
	String get twofactor_auth => 'Two-Factor Authentication';

	/// en: 'Update your login credentials'
	String get update_your_login_credentials => 'Update your login credentials';

	/// en: 'Use fingerprint or Face ID'
	String get use_fingerprint_or_face_id => 'Use fingerprint or Face ID';

	/// en: 'View Active Sessions'
	String get view_active_sessions => 'View Active Sessions';

	/// en: 'Biometrics'
	String get biometrics => 'Biometrics';

	/// en: 'Sessions'
	String get sessions => 'Sessions';

	/// en: 'Security'
	String get security_section => 'Security';

	/// en: 'Support'
	String get support_section => 'Support';

	/// en: 'Contact Us'
	String get contact_us_section => 'Contact Us';

	/// en: 'Tutorials'
	String get tutorials_section => 'Tutorials';

	/// en: 'Forums'
	String get forums_section => 'Forums';

	/// en: 'No New Notifications'
	String get no_new_notifications => 'No New Notifications';

	/// en: 'Security Access'
	String get security_access => 'Security Access';
}

// Path: students
class TranslationsStudentsEn {
	TranslationsStudentsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Digital ID Card'
	String get digital_id_title => 'Digital ID Card';

	/// en: 'Student Name'
	String get student_name => 'Student Name';

	/// en: 'Student ID'
	String get student_id => 'Student ID';

	/// en: 'College'
	String get college => 'College';

	/// en: 'Department'
	String get department => 'Department';

	/// en: 'Level'
	String get level => 'Level';

	/// en: 'GPA'
	String get gpa => 'GPA';

	/// en: 'Credits'
	String get credits => 'Credits';

	/// en: 'Verified'
	String get verified => 'Verified';

	/// en: 'Horus University'
	String get university => 'Horus University';

	/// en: 'Download ID'
	String get download_id => 'Download ID';

	/// en: 'Share ID'
	String get share_id => 'Share ID';

	/// en: 'QR Code'
	String get qr_code => 'QR Code';

	/// en: 'Scan to verify'
	String get scan_to_verify => 'Scan to verify';

	/// en: 'ID Theme'
	String get id_theme => 'ID Theme';

	/// en: 'Classic'
	String get classic_theme => 'Classic';

	/// en: 'Gradient'
	String get gradient_theme => 'Gradient';

	/// en: 'Holographic'
	String get holographic_theme => 'Holographic';

	/// en: 'Dark Matter'
	String get dark_matter_theme => 'Dark Matter';

	/// en: 'Neon Pulse'
	String get neon_pulse_theme => 'Neon Pulse';

	/// en: 'Aurora'
	String get aurora_theme => 'Aurora';

	/// en: 'Student Dashboard'
	String get dashboard_title => 'Student Dashboard';

	/// en: 'Academic'
	String get academic_section => 'Academic';

	/// en: 'Enrollment'
	String get enrollment_section => 'Enrollment';

	/// en: 'Utilities'
	String get utilities_section => 'Utilities';

	/// en: 'Transcript'
	String get transcript => 'Transcript';

	/// en: 'Academic Progress'
	String get progress => 'Academic Progress';

	/// en: 'Degree Plan'
	String get action_plan => 'Degree Plan';

	/// en: 'Subject Results'
	String get subject_results => 'Subject Results';

	/// en: 'Grades'
	String get grades => 'Grades';

	/// en: 'Courses'
	String get courses => 'Courses';

	/// en: 'Schedule'
	String get schedule => 'Schedule';

	/// en: 'Exam Schedule'
	String get exam_schedule => 'Exam Schedule';

	/// en: 'Attendance'
	String get attendance => 'Attendance';

	/// en: 'Registration'
	String get registration => 'Registration';

	/// en: 'Invoices'
	String get invoices => 'Invoices';

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

	/// en: 'Digital ID'
	String get digital_id => 'Digital ID';

	/// en: 'No lectures today'
	String get no_lectures_today => 'No lectures today';

	/// en: 'View Full Schedule'
	String get view_full_schedule => 'View Full Schedule';

	/// en: 'Quick Stats'
	String get quick_stats => 'Quick Stats';

	/// en: 'GPA'
	String get gpa_label => 'GPA';

	/// en: 'Level'
	String get level_label => 'Level';

	/// en: 'Credits'
	String get credits_label => 'Credits';

	/// en: 'Upcoming Exams'
	String get upcoming_exams => 'Upcoming Exams';

	/// en: 'Recent Grades'
	String get recent_grades => 'Recent Grades';

	/// en: 'All'
	String get all => 'All';

	/// en: 'Loading...'
	String get loading => 'Loading...';

	/// en: 'Error'
	String get error => 'Error';

	/// en: 'Retry'
	String get retry => 'Retry';

	/// en: 'Back'
	String get back => 'Back';

	/// en: 'Academic'
	String get academic => 'Academic';

	/// en: 'Access Logs'
	String get access_logs => 'Access Logs';

	/// en: 'Active'
	String get active => 'Active';

	/// en: 'Artificial Intelligence'
	String get artificial_intelligence => 'Artificial Intelligence';

	/// en: 'Copy'
	String get copy => 'Copy';

	/// en: 'Daily Schedule'
	String get daily_schedule => 'Daily Schedule';

	/// en: 'Download'
	String get download => 'Download';

	/// en: 'Enrollment & Finance'
	String get enrollment_finance => 'Enrollment & Finance';

	/// en: 'Horus University'
	String get horus_university => 'Horus University';

	/// en: 'Horus University'
	String get horus_university_1 => 'Horus University';

	/// en: 'ID No.'
	String get id_no => 'ID No.';

	/// en: 'Identity Active & Secure'
	String get identity_active_secure => 'Identity Active & Secure';

	/// en: 'NFC Pass'
	String get nfc_pass => 'NFC Pass';

	/// en: 'Offline Copy'
	String get offline_copy => 'Offline Copy';

	/// en: 'Scan for Secure Access'
	String get scan_for_secure_access => 'Scan for Secure Access';

	/// en: 'Send'
	String get send => 'Send';

	/// en: 'Settings'
	String get settings => 'Settings';

	/// en: 'Share Identity'
	String get share_identity => 'Share Identity';

	/// en: 'Smart Digital ID'
	String get smart_digital_id => 'Smart Digital ID';

	/// en: 'Status'
	String get status => 'Status';

	/// en: 'Student'
	String get student => 'Student';

	/// en: 'Utilities'
	String get utilities => 'Utilities';
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

	/// en: 'Choose Account Recovery Method'
	String get choose_account_recovery_method => 'Choose Account Recovery Method';

	/// en: 'Back to Login'
	String get back_to_login => 'Back to Login';
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

	/// en: 'Test Notifications'
	String get test_notifications => 'Test Notifications';

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

// Path: administration.audit_logs
class TranslationsAdministrationAuditLogsEn {
	TranslationsAdministrationAuditLogsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Audit Logs'
	String get title => 'Audit Logs';

	/// en: 'No logs found matching the criteria.'
	String get no_logs_found => 'No logs found matching the criteria.';

	late final TranslationsAdministrationAuditLogsTabsEn tabs = TranslationsAdministrationAuditLogsTabsEn._(_root);
	late final TranslationsAdministrationAuditLogsLabelsEn labels = TranslationsAdministrationAuditLogsLabelsEn._(_root);
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

// Path: administration.audit_logs.tabs
class TranslationsAdministrationAuditLogsTabsEn {
	TranslationsAdministrationAuditLogsTabsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'All Logs'
	String get all => 'All Logs';

	/// en: 'Security'
	String get security => 'Security';

	/// en: 'User Management'
	String get user_management => 'User Management';

	/// en: 'Data Updates'
	String get data_updates => 'Data Updates';
}

// Path: administration.audit_logs.labels
class TranslationsAdministrationAuditLogsLabelsEn {
	TranslationsAdministrationAuditLogsLabelsEn._(this._root);

	final Translations _root; // ignore: unused_field

	// Translations

	/// en: 'Actor'
	String get actor => 'Actor';

	/// en: 'Table'
	String get table => 'Table';

	/// en: 'Record'
	String get record => 'Record';

	/// en: 'Action'
	String get action => 'Action';

	/// en: 'Old Data'
	String get old_data => 'Old Data';

	/// en: 'New Data'
	String get new_data => 'New Data';

	/// en: 'Notes'
	String get notes => 'Notes';

	/// en: 'Performed By'
	String get performed_by => 'Performed By';

	/// en: 'Close Details'
	String get close_details => 'Close Details';

	/// en: 'View Details'
	String get view_details => 'View Details';
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
			'welcome.student_portal' => 'Student Portal',
			'welcome.welcome_to_the_smart_universit' => 'Welcome to the Smart University',
			'welcome.i_already_have_an_account' => 'I already have an account',
			'onboarding.title' => 'Onboarding',
			'onboarding.language.title' => 'Choose your language',
			'onboarding.language.subtitle' => 'اختر لغتك المفضلة',
			'onboarding.language.english' => 'English',
			'onboarding.language.arabic' => 'العربية',
			'onboarding.language.german' => 'Deutsch',
			'onboarding.language.chinese' => '中文',
			'onboarding.language.hint' => 'You can change this later in settings\nيمكنك تغيير هذا لاحقاً في الإعدادات',
			'onboarding.choose_language' => 'Choose Your Language',
			'onboarding.you_can_change_this_later_in_s' => 'You can change this later in Settings',
			'onboarding.choose_app_style' => 'Choose Your App Style',
			'onboarding.you_can_switch_styles_later_in' => 'You can switch styles later in Settings',
			'onboarding.choose_app_theme' => 'Choose Your Theme',
			'onboarding.select_the_lighting_that_suits' => 'Select the lighting that suits you best',
			'onboarding.classic_solid' => 'Classic',
			'onboarding.high_performance_flat_solid_co' => 'High-performance flat solid colors',
			'onboarding.modern_glass' => 'Modern Glass',
			'onboarding.premium_frosted_glass_blur_eff' => 'Premium frosted glass blur effect',
			'onboarding.almost_there_just_one_more_ste' => 'Almost there! Just one more step.',
			'onboarding.recommended' => 'Recommended',
			'onboarding.light_mode' => 'Light Mode',
			'onboarding.dark_mode' => 'Dark Mode',
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
			'auth.forgot_password.choose_account_recovery_method' => 'Choose Account Recovery Method',
			'auth.forgot_password.back_to_login' => 'Back to Login',
			'auth.back' => 'Back',
			'auth.choose_account_recovery_method' => 'Choose Account Recovery Method',
			'home.tabs.home' => 'Home',
			'home.tabs.colleges' => 'Colleges',
			'home.tabs.student' => 'Student',
			'home.tabs.admin' => 'Admin',
			'home.tabs.search' => 'Search',
			'home.tabs.notifications' => 'Notifications',
			'home.tabs.profile' => 'Profile',
			'home.home' => 'Home',
			'home.colleges' => 'Colleges',
			'home.student' => 'Student',
			'home.prof' => 'Professor',
			'home.admin' => 'Admin',
			'home.admin_portal' => 'Admin Portal',
			'home.faculty_portal' => 'Faculty Portal',
			'home.student_portal' => 'Student Portal',
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
			'settings.tiles.test_notifications' => 'Test Notifications',
			'settings.tiles.about_app' => 'About App',
			'settings.tiles.privacy_policy' => 'Privacy Policy',
			'settings.tiles.logout' => 'Logout',
			'settings.messages.switching_theme' => 'Switching Theme...',
			'settings.messages.changing_language' => 'Changing Language...',
			'settings.messages.rebuilding_design' => 'Rebuilding Design System...',
			'settings.user' => 'User',
			'settings.about_app' => 'About App',
			'settings.university' => 'Horus University',
			'settings.horus_university' => 'Horus University - Egypt',
			'settings.developer' => 'Developer',
			'settings.platform' => 'Platform',
			'settings.backend' => 'Backend',
			'settings.hue_portal_is_a_comprehensive_' => 'HUE Portal is a comprehensive smart university management system.',
			'settings.change_password' => 'Change Password',
			'settings.please_fill_all_fields' => 'Please fill all fields',
			'settings.password_must_be_at_least_6_ch' => 'Password must be at least 6 characters',
			'settings.passwords_do_not_match' => 'Passwords do not match',
			'settings.password_changed_successfully' => 'Password changed successfully',
			'settings.enter_your_new_password' => 'Enter your new password below',
			'settings.new_password' => 'New Password',
			'settings.confirm_password' => 'Confirm Password',
			'settings.privacy_policy' => 'Privacy Policy',
			'settings.last_updated_february_2026' => 'Last updated: February 2026',
			'settings.edit_profile' => 'Edit Profile',
			'settings.save' => 'Save',
			'settings.full_name' => 'Full Name',
			'settings.email' => 'Email',
			'settings.phone' => 'Phone',
			'settings.bio' => 'Bio',
			'settings.role' => 'Role',
			'settings.update_your_info_and_contact_d' => 'Update your info and contact details',
			'settings.change_password_and_security_l' => 'Change password and security level',
			'settings.forgot_password' => 'Forgot Password',
			'settings.send_password_recovery_link_to' => 'Send password recovery link to your email',
			'settings.toggle_between_dark_and_light_' => 'Toggle between dark and light mode',
			'settings.current_glass_design' => 'Current: Glass Design',
			'settings.current_classic_design' => 'Current: Classic Design',
			'settings.switch_style' => 'Switch Style',
			'settings.control_the_types_of_incoming_' => 'Control the types of incoming notifications',
			'settings.send_a_test_notification' => 'Send a test notification',
			'settings.test_notification_successful' => 'Test notification sent successfully!',
			'settings.battery_saver_mode' => 'Battery Saver Mode',
			'settings.disable_complex_visual_effects' => 'Disable complex visual effects for better performance',
			'settings.help_support_center' => 'Help & Support Center',
			'settings.contact_us_to_resolve_any_issu' => 'Contact us to resolve any issue',
			'settings.version_details_and_developers' => 'Version details and developer info',
			'settings.terms_and_rules_for_data_usage' => 'Terms and rules for data usage',
			'settings.select_app_language' => 'Select App Language',
			'settings.deutsch' => 'Deutsch',
			'settings.dynamic_val' => 'Dynamic',
			'settings.kSwitch' => 'Switch',
			'settings.switch_label' => 'Switch',
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
			'administration.audit_logs.title' => 'Audit Logs',
			'administration.audit_logs.no_logs_found' => 'No logs found matching the criteria.',
			'administration.audit_logs.tabs.all' => 'All Logs',
			'administration.audit_logs.tabs.security' => 'Security',
			'administration.audit_logs.tabs.user_management' => 'User Management',
			'administration.audit_logs.tabs.data_updates' => 'Data Updates',
			'administration.audit_logs.labels.actor' => 'Actor',
			'administration.audit_logs.labels.table' => 'Table',
			'administration.audit_logs.labels.record' => 'Record',
			'administration.audit_logs.labels.action' => 'Action',
			'administration.audit_logs.labels.old_data' => 'Old Data',
			'administration.audit_logs.labels.new_data' => 'New Data',
			'administration.audit_logs.labels.notes' => 'Notes',
			'administration.audit_logs.labels.performed_by' => 'Performed By',
			'administration.audit_logs.labels.close_details' => 'Close Details',
			'administration.audit_logs.labels.view_details' => 'View Details',
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
			_ => null,
		} ?? switch (path) {
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
			'academic.academic_progress' => 'Academic Progress',
			'academic.university_requirements' => 'University Requirements',
			'academic.faculty_requirements' => 'Faculty Requirements',
			'academic.major_requirements' => 'Major Requirements',
			'academic.electives' => 'Electives',
			'academic.completed' => 'Completed',
			'academic.remaining' => 'Remaining',
			'academic.transcript_title' => 'Academic Transcript',
			'academic.grades_title' => 'Grades',
			'academic.courses_title' => 'My Courses',
			'academic.action_plan_title' => 'Degree Action Plan',
			'academic.subject_results_title' => 'Subject Results',
			'academic.attendance_title' => 'Attendance',
			'academic.schedule_title' => 'Schedule',
			'academic.exam_schedule_title' => 'Exam Schedule',
			'academic.professor_dashboard' => 'Professor Dashboard',
			'academic.all_students' => 'All Students',
			'academic.groups' => 'Groups',
			'academic.tas' => 'Teaching Assistants',
			'academic.no_groups' => 'No Groups',
			'academic.office_hours' => 'Office Hours',
			'academic.chat' => 'Chat',
			'academic.courses' => 'Courses',
			'academic.assignments' => 'Assignments',
			'academic.feedback' => 'Feedback',
			'academic.view_all' => 'View All',
			'academic.active' => 'Active',
			'academic.inactive' => 'Inactive',
			'academic.add_ta' => 'Add TA',
			'academic.remove_ta' => 'Remove TA',
			'academic.send_message' => 'Send Message',
			'academic.urgent_announcement' => 'Urgent Announcement',
			'academic.upload_file' => 'Upload File',
			'academic.section' => 'Section',
			'academic.group_label' => 'Group',
			'academic.all' => 'All',
			'academic.manage_groups' => 'Manage Groups',
			'academic.manage_tas' => 'Manage TAs',
			'academic.profile' => 'Profile',
			'academic.semester_grades' => 'Semester Grades',
			'academic.grade_summary' => 'Grade Summary',
			'academic.gpa' => 'GPA',
			'academic.credits' => 'Credits',
			'academic.midterm' => 'Midterm',
			'academic.kFinal' => 'Final Exam',
			'academic.practical' => 'Practical',
			'academic.total' => 'Total',
			'academic.year_1' => 'Year 1',
			'academic.year_2' => 'Year 2',
			'academic.year_3' => 'Year 3',
			'academic.year_4' => 'Year 4',
			'academic.enrolled' => 'Enrolled',
			'academic.available' => 'Available',
			'academic.instructor' => 'Instructor',
			'academic.schedule_info' => 'Schedule',
			'academic.time' => 'Time',
			'academic.room' => 'Room',
			'academic.duration' => 'Duration',
			'academic.seat' => 'Seat',
			'academic.exam_date' => 'Exam Date',
			'academic.present' => 'Present',
			'academic.absent' => 'Absent',
			'academic.late' => 'Late',
			'academic.ratio' => 'Ratio',
			'academic.loading' => 'Loading...',
			'academic.error' => 'Error',
			'academic.retry' => 'Retry',
			'academic.no_data' => 'No data available',
			'academic.back' => 'Back',
			'academic.search' => 'Search',
			'academic.filter' => 'Filter',
			'academic.save' => 'Save',
			'academic.cancel' => 'Cancel',
			'academic.confirm' => 'Confirm',
			'academic.delete' => 'Delete',
			'academic.edit' => 'Edit',
			'academic.add' => 'Add',
			'academic.remove' => 'Remove',
			'academic.send' => 'Send',
			'academic.close' => 'Close',
			'academic.academic_journey' => 'Academic Journey',
			'academic.academic_results' => 'Academic Results',
			'academic.academic_standing_excellent' => 'Excellent',
			'academic.across_all_groups' => 'Across All Groups',
			'academic.action_plan' => 'Degree Action Plan',
			'academic.add_new_ta' => 'Add New TA',
			'academic.add_to_calendar' => 'Add to Calendar',
			'academic.added_successfully' => 'Added Successfully',
			'academic.advanced_learning' => 'Advanced Learning',
			'academic.advanced_mathematics' => 'Advanced Mathematics',
			'academic.advisor_assignment' => 'Advisor Assignment',
			'academic.algorithms' => 'Algorithms',
			'academic.are_you_sure_you_want_to_remov' => 'Are you sure you want to remove this TA?',
			'academic.artificial_intelligence' => 'Artificial Intelligence',
			'academic.calculus_i' => 'Calculus I',
			'academic.clicked' => 'Clicked',
			'academic.code_review' => 'Code Review',
			'academic.comp_organization' => 'Computer Organization',
			'academic.completed_1' => 'Completed',
			'academic.completion_rate' => 'Completion Rate',
			'academic.computer_programming' => 'Computer Programming',
			'academic.confirm_removal' => 'Confirm Removal',
			'academic.course_management' => 'Course Management',
			'academic.coursework' => 'Coursework',
			'academic.credits_1' => 'Credits',
			'academic.cs402_artificial_intelligence' => 'CS402 Artificial Intelligence',
			'academic.cs405_machine_learning' => 'CS405 Machine Learning',
			'academic.cs410_computer_vision' => 'CS410 Computer Vision',
			'academic.cumulative_gpa' => 'Cumulative GPA',
			'academic.d_mmmm' => 'd MMMM',
			'academic.data_structures' => 'Data Structures',
			'academic.database_systems' => 'Database Systems',
			'academic.days' => 'Days',
			'academic.deep_learning' => 'Deep Learning',
			'academic.dr_ada_lovelace' => 'Dr. Ada Lovelace',
			'academic.dr_alan_turing' => 'Dr. Alan Turing',
			'academic.dr_robert_smith' => 'Dr. Robert Smith',
			'academic.dr_sarah_ahmed' => 'Dr. Sarah Ahmed',
			'academic.english_composition' => 'English Composition',
			'academic.ethics_in_it' => 'Ethics in IT',
			'academic.exam_schedule' => 'Exam Schedule',
			'academic.fall_2023' => 'Fall 2023',
			'academic.field_internship' => 'Field Internship',
			'academic.file_title' => 'File Title',
			'academic.file_will_be_uploaded_to_cloud' => 'File will be uploaded to cloud storage',
			'academic.final_exam' => 'Final Exam',
			'academic.foundational_skills' => 'Foundational Skills',
			'academic.frontend_ui' => 'Frontend UI',
			'academic.general_physics' => 'General Physics',
			'academic.graduation_mastery' => 'Graduation Mastery',
			'academic.graduation_progress' => 'Graduation Progress',
			'academic.graduation_project' => 'Graduation Project',
			'academic.hall_1' => 'Hall 1',
			'academic.hall_4' => 'Hall 4',
			'academic.hours' => 'Hours',
			'academic.hum210_professional_ethics' => 'HUM210 Professional Ethics',
			'academic.intro_to_ai' => 'Intro to AI',
			'academic.intro_to_programming' => 'Intro to Programming',
			'academic.joined' => 'Joined',
			'academic.lab_12' => 'Lab 12',
			'academic.lab_final' => 'Lab Final',
			'academic.lecture' => 'Lecture',
			'academic.lecture_hall_2' => 'Lecture Hall 2',
			'academic.linear_algebra' => 'Linear Algebra',
			'academic.live' => 'Live',
			'academic.live_now' => 'Live Now',
			'academic.logic_design' => 'Logic Design',
			'academic.machine_learning' => 'Machine Learning',
			'academic.mat301_advanced_calculus' => 'MAT301 Advanced Calculus',
			'academic.mathematics' => 'Mathematics',
			'academic.members' => 'Members',
			'academic.messages' => 'Messages',
			'academic.midterm_exam' => 'Midterm Exam',
			'academic.mins' => 'Mins',
			'academic.network_security' => 'Network Security',
			'academic.next_exam_in' => 'Next Exam In',
			'academic.no_available_tas_currently' => 'No Available TAs Currently',
			'academic.no_exams_on_this_day' => 'No Exams on This Day',
			'academic.no_tas_assigned_yet' => 'No TAs Assigned Yet',
			'academic.overall_attendance' => 'Overall Attendance',
			'academic.overall_progress' => 'Overall Progress',
			'academic.performance_distribution' => 'Performance Distribution',
			'academic.points' => 'Points',
			'academic.practical_project' => 'Practical Project',
			'academic.prof_john_doe' => 'Prof. John Doe',
			'academic.programming_basics' => 'Programming Basics',
			'academic.progress' => 'Progress',
			'academic.psychology' => 'Psychology',
			'academic.quick_actions' => 'Quick Actions',
			'academic.quiz_1' => 'Quiz 1',
			'academic.quiz_2' => 'Quiz 2',
			'academic.rank' => 'Rank',
			'academic.rating' => 'Rating',
			'academic.registration_requests' => 'Registration Requests',
			'academic.removed_successfully' => 'Removed Successfully',
			'academic.results_analysis' => 'Results Analysis',
			'academic.score' => 'Score',
			'academic.select_a_ta_from_the_list_to_a' => 'Select a TA from the list to add',
			'academic.sessions_this_week' => 'Sessions This Week',
			'academic.shared_files' => 'Shared Files',
			'academic.sophomore' => 'Sophomore',
			'academic.specialization_projects' => 'Specialization Projects',
			'academic.spring_2024' => 'Spring 2024',
			'academic.start_by_adding_the_first_ta_f' => 'Start by adding the first TA for your course',
			'academic.students' => 'Students',
			'academic.summer_2024' => 'Summer 2024',
			'academic.ta_team_chat' => 'TA Team Chat',
			'academic.total_students' => 'Total Students',
			'academic.track_project_i' => 'Track Project I',
			'academic.type_a_message' => 'Type a message...',
			'academic.upload' => 'Upload',
			'academic.upload_files' => 'Upload Files',
			'academic.upload_new_file' => 'Upload New File',
			'academic.uploaded_successfully' => 'Uploaded Successfully',
			'academic.urgent_news' => 'Urgent News',
			'academic.web_programming' => 'Web Programming',
			'admin.eeee_mmmm_dd_yyyy' => 'EEEE, MMMM dd, yyyy',
			'admin.en' => 'en',
			'admin.system_online' => 'SYSTEM ONLINE',
			'admin.admin_command_center' => 'Admin Command Center',
			'admin.admin' => 'Admin',
			'admin.live_statistics' => 'Live Statistics',
			'admin.students' => 'Students',
			'admin.staff' => 'Staff',
			'admin.faculty' => 'Faculty',
			'admin.leadership' => 'Leadership',
			'admin.admin_it' => 'Admin & IT',
			'admin.system_modules' => 'System Modules',
			'admin.users' => 'Users',
			'admin.manage_all_accounts' => 'Manage all accounts',
			'admin.colleges' => 'Colleges',
			'admin.manage_faculties' => 'Manage faculties',
			'admin.departments' => 'Departments',
			'admin.academic_departments' => 'Academic departments',
			'admin.professors' => 'Professors',
			'admin.faculty_members' => 'Faculty members',
			'admin.roles' => 'Roles',
			'admin.permission_management' => 'Permission management',
			'admin.audit_logs' => 'Audit Logs',
			'admin.system_activity_log' => 'System activity log',
			'admin.system_settings' => 'System Settings',
			'admin.platform_configuration' => 'Platform configuration',
			'admin.performance' => 'Performance',
			'admin.server_health_metrics' => 'Server health metrics',
			'admin.system_pulse' => 'System Pulse',
			'admin.server' => 'Server',
			'admin.online' => 'Online',
			'admin.latency' => 'Latency',
			'admin.database' => 'Database',
			'admin.active' => 'Active',
			'admin.status' => 'Status',
			'admin.realtime_latency_ms' => 'REALTIME LATENCY (MS)',
			'admin.role_breakdown' => 'Role Breakdown',
			'admin.teaching_staff' => 'Teaching Staff',
			'admin.academic_leadership' => 'Academic Leadership',
			'admin.student_affairs' => 'Student Affairs',
			'admin.total_users' => 'Total Users',
			'admin.system_health' => 'System Health',
			'admin.quick_actions' => 'Quick Actions',
			'admin.management' => 'Management',
			'admin.add_user' => 'Add User',
			'admin.export_data' => 'Export Data',
			'admin.send_announcement' => 'Send Announcement',
			'admin.backup_system' => 'Backup System',
			'admin.user_management' => 'User Management',
			'admin.user_list' => 'User List',
			'admin.filter_all' => 'All',
			'admin.filter_students' => 'Students',
			'admin.filter_staff' => 'Staff',
			'admin.filter_admin' => 'Admin',
			'admin.search_users' => 'Search users...',
			'admin.no_users' => 'No users found',
			'admin.user_count' => ({required Object count}) => '${count} users',
			'admin.student_management' => 'Student Management',
			'admin.staff_management' => 'Staff Management',
			'admin.faculty_management' => 'Faculty Management',
			'admin.leadership_management' => 'Leadership Management',
			'admin.admin_it_management' => 'Admin & IT Management',
			'admin.college_management' => 'College Management',
			'admin.department_management' => 'Department Management',
			'admin.professor_management' => 'Professor Management',
			'admin.role_management' => 'Role Management',
			'admin.audit_log_management' => 'Audit Log Management',
			'admin.system_configuration' => 'System Configuration',
			'admin.add_college' => 'Add College',
			'admin.add_department' => 'Add Department',
			'admin.edit_college' => 'Edit College',
			'admin.edit_department' => 'Edit Department',
			'admin.delete_college' => 'Delete College',
			'admin.delete_department' => 'Delete Department',
			'admin.college_name' => 'College Name',
			'admin.department_name' => 'Department Name',
			'admin.dean_name' => 'Dean Name',
			'admin.head_name' => 'Head Name',
			'admin.student_count' => 'Students',
			'admin.staff_count' => 'Staff',
			'admin.ta_count' => 'TAs',
			'admin.action' => 'Action',
			'admin.timestamp' => 'Timestamp',
			'admin.user' => 'User',
			'admin.details' => 'Details',
			'admin.filter_by_action' => 'Filter by action',
			'admin.filter_by_date' => 'Filter by date',
			'admin.no_logs' => 'No audit logs found',
			'admin.system_version' => 'System Version',
			'admin.maintenance_mode' => 'Maintenance Mode',
			'admin.backup_schedule' => 'Backup Schedule',
			'admin.email_server' => 'Email Server',
			'admin.storage_quota' => 'Storage Quota',
			'admin.security_level' => 'Security Level',
			'admin.log_retention' => 'Log Retention',
			'admin.session_timeout' => 'Session Timeout',
			'admin.save_settings' => 'Save Settings',
			'admin.reset_defaults' => 'Reset to Defaults',
			'admin.user_name' => 'Name',
			'admin.user_email' => 'Email',
			'admin.user_phone' => 'Phone',
			'admin.user_role' => 'Role',
			'admin.user_department' => 'Department',
			'admin.user_college' => 'College',
			'admin.user_status' => 'Status',
			'admin.user_created' => 'Created',
			'admin.user_updated' => 'User updated successfully',
			'admin.add_new_user' => 'Add New User',
			'admin.edit_user' => 'Edit User',
			'admin.delete_user' => 'Delete User',
			'admin.save_user' => 'Save',
			'admin.cancel' => 'Cancel',
			'admin.name_label' => 'Full Name',
			'admin.email_label' => 'Email Address',
			'admin.phone_label' => 'Phone Number',
			'admin.role_label' => 'Select Role',
			'admin.department_label' => 'Department',
			'admin.college_label' => 'College',
			'admin.password_label' => 'Password',
			'admin.confirm_password_label' => 'Confirm Password',
			'admin.category_student' => 'Student',
			'admin.category_staff' => 'Staff',
			'admin.category_faculty' => 'Faculty',
			'admin.category_leadership' => 'Leadership',
			'admin.category_admin' => 'Admin',
			'admin.no_departments' => 'No departments available',
			'admin.no_colleges' => 'No colleges available',
			'admin.select_role' => 'Select a role',
			'admin.select_department' => 'Select a department',
			'admin.select_college' => 'Select a college',
			'admin.user_added' => 'User added successfully',
			'admin.user_deleted' => 'User deleted successfully',
			'admin.confirm_delete' => 'Confirm Delete',
			'admin.confirm_delete_message' => 'Are you sure you want to delete this user?',
			'admin.error_loading' => 'Error loading data',
			'admin.error_saving' => 'Error saving data',
			'admin.retry' => 'Retry',
			'admin.academic_department' => 'Academic Department',
			'admin.academic_departments_1' => 'Academic Departments',
			'admin.academic_leaders' => 'Academic Leaders',
			'admin.academic_warnings' => 'Academic Warnings',
			'admin.account_status' => 'Account Status',
			'admin.account_verification' => 'Account Verification',
			'admin.actor' => 'Actor',
			'admin.add_report' => 'Add Report',
			'admin.admins' => 'Admins',
			'admin.advanced_management' => 'Advanced Management',
			'admin.all' => 'All',
			'admin.all_levels' => 'All Levels',
			'admin.all_systems_operational' => 'All Systems Operational',
			'admin.apply_filters' => 'Apply Filters',
			'admin.are_you_sure_you_want_to_delet' => 'Are you sure you want to delete this user?',
			'admin.assign' => 'Assign',
			'admin.assign_dean' => 'Assign Dean',
			'admin.assign_department_head' => 'Assign Department Head',
			'admin.attached_report' => 'Attached Report',
			'admin.ban_user' => 'Ban User',
			'admin.banned' => 'Banned',
			'admin.change' => 'Change',
			'admin.change_dean' => 'Change Dean',
			'admin.changes_saved_successfully' => 'Changes Saved Successfully',
			'admin.college' => 'College',
			'admin.college_dean' => 'College Dean',
			'admin.college_details' => 'College Details',
			'admin.colleges_management' => 'Colleges Management',
			'admin.coming_soon' => 'Coming Soon',
			'admin.deactivated' => 'Deactivated',
			'admin.delete' => 'Delete',
			'admin.department_details' => 'Department Details',
			'admin.department_projects' => 'Department Projects',
			'admin.departments_management' => 'Departments Management',
			'admin.email_address' => 'Email Address',
			'admin.entity' => 'Entity',
			'admin.error_snapshoterror' => 'Error: {error}',
			'admin.faculty_members_1' => 'Faculty Members',
			'admin.failed_to_load_data' => 'Failed to Load Data',
			'admin.filter_users' => 'Filter Users',
			'admin.full_name' => 'Full Name',
			'admin.head_of_department' => 'Head of Department',
			'admin.incidents' => 'Incidents',
			'admin.leadership_stats' => 'Leadership Statistics',
			'admin.level_level' => 'Level {level}',
			'admin.manage_tags' => 'Manage Tags',
			'admin.min_6_chars' => 'Min. 6 characters',
			'admin.national_id' => 'National ID',
			'admin.nationality' => 'Nationality',
			'admin.no_about_text_available' => 'No About Text Available',
			'admin.no_colleges_found' => 'No Colleges Found',
			'admin.no_dean_assigned' => 'No Dean Assigned',
			'admin.no_departments_found' => 'No Departments Found',
			'admin.no_departments_in_this_college' => 'No Departments in This College',
			'admin.no_description_available' => 'No Description Available',
			'admin.no_faculty_records_found' => 'No Faculty Records Found',
			'admin.no_head_assigned' => 'No Head Assigned',
			'admin.no_logs_found' => 'No Logs Found',
			'admin.no_matching_students_found' => 'No Matching Students Found',
			'admin.no_projects_added_yet' => 'No Projects Added Yet',
			'admin.no_settings_found_in_the_datab' => 'No settings found in the database',
			'admin.no_users_found' => 'No Users Found',
			'admin.office' => 'Office',
			'admin.password' => 'Password',
			'admin.pending_reg' => 'Pending Registration',
			'admin.permanently_delete_user' => 'Permanently Delete User',
			'admin.phone_number' => 'Phone Number',
			'admin.please_assign_a_dean_for_the_c' => 'Please assign a dean for this college',
			'admin.please_assign_a_head_for_the_d' => 'Please assign a head for this department',
			'admin.roles_management' => 'Roles Management',
			'admin.save' => 'Save',
			'admin.save_changes' => 'Save Changes',
			'admin.search_by_name_email_phone_id' => 'Search by name, email, phone or ID...',
			'admin.search_doctor_name' => 'Search doctor name...',
			'admin.search_staff_member' => 'Search staff member...',
			'admin.search_student_or_id' => 'Search student or ID...',
			'admin.select' => 'Select',
			'admin.select_role_in_widgetinitialca' => 'Select role',
			'admin.select_role_permission' => 'Select Role / Permission',
			'admin.separate_tags_with_commas' => 'Separate tags with commas',
			'admin.servers' => 'Servers',
			'admin.student_id' => 'Student ID',
			'admin.system_technical_status' => 'System Technical Status',
			'admin.tag1_tag2' => 'tag1, tag2',
			'admin.teaching_assistants' => 'Teaching Assistants',
			'admin.total_staff' => 'Total Staff',
			'admin.total_students' => 'Total Students',
			'admin.unverified' => 'Unverified',
			'admin.user_roles_ranks' => 'User Roles & Ranks',
			'admin.verification' => 'Verification',
			'admin.verified' => 'Verified',
			'admin.warning_level' => 'Warning Level',
			'admin.you_can_manage_professors_and_' => 'You can manage professors and more here',
			'enrollment.registration_title' => 'Course Registration',
			'enrollment.invoices_title' => 'Financial Invoices',
			'enrollment.payment_title' => 'Tuition Payment',
			'enrollment.advisor' => 'Academic Advisor',
			'enrollment.advisor_approval' => 'Advisor Approval',
			'enrollment.dean_assignment' => 'Dean Advisor Assignment',
			'enrollment.approve' => 'Approve',
			'enrollment.reject' => 'Reject',
			'enrollment.pending' => 'Pending',
			'enrollment.approved' => 'Approved',
			'enrollment.rejected' => 'Rejected',
			'enrollment.student_name' => 'Student Name',
			'enrollment.student_id' => 'Student ID',
			'enrollment.college' => 'College',
			'enrollment.department' => 'Department',
			'enrollment.semester' => 'Semester',
			'enrollment.credits' => 'Credits',
			'enrollment.group' => 'Group',
			'enrollment.section' => 'Section',
			'enrollment.registration_date' => 'Registration Date',
			'enrollment.status' => 'Status',
			'enrollment.no_requests' => 'No requests found',
			'enrollment.search_students' => 'Search students...',
			'enrollment.filter_all' => 'All',
			'enrollment.filter_pending' => 'Pending',
			'enrollment.filter_approved' => 'Approved',
			'enrollment.filter_rejected' => 'Rejected',
			'enrollment.approve_all' => 'Approve All',
			'enrollment.view_details' => 'View Details',
			'enrollment.advisor_name' => 'Advisor Name',
			'enrollment.assign' => 'Assign',
			'enrollment.unassign' => 'Unassign',
			'enrollment.assigned' => 'Assigned',
			'enrollment.unassigned' => 'Unassigned',
			'enrollment.save' => 'Save',
			'enrollment.cancel' => 'Cancel',
			'enrollment.success_approve' => 'Registration approved successfully',
			'enrollment.success_reject' => 'Registration rejected',
			'enrollment.success_assign' => 'Advisor assigned successfully',
			'enrollment.error_loading' => 'Error loading data',
			'enrollment.invoice_id' => 'Invoice ID',
			'enrollment.invoice_date' => 'Date',
			'enrollment.invoice_amount' => 'Amount',
			'enrollment.invoice_status' => 'Status',
			'enrollment.invoice_paid' => 'Paid',
			'enrollment.invoice_unpaid' => 'Unpaid',
			'enrollment.invoice_overdue' => 'Overdue',
			'enrollment.pay_now' => 'Pay Now',
			'enrollment.payment_method' => 'Payment Method',
			'enrollment.credit_card' => 'Credit Card',
			'enrollment.fawry' => 'Fawry',
			'enrollment.bank_transfer' => 'Bank Transfer',
			'enrollment.payment_success' => 'Payment successful',
			'enrollment.payment_error' => 'Payment failed',
			'enrollment.outstanding_balance' => 'Outstanding Balance',
			'enrollment.total_paid' => 'Total Paid',
			'enrollment.no_invoices' => 'No invoices found',
			'enrollment.tuition_fee' => 'Tuition Fee',
			'enrollment.registration_fee' => 'Registration Fee',
			'enrollment.late_fee' => 'Late Fee',
			'enrollment.total' => 'Total',
			'enrollment.semester_label' => ({required Object semester}) => 'Semester ${semester}',
			'enrollment.academic_year' => 'Academic Year',
			'enrollment.submit_request' => 'Submit Request',
			'enrollment.request_submitted' => 'Request submitted successfully',
			'enrollment.all' => 'All',
			'enrollment.loading' => 'Loading...',
			'enrollment.retry' => 'Retry',
			'enrollment.academic_advisor' => 'Academic Advisor',
			_ => null,
		} ?? switch (path) {
			'enrollment.advisor_assignment' => 'Advisor Assignment',
			'enrollment.advisor_requestadvisorfullname' => 'Advisor: {name}',
			'enrollment.advisor_updated_successfully' => 'Advisor Updated Successfully',
			'enrollment.approved_1' => 'Approved',
			'enrollment.approved_courses_registered' => 'Approved — Courses Registered',
			'enrollment.awaiting_advisor_review' => 'Awaiting Advisor Review',
			'enrollment.choose_schedules' => 'Choose Schedules',
			'enrollment.confirm_submit' => 'Confirm & Submit',
			'enrollment.cr' => 'CR',
			'enrollment.dormitory_fee' => 'Dormitory Fee',
			'enrollment.download' => 'Download',
			'enrollment.due' => 'Due',
			'enrollment.error_loading_summary' => 'Error Loading Summary',
			'enrollment.exam_fee' => 'Exam Fee',
			'enrollment.failed_to_load_invoices' => 'Failed to Load Invoices',
			'enrollment.financial_portal' => 'Financial Portal',
			'enrollment.financial_summary' => 'Financial Summary',
			'enrollment.help' => 'Help',
			'enrollment.history' => 'History',
			'enrollment.invoices' => 'Invoices',
			'enrollment.library_fee' => 'Library Fee',
			'enrollment.manage_your_tuition_and_paymen' => 'Manage your tuition and payments',
			'enrollment.mmm_dd_yyyy' => 'MMM dd, yyyy',
			'enrollment.my_invoices' => 'My Invoices',
			'enrollment.next_pick_schedules' => 'Next: Pick Schedules',
			'enrollment.no_advisor' => 'No Advisor',
			'enrollment.no_invoices_found' => 'No Invoices Found',
			'enrollment.no_requests_found' => 'No Requests Found',
			'enrollment.no_schedules_available_for_thi' => 'No schedules available for this course',
			'enrollment.no_students_found' => 'No Students Found',
			'enrollment.notes_optional' => 'Notes (Optional)',
			'enrollment.other' => 'Other',
			'enrollment.overdue' => 'Overdue',
			'enrollment.paid' => 'Paid',
			'enrollment.partial' => 'Partial',
			'enrollment.pay' => 'Pay',
			'enrollment.pending_review' => 'Pending Review',
			'enrollment.preparing_pdf_statement' => 'Preparing PDF Statement...',
			'enrollment.registration_requests' => 'Registration Requests',
			'enrollment.remaining' => 'Remaining',
			'enrollment.request_rejected' => 'Request Rejected',
			'enrollment.requested_courses' => 'Requested Courses',
			'enrollment.reregister' => 'Re-Register',
			'enrollment.review_final_timetable' => 'Review Final Timetable',
			'enrollment.review_registration' => 'Review Registration',
			'enrollment.room' => 'Room',
			'enrollment.sec' => 'Sec',
			'enrollment.select_the_subjects_you_want_t' => 'Select the subjects you want to register',
			'enrollment.select_your_courses' => 'Select Your Courses',
			'enrollment.selected_schedule_summary' => 'Selected Schedule Summary',
			'enrollment.semester_requestsemester' => 'Semester: {semester}',
			'enrollment.sub' => 'Sub',
			'enrollment.summaryoverduecount_overdue' => '{count} Overdue',
			'enrollment.total_invoices' => 'Total Invoices',
			'enrollment.unassigned_only' => 'Unassigned Only',
			'enrollment.unpaid' => 'Unpaid',
			'enrollment.withdrawn' => 'Withdrawn',
			'enrollment.you_have_successfully_register' => 'You have successfully registered your courses!',
			'enrollment.your_account_is_clearnno_invoi' => 'Your account is clear. No invoices found.',
			'shared.notifications' => 'Notifications',
			'shared.no_notifications_yet' => 'No Notifications Yet',
			'shared.notifications_empty' => 'No new notifications',
			'shared.security_title' => 'Security Settings',
			'shared.biometrics_title' => 'Biometrics',
			'shared.fingerprint' => 'Fingerprint',
			'shared.face_id' => 'Face ID',
			'shared.enable_biometrics' => 'Enable Biometrics',
			'shared.sessions_title' => 'Active Sessions',
			'shared.current_session' => 'Current Session',
			'shared.end_session' => 'End Session',
			'shared.end_all_sessions' => 'End All Sessions',
			'shared.device' => 'Device',
			'shared.location' => 'Location',
			'shared.last_active' => 'Last Active',
			'shared.support_title' => 'Support & Help',
			'shared.contact_us' => 'Contact Us',
			'shared.email_us' => 'Email Us',
			'shared.call_us' => 'Call Us',
			'shared.whatsapp' => 'WhatsApp',
			'shared.faq' => 'FAQ',
			'shared.report_issue' => 'Report an Issue',
			'shared.tutorials_title' => 'Tutorials & Guides',
			'shared.forums_title' => 'Forums',
			'shared.create_post' => 'Create Post',
			'shared.search_forums' => 'Search forums...',
			'shared.no_posts' => 'No posts found',
			'shared.transition_title' => 'Loading...',
			'shared.placeholder_title' => 'Coming Soon',
			'shared.placeholder_subtitle' => 'This section is under development',
			'shared.coming_soon' => 'Coming Soon',
			'shared.under_development' => 'This feature is under development',
			'shared.back' => 'Back',
			'shared.retry' => 'Retry',
			'shared.loading' => 'Loading...',
			'shared.error' => 'Error',
			'shared.close' => 'Close',
			'shared.cancel' => 'Cancel',
			'shared.confirm' => 'Confirm',
			'shared.save' => 'Save',
			'shared.delete' => 'Delete',
			'shared.edit' => 'Edit',
			'shared.active_sessions' => 'Active Sessions',
			'shared.authentication' => 'Authentication',
			'shared.biometric_login' => 'Biometric Login',
			'shared.call_hotline' => 'Call Hotline',
			'shared.change_password' => 'Change Password',
			'shared.device_management' => 'Device Management',
			'shared.email_support' => 'Email Support',
			'shared.financial_aid' => 'Financial Aid',
			'shared.forums' => 'Forums',
			'shared.it_support' => 'IT Support',
			'shared.library' => 'Library',
			'shared.logout' => 'Log Out',
			'shared.manage_logged_in_devices' => 'Manage logged-in devices',
			'shared.members' => 'Members',
			'shared.please_wait' => 'Please Wait...',
			'shared.protect_account_with_2fa' => 'Protect account with 2FA',
			'shared.security' => 'Security',
			'shared.student_affairs' => 'Student Affairs',
			'shared.support' => 'Support',
			'shared.this_feature_is_under_developm' => 'This feature is under development',
			'shared.threads' => 'Threads',
			'shared.tutorials' => 'Tutorials',
			'shared.twofactor_auth' => 'Two-Factor Authentication',
			'shared.update_your_login_credentials' => 'Update your login credentials',
			'shared.use_fingerprint_or_face_id' => 'Use fingerprint or Face ID',
			'shared.view_active_sessions' => 'View Active Sessions',
			'shared.biometrics' => 'Biometrics',
			'shared.sessions' => 'Sessions',
			'shared.security_section' => 'Security',
			'shared.support_section' => 'Support',
			'shared.contact_us_section' => 'Contact Us',
			'shared.tutorials_section' => 'Tutorials',
			'shared.forums_section' => 'Forums',
			'shared.no_new_notifications' => 'No New Notifications',
			'shared.security_access' => 'Security Access',
			'students.digital_id_title' => 'Digital ID Card',
			'students.student_name' => 'Student Name',
			'students.student_id' => 'Student ID',
			'students.college' => 'College',
			'students.department' => 'Department',
			'students.level' => 'Level',
			'students.gpa' => 'GPA',
			'students.credits' => 'Credits',
			'students.verified' => 'Verified',
			'students.university' => 'Horus University',
			'students.download_id' => 'Download ID',
			'students.share_id' => 'Share ID',
			'students.qr_code' => 'QR Code',
			'students.scan_to_verify' => 'Scan to verify',
			'students.id_theme' => 'ID Theme',
			'students.classic_theme' => 'Classic',
			'students.gradient_theme' => 'Gradient',
			'students.holographic_theme' => 'Holographic',
			'students.dark_matter_theme' => 'Dark Matter',
			'students.neon_pulse_theme' => 'Neon Pulse',
			'students.aurora_theme' => 'Aurora',
			'students.dashboard_title' => 'Student Dashboard',
			'students.academic_section' => 'Academic',
			'students.enrollment_section' => 'Enrollment',
			'students.utilities_section' => 'Utilities',
			'students.transcript' => 'Transcript',
			'students.progress' => 'Academic Progress',
			'students.action_plan' => 'Degree Plan',
			'students.subject_results' => 'Subject Results',
			'students.grades' => 'Grades',
			'students.courses' => 'Courses',
			'students.schedule' => 'Schedule',
			'students.exam_schedule' => 'Exam Schedule',
			'students.attendance' => 'Attendance',
			'students.registration' => 'Registration',
			'students.invoices' => 'Invoices',
			'students.payment' => 'Payment',
			'students.tutorials' => 'Tutorials',
			'students.security' => 'Security',
			'students.forums' => 'Forums',
			'students.support' => 'Support',
			'students.notifications' => 'Notifications',
			'students.digital_id' => 'Digital ID',
			'students.no_lectures_today' => 'No lectures today',
			'students.view_full_schedule' => 'View Full Schedule',
			'students.quick_stats' => 'Quick Stats',
			'students.gpa_label' => 'GPA',
			'students.level_label' => 'Level',
			'students.credits_label' => 'Credits',
			'students.upcoming_exams' => 'Upcoming Exams',
			'students.recent_grades' => 'Recent Grades',
			'students.all' => 'All',
			'students.loading' => 'Loading...',
			'students.error' => 'Error',
			'students.retry' => 'Retry',
			'students.back' => 'Back',
			'students.academic' => 'Academic',
			'students.access_logs' => 'Access Logs',
			'students.active' => 'Active',
			'students.artificial_intelligence' => 'Artificial Intelligence',
			'students.copy' => 'Copy',
			'students.daily_schedule' => 'Daily Schedule',
			'students.download' => 'Download',
			'students.enrollment_finance' => 'Enrollment & Finance',
			'students.horus_university' => 'Horus University',
			'students.horus_university_1' => 'Horus University',
			'students.id_no' => 'ID No.',
			'students.identity_active_secure' => 'Identity Active & Secure',
			'students.nfc_pass' => 'NFC Pass',
			'students.offline_copy' => 'Offline Copy',
			'students.scan_for_secure_access' => 'Scan for Secure Access',
			'students.send' => 'Send',
			'students.settings' => 'Settings',
			'students.share_identity' => 'Share Identity',
			'students.smart_digital_id' => 'Smart Digital ID',
			'students.status' => 'Status',
			'students.student' => 'Student',
			'students.utilities' => 'Utilities',
			_ => null,
		};
	}
}

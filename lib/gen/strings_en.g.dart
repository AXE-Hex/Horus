part of 'strings.g.dart';

typedef TranslationsEn = Translations;

class Translations with BaseTranslations<AppLocale, Translations> {
  static Translations of(BuildContext context) =>
      InheritedLocaleData.of<AppLocale, Translations>(context).translations;

  Translations({
    Map<String, Node>? overrides,
    PluralResolver? cardinalResolver,
    PluralResolver? ordinalResolver,
    TranslationMetadata<AppLocale, Translations>? meta,
  }) : assert(
         overrides == null,
         'Set "translation_overrides: true" in order to enable this feature.',
       ),
       $meta =
           meta ??
           TranslationMetadata(
             locale: AppLocale.en,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  dynamic operator [](String key) => $meta.getTranslation(key);

  late final Translations _root = this;

  Translations $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => Translations(meta: meta ?? this.$meta);

  late final TranslationsCommonEn common = TranslationsCommonEn._(_root);
  late final TranslationsWelcomeEn welcome = TranslationsWelcomeEn._(_root);
  late final TranslationsOnboardingEn onboarding = TranslationsOnboardingEn._(
    _root,
  );
  late final TranslationsAuthEn auth = TranslationsAuthEn._(_root);
  late final TranslationsHomeEn home = TranslationsHomeEn._(_root);
  late final TranslationsFeedEn feed = TranslationsFeedEn._(_root);
  late final TranslationsDashboardEn dashboard = TranslationsDashboardEn._(
    _root,
  );
  late final TranslationsSettingsEn settings = TranslationsSettingsEn._(_root);
  late final TranslationsCollegesEn colleges = TranslationsCollegesEn._(_root);
  late final TranslationsTranscriptEn transcript = TranslationsTranscriptEn._(
    _root,
  );
  late final TranslationsAcademicProgressEn academic_progress =
      TranslationsAcademicProgressEn._(_root);
  late final TranslationsGradesEn grades = TranslationsGradesEn._(_root);
  late final TranslationsSubjectResultsEn subject_results =
      TranslationsSubjectResultsEn._(_root);
  late final TranslationsActionPlanEn action_plan = TranslationsActionPlanEn._(
    _root,
  );
  late final TranslationsCoursesEn courses = TranslationsCoursesEn._(_root);
  late final TranslationsScheduleEn schedule = TranslationsScheduleEn._(_root);
  late final TranslationsExamScheduleEn exam_schedule =
      TranslationsExamScheduleEn._(_root);
  late final TranslationsAttendanceEn attendance = TranslationsAttendanceEn._(
    _root,
  );
  late final TranslationsRegistrationEn registration =
      TranslationsRegistrationEn._(_root);
  late final TranslationsPaymentEn payment = TranslationsPaymentEn._(_root);
  late final TranslationsInvoicesEn invoices = TranslationsInvoicesEn._(_root);
  late final TranslationsNotificationsEn notifications =
      TranslationsNotificationsEn._(_root);
  late final TranslationsSupportEn support = TranslationsSupportEn._(_root);
  late final TranslationsSecurityEn security = TranslationsSecurityEn._(_root);
  late final TranslationsTutorialsEn tutorials = TranslationsTutorialsEn._(
    _root,
  );
  late final TranslationsForumsEn forums = TranslationsForumsEn._(_root);
  late final TranslationsAdministrationEn administration =
      TranslationsAdministrationEn._(_root);
  late final TranslationsProfessorEn professor = TranslationsProfessorEn._(
    _root,
  );
  late final TranslationsRolesEn roles = TranslationsRolesEn._(_root);
  late final TranslationsAcademicEn academic = TranslationsAcademicEn._(_root);
  late final TranslationsAdminEn admin = TranslationsAdminEn._(_root);
  late final TranslationsEnrollmentEn enrollment = TranslationsEnrollmentEn._(
    _root,
  );
  late final TranslationsSharedEn shared = TranslationsSharedEn._(_root);
  late final TranslationsStudentsEn students = TranslationsStudentsEn._(_root);
  late final TranslationsExtractedEn extracted = TranslationsExtractedEn._(
    _root,
  );
}

class TranslationsCommonEn {
  TranslationsCommonEn._(this._root);

  final Translations _root;

  String get close => 'Close';

  String get cancel => 'Cancel';

  String get confirm => 'Confirm';

  String get save => 'Save';

  String get back => 'Back';
}

class TranslationsWelcomeEn {
  TranslationsWelcomeEn._(this._root);

  final Translations _root;

  String get title => 'Welcome To Hue';

  String get subtitle => 'Light up your world with meaningful connections.';

  String get get_started => 'Get Started';

  String get have_account => 'I already have an account';

  String get student_portal => 'HUE Portal';

  String get welcome_to_the_smart_universit =>
      'Welcome to the Smart University';

  String get i_already_have_an_account => 'I already have an account';
}

class TranslationsOnboardingEn {
  TranslationsOnboardingEn._(this._root);

  final Translations _root;

  String get title => 'Onboarding';

  late final TranslationsOnboardingLanguageEn language =
      TranslationsOnboardingLanguageEn._(_root);

  String get choose_language => 'Choose Your Language';

  String get you_can_change_this_later_in_s =>
      'You can change this later in Settings';

  String get choose_app_style => 'Choose Your App Style';

  String get you_can_switch_styles_later_in =>
      'You can switch styles later in Settings';

  String get choose_app_theme => 'Choose Your Theme';

  String get select_the_lighting_that_suits =>
      'Select the lighting that suits you best';

  String get classic_solid => 'Classic';

  String get high_performance_flat_solid_co =>
      'High-performance flat solid colors';

  String get modern_glass => 'Modern Glass';

  String get premium_frosted_glass_blur_eff =>
      'Premium frosted glass blur effect';

  String get almost_there_just_one_more_ste =>
      'Almost there! Just one more step.';

  String get recommended => 'Recommended';

  String get light_mode => 'Light Mode';

  String get dark_mode => 'Dark Mode';

  late final TranslationsOnboardingFacultiesDirectoryEn faculties_directory =
      TranslationsOnboardingFacultiesDirectoryEn._(_root);
  late final TranslationsOnboardingStyleEn style =
      TranslationsOnboardingStyleEn._(_root);
  late final TranslationsOnboardingThemeEn theme =
      TranslationsOnboardingThemeEn._(_root);
}

class TranslationsAuthEn {
  TranslationsAuthEn._(this._root);

  final Translations _root;

  late final TranslationsAuthLoginEn login = TranslationsAuthLoginEn._(_root);
  late final TranslationsAuthForgotPasswordEn forgot_password =
      TranslationsAuthForgotPasswordEn._(_root);

  String get back => 'Back';

  String get choose_account_recovery_method => 'Choose Account Recovery Method';
}

class TranslationsHomeEn {
  TranslationsHomeEn._(this._root);

  final Translations _root;

  late final TranslationsHomeTabsEn tabs = TranslationsHomeTabsEn._(_root);

  String get home => 'Home';

  String get colleges => 'Colleges';

  String get student => 'Student';

  String get prof => 'Professor';

  String get admin => 'Admin';

  String get admin_portal => 'Admin Portal';

  String get faculty_portal => 'Faculty Portal';

  String get student_portal => 'Student Portal';
}

class TranslationsFeedEn {
  TranslationsFeedEn._(this._root);

  final Translations _root;

  String get likes => 'likes';

  String get caption_sample => 'This is a sample caption for post';

  String get hours_ago => 'hours ago';
}

class TranslationsDashboardEn {
  TranslationsDashboardEn._(this._root);

  final Translations _root;

  late final TranslationsDashboardIdCardEn id_card =
      TranslationsDashboardIdCardEn._(_root);
  late final TranslationsDashboardSectionsEn sections =
      TranslationsDashboardSectionsEn._(_root);
  late final TranslationsDashboardItemsEn items =
      TranslationsDashboardItemsEn._(_root);
  late final TranslationsDashboardLabelsEn labels =
      TranslationsDashboardLabelsEn._(_root);
}

class TranslationsSettingsEn {
  TranslationsSettingsEn._(this._root);

  final Translations _root;

  String get title => 'Settings';

  late final TranslationsSettingsSectionsEn sections =
      TranslationsSettingsSectionsEn._(_root);
  late final TranslationsSettingsTilesEn tiles = TranslationsSettingsTilesEn._(
    _root,
  );
  late final TranslationsSettingsMessagesEn messages =
      TranslationsSettingsMessagesEn._(_root);

  String get user => 'User';

  String get about_app => 'About App';

  String get university => 'Horus University';

  String get horus_university => 'Horus University - Egypt';

  String get developer => 'Developer';

  String get platform => 'Platform';

  String get backend => 'Backend';

  String get hue_portal_is_a_comprehensive_ =>
      'HUE Portal is a comprehensive smart university management system.';

  String get change_password => 'Change Password';

  String get please_fill_all_fields => 'Please fill all fields';

  String get password_must_be_at_least_6_ch =>
      'Password must be at least 6 characters';

  String get passwords_do_not_match => 'Passwords do not match';

  String get password_changed_successfully => 'Password changed successfully';

  String get enter_your_new_password => 'Enter your new password below';

  String get new_password => 'New Password';

  String get confirm_password => 'Confirm Password';

  String get privacy_policy => 'Privacy Policy';

  String get last_updated_february_2026 => 'Last updated: February 2026';

  String get edit_profile => 'Edit Profile';

  String get save => 'Save';

  String get full_name => 'Full Name';

  String get email => 'Email';

  String get phone => 'Phone';

  String get bio => 'Bio';

  String get role => 'Role';

  String get update_your_info_and_contact_d =>
      'Update your info and contact details';

  String get change_password_and_security_l =>
      'Change password and security level';

  String get forgot_password => 'Forgot Password';

  String get send_password_recovery_link_to =>
      'Send password recovery link to your email';

  String get toggle_between_dark_and_light_ =>
      'Toggle between dark and light mode';

  String get current_glass_design => 'Current: Glass Design';

  String get current_classic_design => 'Current: Classic Design';

  String get switch_style => 'Switch Style';

  String get control_the_types_of_incoming_ =>
      'Control the types of incoming notifications';

  String get send_a_test_notification => 'Send a test notification';

  String get test_notification_successful =>
      'Test notification sent successfully!';

  String get battery_saver_mode => 'Battery Saver Mode';

  String get disable_complex_visual_effects =>
      'Disable complex visual effects for better performance';

  String get help_support_center => 'Help & Support Center';

  String get contact_us_to_resolve_any_issu =>
      'Contact us to resolve any issue';

  String get version_details_and_developers =>
      'Version details and developer info';

  String get terms_and_rules_for_data_usage => 'Terms and rules for data usage';

  String get select_app_language => 'Select App Language';

  String get deutsch => 'Deutsch';

  String get dynamic_val => 'Dynamic';

  String get kSwitch => 'Switch';

  String get switch_label => 'Switch';
}

class TranslationsCollegesEn {
  TranslationsCollegesEn._(this._root);

  final Translations _root;

  late final TranslationsCollegesDetailsEn details =
      TranslationsCollegesDetailsEn._(_root);

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

  late final TranslationsCollegesDepartmentsEn departments =
      TranslationsCollegesDepartmentsEn._(_root);
}

class TranslationsTranscriptEn {
  TranslationsTranscriptEn._(this._root);

  final Translations _root;

  String get title => 'Academic Transcript';

  late final TranslationsTranscriptOverviewEn overview =
      TranslationsTranscriptOverviewEn._(_root);
  late final TranslationsTranscriptSemesterEn semester =
      TranslationsTranscriptSemesterEn._(_root);
  late final TranslationsTranscriptCourseEn course =
      TranslationsTranscriptCourseEn._(_root);
}

class TranslationsAcademicProgressEn {
  TranslationsAcademicProgressEn._(this._root);

  final Translations _root;

  String get title => 'Academic Progress';

  String get completion => 'Degree Completion';

  String get total_credits => 'Total Credits';

  late final TranslationsAcademicProgressCategoriesEn categories =
      TranslationsAcademicProgressCategoriesEn._(_root);
  late final TranslationsAcademicProgressStatusEn status =
      TranslationsAcademicProgressStatusEn._(_root);
}

class TranslationsGradesEn {
  TranslationsGradesEn._(this._root);

  final Translations _root;

  String get title => 'Semester Grades';

  String get summary => 'Grade Summary';

  String get cumulative_gpa => 'Cumulative GPA';

  String get gpa => 'Semester GPA';

  String get credits => 'Credits';

  String get grade_point => 'Grade Point';

  String get letter_grade => 'Letter Grade';
}

class TranslationsSubjectResultsEn {
  TranslationsSubjectResultsEn._(this._root);

  final Translations _root;

  String get title => 'Subject Results';

  String get midterm => 'Midterm';

  String get kFinal => 'Final Exam';

  String get practical => 'Practical/Lab';

  String get activities => 'Semester Activities';

  String get total => 'Total Score';
}

class TranslationsActionPlanEn {
  TranslationsActionPlanEn._(this._root);

  final Translations _root;

  String get title => 'Degree Action Plan';

  String get roadmap => 'Course Roadmap';

  String get year_1 => 'Freshman Year';

  String get year_2 => 'Sophomore Year';

  String get year_3 => 'Junior Year';

  String get year_4 => 'Senior Year';
}

class TranslationsCoursesEn {
  TranslationsCoursesEn._(this._root);

  final Translations _root;

  String get title => 'My Courses';

  String get enrolled => 'Enrolled';

  String get available => 'Available';

  String get instructor => 'Instructor';

  String get schedule => 'Schedule';
}

class TranslationsScheduleEn {
  TranslationsScheduleEn._(this._root);

  final Translations _root;

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
  TranslationsExamScheduleEn._(this._root);

  final Translations _root;

  String get title => 'Exam Schedule';

  String get date => 'Date';

  String get duration => 'Duration';

  String get seat => 'Seat Number';
}

class TranslationsAttendanceEn {
  TranslationsAttendanceEn._(this._root);

  final Translations _root;

  String get title => 'Attendance Statistics';

  String get present => 'Present';

  String get absent => 'Absent';

  String get late => 'Late';

  String get ratio => 'Attendance Ratio';

  late final TranslationsAttendanceSubjectsEn subjects =
      TranslationsAttendanceSubjectsEn._(_root);
}

class TranslationsRegistrationEn {
  TranslationsRegistrationEn._(this._root);

  final Translations _root;

  String get title => 'Course Registration';

  String get submit => 'Submit Registration';

  String get enrolled_credits => 'Enrolled Credits';

  String get step1_title => 'Step 1: Choose Main Group';

  String get step1_subtitle =>
      'Select the main group you wish to register for this semester.';

  String group_label({required Object group}) => 'Group ${group}';

  String get main_cohort => 'Main cohort registration';

  String get step2_title => 'Step 2: Choose Sub-section';

  String step2_subtitle({required Object group}) =>
      'Selected Group: ${group}. Now select your practical sub-section.';

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

  String success_message({required Object group, required Object section}) =>
      'You have successfully registered for this semester.\nGroup: ${group} | Section: ${section}';

  String get back_home => 'Back to Home';

  String get registration_success => 'Registration Successful!';

  String error_loading({required Object error}) =>
      'Error: ${error}\n\nTap to retry';
}

class TranslationsPaymentEn {
  TranslationsPaymentEn._(this._root);

  final Translations _root;

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
  TranslationsInvoicesEn._(this._root);

  final Translations _root;

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
  TranslationsNotificationsEn._(this._root);

  final Translations _root;

  String get title => 'Notifications';

  String get empty => 'No new notifications';
}

class TranslationsSupportEn {
  TranslationsSupportEn._(this._root);

  final Translations _root;

  String get title => 'Support & Help';

  String get contact_us => 'Contact Us';
}

class TranslationsSecurityEn {
  TranslationsSecurityEn._(this._root);

  final Translations _root;

  String get title => 'Security';

  String get biometrics => 'Biometrics';

  String get sessions => 'Active Sessions';
}

class TranslationsTutorialsEn {
  TranslationsTutorialsEn._(this._root);

  final Translations _root;

  String get title => 'Tutorials & Guides';
}

class TranslationsForumsEn {
  TranslationsForumsEn._(this._root);

  final Translations _root;

  String get title => 'Forums';
}

class TranslationsAdministrationEn {
  TranslationsAdministrationEn._(this._root);

  final Translations _root;

  String get title => 'Student Management';

  String get stats => 'System Stats';

  String get users => 'Users';

  String get reports => 'Reports';

  late final TranslationsAdministrationAuditLogsEn audit_logs =
      TranslationsAdministrationAuditLogsEn._(_root);
}

class TranslationsProfessorEn {
  TranslationsProfessorEn._(this._root);

  final Translations _root;

  String get dashboard_title => 'Professor Dashboard';

  String welcome_back_name({required Object name}) => 'Welcome back, ${name}';

  String active_tas_count({required Object count}) => '${count} Active TAs';

  String total_students_count({required Object count}) =>
      '${count} Total Students';

  String uploaded_files_count({required Object count}) =>
      '${count} Uploaded Files';

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

  late final TranslationsProfessorStatsEn stats =
      TranslationsProfessorStatsEn._(_root);
  late final TranslationsProfessorQuickActionsEn quick_actions =
      TranslationsProfessorQuickActionsEn._(_root);
  late final TranslationsProfessorProfileEn profile =
      TranslationsProfessorProfileEn._(_root);
}

class TranslationsRolesEn {
  TranslationsRolesEn._(this._root);

  final Translations _root;

  late final TranslationsRolesCategoriesEn categories =
      TranslationsRolesCategoriesEn._(_root);
  late final TranslationsRolesNamesEn names = TranslationsRolesNamesEn._(_root);
  late final TranslationsRolesDescriptionsEn descriptions =
      TranslationsRolesDescriptionsEn._(_root);
}

class TranslationsAcademicEn {
  TranslationsAcademicEn._(this._root);

  final Translations _root;

  String get academic_progress => 'Academic Progress';

  String get university_requirements => 'University Requirements';

  String get faculty_requirements => 'Faculty Requirements';

  String get major_requirements => 'Major Requirements';

  String get electives => 'Electives';

  String get completed => 'Completed';

  String get remaining => 'Remaining';

  String get transcript_title => 'Academic Transcript';

  String get grades_title => 'Grades';

  String get courses_title => 'My Courses';

  String get action_plan_title => 'Degree Action Plan';

  String get subject_results_title => 'Subject Results';

  String get attendance_title => 'Attendance';

  String get schedule_title => 'Schedule';

  String get exam_schedule_title => 'Exam Schedule';

  String get professor_dashboard => 'Professor Dashboard';

  String get all_students => 'All Students';

  String get groups => 'Groups';

  String get tas => 'Teaching Assistants';

  String get no_groups => 'No Groups';

  String get office_hours => 'Office Hours';

  String get chat => 'Chat';

  String get courses => 'Courses';

  String get assignments => 'Assignments';

  String get feedback => 'Feedback';

  String get view_all => 'View All';

  String get active => 'Active';

  String get inactive => 'Inactive';

  String get add_ta => 'Add TA';

  String get remove_ta => 'Remove TA';

  String get send_message => 'Send Message';

  String get urgent_announcement => 'Urgent Announcement';

  String get upload_file => 'Upload File';

  String get section => 'Section';

  String get group_label => 'Group';

  String get all => 'All';

  String get manage_groups => 'Manage Groups';

  String get manage_tas => 'Manage TAs';

  String get profile => 'Profile';

  String get semester_grades => 'Semester Grades';

  String get grade_summary => 'Grade Summary';

  String get gpa => 'GPA';

  String get credits => 'Credits';

  String get midterm => 'Midterm';

  String get kFinal => 'Final Exam';

  String get practical => 'Practical';

  String get total => 'Total';

  String get year_1 => 'Year 1';

  String get year_2 => 'Year 2';

  String get year_3 => 'Year 3';

  String get year_4 => 'Year 4';

  String get enrolled => 'Enrolled';

  String get available => 'Available';

  String get instructor => 'Instructor';

  String get schedule_info => 'Schedule';

  String get time => 'Time';

  String get room => 'Room';

  String get duration => 'Duration';

  String get seat => 'Seat';

  String get exam_date => 'Exam Date';

  String get present => 'Present';

  String get absent => 'Absent';

  String get late => 'Late';

  String get ratio => 'Ratio';

  String get loading => 'Loading...';

  String get error => 'Error';

  String get retry => 'Retry';

  String get no_data => 'No data available';

  String get back => 'Back';

  String get search => 'Search';

  String get filter => 'Filter';

  String get save => 'Save';

  String get cancel => 'Cancel';

  String get confirm => 'Confirm';

  String get delete => 'Delete';

  String get edit => 'Edit';

  String get add => 'Add';

  String get remove => 'Remove';

  String get send => 'Send';

  String get close => 'Close';

  String get academic_journey => 'Academic Journey';

  String get academic_results => 'Academic Results';

  String get academic_standing_excellent => 'Excellent';

  String get across_all_groups => 'Across All Groups';

  String get action_plan => 'Degree Action Plan';

  String get add_new_ta => 'Add New TA';

  String get add_to_calendar => 'Add to Calendar';

  String get added_successfully => 'Added Successfully';

  String get advanced_learning => 'Advanced Learning';

  String get advanced_mathematics => 'Advanced Mathematics';

  String get advisor_assignment => 'Advisor Assignment';

  String get algorithms => 'Algorithms';

  String get are_you_sure_you_want_to_remov =>
      'Are you sure you want to remove this TA?';

  String get artificial_intelligence => 'Artificial Intelligence';

  String get calculus_i => 'Calculus I';

  String get clicked => 'Clicked';

  String get code_review => 'Code Review';

  String get comp_organization => 'Computer Organization';

  String get completed_1 => 'Completed';

  String get completion_rate => 'Completion Rate';

  String get computer_programming => 'Computer Programming';

  String get confirm_removal => 'Confirm Removal';

  String get course_management => 'Course Management';

  String get coursework => 'Coursework';

  String get credits_1 => 'Credits';

  String get cs402_artificial_intelligence => 'CS402 Artificial Intelligence';

  String get cs405_machine_learning => 'CS405 Machine Learning';

  String get cs410_computer_vision => 'CS410 Computer Vision';

  String get cumulative_gpa => 'Cumulative GPA';

  String get d_mmmm => 'd MMMM';

  String get data_structures => 'Data Structures';

  String get database_systems => 'Database Systems';

  String get days => 'Days';

  String get deep_learning => 'Deep Learning';

  String get dr_ada_lovelace => 'Dr. Ada Lovelace';

  String get dr_alan_turing => 'Dr. Alan Turing';

  String get dr_robert_smith => 'Dr. Robert Smith';

  String get dr_sarah_ahmed => 'Dr. Sarah Ahmed';

  String get english_composition => 'English Composition';

  String get ethics_in_it => 'Ethics in IT';

  String get exam_schedule => 'Exam Schedule';

  String get fall_2023 => 'Fall 2023';

  String get field_internship => 'Field Internship';

  String get file_title => 'File Title';

  String get file_will_be_uploaded_to_cloud =>
      'File will be uploaded to cloud storage';

  String get final_exam => 'Final Exam';

  String get foundational_skills => 'Foundational Skills';

  String get frontend_ui => 'Frontend UI';

  String get general_physics => 'General Physics';

  String get graduation_mastery => 'Graduation Mastery';

  String get graduation_progress => 'Graduation Progress';

  String get graduation_project => 'Graduation Project';

  String get hall_1 => 'Hall 1';

  String get hall_4 => 'Hall 4';

  String get hours => 'Hours';

  String get hum210_professional_ethics => 'HUM210 Professional Ethics';

  String get intro_to_ai => 'Intro to AI';

  String get intro_to_programming => 'Intro to Programming';

  String get joined => 'Joined';

  String get lab_12 => 'Lab 12';

  String get lab_final => 'Lab Final';

  String get lecture => 'Lecture';

  String get lecture_hall_2 => 'Lecture Hall 2';

  String get linear_algebra => 'Linear Algebra';

  String get live => 'Live';

  String get live_now => 'Live Now';

  String get logic_design => 'Logic Design';

  String get machine_learning => 'Machine Learning';

  String get mat301_advanced_calculus => 'MAT301 Advanced Calculus';

  String get mathematics => 'Mathematics';

  String get members => 'Members';

  String get messages => 'Messages';

  String get midterm_exam => 'Midterm Exam';

  String get mins => 'Mins';

  String get network_security => 'Network Security';

  String get next_exam_in => 'Next Exam In';

  String get no_available_tas_currently => 'No Available TAs Currently';

  String get no_exams_on_this_day => 'No Exams on This Day';

  String get no_tas_assigned_yet => 'No TAs Assigned Yet';

  String get overall_attendance => 'Overall Attendance';

  String get overall_progress => 'Overall Progress';

  String get performance_distribution => 'Performance Distribution';

  String get points => 'Points';

  String get practical_project => 'Practical Project';

  String get prof_john_doe => 'Prof. John Doe';

  String get programming_basics => 'Programming Basics';

  String get progress => 'Progress';

  String get psychology => 'Psychology';

  String get quick_actions => 'Quick Actions';

  String get quiz_1 => 'Quiz 1';

  String get quiz_2 => 'Quiz 2';

  String get rank => 'Rank';

  String get rating => 'Rating';

  String get registration_requests => 'Registration Requests';

  String get removed_successfully => 'Removed Successfully';

  String get results_analysis => 'Results Analysis';

  String get score => 'Score';

  String get select_a_ta_from_the_list_to_a =>
      'Select a TA from the list to add';

  String get sessions_this_week => 'Sessions This Week';

  String get shared_files => 'Shared Files';

  String get sophomore => 'Sophomore';

  String get specialization_projects => 'Specialization Projects';

  String get spring_2024 => 'Spring 2024';

  String get start_by_adding_the_first_ta_f =>
      'Start by adding the first TA for your course';

  String get students => 'Students';

  String get summer_2024 => 'Summer 2024';

  String get ta_team_chat => 'TA Team Chat';

  String get total_students => 'Total Students';

  String get track_project_i => 'Track Project I';

  String get type_a_message => 'Type a message...';

  String get upload => 'Upload';

  String get upload_files => 'Upload Files';

  String get upload_new_file => 'Upload New File';

  String get uploaded_successfully => 'Uploaded Successfully';

  String get urgent_news => 'Urgent News';

  String get web_programming => 'Web Programming';
}

class TranslationsAdminEn {
  TranslationsAdminEn._(this._root);

  final Translations _root;

  String get eeee_mmmm_dd_yyyy => 'EEEE, MMMM dd, yyyy';

  String get en => 'en';

  String get system_online => 'SYSTEM ONLINE';

  String get admin_command_center => 'Admin Command Center';

  String get admin => 'Admin';

  String get live_statistics => 'Live Statistics';

  String get students => 'Students';

  String get staff => 'Staff';

  String get faculty => 'Faculty';

  String get leadership => 'Leadership';

  String get admin_it => 'Admin & IT';

  String get system_modules => 'System Modules';

  String get users => 'Users';

  String get manage_all_accounts => 'Manage all accounts';

  String get colleges => 'Colleges';

  String get manage_faculties => 'Manage faculties';

  String get departments => 'Departments';

  String get academic_departments => 'Academic departments';

  String get professors => 'Professors';

  String get faculty_members => 'Faculty members';

  String get roles => 'Roles';

  String get permission_management => 'Permission management';

  String get audit_logs => 'Audit Logs';

  String get system_activity_log => 'System activity log';

  String get system_settings => 'System Settings';

  String get platform_configuration => 'Platform configuration';

  String get performance => 'Performance';

  String get server_health_metrics => 'Server health metrics';

  String get system_pulse => 'System Pulse';

  String get server => 'Server';

  String get online => 'Online';

  String get latency => 'Latency';

  String get database => 'Database';

  String get active => 'Active';

  String get status => 'Status';

  String get realtime_latency_ms => 'REALTIME LATENCY (MS)';

  String get role_breakdown => 'Role Breakdown';

  String get teaching_staff => 'Teaching Staff';

  String get academic_leadership => 'Academic Leadership';

  String get student_affairs => 'Student Affairs';

  String get total_users => 'Total Users';

  String get system_health => 'System Health';

  String get quick_actions => 'Quick Actions';

  String get management => 'Management';

  String get add_user => 'Add User';

  String get export_data => 'Export Data';

  String get send_announcement => 'Send Announcement';

  String get backup_system => 'Backup System';

  String get user_management => 'User Management';

  String get user_list => 'User List';

  String get filter_all => 'All';

  String get filter_students => 'Students';

  String get filter_staff => 'Staff';

  String get filter_admin => 'Admin';

  String get search_users => 'Search users...';

  String get no_users => 'No users found';

  String user_count({required Object count}) => '${count} users';

  String get student_management => 'Student Management';

  String get staff_management => 'Staff Management';

  String get faculty_management => 'Faculty Management';

  String get leadership_management => 'Leadership Management';

  String get admin_it_management => 'Admin & IT Management';

  String get college_management => 'College Management';

  String get department_management => 'Department Management';

  String get professor_management => 'Professor Management';

  String get role_management => 'Role Management';

  String get audit_log_management => 'Audit Log Management';

  String get system_configuration => 'System Configuration';

  String get add_college => 'Add College';

  String get add_department => 'Add Department';

  String get edit_college => 'Edit College';

  String get edit_department => 'Edit Department';

  String get delete_college => 'Delete College';

  String get delete_department => 'Delete Department';

  String get college_name => 'College Name';

  String get department_name => 'Department Name';

  String get dean_name => 'Dean Name';

  String get head_name => 'Head Name';

  String get student_count => 'Students';

  String get staff_count => 'Staff';

  String get ta_count => 'TAs';

  String get action => 'Action';

  String get timestamp => 'Timestamp';

  String get user => 'User';

  String get details => 'Details';

  String get filter_by_action => 'Filter by action';

  String get filter_by_date => 'Filter by date';

  String get no_logs => 'No audit logs found';

  String get system_version => 'System Version';

  String get maintenance_mode => 'Maintenance Mode';

  String get backup_schedule => 'Backup Schedule';

  String get email_server => 'Email Server';

  String get storage_quota => 'Storage Quota';

  String get security_level => 'Security Level';

  String get log_retention => 'Log Retention';

  String get session_timeout => 'Session Timeout';

  String get save_settings => 'Save Settings';

  String get reset_defaults => 'Reset to Defaults';

  String get user_name => 'Name';

  String get user_email => 'Email';

  String get user_phone => 'Phone';

  String get user_role => 'Role';

  String get user_department => 'Department';

  String get user_college => 'College';

  String get user_status => 'Status';

  String get user_created => 'Created';

  String get user_updated => 'User updated successfully';

  String get add_new_user => 'Add New User';

  String get edit_user => 'Edit User';

  String get delete_user => 'Delete User';

  String get save_user => 'Save';

  String get cancel => 'Cancel';

  String get name_label => 'Full Name';

  String get email_label => 'Email Address';

  String get phone_label => 'Phone Number';

  String get role_label => 'Select Role';

  String get department_label => 'Department';

  String get college_label => 'College';

  String get password_label => 'Password';

  String get confirm_password_label => 'Confirm Password';

  String get category_student => 'Student';

  String get category_staff => 'Staff';

  String get category_faculty => 'Faculty';

  String get category_leadership => 'Leadership';

  String get category_admin => 'Admin';

  String get no_departments => 'No departments available';

  String get no_colleges => 'No colleges available';

  String get select_role => 'Select a role';

  String get select_department => 'Select a department';

  String get select_college => 'Select a college';

  String get user_added => 'User added successfully';

  String get user_deleted => 'User deleted successfully';

  String get confirm_delete => 'Confirm Delete';

  String get confirm_delete_message =>
      'Are you sure you want to delete this user?';

  String get error_loading => 'Error loading data';

  String get error_saving => 'Error saving data';

  String get retry => 'Retry';

  String get academic_department => 'Academic Department';

  String get academic_departments_1 => 'Academic Departments';

  String get academic_leaders => 'Academic Leaders';

  String get academic_warnings => 'Academic Warnings';

  String get account_status => 'Account Status';

  String get account_verification => 'Account Verification';

  String get actor => 'Actor';

  String get add_report => 'Add Report';

  String get admins => 'Admins';

  String get advanced_management => 'Advanced Management';

  String get all => 'All';

  String get all_levels => 'All Levels';

  String get all_systems_operational => 'All Systems Operational';

  String get apply_filters => 'Apply Filters';

  String get are_you_sure_you_want_to_delet =>
      'Are you sure you want to delete this user?';

  String get assign => 'Assign';

  String get assign_dean => 'Assign Dean';

  String get assign_department_head => 'Assign Department Head';

  String get attached_report => 'Attached Report';

  String get ban_user => 'Ban User';

  String get banned => 'Banned';

  String get change => 'Change';

  String get change_dean => 'Change Dean';

  String get changes_saved_successfully => 'Changes Saved Successfully';

  String get college => 'College';

  String get college_dean => 'College Dean';

  String get college_details => 'College Details';

  String get colleges_management => 'Colleges Management';

  String get coming_soon => 'Coming Soon';

  String get deactivated => 'Deactivated';

  String get delete => 'Delete';

  String get department_details => 'Department Details';

  String get department_projects => 'Department Projects';

  String get departments_management => 'Departments Management';

  String get email_address => 'Email Address';

  String get entity => 'Entity';

  String error_snapshoterror({required Object error}) => 'Error: ${error}';

  String get faculty_members_1 => 'Faculty Members';

  String get failed_to_load_data => 'Failed to Load Data';

  String get filter_users => 'Filter Users';

  String get full_name => 'Full Name';

  String get head_of_department => 'Head of Department';

  String get incidents => 'Incidents';

  String get leadership_stats => 'Leadership Statistics';

  String level_level({required Object level}) => 'Level ${level}';

  String get manage_tags => 'Manage Tags';

  String get min_6_chars => 'Min. 6 characters';

  String get national_id => 'National ID';

  String get nationality => 'Nationality';

  String get no_about_text_available => 'No About Text Available';

  String get no_colleges_found => 'No Colleges Found';

  String get no_dean_assigned => 'No Dean Assigned';

  String get no_departments_found => 'No Departments Found';

  String get no_departments_in_this_college => 'No Departments in This College';

  String get no_description_available => 'No Description Available';

  String get no_faculty_records_found => 'No Faculty Records Found';

  String get no_head_assigned => 'No Head Assigned';

  String get no_logs_found => 'No Logs Found';

  String get no_matching_students_found => 'No Matching Students Found';

  String get no_projects_added_yet => 'No Projects Added Yet';

  String get no_settings_found_in_the_datab =>
      'No settings found in the database';

  String get no_users_found => 'No Users Found';

  String get office => 'Office';

  String get password => 'Password';

  String get pending_reg => 'Pending Registration';

  String get permanently_delete_user => 'Permanently Delete User';

  String get phone_number => 'Phone Number';

  String get please_assign_a_dean_for_the_c =>
      'Please assign a dean for this college';

  String get please_assign_a_head_for_the_d =>
      'Please assign a head for this department';

  String get roles_management => 'Roles Management';

  String get save => 'Save';

  String get save_changes => 'Save Changes';

  String get search_by_name_email_phone_id =>
      'Search by name, email, phone or ID...';

  String get search_doctor_name => 'Search doctor name...';

  String get search_staff_member => 'Search staff member...';

  String get search_student_or_id => 'Search student or ID...';

  String get select => 'Select';

  String get select_role_in_widgetinitialca => 'Select role';

  String get select_role_permission => 'Select Role / Permission';

  String get separate_tags_with_commas => 'Separate tags with commas';

  String get servers => 'Servers';

  String get student_id => 'Student ID';

  String get system_technical_status => 'System Technical Status';

  String get tag1_tag2 => 'tag1, tag2';

  String get teaching_assistants => 'Teaching Assistants';

  String get total_staff => 'Total Staff';

  String get total_students => 'Total Students';

  String get unverified => 'Unverified';

  String get user_roles_ranks => 'User Roles & Ranks';

  String get verification => 'Verification';

  String get verified => 'Verified';

  String get warning_level => 'Warning Level';

  String get you_can_manage_professors_and_ =>
      'You can manage professors and more here';
}

class TranslationsEnrollmentEn {
  TranslationsEnrollmentEn._(this._root);

  final Translations _root;

  String get registration_title => 'Course Registration';

  String get invoices_title => 'Financial Invoices';

  String get payment_title => 'Tuition Payment';

  String get advisor => 'Academic Advisor';

  String get advisor_approval => 'Advisor Approval';

  String get dean_assignment => 'Dean Advisor Assignment';

  String get approve => 'Approve';

  String get reject => 'Reject';

  String get pending => 'Pending';

  String get approved => 'Approved';

  String get rejected => 'Rejected';

  String get student_name => 'Student Name';

  String get student_id => 'Student ID';

  String get college => 'College';

  String get department => 'Department';

  String get semester => 'Semester';

  String get credits => 'Credits';

  String get group => 'Group';

  String get section => 'Section';

  String get registration_date => 'Registration Date';

  String get status => 'Status';

  String get no_requests => 'No requests found';

  String get search_students => 'Search students...';

  String get filter_all => 'All';

  String get filter_pending => 'Pending';

  String get filter_approved => 'Approved';

  String get filter_rejected => 'Rejected';

  String get approve_all => 'Approve All';

  String get view_details => 'View Details';

  String get advisor_name => 'Advisor Name';

  String get assign => 'Assign';

  String get unassign => 'Unassign';

  String get assigned => 'Assigned';

  String get unassigned => 'Unassigned';

  String get save => 'Save';

  String get cancel => 'Cancel';

  String get success_approve => 'Registration approved successfully';

  String get success_reject => 'Registration rejected';

  String get success_assign => 'Advisor assigned successfully';

  String get error_loading => 'Error loading data';

  String get invoice_id => 'Invoice ID';

  String get invoice_date => 'Date';

  String get invoice_amount => 'Amount';

  String get invoice_status => 'Status';

  String get invoice_paid => 'Paid';

  String get invoice_unpaid => 'Unpaid';

  String get invoice_overdue => 'Overdue';

  String get pay_now => 'Pay Now';

  String get payment_method => 'Payment Method';

  String get credit_card => 'Credit Card';

  String get fawry => 'Fawry';

  String get bank_transfer => 'Bank Transfer';

  String get payment_success => 'Payment successful';

  String get payment_error => 'Payment failed';

  String get outstanding_balance => 'Outstanding Balance';

  String get total_paid => 'Total Paid';

  String get no_invoices => 'No invoices found';

  String get tuition_fee => 'Tuition Fee';

  String get registration_fee => 'Registration Fee';

  String get late_fee => 'Late Fee';

  String get total => 'Total';

  String semester_label({required Object semester}) => 'Semester ${semester}';

  String get academic_year => 'Academic Year';

  String get submit_request => 'Submit Request';

  String get request_submitted => 'Request submitted successfully';

  String get all => 'All';

  String get loading => 'Loading...';

  String get retry => 'Retry';

  String get academic_advisor => 'Academic Advisor';

  String get advisor_assignment => 'Advisor Assignment';

  String advisor_requestadvisorfullname({required Object name}) =>
      'Advisor: ${name}';

  String get advisor_updated_successfully => 'Advisor Updated Successfully';

  String get approved_1 => 'Approved';

  String get approved_courses_registered => 'Approved — Courses Registered';

  String get awaiting_advisor_review => 'Awaiting Advisor Review';

  String get choose_schedules => 'Choose Schedules';

  String get confirm_submit => 'Confirm & Submit';

  String get cr => 'CR';

  String get dormitory_fee => 'Dormitory Fee';

  String get download => 'Download';

  String get due => 'Due';

  String get error_loading_summary => 'Error Loading Summary';

  String get exam_fee => 'Exam Fee';

  String get failed_to_load_invoices => 'Failed to Load Invoices';

  String get financial_portal => 'Financial Portal';

  String get financial_summary => 'Financial Summary';

  String get help => 'Help';

  String get history => 'History';

  String get invoices => 'Invoices';

  String get library_fee => 'Library Fee';

  String get manage_your_tuition_and_paymen =>
      'Manage your tuition and payments';

  String get mmm_dd_yyyy => 'MMM dd, yyyy';

  String get my_invoices => 'My Invoices';

  String get next_pick_schedules => 'Next: Pick Schedules';

  String get no_advisor => 'No Advisor';

  String get no_invoices_found => 'No Invoices Found';

  String get no_requests_found => 'No Requests Found';

  String get no_schedules_available_for_thi =>
      'No schedules available for this course';

  String get no_students_found => 'No Students Found';

  String get notes_optional => 'Notes (Optional)';

  String get other => 'Other';

  String get overdue => 'Overdue';

  String get paid => 'Paid';

  String get partial => 'Partial';

  String get pay => 'Pay';

  String get pending_review => 'Pending Review';

  String get preparing_pdf_statement => 'Preparing PDF Statement...';

  String get registration_requests => 'Registration Requests';

  String get remaining => 'Remaining';

  String get request_rejected => 'Request Rejected';

  String get requested_courses => 'Requested Courses';

  String get reregister => 'Re-Register';

  String get review_final_timetable => 'Review Final Timetable';

  String get review_registration => 'Review Registration';

  String get room => 'Room';

  String get sec => 'Sec';

  String get select_the_subjects_you_want_t =>
      'Select the subjects you want to register';

  String get select_your_courses => 'Select Your Courses';

  String get selected_schedule_summary => 'Selected Schedule Summary';

  String semester_requestsemester({required Object semester}) =>
      'Semester: ${semester}';

  String get sub => 'Sub';

  String summaryoverduecount_overdue({required Object count}) =>
      '${count} Overdue';

  String get total_invoices => 'Total Invoices';

  String get unassigned_only => 'Unassigned Only';

  String get unpaid => 'Unpaid';

  String get withdrawn => 'Withdrawn';

  String get you_have_successfully_register =>
      'You have successfully registered your courses!';

  String get your_account_is_clearnno_invoi =>
      'Your account is clear. No invoices found.';

  String get no_schedules_available => 'No schedules available';

  String get registration_success_message => 'Registration successful!';

  String advisor_name_label({required Object name}) => 'Advisor: ${name}';

  String semester_label_with_value({required Object semester}) =>
      'Semester: ${semester}';
}

class TranslationsSharedEn {
  TranslationsSharedEn._(this._root);

  final Translations _root;

  String get notifications => 'Notifications';

  String get no_notifications_yet => 'No Notifications Yet';

  String get notifications_empty => 'No new notifications';

  String get security_title => 'Security Settings';

  String get biometrics_title => 'Biometrics';

  String get fingerprint => 'Fingerprint';

  String get face_id => 'Face ID';

  String get enable_biometrics => 'Enable Biometrics';

  String get sessions_title => 'Active Sessions';

  String get current_session => 'Current Session';

  String get end_session => 'End Session';

  String get end_all_sessions => 'End All Sessions';

  String get device => 'Device';

  String get location => 'Location';

  String get last_active => 'Last Active';

  String get support_title => 'Support & Help';

  String get contact_us => 'Contact Us';

  String get email_us => 'Email Us';

  String get call_us => 'Call Us';

  String get whatsapp => 'WhatsApp';

  String get faq => 'FAQ';

  String get report_issue => 'Report an Issue';

  String get tutorials_title => 'Tutorials & Guides';

  String get forums_title => 'Forums';

  String get create_post => 'Create Post';

  String get search_forums => 'Search forums...';

  String get no_posts => 'No posts found';

  String get transition_title => 'Loading...';

  String get placeholder_title => 'Coming Soon';

  String get placeholder_subtitle => 'This section is under development';

  String get coming_soon => 'Coming Soon';

  String get under_development => 'This feature is under development';

  String get back => 'Back';

  String get retry => 'Retry';

  String get loading => 'Loading...';

  String get error => 'Error';

  String get close => 'Close';

  String get cancel => 'Cancel';

  String get confirm => 'Confirm';

  String get save => 'Save';

  String get delete => 'Delete';

  String get edit => 'Edit';

  String get active_sessions => 'Active Sessions';

  String get authentication => 'Authentication';

  String get biometric_login => 'Biometric Login';

  String get call_hotline => 'Call Hotline';

  String get change_password => 'Change Password';

  String get device_management => 'Device Management';

  String get email_support => 'Email Support';

  String get financial_aid => 'Financial Aid';

  String get forums => 'Forums';

  String get it_support => 'IT Support';

  String get library => 'Library';

  String get logout => 'Log Out';

  String get manage_logged_in_devices => 'Manage logged-in devices';

  String get members => 'Members';

  String get please_wait => 'Please Wait...';

  String get protect_account_with_2fa => 'Protect account with 2FA';

  String get security => 'Security';

  String get student_affairs => 'Student Affairs';

  String get support => 'Support';

  String get this_feature_is_under_developm =>
      'This feature is under development';

  String get threads => 'Threads';

  String get tutorials => 'Tutorials';

  String get twofactor_auth => 'Two-Factor Authentication';

  String get update_your_login_credentials => 'Update your login credentials';

  String get use_fingerprint_or_face_id => 'Use fingerprint or Face ID';

  String get view_active_sessions => 'View Active Sessions';

  String get biometrics => 'Biometrics';

  String get sessions => 'Sessions';

  String get security_section => 'Security';

  String get support_section => 'Support';

  String get contact_us_section => 'Contact Us';

  String get tutorials_section => 'Tutorials';

  String get forums_section => 'Forums';

  String get no_new_notifications => 'No New Notifications';

  String get security_access => 'Security Access';
}

class TranslationsStudentsEn {
  TranslationsStudentsEn._(this._root);

  final Translations _root;

  String get digital_id_title => 'Digital ID Card';

  String get student_name => 'Student Name';

  String get student_id => 'Student ID';

  String get college => 'College';

  String get department => 'Department';

  String get level => 'Level';

  String get gpa => 'GPA';

  String get credits => 'Credits';

  String get verified => 'Verified';

  String get university => 'Horus University';

  String get download_id => 'Download ID';

  String get share_id => 'Share ID';

  String get qr_code => 'QR Code';

  String get scan_to_verify => 'Scan to verify';

  String get id_theme => 'ID Theme';

  String get classic_theme => 'Classic';

  String get gradient_theme => 'Gradient';

  String get holographic_theme => 'Holographic';

  String get dark_matter_theme => 'Dark Matter';

  String get neon_pulse_theme => 'Neon Pulse';

  String get aurora_theme => 'Aurora';

  String get dashboard_title => 'Student Dashboard';

  String get academic_section => 'Academic';

  String get enrollment_section => 'Enrollment';

  String get utilities_section => 'Utilities';

  String get transcript => 'Transcript';

  String get progress => 'Academic Progress';

  String get action_plan => 'Degree Plan';

  String get subject_results => 'Subject Results';

  String get grades => 'Grades';

  String get courses => 'Courses';

  String get schedule => 'Schedule';

  String get exam_schedule => 'Exam Schedule';

  String get attendance => 'Attendance';

  String get registration => 'Registration';

  String get invoices => 'Invoices';

  String get payment => 'Payment';

  String get tutorials => 'Tutorials';

  String get security => 'Security';

  String get forums => 'Forums';

  String get support => 'Support';

  String get notifications => 'Notifications';

  String get digital_id => 'Digital ID';

  String get no_lectures_today => 'No lectures today';

  String get view_full_schedule => 'View Full Schedule';

  String get quick_stats => 'Quick Stats';

  String get gpa_label => 'GPA';

  String get level_label => 'Level';

  String get credits_label => 'Credits';

  String get upcoming_exams => 'Upcoming Exams';

  String get recent_grades => 'Recent Grades';

  String get all => 'All';

  String get loading => 'Loading...';

  String get error => 'Error';

  String get retry => 'Retry';

  String get back => 'Back';

  String get academic => 'Academic';

  String get access_logs => 'Access Logs';

  String get active => 'Active';

  String get artificial_intelligence => 'Artificial Intelligence';

  String get copy => 'Copy';

  String get daily_schedule => 'Daily Schedule';

  String get download => 'Download';

  String get enrollment_finance => 'Enrollment & Finance';

  String get horus_university => 'Horus University';

  String get horus_university_1 => 'Horus University';

  String get id_no => 'ID No.';

  String get identity_active_secure => 'Identity Active & Secure';

  String get nfc_pass => 'NFC Pass';

  String get offline_copy => 'Offline Copy';

  String get scan_for_secure_access => 'Scan for Secure Access';

  String get send => 'Send';

  String get settings => 'Settings';

  String get share_identity => 'Share Identity';

  String get smart_digital_id => 'Smart Digital ID';

  String get status => 'Status';

  String get student => 'Student';

  String get utilities => 'Utilities';
}

class TranslationsExtractedEn {
  TranslationsExtractedEn._(this._root);

  final Translations _root;

  String get change_profile_photo => 'Change Profile Photo';

  String get take_photo => 'Take Photo';

  String get choose_from_gallery => 'Choose from Gallery';

  String get remove_photo => 'Remove Photo';

  String get save => 'Save';

  String get user => 'User';

  String get personal_info => 'Personal Info';

  String get full_name => 'Full Name';

  String get required => 'Required';

  String get email => 'Email';

  String get phone_number => 'Phone Number';

  String get national_id => 'National ID';

  String get about_me => 'About Me';

  String get write_something_about_yourself =>
      'Write something about yourself...';

  String get account_info => 'Account Info';

  String get role => 'Role';

  String get account_status => 'Account Status';

  String get active => 'Active';

  String get save_changes => 'Save Changes';

  String get account => 'Account';

  String get appearance => 'Appearance';

  String get notifications => 'Notifications';

  String get language_region => 'Language & Region';

  String get support_feedback => 'Support & Feedback';

  String get about => 'About';

  String get edit_profile => 'Edit Profile';

  String get update_your_personal_info_and_photo =>
      'Update your personal info and photo';

  String get password_recovery => 'Password Recovery';

  String get send_password_recovery_link_to_your_emai =>
      'Send password recovery link to your email';

  String get dark_mode => 'Dark Mode';

  String get toggle_between_dark_and_light_mode =>
      'Toggle between dark and light mode';

  String get ui_style => 'UI Style';

  String get current_glass_design => 'Current: Glass Design';

  String get current_classic_design => 'Current: Classic Design';

  String get kSwitch => 'Switch';

  String get battery_saver_mode => 'Battery Saver Mode';

  String get disable_complex_visual_effects => 'Disable complex visual effects';

  String get app_notifications => 'App Notifications';

  String get notifications_are_active => 'Notifications are active';

  String get notifications_are_off => 'Notifications are off';

  String get notification_center => 'Notification Center';

  String get view_all_your_notifications => 'View all your notifications';

  String get test_notification => 'Test Notification';

  String get send_a_test_notification => 'Send a test notification';

  String get test_notification_sent => 'Test notification sent!';

  String get app_language => 'App Language';

  String get support_center => 'Support Center';

  String get get_help_and_resolve_any_issues =>
      'Get help and resolve any issues';

  String get send_feedback => 'Send Feedback';

  String get share_your_thoughts_to_help_improve_the_ =>
      'Share your thoughts to help improve the app';

  String get rate_the_app => 'Rate the App';

  String get your_support_matters => '⭐ Your support matters';

  String get thank_you_for_your_support => 'Thank you for your support! 🎉';

  String get about_app => 'About App';

  String get version_details_and_developer_info =>
      'Version details and developer info';

  String get privacy_policy => 'Privacy Policy';

  String get terms_and_rules_for_data_usage => 'Terms and rules for data usage';

  String get log_out => 'Log Out';

  String get how_can_we_help_you => 'How can we help you?';

  String get email_support => 'Email Support';

  String get call_hotline => 'Call Hotline';

  String get chat_with_us_on_whatsapp => 'Chat with us on WhatsApp';

  String get your_opinion_helps_us_improve => 'Your opinion helps us improve';

  String get write_your_feedback_here => 'Write your feedback here...';

  String get thank_you_feedback_submitted => '✅ Thank you! Feedback submitted.';

  String get submit_feedback => 'Submit Feedback';

  String get departments => 'Departments';

  String get students => 'Students';

  String get est => 'Est.';

  String get add_department => 'Add Department';

  String get add_new_department => 'Add New Department';

  String get department_name_en => 'Department Name (EN)';

  String get department_name_ar => 'Department Name (AR)';

  String get department_code => 'Department Code';

  String get description => 'Description';

  String get cancel => 'Cancel';

  String get add => 'Add';

  String get staff => 'Staff';

  String get building => 'Building';

  String get assistant_head => 'Assistant Head';

  String get no_assistant_assigned => 'No Assistant Assigned';

  String get please_assign_an_assistant_head_for_the_ =>
      'Please assign an assistant head for the department';

  String get add_staff => 'Add Staff';

  String get no_faculty_members_assigned => 'No faculty members assigned';

  String get add_faculty => 'Add Faculty';

  String get head => 'Head';

  String get asst => 'Asst.';

  String get remove => 'Remove';

  String get add_faculty_member => 'Add Faculty Member';

  String get confirm_removal => 'Confirm Removal';

  String remove_stafffullname_from_this_department({
    required Object staff_fullName,
  }) => 'Remove ${staff_fullName} from this department?';

  String get roles_management => 'Roles Management';

  String get merge_roles => 'Merge Roles';

  String get create_role => 'Create Role';

  String get search_roles => 'Search roles...';

  String get custom => 'Custom';

  String get no_results => 'No results';

  String get no_roles => 'No roles';

  String get no_custom_roles_yet => 'No custom roles yet';

  String get create_a_new_role_or_merge_two_roles =>
      'Create a new role or merge two roles';

  String get create => 'Create';

  String get merge => 'Merge';

  String get could_not_load_custom_roles => 'Could not load custom roles';

  String get make_sure_roles_table_exists_in_supabase =>
      'Make sure "roles" table exists in Supabase';

  String get create_new_role => 'Create New Role';

  String get name_english => 'Name (English)';

  String get name_arabic => 'Name (Arabic)';

  String get category => 'Category';

  String get description_english => 'Description (English)';

  String get description_arabic => 'Description (Arabic)';

  String get permissions => 'Permissions';

  String get role_created => 'Role created';

  String get merge_two_roles => 'Merge Two Roles';

  String get select_two_roles_to_combine_their_permis =>
      'Select two roles to combine their permissions';

  String get first_role => 'First Role';

  String get second_role => 'Second Role';

  String get merged_role_name_english => 'Merged Role Name (English)';

  String get merged_role_name_arabic => 'Merged Role Name (Arabic)';

  String get merged_permissions_preview => 'Merged Permissions Preview';

  String get roles_merged_successfully => 'Roles merged successfully';

  String get edit_role => 'Edit Role';

  String get role_updated => 'Role updated';

  String get delete_role => 'Delete Role';

  String delete_role_rolenameen_this_cannot_be_undone({
    required Object role_nameEn,
  }) => 'Delete "${role_nameEn}"? This cannot be undone.';

  String get delete => 'Delete';

  String get admin_it => 'Admin & IT';

  String get leadership => 'Leadership';

  String get teaching => 'Teaching';

  String get student_affairs => 'Student Affairs';

  String get facilities => 'Facilities';

  String get external => 'External';

  String get permissions_1 => 'Permissions:';

  String get merged => 'MERGED';

  String get user_details => 'User Details';

  String get quick_actions => 'Quick Actions';

  String get verification => 'Verification';

  String get ban_management => 'Ban Management';

  String get tags => 'Tags';

  String get warning_level => 'Warning Level';

  String get danger_zone => 'Danger Zone';

  String get verified => 'Verified';

  String get banned => 'Banned';

  String get deactivate => 'Deactivate';

  String get activate => 'Activate';

  String get unverify => 'Unverify';

  String get verify => 'Verify';

  String get unban => 'Unban';

  String get ban => 'Ban';

  String get account_verified => 'Account Verified';

  String get not_verified => 'Not Verified';

  String get user_identity_has_been_verified =>
      'User identity has been verified';

  String get identity_not_yet_verified => 'Identity not yet verified';

  String get user_banned => 'User Banned';

  String get not_banned => 'Not Banned';

  String get user_cannot_access_the_system => 'User cannot access the system';

  String get user_has_normal_access => 'User has normal access';

  String get no_tags_assigned => 'No tags assigned';

  String get add_tag => 'Add Tag';

  String get current_level => 'Current Level';

  String get created => 'Created';

  String get last_login => 'Last Login';

  String get nationality => 'Nationality';

  String get soft_delete_deactivate => 'Soft Delete (Deactivate)';

  String get permanently_delete => 'Permanently Delete';

  String get verify_account => 'Verify Account';

  String get remove_verification => 'Remove Verification';

  String verify_userfullname({required Object user_fullName}) =>
      'Verify ${user_fullName}';

  String remove_verification_from_userfullname({
    required Object user_fullName,
  }) => 'Remove verification from ${user_fullName}?';

  String get ban_user => 'Ban User';

  String get unban_user => 'Unban User';

  String ban_userfullname_they_will_lose_system_access({
    required Object user_fullName,
  }) => 'Ban ${user_fullName}? They will lose system access.';

  String unban_userfullname({required Object user_fullName}) =>
      'Unban ${user_fullName}?';

  String warning_level_set_to_level({required Object level}) =>
      'Warning level set to ${level}';

  String get tag_removed => 'Tag removed';

  String get tag_name => 'Tag name';

  String get permanent_delete => 'Permanent Delete';

  String get soft_delete => 'Soft Delete';

  String permanently_delete_userfullname_this_cannot_be_undone({
    required Object user_fullName,
  }) => 'Permanently delete ${user_fullName}? This cannot be undone!';

  String deactivate_userfullname({required Object user_fullName}) =>
      'Deactivate ${user_fullName}';

  String get institution => 'Institution';

  String get select_college => 'Select College';

  String get college_is_required => 'College is required';

  String get select_department => 'Select Department';

  String get department_is_required => 'Department is required';

  String out_of_max({required Object max}) => 'OUT OF ${max}';

  String get exceeding => 'Exceeding';

  String get top_5 => 'Top 5%';

  String get total => 'Total';

  String get grade => 'Grade';

  String get mmm_dd_yyyy => 'MMM dd, yyyy';

  String get no_projects_available_yet => 'No projects available yet';

  String get details => 'Details';

  String get completed => 'Completed';

  String get paused => 'Paused';

  String get cancelled => 'Cancelled';

  String get faculty_members => 'Faculty Members';

  String get please_assign_an_assistant_head_for_the =>
      'Please assign an assistant head for the department';

  String get roles => 'Roles';

  String get permissions_2 => 'Permissions';

  String get academic_leadership => 'Academic Leadership';

  String get administration => 'Administration';

  String get manage_grades => 'Manage Grades';

  String get manage_attendance => 'Manage Attendance';

  String get manage_tas => 'Manage TAs';

  String get loading_profile => 'Loading Profile...';

  String get manage_groups => 'Manage Groups';

  String get upload_materials => 'Upload Materials';

  String get professor_chat => 'Professor Chat';

  String get manage_courses => 'Manage Courses';

  String get manage_schedules => 'Manage Schedules';

  String get approve_enrollments => 'Approve Enrollments';

  String get announcements => 'Announcements';

  String get manage_enrollments => 'Manage Enrollments';

  String get academic_advising => 'Academic Advising';

  String get manage_library => 'Manage Library';

  String get student_records => 'Student Records';

  String get manage_users => 'Manage Users';

  String get manage_colleges => 'Manage Colleges';

  String get manage_departments => 'Manage Departments';

  String get audit_logs => 'Audit Logs';

  String get manage_roles => 'Manage Roles';

  String get finances => 'Finances';

  String get you_do_not_have_permission_to_access_this_section =>
      'You do not have permission to access this section';

  String get personal_details => 'Personal Details';

  String get account_credentials => 'Account Credentials';

  String get roles_permissions => 'Roles & Permissions';

  String get academic_affiliation => 'Academic Affiliation';

  String get gender => 'Gender';

  String get male => 'Male';

  String get female => 'Female';

  String get enter_prefix_only => 'Enter prefix only (e.g., ahmed123)';

  String get previous => 'Previous';

  String get create_account => 'Create Account';

  String get next => 'Next';

  String get about_college => 'About College';

  String get origins_roots => 'Origins & Roots';

  String get vision_mission => 'Vision & Mission';

  String get strategic_goals => 'Strategic Goals';

  String get faculty_management => 'Faculty Management';

  String get faculty_staff => 'Faculty & Staff';

  String get no_staff_registered_yet => 'No staff registered yet';

  String get scientific_departments => 'Scientific Departments';

  String get posted_successfully => 'Posted Successfully!';

  String get your_post_is_now_live_on_the_feed =>
      'Your post is now live on the feed';

  String get create_post => 'Create Post';

  String get post => 'Post';

  String get as_college => 'As College';

  String get public => 'Public';

  String get mention_collegedept => 'Mention College/Dept';

  String get dept => 'Dept';

  String get whats_on_your_mind => 'What\'s on your mind?';

  String get paste_link_here => 'Paste link here...';

  String get add_to_your_post => 'Add to your post';

  String get en => 'en';

  String get news => 'News';

  String get edit_post => 'Edit Post';

  String get write_something => 'Write something...';

  String get dashboard => 'Dashboard';

  String get share_your_thoughts_to_help_improve_the =>
      'Share your thoughts to help improve the system';
}

class TranslationsOnboardingLanguageEn {
  TranslationsOnboardingLanguageEn._(this._root);

  final Translations _root;

  String get title => 'Choose your language';

  String get subtitle => 'اختر لغتك المفضلة';

  String get english => 'English';

  String get arabic => 'العربية';

  String get german => 'Deutsch';

  String get chinese => '中文';

  String get hint =>
      'You can change this later in settings\nيمكنك تغيير هذا لاحقاً في الإعدادات';
}

class TranslationsOnboardingFacultiesDirectoryEn {
  TranslationsOnboardingFacultiesDirectoryEn._(this._root);

  final Translations _root;

  String get title => 'Our Faculties';

  String get subtitle => 'Discover Horus University portal.';
}

class TranslationsOnboardingStyleEn {
  TranslationsOnboardingStyleEn._(this._root);

  final Translations _root;

  String get title => 'Choose your style';

  String get subtitle => 'Select the interface design you prefer';

  late final TranslationsOnboardingStyleClassicEn classic =
      TranslationsOnboardingStyleClassicEn._(_root);
  late final TranslationsOnboardingStyleGlassEn glass =
      TranslationsOnboardingStyleGlassEn._(_root);
}

class TranslationsOnboardingThemeEn {
  TranslationsOnboardingThemeEn._(this._root);

  final Translations _root;

  String get title => 'Choose a theme';

  String get subtitle => 'Light or dark, your choice';

  String get light => 'Light';

  String get dark => 'Dark';
}

class TranslationsAuthLoginEn {
  TranslationsAuthLoginEn._(this._root);

  final Translations _root;

  String get welcome => 'Welcome Back';

  String get subtitle => 'Sign in to continue';

  String get email => 'Email';

  String get password => 'Password';

  String get forgot_password => 'Forgot Password?';

  String get submit => 'Login';

  String get guest => 'Browse as Guest';
}

class TranslationsAuthForgotPasswordEn {
  TranslationsAuthForgotPasswordEn._(this._root);

  final Translations _root;

  String get title => 'Forgot Password';

  String get subtitle => 'Choose a recovery method';

  String get method_admin => 'Visit Administration';

  String get method_online => 'Online Request';

  String get admin_instructions =>
      'Please visit the student affairs office to reset your password. Bring your valid university ID.';

  String get phone_label => 'Phone Number';

  String get upload_id => 'Upload ID Photo';

  String get upload_id_hint =>
      'Tap to upload a clear photo of your university ID';

  String get submit => 'Submit Request';

  String get back => 'Back to Login';

  String get error_empty_phone => 'Please enter your phone number';

  String get error_empty_email => 'Please enter your email';

  String get error_no_id => 'Please upload your ID photo';

  String get success => 'Request submitted successfully';

  String get id_uploaded => 'ID Uploaded';

  String get choose_account_recovery_method => 'Choose Account Recovery Method';

  String get back_to_login => 'Back to Login';
}

class TranslationsHomeTabsEn {
  TranslationsHomeTabsEn._(this._root);

  final Translations _root;

  String get home => 'Home';

  String get colleges => 'Colleges';

  String get student => 'Student';

  String get admin => 'Admin';

  String get search => 'Search';

  String get notifications => 'Notifications';

  String get profile => 'Profile';
}

class TranslationsDashboardIdCardEn {
  TranslationsDashboardIdCardEn._(this._root);

  final Translations _root;

  String get student_name => 'Student Name';

  String get college => 'College';

  String get id => 'Student ID';

  String get gpa => 'GPA';

  String get level => 'Level';

  String get verified => 'Verified';
}

class TranslationsDashboardSectionsEn {
  TranslationsDashboardSectionsEn._(this._root);

  final Translations _root;

  String get academic => 'Academic';

  String get enrollment => 'Enrollment';

  String get utilities => 'Utilities';
}

class TranslationsDashboardItemsEn {
  TranslationsDashboardItemsEn._(this._root);

  final Translations _root;

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
  TranslationsDashboardLabelsEn._(this._root);

  final Translations _root;

  String get university_name => 'Horus University';

  String get id_short => 'ID';

  String get gpa_short => 'GPA';

  String get level_short => 'LVL';
}

class TranslationsSettingsSectionsEn {
  TranslationsSettingsSectionsEn._(this._root);

  final Translations _root;

  String get account => 'Account';

  String get display => 'Display';

  String get notifications => 'Notifications';

  String get about => 'About';
}

class TranslationsSettingsTilesEn {
  TranslationsSettingsTilesEn._(this._root);

  final Translations _root;

  String get edit_profile => 'Edit Profile';

  String get change_password => 'Change Password';

  String get dark_mode => 'Dark Mode';

  String get language => 'Language';

  String get ui_style => 'UI Style';

  String get app_notifications => 'App Notifications';

  String get test_notifications => 'Test Notifications';

  String get about_app => 'About App';

  String get privacy_policy => 'Privacy Policy';

  String get logout => 'Logout';
}

class TranslationsSettingsMessagesEn {
  TranslationsSettingsMessagesEn._(this._root);

  final Translations _root;

  String get switching_theme => 'Switching Theme...';

  String get changing_language => 'Changing Language...';

  String get rebuilding_design => 'Rebuilding Design System...';
}

class TranslationsCollegesDetailsEn {
  TranslationsCollegesDetailsEn._(this._root);

  final Translations _root;

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
  TranslationsCollegesDepartmentsEn._(this._root);

  final Translations _root;

  String get medical_laboratories_technology =>
      'Medical Laboratories Technology';

  String get radiology_and_imaging_technology =>
      'Radiology and Imaging Technology';

  String get respiratory_care_technology => 'Respiratory Care Technology';

  String get dental_prosthetics_technology => 'Dental Prosthetics Technology';

  String get health_administration_and_informatics_technology =>
      'Health Administration and Informatics Technology';

  String get accounting => 'Accounting';

  String get business_management => 'Business Management';

  String get economics => 'Economics';

  String get marketing => 'Marketing';

  String get accounting_program_english => 'Accounting Program (English)';

  String get business_administration_program_english =>
      'Business Administration Program (English)';

  String get basic_sciences_in_dentistry => 'Basic Sciences in Dentistry';

  String get basic_medical_and_clinical_sciences =>
      'Basic Medical and Clinical Sciences';

  String get oral_and_maxillofacial_surgery => 'Oral and Maxillofacial Surgery';

  String get orthodontics_and_pediatric_dentistry =>
      'Orthodontics and Pediatric Dentistry';

  String get periodontics_and_oral_medicine => 'Periodontics and Oral Medicine';

  String get prosthodontics => 'Prosthodontics';

  String get conservative_dentistry_and_endodontics =>
      'Conservative Dentistry and Endodontics';

  String get architectural_engineering => 'Architectural Engineering';

  String get basic_sciences => 'Basic Sciences';

  String get civil_engineering => 'Civil Engineering';

  String get mechanical_engineering => 'Mechanical Engineering';

  String get electrical_engineering => 'Electrical Engineering';

  String get artificial_intelligence_engineering =>
      'Artificial Intelligence Engineering';

  String get interior_design_and_architecture =>
      'Interior Design and Architecture';

  String get furniture_design_and_production_technology =>
      'Furniture Design and Production Technology';

  String get graphics_and_digital_arts => 'Graphics and Digital Arts';

  String get animation_and_multimedia => 'Animation and Multimedia';

  String get medical_education => 'Medical Education';

  String get histology_and_cell_biology => 'Histology and Cell Biology';

  String get clinical_pharmacy => 'Clinical Pharmacy';

  String get human_anatomy_and_embryology => 'Human Anatomy and Embryology';

  String get medical_physiology => 'Medical Physiology';

  String get medical_microbiology_and_immunology =>
      'Medical Microbiology and Immunology';

  String get forensic_medicine_and_toxicology =>
      'Forensic Medicine and Toxicology';

  String get community_medicine_and_public_health =>
      'Community Medicine and Public Health';

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

  String get pt_internal_medicine_and_geriatrics =>
      'PT for Internal Medicine and Geriatrics';

  String get pt_womens_health => 'PT for Women\'s Health';

  String get pt_surgery_and_integumentary => 'PT for Surgery and Integumentary';

  String get pt_orthopedics => 'PT for Orthopedics';

  String get pt_neurology => 'PT for Neurology';

  String get pt_pediatrics => 'PT for Pediatrics';

  String get artificial_biomedical_computing =>
      'Artificial Biomedical Computing';

  String get artificial_cybersecurity => 'Cyber Security';

  String get ai_and_data_science => 'AI and Data Science';

  String get ai_for_robotics => 'AI for Robotics';

  String get smart_systems => 'Smart Systems';
}

class TranslationsTranscriptOverviewEn {
  TranslationsTranscriptOverviewEn._(this._root);

  final Translations _root;

  String get gpa => 'Cumulative GPA';

  String get credits => 'Earned Credits';

  String get standing => 'Standing';

  String get active => 'Good Standing';
}

class TranslationsTranscriptSemesterEn {
  TranslationsTranscriptSemesterEn._(this._root);

  final Translations _root;

  String get fall => 'Fall Semester';

  String get spring => 'Spring Semester';

  String get summer => 'Summer Session';
}

class TranslationsTranscriptCourseEn {
  TranslationsTranscriptCourseEn._(this._root);

  final Translations _root;

  String get grade => 'Grade';

  String get credits => 'Credits';

  late final TranslationsTranscriptCourseStatusEn status =
      TranslationsTranscriptCourseStatusEn._(_root);
}

class TranslationsAcademicProgressCategoriesEn {
  TranslationsAcademicProgressCategoriesEn._(this._root);

  final Translations _root;

  String get university_name => 'Horus University';

  String get faculty => 'Faculty Requirements';

  String get major => 'Major Requirements';

  String get electives => 'Electives';
}

class TranslationsAcademicProgressStatusEn {
  TranslationsAcademicProgressStatusEn._(this._root);

  final Translations _root;

  String get completed => 'Completed';

  String get in_progress => 'In Progress';

  String get remaining => 'Remaining';

  String get requirement_met => 'Requirement Met';
}

class TranslationsAttendanceSubjectsEn {
  TranslationsAttendanceSubjectsEn._(this._root);

  final Translations _root;

  String get ai => 'Artificial Intelligence';

  String get machine_learning => 'Machine Learning';

  String get ethics => 'Ethics in IT';

  String get calculus => 'Advanced Calculus';
}

class TranslationsAdministrationAuditLogsEn {
  TranslationsAdministrationAuditLogsEn._(this._root);

  final Translations _root;

  String get title => 'Audit Logs';

  String get no_logs_found => 'No logs found matching the criteria.';

  late final TranslationsAdministrationAuditLogsTabsEn tabs =
      TranslationsAdministrationAuditLogsTabsEn._(_root);
  late final TranslationsAdministrationAuditLogsLabelsEn labels =
      TranslationsAdministrationAuditLogsLabelsEn._(_root);
}

class TranslationsProfessorStatsEn {
  TranslationsProfessorStatsEn._(this._root);

  final Translations _root;

  String get groups => 'Groups';

  String get students => 'Total Students';

  String get tas => 'Teaching Assistants';

  String get rating => 'Rating';

  String get shared_files => 'Shared Files';

  String get office_hours => 'Office Hours';
}

class TranslationsProfessorQuickActionsEn {
  TranslationsProfessorQuickActionsEn._(this._root);

  final Translations _root;

  String get urgent => 'Urgent';

  String get upload => 'Upload';

  String get message => 'Message';

  String get action_clicked => 'Clicked';
}

class TranslationsProfessorProfileEn {
  TranslationsProfessorProfileEn._(this._root);

  final Translations _root;

  String get urgent_announcements => 'Urgent Announcements';

  String get teaching_assistants => 'Teaching Assistants';

  String get shared_resources => 'Shared Resources';

  String get office_hours => 'Office Hours';
}

class TranslationsRolesCategoriesEn {
  TranslationsRolesCategoriesEn._(this._root);

  final Translations _root;

  String get admin_it => 'Admin & IT';

  String get academic_leadership => 'Academic Leadership';

  String get teaching_staff => 'Teaching Staff';

  String get student_affairs => 'Student Affairs';

  String get student_roles => 'Student Roles';

  String get facilities_security => 'Facilities & Security';

  String get external_roles => 'External Roles';
}

class TranslationsRolesNamesEn {
  TranslationsRolesNamesEn._(this._root);

  final Translations _root;

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
  TranslationsRolesDescriptionsEn._(this._root);

  final Translations _root;

  String get super_admin => 'Full control over the entire system';

  String get admin => 'System administrator with high privileges';

  String get it_support => 'Technical system support and maintenance';

  String get financial_auditor => 'Oversees financial records and invoices';

  String get rector => 'University president with full academic oversight';

  String get dean => 'Head of a college/faculty';

  String get department_head => 'Head of an academic department';

  String get academic_coordinator =>
      'Coordinates academic programs and scheduling';

  String get professor => 'Faculty member who teaches and manages courses';

  String get lecturer => 'Teaches courses without full professor privileges';

  String get teaching_assistant =>
      'Assists professors with grading, labs, and tutorials';

  String get registrar_officer => 'Manages student enrollment and registration';

  String get academic_advisor => 'Guides students through academic planning';

  String get librarian => 'Manages library resources and materials';

  String get freshman => 'First-year student with limited system access';

  String get regular_student =>
      'Full student with all standard academic privileges';

  String get student => 'General student role';

  String get class_representative =>
      'Student leader who represents the class body';

  String get alumni => 'Graduated student with limited access';

  String get dorm_supervisor => 'Manages student dormitory operations';

  String get security_officer => 'Campus security and access control';

  String get guest => 'Temporary visitor with minimal access';

  String get parent => 'Can view linked student progress and grades';

  String get recruiter => 'External recruitment organization';
}

class TranslationsOnboardingStyleClassicEn {
  TranslationsOnboardingStyleClassicEn._(this._root);

  final Translations _root;

  String get title => 'Classic';

  String get desc => 'Clean, simple, and familiar Material Design';
}

class TranslationsOnboardingStyleGlassEn {
  TranslationsOnboardingStyleGlassEn._(this._root);

  final Translations _root;

  String get title => 'Glass';

  String get desc => 'Modern, translucent, and vibrant aesthetics';
}

class TranslationsTranscriptCourseStatusEn {
  TranslationsTranscriptCourseStatusEn._(this._root);

  final Translations _root;

  String get completed => 'Completed';

  String get transferred => 'Transferred';
}

class TranslationsAdministrationAuditLogsTabsEn {
  TranslationsAdministrationAuditLogsTabsEn._(this._root);

  final Translations _root;

  String get all => 'All Logs';

  String get security => 'Security';

  String get user_management => 'User Management';

  String get data_updates => 'Data Updates';
}

class TranslationsAdministrationAuditLogsLabelsEn {
  TranslationsAdministrationAuditLogsLabelsEn._(this._root);

  final Translations _root;

  String get actor => 'Actor';

  String get table => 'Table';

  String get record => 'Record';

  String get action => 'Action';

  String get old_data => 'Old Data';

  String get new_data => 'New Data';

  String get notes => 'Notes';

  String get performed_by => 'Performed By';

  String get close_details => 'Close Details';

  String get view_details => 'View Details';
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
          'welcome.subtitle' =>
            'Light up your world with meaningful connections.',
          'welcome.get_started' => 'Get Started',
          'welcome.have_account' => 'I already have an account',
          'welcome.student_portal' => 'HUE Portal',
          'welcome.welcome_to_the_smart_universit' =>
            'Welcome to the Smart University',
          'welcome.i_already_have_an_account' => 'I already have an account',
          'onboarding.title' => 'Onboarding',
          'onboarding.language.title' => 'Choose your language',
          'onboarding.language.subtitle' => 'اختر لغتك المفضلة',
          'onboarding.language.english' => 'English',
          'onboarding.language.arabic' => 'العربية',
          'onboarding.language.german' => 'Deutsch',
          'onboarding.language.chinese' => '中文',
          'onboarding.language.hint' =>
            'You can change this later in settings\nيمكنك تغيير هذا لاحقاً في الإعدادات',
          'onboarding.choose_language' => 'Choose Your Language',
          'onboarding.you_can_change_this_later_in_s' =>
            'You can change this later in Settings',
          'onboarding.choose_app_style' => 'Choose Your App Style',
          'onboarding.you_can_switch_styles_later_in' =>
            'You can switch styles later in Settings',
          'onboarding.choose_app_theme' => 'Choose Your Theme',
          'onboarding.select_the_lighting_that_suits' =>
            'Select the lighting that suits you best',
          'onboarding.classic_solid' => 'Classic',
          'onboarding.high_performance_flat_solid_co' =>
            'High-performance flat solid colors',
          'onboarding.modern_glass' => 'Modern Glass',
          'onboarding.premium_frosted_glass_blur_eff' =>
            'Premium frosted glass blur effect',
          'onboarding.almost_there_just_one_more_ste' =>
            'Almost there! Just one more step.',
          'onboarding.recommended' => 'Recommended',
          'onboarding.light_mode' => 'Light Mode',
          'onboarding.dark_mode' => 'Dark Mode',
          'onboarding.faculties_directory.title' => 'Our Faculties',
          'onboarding.faculties_directory.subtitle' =>
            'Discover Horus University portal.',
          'onboarding.style.title' => 'Choose your style',
          'onboarding.style.subtitle' =>
            'Select the interface design you prefer',
          'onboarding.style.classic.title' => 'Classic',
          'onboarding.style.classic.desc' =>
            'Clean, simple, and familiar Material Design',
          'onboarding.style.glass.title' => 'Glass',
          'onboarding.style.glass.desc' =>
            'Modern, translucent, and vibrant aesthetics',
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
          'auth.forgot_password.admin_instructions' =>
            'Please visit the student affairs office to reset your password. Bring your valid university ID.',
          'auth.forgot_password.phone_label' => 'Phone Number',
          'auth.forgot_password.upload_id' => 'Upload ID Photo',
          'auth.forgot_password.upload_id_hint' =>
            'Tap to upload a clear photo of your university ID',
          'auth.forgot_password.submit' => 'Submit Request',
          'auth.forgot_password.back' => 'Back to Login',
          'auth.forgot_password.error_empty_phone' =>
            'Please enter your phone number',
          'auth.forgot_password.error_empty_email' => 'Please enter your email',
          'auth.forgot_password.error_no_id' => 'Please upload your ID photo',
          'auth.forgot_password.success' => 'Request submitted successfully',
          'auth.forgot_password.id_uploaded' => 'ID Uploaded',
          'auth.forgot_password.choose_account_recovery_method' =>
            'Choose Account Recovery Method',
          'auth.forgot_password.back_to_login' => 'Back to Login',
          'auth.back' => 'Back',
          'auth.choose_account_recovery_method' =>
            'Choose Account Recovery Method',
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
          'settings.messages.rebuilding_design' =>
            'Rebuilding Design System...',
          'settings.user' => 'User',
          'settings.about_app' => 'About App',
          'settings.university' => 'Horus University',
          'settings.horus_university' => 'Horus University - Egypt',
          'settings.developer' => 'Developer',
          'settings.platform' => 'Platform',
          'settings.backend' => 'Backend',
          'settings.hue_portal_is_a_comprehensive_' =>
            'HUE Portal is a comprehensive smart university management system.',
          'settings.change_password' => 'Change Password',
          'settings.please_fill_all_fields' => 'Please fill all fields',
          'settings.password_must_be_at_least_6_ch' =>
            'Password must be at least 6 characters',
          'settings.passwords_do_not_match' => 'Passwords do not match',
          'settings.password_changed_successfully' =>
            'Password changed successfully',
          'settings.enter_your_new_password' => 'Enter your new password below',
          'settings.new_password' => 'New Password',
          'settings.confirm_password' => 'Confirm Password',
          'settings.privacy_policy' => 'Privacy Policy',
          'settings.last_updated_february_2026' =>
            'Last updated: February 2026',
          'settings.edit_profile' => 'Edit Profile',
          'settings.save' => 'Save',
          'settings.full_name' => 'Full Name',
          'settings.email' => 'Email',
          'settings.phone' => 'Phone',
          'settings.bio' => 'Bio',
          'settings.role' => 'Role',
          'settings.update_your_info_and_contact_d' =>
            'Update your info and contact details',
          'settings.change_password_and_security_l' =>
            'Change password and security level',
          'settings.forgot_password' => 'Forgot Password',
          'settings.send_password_recovery_link_to' =>
            'Send password recovery link to your email',
          'settings.toggle_between_dark_and_light_' =>
            'Toggle between dark and light mode',
          'settings.current_glass_design' => 'Current: Glass Design',
          'settings.current_classic_design' => 'Current: Classic Design',
          'settings.switch_style' => 'Switch Style',
          'settings.control_the_types_of_incoming_' =>
            'Control the types of incoming notifications',
          'settings.send_a_test_notification' => 'Send a test notification',
          'settings.test_notification_successful' =>
            'Test notification sent successfully!',
          'settings.battery_saver_mode' => 'Battery Saver Mode',
          'settings.disable_complex_visual_effects' =>
            'Disable complex visual effects for better performance',
          'settings.help_support_center' => 'Help & Support Center',
          'settings.contact_us_to_resolve_any_issu' =>
            'Contact us to resolve any issue',
          'settings.version_details_and_developers' =>
            'Version details and developer info',
          'settings.terms_and_rules_for_data_usage' =>
            'Terms and rules for data usage',
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
          'colleges.applied_health_sciences' =>
            'Faculty of Applied Health Sciences',
          'colleges.business_administration' =>
            'Faculty of Business Administration',
          'colleges.dentistry' => 'Faculty of Dentistry',
          'colleges.engineering' => 'Faculty of Engineering',
          'colleges.fine_arts' => 'Faculty of Fine Arts',
          'colleges.human_medicine' => 'Faculty of Human Medicine',
          'colleges.linguistics' => 'Faculty of Linguistics & Translation',
          'colleges.pharmacy' => 'Faculty of Pharmacy',
          'colleges.physical_therapy' => 'Faculty of Physical Therapy',
          'colleges.ai' => 'Faculty of Artificial Intelligence',
          'colleges.departments.medical_laboratories_technology' =>
            'Medical Laboratories Technology',
          'colleges.departments.radiology_and_imaging_technology' =>
            'Radiology and Imaging Technology',
          'colleges.departments.respiratory_care_technology' =>
            'Respiratory Care Technology',
          'colleges.departments.dental_prosthetics_technology' =>
            'Dental Prosthetics Technology',
          'colleges.departments.health_administration_and_informatics_technology' =>
            'Health Administration and Informatics Technology',
          'colleges.departments.accounting' => 'Accounting',
          'colleges.departments.business_management' => 'Business Management',
          'colleges.departments.economics' => 'Economics',
          'colleges.departments.marketing' => 'Marketing',
          'colleges.departments.accounting_program_english' =>
            'Accounting Program (English)',
          'colleges.departments.business_administration_program_english' =>
            'Business Administration Program (English)',
          'colleges.departments.basic_sciences_in_dentistry' =>
            'Basic Sciences in Dentistry',
          'colleges.departments.basic_medical_and_clinical_sciences' =>
            'Basic Medical and Clinical Sciences',
          'colleges.departments.oral_and_maxillofacial_surgery' =>
            'Oral and Maxillofacial Surgery',
          'colleges.departments.orthodontics_and_pediatric_dentistry' =>
            'Orthodontics and Pediatric Dentistry',
          'colleges.departments.periodontics_and_oral_medicine' =>
            'Periodontics and Oral Medicine',
          'colleges.departments.prosthodontics' => 'Prosthodontics',
          'colleges.departments.conservative_dentistry_and_endodontics' =>
            'Conservative Dentistry and Endodontics',
          'colleges.departments.architectural_engineering' =>
            'Architectural Engineering',
          'colleges.departments.basic_sciences' => 'Basic Sciences',
          'colleges.departments.civil_engineering' => 'Civil Engineering',
          'colleges.departments.mechanical_engineering' =>
            'Mechanical Engineering',
          'colleges.departments.electrical_engineering' =>
            'Electrical Engineering',
          'colleges.departments.artificial_intelligence_engineering' =>
            'Artificial Intelligence Engineering',
          'colleges.departments.interior_design_and_architecture' =>
            'Interior Design and Architecture',
          'colleges.departments.furniture_design_and_production_technology' =>
            'Furniture Design and Production Technology',
          'colleges.departments.graphics_and_digital_arts' =>
            'Graphics and Digital Arts',
          'colleges.departments.animation_and_multimedia' =>
            'Animation and Multimedia',
          'colleges.departments.medical_education' => 'Medical Education',
          'colleges.departments.histology_and_cell_biology' =>
            'Histology and Cell Biology',
          'colleges.departments.clinical_pharmacy' => 'Clinical Pharmacy',
          'colleges.departments.human_anatomy_and_embryology' =>
            'Human Anatomy and Embryology',
          'colleges.departments.medical_physiology' => 'Medical Physiology',
          'colleges.departments.medical_microbiology_and_immunology' =>
            'Medical Microbiology and Immunology',
          'colleges.departments.forensic_medicine_and_toxicology' =>
            'Forensic Medicine and Toxicology',
          'colleges.departments.community_medicine_and_public_health' =>
            'Community Medicine and Public Health',
          'colleges.departments.biochemistry' => 'Biochemistry',
          'colleges.departments.pathology' => 'Pathology',
          'colleges.departments.english_language_program' =>
            'English Language Program',
          'colleges.departments.german_language_program' =>
            'German Language Program',
          'colleges.departments.chinese_language_program' =>
            'Chinese Language Program',
          'colleges.departments.french_department' => 'French Department',
          'colleges.departments.translation_department' =>
            'Translation Department',
          'colleges.departments.pharmaceutical_chemistry' =>
            'Pharmaceutical Chemistry',
          'colleges.departments.pharmacology_and_biochemistry' =>
            'Pharmacology and Biochemistry',
          'colleges.departments.pharmacognosy' => 'Pharmacognosy',
          'colleges.departments.microbiology_and_immunology' =>
            'Microbiology and Immunology',
          'colleges.departments.pharmaceutical_technology' =>
            'Pharmaceutical Technology',
          'colleges.departments.pharmacy_practice' => 'Pharmacy Practice',
          'colleges.departments.basic_sciences_pt' => 'Basic Sciences',
          'colleges.departments.biomechanics' => 'Biomechanics',
          'colleges.departments.pt_internal_medicine_and_geriatrics' =>
            'PT for Internal Medicine and Geriatrics',
          'colleges.departments.pt_womens_health' => 'PT for Women\'s Health',
          'colleges.departments.pt_surgery_and_integumentary' =>
            'PT for Surgery and Integumentary',
          'colleges.departments.pt_orthopedics' => 'PT for Orthopedics',
          'colleges.departments.pt_neurology' => 'PT for Neurology',
          'colleges.departments.pt_pediatrics' => 'PT for Pediatrics',
          'colleges.departments.artificial_biomedical_computing' =>
            'Artificial Biomedical Computing',
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
          'registration.step1_subtitle' =>
            'Select the main group you wish to register for this semester.',
          'registration.group_label' =>
            ({required Object group}) => 'Group ${group}',
          'registration.main_cohort' => 'Main cohort registration',
          'registration.step2_title' => 'Step 2: Choose Sub-section',
          'registration.step2_subtitle' =>
            ({required Object group}) =>
                'Selected Group: ${group}. Now select your practical sub-section.',
          'registration.section_label' =>
            ({required Object section}) => 'Section ${section}',
          'registration.labs_sessions' => 'Labs and practical sessions',
          'registration.step3_title' => 'Step 3: Confirm Registration',
          'registration.review' => 'Review Selections',
          'registration.semester' => 'Semester',
          'registration.group' => 'Group',
          'registration.section' => 'Section',
          'registration.auto_registered' =>
            'Courses to be automatically registered:',
          'registration.credits_count' =>
            ({required Object credits}) => '${credits} CR',
          'registration.confirm_final' => 'Confirm Final Registration',
          'registration.already_registered_title' => 'Already Registered!',
          'registration.success_message' =>
            ({required Object group, required Object section}) =>
                'You have successfully registered for this semester.\nGroup: ${group} | Section: ${section}',
          'registration.back_home' => 'Back to Home',
          'registration.registration_success' => 'Registration Successful!',
          'registration.error_loading' =>
            ({required Object error}) => 'Error: ${error}\n\nTap to retry',
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
          'administration.audit_logs.no_logs_found' =>
            'No logs found matching the criteria.',
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
          'professor.welcome_back_name' =>
            ({required Object name}) => 'Welcome back, ${name}',
          'professor.active_tas_count' =>
            ({required Object count}) => '${count} Active TAs',
          'professor.total_students_count' =>
            ({required Object count}) => '${count} Total Students',
          'professor.uploaded_files_count' =>
            ({required Object count}) => '${count} Uploaded Files',
          'professor.weekly_slots_count' =>
            ({required Object count}) => '${count} Weekly Slots',
          'professor.announcement_to' =>
            ({required Object count}) => 'Announce to ${count}',
          'professor.preparing_announcement' => 'Preparing Announcement...',
          'professor.no_groups' => 'No Groups Available',
          'professor.select_all' => 'Select All',
          'professor.deselect_all' => 'Deselect All',
          'professor.selected_count' =>
            ({required Object count}) => '${count} Selected',
          'professor.action_clicked' =>
            ({required Object action}) => 'Clicked: ${action}',
          'professor.activating' =>
            ({required Object target}) => 'Activating: ${target}',
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
          'roles.descriptions.super_admin' =>
            'Full control over the entire system',
          'roles.descriptions.admin' =>
            'System administrator with high privileges',
          'roles.descriptions.it_support' =>
            'Technical system support and maintenance',
          'roles.descriptions.financial_auditor' =>
            'Oversees financial records and invoices',
          'roles.descriptions.rector' =>
            'University president with full academic oversight',
          'roles.descriptions.dean' => 'Head of a college/faculty',
          'roles.descriptions.department_head' =>
            'Head of an academic department',
          _ => null,
        } ??
        switch (path) {
          'roles.descriptions.academic_coordinator' =>
            'Coordinates academic programs and scheduling',
          'roles.descriptions.professor' =>
            'Faculty member who teaches and manages courses',
          'roles.descriptions.lecturer' =>
            'Teaches courses without full professor privileges',
          'roles.descriptions.teaching_assistant' =>
            'Assists professors with grading, labs, and tutorials',
          'roles.descriptions.registrar_officer' =>
            'Manages student enrollment and registration',
          'roles.descriptions.academic_advisor' =>
            'Guides students through academic planning',
          'roles.descriptions.librarian' =>
            'Manages library resources and materials',
          'roles.descriptions.freshman' =>
            'First-year student with limited system access',
          'roles.descriptions.regular_student' =>
            'Full student with all standard academic privileges',
          'roles.descriptions.student' => 'General student role',
          'roles.descriptions.class_representative' =>
            'Student leader who represents the class body',
          'roles.descriptions.alumni' =>
            'Graduated student with limited access',
          'roles.descriptions.dorm_supervisor' =>
            'Manages student dormitory operations',
          'roles.descriptions.security_officer' =>
            'Campus security and access control',
          'roles.descriptions.guest' => 'Temporary visitor with minimal access',
          'roles.descriptions.parent' =>
            'Can view linked student progress and grades',
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
          'academic.are_you_sure_you_want_to_remov' =>
            'Are you sure you want to remove this TA?',
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
          'academic.cs402_artificial_intelligence' =>
            'CS402 Artificial Intelligence',
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
          'academic.file_will_be_uploaded_to_cloud' =>
            'File will be uploaded to cloud storage',
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
          'academic.select_a_ta_from_the_list_to_a' =>
            'Select a TA from the list to add',
          'academic.sessions_this_week' => 'Sessions This Week',
          'academic.shared_files' => 'Shared Files',
          'academic.sophomore' => 'Sophomore',
          'academic.specialization_projects' => 'Specialization Projects',
          'academic.spring_2024' => 'Spring 2024',
          'academic.start_by_adding_the_first_ta_f' =>
            'Start by adding the first TA for your course',
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
          'admin.confirm_delete_message' =>
            'Are you sure you want to delete this user?',
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
          'admin.are_you_sure_you_want_to_delet' =>
            'Are you sure you want to delete this user?',
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
          'admin.error_snapshoterror' =>
            ({required Object error}) => 'Error: ${error}',
          'admin.faculty_members_1' => 'Faculty Members',
          'admin.failed_to_load_data' => 'Failed to Load Data',
          'admin.filter_users' => 'Filter Users',
          'admin.full_name' => 'Full Name',
          'admin.head_of_department' => 'Head of Department',
          'admin.incidents' => 'Incidents',
          'admin.leadership_stats' => 'Leadership Statistics',
          'admin.level_level' => ({required Object level}) => 'Level ${level}',
          'admin.manage_tags' => 'Manage Tags',
          'admin.min_6_chars' => 'Min. 6 characters',
          'admin.national_id' => 'National ID',
          'admin.nationality' => 'Nationality',
          'admin.no_about_text_available' => 'No About Text Available',
          'admin.no_colleges_found' => 'No Colleges Found',
          'admin.no_dean_assigned' => 'No Dean Assigned',
          'admin.no_departments_found' => 'No Departments Found',
          'admin.no_departments_in_this_college' =>
            'No Departments in This College',
          'admin.no_description_available' => 'No Description Available',
          'admin.no_faculty_records_found' => 'No Faculty Records Found',
          'admin.no_head_assigned' => 'No Head Assigned',
          'admin.no_logs_found' => 'No Logs Found',
          'admin.no_matching_students_found' => 'No Matching Students Found',
          'admin.no_projects_added_yet' => 'No Projects Added Yet',
          'admin.no_settings_found_in_the_datab' =>
            'No settings found in the database',
          'admin.no_users_found' => 'No Users Found',
          'admin.office' => 'Office',
          'admin.password' => 'Password',
          'admin.pending_reg' => 'Pending Registration',
          'admin.permanently_delete_user' => 'Permanently Delete User',
          'admin.phone_number' => 'Phone Number',
          'admin.please_assign_a_dean_for_the_c' =>
            'Please assign a dean for this college',
          'admin.please_assign_a_head_for_the_d' =>
            'Please assign a head for this department',
          'admin.roles_management' => 'Roles Management',
          'admin.save' => 'Save',
          'admin.save_changes' => 'Save Changes',
          'admin.search_by_name_email_phone_id' =>
            'Search by name, email, phone or ID...',
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
          'admin.you_can_manage_professors_and_' =>
            'You can manage professors and more here',
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
          'enrollment.semester_label' =>
            ({required Object semester}) => 'Semester ${semester}',
          'enrollment.academic_year' => 'Academic Year',
          'enrollment.submit_request' => 'Submit Request',
          'enrollment.request_submitted' => 'Request submitted successfully',
          'enrollment.all' => 'All',
          'enrollment.loading' => 'Loading...',
          'enrollment.retry' => 'Retry',
          'enrollment.academic_advisor' => 'Academic Advisor',
          _ => null,
        } ??
        switch (path) {
          'enrollment.advisor_assignment' => 'Advisor Assignment',
          'enrollment.advisor_requestadvisorfullname' =>
            ({required Object name}) => 'Advisor: ${name}',
          'enrollment.advisor_updated_successfully' =>
            'Advisor Updated Successfully',
          'enrollment.approved_1' => 'Approved',
          'enrollment.approved_courses_registered' =>
            'Approved — Courses Registered',
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
          'enrollment.manage_your_tuition_and_paymen' =>
            'Manage your tuition and payments',
          'enrollment.mmm_dd_yyyy' => 'MMM dd, yyyy',
          'enrollment.my_invoices' => 'My Invoices',
          'enrollment.next_pick_schedules' => 'Next: Pick Schedules',
          'enrollment.no_advisor' => 'No Advisor',
          'enrollment.no_invoices_found' => 'No Invoices Found',
          'enrollment.no_requests_found' => 'No Requests Found',
          'enrollment.no_schedules_available_for_thi' =>
            'No schedules available for this course',
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
          'enrollment.select_the_subjects_you_want_t' =>
            'Select the subjects you want to register',
          'enrollment.select_your_courses' => 'Select Your Courses',
          'enrollment.selected_schedule_summary' => 'Selected Schedule Summary',
          'enrollment.semester_requestsemester' =>
            ({required Object semester}) => 'Semester: ${semester}',
          'enrollment.sub' => 'Sub',
          'enrollment.summaryoverduecount_overdue' =>
            ({required Object count}) => '${count} Overdue',
          'enrollment.total_invoices' => 'Total Invoices',
          'enrollment.unassigned_only' => 'Unassigned Only',
          'enrollment.unpaid' => 'Unpaid',
          'enrollment.withdrawn' => 'Withdrawn',
          'enrollment.you_have_successfully_register' =>
            'You have successfully registered your courses!',
          'enrollment.your_account_is_clearnno_invoi' =>
            'Your account is clear. No invoices found.',
          'enrollment.no_schedules_available' => 'No schedules available',
          'enrollment.registration_success_message' =>
            'Registration successful!',
          'enrollment.advisor_name_label' =>
            ({required Object name}) => 'Advisor: ${name}',
          'enrollment.semester_label_with_value' =>
            ({required Object semester}) => 'Semester: ${semester}',
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
          'shared.this_feature_is_under_developm' =>
            'This feature is under development',
          'shared.threads' => 'Threads',
          'shared.tutorials' => 'Tutorials',
          'shared.twofactor_auth' => 'Two-Factor Authentication',
          'shared.update_your_login_credentials' =>
            'Update your login credentials',
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
          'extracted.change_profile_photo' => 'Change Profile Photo',
          'extracted.take_photo' => 'Take Photo',
          'extracted.choose_from_gallery' => 'Choose from Gallery',
          'extracted.remove_photo' => 'Remove Photo',
          'extracted.save' => 'Save',
          'extracted.user' => 'User',
          'extracted.personal_info' => 'Personal Info',
          'extracted.full_name' => 'Full Name',
          'extracted.required' => 'Required',
          'extracted.email' => 'Email',
          'extracted.phone_number' => 'Phone Number',
          'extracted.national_id' => 'National ID',
          'extracted.about_me' => 'About Me',
          'extracted.write_something_about_yourself' =>
            'Write something about yourself...',
          'extracted.account_info' => 'Account Info',
          'extracted.role' => 'Role',
          'extracted.account_status' => 'Account Status',
          'extracted.active' => 'Active',
          'extracted.save_changes' => 'Save Changes',
          'extracted.account' => 'Account',
          'extracted.appearance' => 'Appearance',
          'extracted.notifications' => 'Notifications',
          'extracted.language_region' => 'Language & Region',
          'extracted.support_feedback' => 'Support & Feedback',
          'extracted.about' => 'About',
          'extracted.edit_profile' => 'Edit Profile',
          'extracted.update_your_personal_info_and_photo' =>
            'Update your personal info and photo',
          'extracted.password_recovery' => 'Password Recovery',
          'extracted.send_password_recovery_link_to_your_emai' =>
            'Send password recovery link to your email',
          'extracted.dark_mode' => 'Dark Mode',
          'extracted.toggle_between_dark_and_light_mode' =>
            'Toggle between dark and light mode',
          'extracted.ui_style' => 'UI Style',
          'extracted.current_glass_design' => 'Current: Glass Design',
          'extracted.current_classic_design' => 'Current: Classic Design',
          'extracted.kSwitch' => 'Switch',
          'extracted.battery_saver_mode' => 'Battery Saver Mode',
          'extracted.disable_complex_visual_effects' =>
            'Disable complex visual effects',
          'extracted.app_notifications' => 'App Notifications',
          'extracted.notifications_are_active' => 'Notifications are active',
          'extracted.notifications_are_off' => 'Notifications are off',
          'extracted.notification_center' => 'Notification Center',
          'extracted.view_all_your_notifications' =>
            'View all your notifications',
          'extracted.test_notification' => 'Test Notification',
          'extracted.send_a_test_notification' => 'Send a test notification',
          'extracted.test_notification_sent' => 'Test notification sent!',
          'extracted.app_language' => 'App Language',
          'extracted.support_center' => 'Support Center',
          'extracted.get_help_and_resolve_any_issues' =>
            'Get help and resolve any issues',
          'extracted.send_feedback' => 'Send Feedback',
          'extracted.share_your_thoughts_to_help_improve_the_' =>
            'Share your thoughts to help improve the app',
          'extracted.rate_the_app' => 'Rate the App',
          'extracted.your_support_matters' => '⭐ Your support matters',
          'extracted.thank_you_for_your_support' =>
            'Thank you for your support! 🎉',
          'extracted.about_app' => 'About App',
          'extracted.version_details_and_developer_info' =>
            'Version details and developer info',
          'extracted.privacy_policy' => 'Privacy Policy',
          'extracted.terms_and_rules_for_data_usage' =>
            'Terms and rules for data usage',
          'extracted.log_out' => 'Log Out',
          'extracted.how_can_we_help_you' => 'How can we help you?',
          'extracted.email_support' => 'Email Support',
          'extracted.call_hotline' => 'Call Hotline',
          'extracted.chat_with_us_on_whatsapp' => 'Chat with us on WhatsApp',
          'extracted.your_opinion_helps_us_improve' =>
            'Your opinion helps us improve',
          'extracted.write_your_feedback_here' => 'Write your feedback here...',
          'extracted.thank_you_feedback_submitted' =>
            '✅ Thank you! Feedback submitted.',
          'extracted.submit_feedback' => 'Submit Feedback',
          'extracted.departments' => 'Departments',
          'extracted.students' => 'Students',
          'extracted.est' => 'Est.',
          'extracted.add_department' => 'Add Department',
          'extracted.add_new_department' => 'Add New Department',
          'extracted.department_name_en' => 'Department Name (EN)',
          'extracted.department_name_ar' => 'Department Name (AR)',
          'extracted.department_code' => 'Department Code',
          'extracted.description' => 'Description',
          'extracted.cancel' => 'Cancel',
          'extracted.add' => 'Add',
          'extracted.staff' => 'Staff',
          'extracted.building' => 'Building',
          'extracted.assistant_head' => 'Assistant Head',
          'extracted.no_assistant_assigned' => 'No Assistant Assigned',
          'extracted.please_assign_an_assistant_head_for_the_' =>
            'Please assign an assistant head for the department',
          'extracted.add_staff' => 'Add Staff',
          'extracted.no_faculty_members_assigned' =>
            'No faculty members assigned',
          'extracted.add_faculty' => 'Add Faculty',
          'extracted.head' => 'Head',
          'extracted.asst' => 'Asst.',
          'extracted.remove' => 'Remove',
          'extracted.add_faculty_member' => 'Add Faculty Member',
          'extracted.confirm_removal' => 'Confirm Removal',
          'extracted.remove_stafffullname_from_this_department' =>
            ({required Object staff_fullName}) =>
                'Remove ${staff_fullName} from this department?',
          'extracted.roles_management' => 'Roles Management',
          'extracted.merge_roles' => 'Merge Roles',
          'extracted.create_role' => 'Create Role',
          'extracted.search_roles' => 'Search roles...',
          'extracted.custom' => 'Custom',
          'extracted.no_results' => 'No results',
          'extracted.no_roles' => 'No roles',
          'extracted.no_custom_roles_yet' => 'No custom roles yet',
          'extracted.create_a_new_role_or_merge_two_roles' =>
            'Create a new role or merge two roles',
          'extracted.create' => 'Create',
          'extracted.merge' => 'Merge',
          'extracted.could_not_load_custom_roles' =>
            'Could not load custom roles',
          'extracted.make_sure_roles_table_exists_in_supabase' =>
            'Make sure "roles" table exists in Supabase',
          'extracted.create_new_role' => 'Create New Role',
          'extracted.name_english' => 'Name (English)',
          'extracted.name_arabic' => 'Name (Arabic)',
          'extracted.category' => 'Category',
          'extracted.description_english' => 'Description (English)',
          'extracted.description_arabic' => 'Description (Arabic)',
          'extracted.permissions' => 'Permissions',
          'extracted.role_created' => 'Role created',
          'extracted.merge_two_roles' => 'Merge Two Roles',
          'extracted.select_two_roles_to_combine_their_permis' =>
            'Select two roles to combine their permissions',
          'extracted.first_role' => 'First Role',
          'extracted.second_role' => 'Second Role',
          'extracted.merged_role_name_english' => 'Merged Role Name (English)',
          'extracted.merged_role_name_arabic' => 'Merged Role Name (Arabic)',
          'extracted.merged_permissions_preview' =>
            'Merged Permissions Preview',
          'extracted.roles_merged_successfully' => 'Roles merged successfully',
          'extracted.edit_role' => 'Edit Role',
          'extracted.role_updated' => 'Role updated',
          'extracted.delete_role' => 'Delete Role',
          'extracted.delete_role_rolenameen_this_cannot_be_undone' =>
            ({required Object role_nameEn}) =>
                'Delete "${role_nameEn}"? This cannot be undone.',
          'extracted.delete' => 'Delete',
          'extracted.admin_it' => 'Admin & IT',
          'extracted.leadership' => 'Leadership',
          'extracted.teaching' => 'Teaching',
          'extracted.student_affairs' => 'Student Affairs',
          'extracted.facilities' => 'Facilities',
          'extracted.external' => 'External',
          'extracted.permissions_1' => 'Permissions:',
          'extracted.merged' => 'MERGED',
          'extracted.user_details' => 'User Details',
          'extracted.quick_actions' => 'Quick Actions',
          'extracted.verification' => 'Verification',
          'extracted.ban_management' => 'Ban Management',
          'extracted.tags' => 'Tags',
          'extracted.warning_level' => 'Warning Level',
          'extracted.danger_zone' => 'Danger Zone',
          'extracted.verified' => 'Verified',
          'extracted.banned' => 'Banned',
          'extracted.deactivate' => 'Deactivate',
          'extracted.activate' => 'Activate',
          'extracted.unverify' => 'Unverify',
          'extracted.verify' => 'Verify',
          'extracted.unban' => 'Unban',
          'extracted.ban' => 'Ban',
          'extracted.account_verified' => 'Account Verified',
          'extracted.not_verified' => 'Not Verified',
          'extracted.user_identity_has_been_verified' =>
            'User identity has been verified',
          'extracted.identity_not_yet_verified' => 'Identity not yet verified',
          'extracted.user_banned' => 'User Banned',
          'extracted.not_banned' => 'Not Banned',
          'extracted.user_cannot_access_the_system' =>
            'User cannot access the system',
          'extracted.user_has_normal_access' => 'User has normal access',
          'extracted.no_tags_assigned' => 'No tags assigned',
          'extracted.add_tag' => 'Add Tag',
          'extracted.current_level' => 'Current Level',
          'extracted.created' => 'Created',
          'extracted.last_login' => 'Last Login',
          'extracted.nationality' => 'Nationality',
          'extracted.soft_delete_deactivate' => 'Soft Delete (Deactivate)',
          'extracted.permanently_delete' => 'Permanently Delete',
          'extracted.verify_account' => 'Verify Account',
          'extracted.remove_verification' => 'Remove Verification',
          'extracted.verify_userfullname' =>
            ({required Object user_fullName}) => 'Verify ${user_fullName}',
          'extracted.remove_verification_from_userfullname' =>
            ({required Object user_fullName}) =>
                'Remove verification from ${user_fullName}?',
          'extracted.ban_user' => 'Ban User',
          'extracted.unban_user' => 'Unban User',
          'extracted.ban_userfullname_they_will_lose_system_access' =>
            ({required Object user_fullName}) =>
                'Ban ${user_fullName}? They will lose system access.',
          'extracted.unban_userfullname' =>
            ({required Object user_fullName}) => 'Unban ${user_fullName}?',
          'extracted.warning_level_set_to_level' =>
            ({required Object level}) => 'Warning level set to ${level}',
          'extracted.tag_removed' => 'Tag removed',
          'extracted.tag_name' => 'Tag name',
          'extracted.permanent_delete' => 'Permanent Delete',
          'extracted.soft_delete' => 'Soft Delete',
          'extracted.permanently_delete_userfullname_this_cannot_be_undone' =>
            ({required Object user_fullName}) =>
                'Permanently delete ${user_fullName}? This cannot be undone!',
          'extracted.deactivate_userfullname' =>
            ({required Object user_fullName}) => 'Deactivate ${user_fullName}',
          'extracted.institution' => 'Institution',
          'extracted.select_college' => 'Select College',
          'extracted.college_is_required' => 'College is required',
          'extracted.select_department' => 'Select Department',
          'extracted.department_is_required' => 'Department is required',
          'extracted.out_of_max' => ({required Object max}) => 'OUT OF ${max}',
          'extracted.exceeding' => 'Exceeding',
          'extracted.top_5' => 'Top 5%',
          'extracted.total' => 'Total',
          'extracted.grade' => 'Grade',
          'extracted.mmm_dd_yyyy' => 'MMM dd, yyyy',
          'extracted.no_projects_available_yet' => 'No projects available yet',
          'extracted.details' => 'Details',
          'extracted.completed' => 'Completed',
          'extracted.paused' => 'Paused',
          'extracted.cancelled' => 'Cancelled',
          'extracted.faculty_members' => 'Faculty Members',
          'extracted.please_assign_an_assistant_head_for_the' =>
            'Please assign an assistant head for the department',
          'extracted.roles' => 'Roles',
          'extracted.permissions_2' => 'Permissions',
          'extracted.academic_leadership' => 'Academic Leadership',
          'extracted.administration' => 'Administration',
          'extracted.manage_grades' => 'Manage Grades',
          'extracted.manage_attendance' => 'Manage Attendance',
          'extracted.manage_tas' => 'Manage TAs',
          'extracted.loading_profile' => 'Loading Profile...',
          'extracted.manage_groups' => 'Manage Groups',
          'extracted.upload_materials' => 'Upload Materials',
          'extracted.professor_chat' => 'Professor Chat',
          'extracted.manage_courses' => 'Manage Courses',
          'extracted.manage_schedules' => 'Manage Schedules',
          'extracted.approve_enrollments' => 'Approve Enrollments',
          'extracted.announcements' => 'Announcements',
          'extracted.manage_enrollments' => 'Manage Enrollments',
          'extracted.academic_advising' => 'Academic Advising',
          'extracted.manage_library' => 'Manage Library',
          'extracted.student_records' => 'Student Records',
          'extracted.manage_users' => 'Manage Users',
          'extracted.manage_colleges' => 'Manage Colleges',
          'extracted.manage_departments' => 'Manage Departments',
          'extracted.audit_logs' => 'Audit Logs',
          'extracted.manage_roles' => 'Manage Roles',
          'extracted.finances' => 'Finances',
          'extracted.you_do_not_have_permission_to_access_this_section' =>
            'You do not have permission to access this section',
          'extracted.personal_details' => 'Personal Details',
          'extracted.account_credentials' => 'Account Credentials',
          'extracted.roles_permissions' => 'Roles & Permissions',
          'extracted.academic_affiliation' => 'Academic Affiliation',
          'extracted.gender' => 'Gender',
          'extracted.male' => 'Male',
          'extracted.female' => 'Female',
          'extracted.enter_prefix_only' => 'Enter prefix only (e.g., ahmed123)',
          'extracted.previous' => 'Previous',
          'extracted.create_account' => 'Create Account',
          'extracted.next' => 'Next',
          'extracted.about_college' => 'About College',
          'extracted.origins_roots' => 'Origins & Roots',
          'extracted.vision_mission' => 'Vision & Mission',
          'extracted.strategic_goals' => 'Strategic Goals',
          'extracted.faculty_management' => 'Faculty Management',
          'extracted.faculty_staff' => 'Faculty & Staff',
          'extracted.no_staff_registered_yet' => 'No staff registered yet',
          'extracted.scientific_departments' => 'Scientific Departments',
          'extracted.posted_successfully' => 'Posted Successfully!',
          'extracted.your_post_is_now_live_on_the_feed' =>
            'Your post is now live on the feed',
          'extracted.create_post' => 'Create Post',
          'extracted.post' => 'Post',
          'extracted.as_college' => 'As College',
          'extracted.public' => 'Public',
          'extracted.mention_collegedept' => 'Mention College/Dept',
          'extracted.dept' => 'Dept',
          'extracted.whats_on_your_mind' => 'What\'s on your mind?',
          'extracted.paste_link_here' => 'Paste link here...',
          'extracted.add_to_your_post' => 'Add to your post',
          'extracted.en' => 'en',
          'extracted.news' => 'News',
          'extracted.edit_post' => 'Edit Post',
          'extracted.write_something' => 'Write something...',
          'extracted.dashboard' => 'Dashboard',
          'extracted.share_your_thoughts_to_help_improve_the' =>
            'Share your thoughts to help improve the system',
          _ => null,
        };
  }
}

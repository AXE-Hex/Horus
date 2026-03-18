///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import
// dart format off

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

// Path: <root>
class TranslationsAr with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsAr _root = this; // ignore: unused_field

	@override 
	TranslationsAr $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsAr(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonAr common = _TranslationsCommonAr._(_root);
	@override late final _TranslationsWelcomeAr welcome = _TranslationsWelcomeAr._(_root);
	@override late final _TranslationsOnboardingAr onboarding = _TranslationsOnboardingAr._(_root);
	@override late final _TranslationsAuthAr auth = _TranslationsAuthAr._(_root);
	@override late final _TranslationsHomeAr home = _TranslationsHomeAr._(_root);
	@override late final _TranslationsFeedAr feed = _TranslationsFeedAr._(_root);
	@override late final _TranslationsDashboardAr dashboard = _TranslationsDashboardAr._(_root);
	@override late final _TranslationsSettingsAr settings = _TranslationsSettingsAr._(_root);
	@override late final _TranslationsCollegesAr colleges = _TranslationsCollegesAr._(_root);
	@override late final _TranslationsTranscriptAr transcript = _TranslationsTranscriptAr._(_root);
	@override late final _TranslationsAcademicProgressAr academic_progress = _TranslationsAcademicProgressAr._(_root);
	@override late final _TranslationsGradesAr grades = _TranslationsGradesAr._(_root);
	@override late final _TranslationsSubjectResultsAr subject_results = _TranslationsSubjectResultsAr._(_root);
	@override late final _TranslationsActionPlanAr action_plan = _TranslationsActionPlanAr._(_root);
	@override late final _TranslationsCoursesAr courses = _TranslationsCoursesAr._(_root);
	@override late final _TranslationsScheduleAr schedule = _TranslationsScheduleAr._(_root);
	@override late final _TranslationsExamScheduleAr exam_schedule = _TranslationsExamScheduleAr._(_root);
	@override late final _TranslationsAttendanceAr attendance = _TranslationsAttendanceAr._(_root);
	@override late final _TranslationsRegistrationAr registration = _TranslationsRegistrationAr._(_root);
	@override late final _TranslationsPaymentAr payment = _TranslationsPaymentAr._(_root);
	@override late final _TranslationsInvoicesAr invoices = _TranslationsInvoicesAr._(_root);
	@override late final _TranslationsNotificationsAr notifications = _TranslationsNotificationsAr._(_root);
	@override late final _TranslationsSupportAr support = _TranslationsSupportAr._(_root);
	@override late final _TranslationsSecurityAr security = _TranslationsSecurityAr._(_root);
	@override late final _TranslationsTutorialsAr tutorials = _TranslationsTutorialsAr._(_root);
	@override late final _TranslationsForumsAr forums = _TranslationsForumsAr._(_root);
	@override late final _TranslationsAdministrationAr administration = _TranslationsAdministrationAr._(_root);
	@override late final _TranslationsProfessorAr professor = _TranslationsProfessorAr._(_root);
	@override late final _TranslationsRolesAr roles = _TranslationsRolesAr._(_root);
	@override late final _TranslationsExtractedAr extracted = _TranslationsExtractedAr._(_root);
	@override late final _TranslationsAcademicAr academic = _TranslationsAcademicAr._(_root);
	@override late final _TranslationsAdminAr admin = _TranslationsAdminAr._(_root);
	@override late final _TranslationsEnrollmentAr enrollment = _TranslationsEnrollmentAr._(_root);
	@override late final _TranslationsSharedAr shared = _TranslationsSharedAr._(_root);
	@override late final _TranslationsStudentsAr students = _TranslationsStudentsAr._(_root);
}

// Path: common
class _TranslationsCommonAr implements TranslationsCommonEn {
	_TranslationsCommonAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get close => 'إغلاق';
	@override String get cancel => 'إلغاء';
	@override String get confirm => 'تأكيد';
	@override String get save => 'حفظ';
	@override String get back => 'رجوع';
}

// Path: welcome
class _TranslationsWelcomeAr implements TranslationsWelcomeEn {
	_TranslationsWelcomeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مرحبا بك في Hue';
	@override String get subtitle => 'أنر عالمك باتصالات ذات مغزى.';
	@override String get get_started => 'ابدأ الآن';
	@override String get have_account => 'لدي حساب بالفعل';
	@override String get i_already_have_an_account => 'لدي حساب بالفعل';
	@override String get student_portal => 'بوابة HUE';
	@override String get welcome_to_the_smart_universit => 'مرحبا بكم في الجامعة الذكية';
}

// Path: onboarding
class _TranslationsOnboardingAr implements TranslationsOnboardingEn {
	_TranslationsOnboardingAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsOnboardingLanguageAr language = _TranslationsOnboardingLanguageAr._(_root);
	@override late final _TranslationsOnboardingFacultiesDirectoryAr faculties_directory = _TranslationsOnboardingFacultiesDirectoryAr._(_root);
	@override late final _TranslationsOnboardingStyleAr style = _TranslationsOnboardingStyleAr._(_root);
	@override late final _TranslationsOnboardingThemeAr theme = _TranslationsOnboardingThemeAr._(_root);
	@override String get you_can_switch_styles_later_in => 'يمكنك تبديل الأنماط لاحقًا في الإعدادات';
	@override String get select_the_lighting_that_suits => 'اختر الإضاءة التي تناسبك';
	@override String get title => 'الإعداد';
	@override String get high_performance_flat_solid_co => 'ألوان صلبة مسطحة عالية الأداء';
	@override String get modern_glass => 'الزجاج الحديث';
	@override String get you_can_change_this_later_in_s => 'يمكنك تغيير هذا لاحقًا في الإعدادات';
	@override String get almost_there_just_one_more_ste => 'تقريبا هناك! مجرد خطوة واحدة أخرى.';
	@override String get recommended => 'مُستَحسَن';
	@override String get choose_app_theme => 'اختر الموضوع الخاص بك';
	@override String get dark_mode => 'الوضع المظلم';
	@override String get choose_app_style => 'اختر نمط التطبيق الخاص بك';
	@override String get light_mode => 'وضع الضوء';
	@override String get choose_language => 'اختر لغتك';
	@override String get classic_solid => 'كلاسيكي';
	@override String get premium_frosted_glass_blur_eff => 'تأثير طمس زجاجي بلوري ممتاز';
}

// Path: auth
class _TranslationsAuthAr implements TranslationsAuthEn {
	_TranslationsAuthAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthLoginAr login = _TranslationsAuthLoginAr._(_root);
	@override late final _TranslationsAuthForgotPasswordAr forgot_password = _TranslationsAuthForgotPasswordAr._(_root);
	@override String get back => 'خلف';
	@override String get choose_account_recovery_method => 'اختر طريقة استرداد الحساب';
}

// Path: home
class _TranslationsHomeAr implements TranslationsHomeEn {
	_TranslationsHomeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeTabsAr tabs = _TranslationsHomeTabsAr._(_root);
	@override String get admin_portal => 'بوابة المشرف';
	@override String get prof => 'أستاذ';
	@override String get home => 'الرئيسية';
	@override String get student_portal => 'بوابة الطالب';
	@override String get student => 'طالب';
	@override String get colleges => 'الكليات';
	@override String get admin => 'إدارة';
	@override String get faculty_portal => 'بوابة الكلية';
}

// Path: feed
class _TranslationsFeedAr implements TranslationsFeedEn {
	_TranslationsFeedAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get likes => 'إعجابات';
	@override String get caption_sample => 'هذا مثال لشرح المنشور';
	@override String get hours_ago => 'منذ ساعتين';
}

// Path: dashboard
class _TranslationsDashboardAr implements TranslationsDashboardEn {
	_TranslationsDashboardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDashboardIdCardAr id_card = _TranslationsDashboardIdCardAr._(_root);
	@override late final _TranslationsDashboardSectionsAr sections = _TranslationsDashboardSectionsAr._(_root);
	@override late final _TranslationsDashboardItemsAr items = _TranslationsDashboardItemsAr._(_root);
	@override late final _TranslationsDashboardLabelsAr labels = _TranslationsDashboardLabelsAr._(_root);
}

// Path: settings
class _TranslationsSettingsAr implements TranslationsSettingsEn {
	_TranslationsSettingsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإعدادات';
	@override late final _TranslationsSettingsSectionsAr sections = _TranslationsSettingsSectionsAr._(_root);
	@override late final _TranslationsSettingsTilesAr tiles = _TranslationsSettingsTilesAr._(_root);
	@override late final _TranslationsSettingsMessagesAr messages = _TranslationsSettingsMessagesAr._(_root);
	@override String get about_app => 'حول التطبيق';
	@override String get university => 'جامعة حورس';
	@override String get user => 'مستخدم';
	@override String get horus_university => 'جامعة حورس – مصر';
	@override String get developer => 'المطور';
	@override String get platform => 'منصة';
	@override String get hue_portal_is_a_comprehensive_ => 'بوابة HUE هي نظام إدارة جامعي ذكي شامل.';
	@override String get backend => 'الخلفية';
	@override String get change_password => 'تغيير كلمة المرور';
	@override String get passwords_do_not_match => 'كلمات المرور غير متطابقة';
	@override String get enter_your_new_password => 'أدخل كلمة المرور الجديدة أدناه';
	@override String get password_must_be_at_least_6_ch => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل';
	@override String get confirm_password => 'تأكيد كلمة المرور';
	@override String get privacy_policy => 'سياسة الخصوصية';
	@override String get password_changed_successfully => 'تم تغيير كلمة المرور بنجاح';
	@override String get new_password => 'كلمة المرور الجديدة';
	@override String get please_fill_all_fields => 'يرجى ملء جميع الحقول';
	@override String get last_updated_february_2026 => 'آخر تحديث: فبراير 2026';
	@override String get edit_profile => 'تحرير الملف الشخصي';
	@override String get role => 'دور';
	@override String get phone => 'هاتف';
	@override String get email => 'بريد إلكتروني';
	@override String get bio => 'السيرة الذاتية';
	@override String get full_name => 'الاسم الكامل';
	@override String get update_your_info_and_contact_d => 'قم بتحديث معلوماتك وتفاصيل الاتصال بك';
	@override String get change_password_and_security_l => 'تغيير كلمة المرور ومستوى الأمان';
	@override String get save => 'يحفظ';
	@override String get forgot_password => 'هل نسيت كلمة السر';
	@override String get send_password_recovery_link_to => 'أرسل رابط استعادة كلمة المرور إلى بريدك الإلكتروني';
	@override String get toggle_between_dark_and_light_ => 'التبديل بين الوضع الداكن والخفيف';
	@override String get control_the_types_of_incoming_ => 'التحكم في أنواع الإخطارات الواردة';
	@override String get current_glass_design => 'الحالي: تصميم الزجاج';
	@override String get disable_complex_visual_effects => 'قم بتعطيل التأثيرات المرئية المعقدة للحصول على أداء أفضل';
	@override String get current_classic_design => 'الحالي: تصميم كلاسيكي';
	@override String get test_notification_successful => 'تم إرسال إشعار الاختبار بنجاح!';
	@override String get battery_saver_mode => 'وضع توفير البطارية';
	@override String get switch_style => 'تبديل النمط';
	@override String get send_a_test_notification => 'إرسال إشعار الاختبار';
	@override String get version_details_and_developers => 'تفاصيل الإصدار ومعلومات المطور';
	@override String get terms_and_rules_for_data_usage => 'شروط وقواعد استخدام البيانات';
	@override String get help_support_center => 'مركز المساعدة والدعم';
	@override String get select_app_language => 'حدد لغة التطبيق';
	@override String get deutsch => 'الألمانية';
	@override String get dynamic_val => 'متحرك';
	@override String get contact_us_to_resolve_any_issu => 'اتصل بنا لحل أي مشكلة';
	@override String get kSwitch => 'يُحوّل';
	@override String get switch_label => 'يُحوّل';
}

// Path: colleges
class _TranslationsCollegesAr implements TranslationsCollegesEn {
	_TranslationsCollegesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsCollegesDetailsAr details = _TranslationsCollegesDetailsAr._(_root);
	@override String get applied_health_sciences => 'كلية تكنولوجيا العلوم الصحية التطبيقية';
	@override String get business_administration => 'كلية إدارة الأعمال';
	@override String get dentistry => 'كلية طب الفم والأسنان';
	@override String get engineering => 'كلية الهندسة';
	@override String get fine_arts => 'كلية الفنون الجميلة';
	@override String get human_medicine => 'كلية الطب البشري';
	@override String get linguistics => 'كلية الألسن والترجمة';
	@override String get pharmacy => 'كلية الصيدلة';
	@override String get physical_therapy => 'كلية العلاج الطبيعي';
	@override String get ai => 'كلية الذكاء الاصطناعي';
	@override late final _TranslationsCollegesDepartmentsAr departments = _TranslationsCollegesDepartmentsAr._(_root);
}

// Path: transcript
class _TranslationsTranscriptAr implements TranslationsTranscriptEn {
	_TranslationsTranscriptAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'السجل الأكاديمي';
	@override late final _TranslationsTranscriptOverviewAr overview = _TranslationsTranscriptOverviewAr._(_root);
	@override late final _TranslationsTranscriptSemesterAr semester = _TranslationsTranscriptSemesterAr._(_root);
	@override late final _TranslationsTranscriptCourseAr course = _TranslationsTranscriptCourseAr._(_root);
}

// Path: academic_progress
class _TranslationsAcademicProgressAr implements TranslationsAcademicProgressEn {
	_TranslationsAcademicProgressAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التقدم الدراسي';
	@override String get completion => 'نسبة إنجاز الدرجة العلمية';
	@override String get total_credits => 'إجمالي الساعات';
	@override late final _TranslationsAcademicProgressCategoriesAr categories = _TranslationsAcademicProgressCategoriesAr._(_root);
	@override late final _TranslationsAcademicProgressStatusAr status = _TranslationsAcademicProgressStatusAr._(_root);
}

// Path: grades
class _TranslationsGradesAr implements TranslationsGradesEn {
	_TranslationsGradesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الدرجات';
	@override String get summary => 'ملخص الدرجات';
	@override String get cumulative_gpa => 'المعدل التراكمي';
	@override String get gpa => 'المعدل الفصلي';
	@override String get credits => 'ساعات';
	@override String get grade_point => 'النقاط';
	@override String get letter_grade => 'التقدير';
}

// Path: subject_results
class _TranslationsSubjectResultsAr implements TranslationsSubjectResultsEn {
	_TranslationsSubjectResultsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'نتائج المواد';
	@override String get midterm => 'منتصف الفصل';
	@override String get kFinal => 'الاختبار النهائي';
	@override String get practical => 'العملي';
	@override String get activities => 'أعمال الفصل';
	@override String get total => 'المجموع الكلي';
}

// Path: action_plan
class _TranslationsActionPlanAr implements TranslationsActionPlanEn {
	_TranslationsActionPlanAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الخطة الدراسية';
	@override String get roadmap => 'خريطة المقررات';
	@override String get year_1 => 'السنة الأولى';
	@override String get year_2 => 'السنة الثانية';
	@override String get year_3 => 'السنة الثالثة';
	@override String get year_4 => 'السنة الرابعة';
}

// Path: courses
class _TranslationsCoursesAr implements TranslationsCoursesEn {
	_TranslationsCoursesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مقرراتي';
	@override String get enrolled => 'المسجلة';
	@override String get available => 'المتاحة';
	@override String get instructor => 'المحاضر';
	@override String get schedule => 'الموعد';
}

// Path: schedule
class _TranslationsScheduleAr implements TranslationsScheduleEn {
	_TranslationsScheduleAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'جدول المحاضرات';
	@override String get daily_title => 'الجدول اليومي';
	@override String get no_lectures => 'لا توجد محاضرات اليوم';
	@override String get time => 'الوقت';
	@override String get room => 'القاعة';
	@override String get monday => 'الاثنين';
	@override String get tuesday => 'الثلاثاء';
	@override String get wednesday => 'الأربعاء';
	@override String get thursday => 'الخميس';
	@override String get friday => 'الجمعة';
	@override String get saturday => 'السبت';
	@override String get sunday => 'الأحد';
	@override String get instructor => 'المحاضر';
	@override String get doctor => 'د.';
	@override String get type_lecture => 'محاضرة';
	@override String get type_section => 'سكشن';
	@override String get status_active => 'قادمة';
	@override String get status_started => 'بدأت';
	@override String get status_cancelled => 'ملغاة';
	@override String get status_online => 'أونلاين';
	@override String get status_substitute => 'دكتور بديل';
	@override String get morning => 'صباحي';
	@override String get afternoon => 'مسائي';
	@override String get evening => 'ليلي';
	@override String get all_periods => 'كل الفترات';
	@override String get floor => 'الدور';
	@override String get direction => 'الاتجاه';
	@override String get east => 'شرق';
	@override String get west => 'غرب';
	@override String get south => 'جنوب';
	@override String get north => 'شمال';
}

// Path: exam_schedule
class _TranslationsExamScheduleAr implements TranslationsExamScheduleEn {
	_TranslationsExamScheduleAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'جدول الامتحانات';
	@override String get date => 'التاريخ';
	@override String get duration => 'المدة';
	@override String get seat => 'رقم الجلوس';
}

// Path: attendance
class _TranslationsAttendanceAr implements TranslationsAttendanceEn {
	_TranslationsAttendanceAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'إحصائيات الحضور';
	@override String get present => 'حاضر';
	@override String get absent => 'غائب';
	@override String get late => 'متأخر';
	@override String get ratio => 'نسبة الحضور';
	@override late final _TranslationsAttendanceSubjectsAr subjects = _TranslationsAttendanceSubjectsAr._(_root);
}

// Path: registration
class _TranslationsRegistrationAr implements TranslationsRegistrationEn {
	_TranslationsRegistrationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التسجيل الأكاديمي';
	@override String get submit => 'إرسال طلب التسجيل';
	@override String get enrolled_credits => 'الساعات المسجلة';
	@override String get step1_title => 'الخطوة ١: اختر المجموعة الرئيسية';
	@override String get step1_subtitle => 'اختر المجموعة التي ترغب بالتسجيل فيها لهذا الفصل الدراسي.';
	@override String group_label({required Object group}) => 'المجموعة ${group}';
	@override String get main_cohort => 'تسجيل المجموعة الرئيسية';
	@override String get step2_title => 'الخطوة ٢: اختر القسم الفرعي (السكشن)';
	@override String step2_subtitle({required Object group}) => 'المجموعة المختارة: ${group}. الآن اختر السكشن العملي والتطبيقي.';
	@override String section_label({required Object section}) => 'سكشن ${section}';
	@override String get labs_sessions => 'المعامل والدروس العملية';
	@override String get step3_title => 'الخطوة ٣: تأكيد التسجيل';
	@override String get review => 'مراجعة خياراتك';
	@override String get semester => 'الفصل';
	@override String get group => 'المجموعة';
	@override String get section => 'السكشن';
	@override String get auto_registered => 'المقررات التي سيتم تسجيلها تلقائياً:';
	@override String credits_count({required Object credits}) => '${credits} ساعات';
	@override String get confirm_final => 'تأكيد التسجيل النهائي';
	@override String get already_registered_title => 'مسجل بالفعل!';
	@override String success_message({required Object group, required Object section}) => 'لقد قمت بالتسجيل المسبق بنجاح في هذا الفصل.\nالمجموعة: ${group} | السكشن: ${section}';
	@override String get back_home => 'العودة للرئيسية';
	@override String get registration_success => 'تم التسجيل بنجاح!';
	@override String error_loading({required Object error}) => 'خطأ: ${error}\n\nاضغط لإعادة المحاولة';
}

// Path: payment
class _TranslationsPaymentAr implements TranslationsPaymentEn {
	_TranslationsPaymentAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الدفع الإلكتروني';
	@override String get outstanding => 'المبلغ المستحق';
	@override String get pay_now => 'سداد الآن';
	@override String get methods => 'طرق الدفع';
	@override String get university_guaranteed => 'طرق الدفع بضمان الجامعة';
	@override String get credit_debit => 'بطاقة ائتمان / خصم مباشر';
	@override String get fawry => 'فوري / دفع إلكتروني';
	@override String get bank_transfer => 'تحويل بنكي';
	@override String currency({required Object amount}) => '${amount} ج.م';
}

// Path: invoices
class _TranslationsInvoicesAr implements TranslationsInvoicesEn {
	_TranslationsInvoicesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الفواتير والمالية';
	@override String get history => 'سجل الدفع';
	@override String get unpaid => 'غير مدفوع';
	@override String get paid => 'تم الدفع';
	@override String get id => 'رقم الفاتورة';
	@override String get date => 'التاريخ';
	@override String get amount => 'المبلغ';
	@override String get status => 'الحالة';
}

// Path: notifications
class _TranslationsNotificationsAr implements TranslationsNotificationsEn {
	_TranslationsNotificationsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإشعارات';
	@override String get empty => 'لا توجد إشعارات جديدة';
}

// Path: support
class _TranslationsSupportAr implements TranslationsSupportEn {
	_TranslationsSupportAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الدعم والمساعدة';
	@override String get contact_us => 'اتصل بنا';
}

// Path: security
class _TranslationsSecurityAr implements TranslationsSecurityEn {
	_TranslationsSecurityAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الأمان';
	@override String get biometrics => 'البصمة';
	@override String get sessions => 'الجلسات النشطة';
}

// Path: tutorials
class _TranslationsTutorialsAr implements TranslationsTutorialsEn {
	_TranslationsTutorialsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التعليمات والدروس';
}

// Path: forums
class _TranslationsForumsAr implements TranslationsForumsEn {
	_TranslationsForumsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'المنتديات';
}

// Path: administration
class _TranslationsAdministrationAr implements TranslationsAdministrationEn {
	_TranslationsAdministrationAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'إدارة الطلاب';
	@override String get stats => 'إحصائيات النظام';
	@override String get users => 'المستخدمين';
	@override String get reports => 'التقارير';
	@override late final _TranslationsAdministrationAuditLogsAr audit_logs = _TranslationsAdministrationAuditLogsAr._(_root);
}

// Path: professor
class _TranslationsProfessorAr implements TranslationsProfessorEn {
	_TranslationsProfessorAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get dashboard_title => 'لوحة تحكم الدكتور';
	@override String welcome_back_name({required Object name}) => 'مرحباً بعودتك، ${name}';
	@override String active_tas_count({required Object count}) => '${count} معيد حالي';
	@override String total_students_count({required Object count}) => '${count} إجمالي الطلاب';
	@override String uploaded_files_count({required Object count}) => '${count} ملف مرفوع';
	@override String weekly_slots_count({required Object count}) => '${count} مواعيد أسبوعية';
	@override String announcement_to({required Object count}) => 'إرسال إعلان لـ ${count}';
	@override String get preparing_announcement => 'جاري تجهيز الإعلان...';
	@override String get no_groups => 'لا توجد مجموعات';
	@override String get select_all => 'تحديد الكل';
	@override String get deselect_all => 'إلغاء التحديد';
	@override String selected_count({required Object count}) => '${count} محدد';
	@override String action_clicked({required Object action}) => 'تم النقر: ${action}';
	@override String activating({required Object target}) => 'تفعيل: ${target}';
	@override String get add_new_ta => 'إضافة معيد جديد';
	@override String get no_available_tas => 'لا يوجد معيدون متاحون';
	@override String get no_active_tas => 'لا يوجد معيدون حالياً';
	@override String added({required Object name}) => 'تم إضافة: ${name}';
	@override String removed({required Object name}) => 'تم إزالة: ${name}';
	@override String get add => 'إضافة';
	@override String get urgent => 'عاجل';
	@override String get upload => 'رفع';
	@override String get message => 'مراسلة';
	@override String get downloading => 'جاري التحميل...';
	@override String get walk_in => 'بدون موعد';
	@override String joined({required Object name}) => 'تم الانضمام: ${name}';
	@override String get join => 'انضمام';
	@override late final _TranslationsProfessorStatsAr stats = _TranslationsProfessorStatsAr._(_root);
	@override late final _TranslationsProfessorQuickActionsAr quick_actions = _TranslationsProfessorQuickActionsAr._(_root);
	@override late final _TranslationsProfessorProfileAr profile = _TranslationsProfessorProfileAr._(_root);
}

// Path: roles
class _TranslationsRolesAr implements TranslationsRolesEn {
	_TranslationsRolesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsRolesCategoriesAr categories = _TranslationsRolesCategoriesAr._(_root);
	@override late final _TranslationsRolesNamesAr names = _TranslationsRolesNamesAr._(_root);
	@override late final _TranslationsRolesDescriptionsAr descriptions = _TranslationsRolesDescriptionsAr._(_root);
}

// Path: extracted
class _TranslationsExtractedAr implements TranslationsExtractedEn {
	_TranslationsExtractedAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get change_profile_photo => 'تغيير الصورة الشخصية';
	@override String get take_photo => 'التقاط صورة';
	@override String get choose_from_gallery => 'اختيار من المعرض';
	@override String get remove_photo => 'حذف الصورة';
	@override String get save => 'حفظ';
	@override String get user => 'المستخدم';
	@override String get personal_info => 'المعلومات الشخصية';
	@override String get full_name => 'الاسم الكامل';
	@override String get required => 'مطلوب';
	@override String get email => 'البريد الإلكتروني';
	@override String get phone_number => 'رقم الجوال';
	@override String get national_id => 'رقم الهوية';
	@override String get about_me => 'نبذة شخصية';
	@override String get write_something_about_yourself => 'اكتب نبذة عن نفسك...';
	@override String get account_info => 'معلومات الحساب';
	@override String get role => 'الدور';
	@override String get account_status => 'حالة الحساب';
	@override String get active => 'نشط';
	@override String get save_changes => 'حفظ التغييرات';
	@override String get account => 'بيانات الحساب';
	@override String get appearance => 'المظهر';
	@override String get notifications => 'الإشعارات';
	@override String get language_region => 'اللغة والمنطقة';
	@override String get support_feedback => 'الدعم والتواصل';
	@override String get about => 'حول التطبيق';
	@override String get edit_profile => 'تعديل الملف الشخصي';
	@override String get update_your_personal_info_and_photo => 'تحديث معلوماتك وبياناتك الشخصية';
	@override String get password_recovery => 'استعادة كلمة المرور';
	@override String get send_password_recovery_link_to_your_emai => 'إرسال رابط استعادة كلمة المرور لبريدك الإلكتروني';
	@override String get dark_mode => 'الوضع المظلم';
	@override String get toggle_between_dark_and_light_mode => 'التبديل بين الوضع الداكن والفاتح';
	@override String get ui_style => 'نمط الواجهة';
	@override String get current_glass_design => 'الحالي: تصميم الزجاج';
	@override String get current_classic_design => 'الحالي: التصميم الكلاسيكي';
	@override String get kSwitch => 'تبديل';
	@override String get battery_saver_mode => 'وضع توفير البطارية';
	@override String get disable_complex_visual_effects => 'تعطيل التأثيرات البصرية لأداء أفضل';
	@override String get app_notifications => 'إشعارات التطبيق';
	@override String get notifications_are_active => 'الإشعارات مفعّلة';
	@override String get notifications_are_off => 'الإشعارات موقوفة';
	@override String get notification_center => 'مركز الإشعارات';
	@override String get view_all_your_notifications => 'عرض جميع الإشعارات والتنبيهات';
	@override String get test_notification => 'اختبار الإشعارات';
	@override String get send_a_test_notification => 'إرسال إشعار تجريبي';
	@override String get test_notification_sent => 'تم إرسال الإشعار بنجاح!';
	@override String get app_language => 'لغة التطبيق';
	@override String get support_center => 'مركز الدعم';
	@override String get get_help_and_resolve_any_issues => 'تواصل معنا لحل أي مشكلة';
	@override String get send_feedback => 'إرسال ملاحظة';
	@override String get share_your_thoughts_to_help_improve_the_ => 'شاركنا رأيك لتحسين التطبيق';
	@override String get rate_the_app => 'تقييم التطبيق';
	@override String get your_support_matters => '⭐ دعمك يهمنا';
	@override String get thank_you_for_your_support => 'شكراً على دعمك! 🎉';
	@override String get about_app => 'حول التطبيق';
	@override String get version_details_and_developer_info => 'تفاصيل الإصدار والمطورين';
	@override String get privacy_policy => 'سياسة الخصوصية';
	@override String get terms_and_rules_for_data_usage => 'شروط وقواعد استخدام بياناتك';
	@override String get log_out => 'تسجيل الخروج';
	@override String get how_can_we_help_you => 'كيف يمكننا مساعدتك؟';
	@override String get email_support => 'البريد الإلكتروني';
	@override String get call_hotline => 'خط الدعم الساخن';
	@override String get chat_with_us_on_whatsapp => 'تواصل معنا عبر واتساب';
	@override String get your_opinion_helps_us_improve => 'رأيك يساعدنا على التطوير';
	@override String get write_your_feedback_here => 'اكتب ملاحظتك هنا...';
	@override String get thank_you_feedback_submitted => '✅ شكراً! تم إرسال ملاحظتك بنجاح';
	@override String get submit_feedback => 'إرسال الملاحظة';
	@override String get departments => 'أقسام';
	@override String get students => 'الطلاب';
	@override String get est => 'تأسيس';
	@override String get add_department => 'إضافة قسم جديد';
	@override String get add_new_department => 'إضافة قسم جديد';
	@override String get department_name_en => 'اسم القسم (إنجليزي)';
	@override String get department_name_ar => 'اسم القسم (عربي)';
	@override String get department_code => 'رمز القسم';
	@override String get description => 'الوصف';
	@override String get cancel => 'إلغاء';
	@override String get add => 'إضافة';
	@override String get staff => 'أعضاء';
	@override String get building => 'مبنى';
	@override String get assistant_head => 'مساعد رئيس القسم';
	@override String get no_assistant_assigned => 'لم يتم تعيين مساعد';
	@override String get please_assign_an_assistant_head_for_the_ => 'يرجى تعيين مساعد لرئيس القسم';
	@override String get add_staff => 'إضافة عضو';
	@override String get no_faculty_members_assigned => 'لا يوجد أعضاء هيئة تدريس';
	@override String get add_faculty => 'إضافة عضو هيئة تدريس';
	@override String get head => 'رئيس';
	@override String get asst => 'مساعد';
	@override String get remove => 'إزالة';
	@override String get add_faculty_member => 'إضافة عضو هيئة تدريس';
	@override String get confirm_removal => 'تأكيد الإزالة';
	@override String remove_stafffullname_from_this_department({required Object staff_fullName}) => 'هل تريد إزالة ${staff_fullName} من هذا القسم؟';
	@override String get roles_management => 'إدارة الرتب';
	@override String get merge_roles => 'دمج رتبتين';
	@override String get create_role => 'إنشاء رتبة جديدة';
	@override String get search_roles => 'بحث عن رتبة...';
	@override String get custom => 'مخصصة';
	@override String get no_results => 'لا توجد نتائج';
	@override String get no_roles => 'لا توجد رتب';
	@override String get no_custom_roles_yet => 'لا توجد رتب مخصصة بعد';
	@override String get create_a_new_role_or_merge_two_roles => 'أنشئ رتبة جديدة أو ادمج رتبتين';
	@override String get create => 'إنشاء';
	@override String get merge => 'دمج';
	@override String get could_not_load_custom_roles => 'لا يمكن تحميل الرتب المخصصة';
	@override String get make_sure_roles_table_exists_in_supabase => 'تأكد من وجود جدول "roles" في Supabase';
	@override String get create_new_role => 'إنشاء رتبة جديدة';
	@override String get name_english => 'الاسم بالإنجليزية';
	@override String get name_arabic => 'الاسم بالعربية';
	@override String get category => 'القسم';
	@override String get description_english => 'الوصف بالإنجليزية';
	@override String get description_arabic => 'الوصف بالعربية';
	@override String get permissions => 'الصلاحيات';
	@override String get role_created => 'تم إنشاء الرتبة بنجاح';
	@override String get merge_two_roles => 'دمج رتبتين';
	@override String get select_two_roles_to_combine_their_permis => 'اختر رتبتين لدمجهما وإنشاء رتبة مدمجة جديدة';
	@override String get first_role => 'الرتبة الأولى';
	@override String get second_role => 'الرتبة الثانية';
	@override String get merged_role_name_english => 'اسم الرتبة المدمجة (إنجليزي)';
	@override String get merged_role_name_arabic => 'اسم الرتبة المدمجة (عربي)';
	@override String get merged_permissions_preview => 'معاينة الصلاحيات المدمجة';
	@override String get roles_merged_successfully => 'تم دمج الرتبتين بنجاح';
	@override String get edit_role => 'تعديل الرتبة';
	@override String get role_updated => 'تم تحديث الرتبة';
	@override String get delete_role => 'حذف الرتبة';
	@override String delete_role_rolenameen_this_cannot_be_undone({required Object role_nameEn}) => 'هل تريد حذف "${role_nameEn}"؟ لا يمكن التراجع.';
	@override String get delete => 'حذف';
	@override String get admin_it => 'الإدارة والتقنية';
	@override String get leadership => 'القيادة الأكاديمية';
	@override String get teaching => 'الهيئة التدريسية';
	@override String get student_affairs => 'شؤون الطلاب';
	@override String get facilities => 'المرافق والأمن';
	@override String get external => 'خارجي';
	@override String get permissions_1 => 'الصلاحيات:';
	@override String get merged => 'مدمجة';
	@override String get user_details => 'تفاصيل المستخدم';
	@override String get quick_actions => 'إجراءات سريعة';
	@override String get verification => 'التوثيق';
	@override String get ban_management => 'الحظر';
	@override String get tags => 'العلامات';
	@override String get warning_level => 'مستوى التحذير';
	@override String get danger_zone => 'منطقة الخطر';
	@override String get verified => 'موثق';
	@override String get banned => 'محظور';
	@override String get deactivate => 'تعطيل';
	@override String get activate => 'تفعيل';
	@override String get unverify => 'إلغاء التوثيق';
	@override String get verify => 'توثيق';
	@override String get unban => 'إلغاء الحظر';
	@override String get ban => 'حظر';
	@override String get account_verified => 'الحساب موثق';
	@override String get not_verified => 'الحساب غير موثق';
	@override String get user_identity_has_been_verified => 'تم التحقق من هوية المستخدم';
	@override String get identity_not_yet_verified => 'لم يتم التحقق بعد';
	@override String get user_banned => 'المستخدم محظور';
	@override String get not_banned => 'غير محظور';
	@override String get user_cannot_access_the_system => 'المستخدم لا يمكنه الوصول للنظام';
	@override String get user_has_normal_access => 'المستخدم يمكنه الوصول بشكل طبيعي';
	@override String get no_tags_assigned => 'لا توجد علامات';
	@override String get add_tag => 'إضافة علامة';
	@override String get current_level => 'المستوى الحالي';
	@override String get created => 'تاريخ الإنشاء';
	@override String get last_login => 'آخر تسجيل دخول';
	@override String get nationality => 'الجنسية';
	@override String get soft_delete_deactivate => 'تعطيل الحساب';
	@override String get permanently_delete => 'حذف نهائي';
	@override String get verify_account => 'توثيق الحساب';
	@override String get remove_verification => 'إلغاء التوثيق';
	@override String verify_userfullname({required Object user_fullName}) => 'هل تريد توثيق حساب ${user_fullName}؟';
	@override String remove_verification_from_userfullname({required Object user_fullName}) => 'هل تريد إلغاء توثيق حساب ${user_fullName}؟';
	@override String get ban_user => 'حظر المستخدم';
	@override String get unban_user => 'إلغاء الحظر';
	@override String ban_userfullname_they_will_lose_system_access({required Object user_fullName}) => 'هل تريد حظر ${user_fullName}؟ لن يتمكن من الوصول للنظام.';
	@override String unban_userfullname({required Object user_fullName}) => 'هل تريد إلغاء حظر ${user_fullName}؟';
	@override String warning_level_set_to_level({required Object level}) => 'تم تحديث مستوى التحذير إلى ${level}';
	@override String get tag_removed => 'تم إزالة العلامة';
	@override String get tag_name => 'اسم العلامة';
	@override String get permanent_delete => 'حذف نهائي';
	@override String get soft_delete => 'تعطيل الحساب';
	@override String permanently_delete_userfullname_this_cannot_be_undone({required Object user_fullName}) => 'هل أنت متأكد من حذف ${user_fullName} نهائياً؟ لا يمكن التراجع!';
	@override String deactivate_userfullname({required Object user_fullName}) => 'هل تريد تعطيل حساب ${user_fullName}؟';
	@override String get institution => 'الكلية والقسم';
	@override String get select_college => 'اختر الكلية';
	@override String get college_is_required => 'الكلية مطلوبة';
	@override String get select_department => 'اختر القسم';
	@override String get department_is_required => 'القسم مطلوب';
	@override String out_of_max({required Object max}) => 'من ${max}';
	@override String get exceeding => 'متفوق';
	@override String get top_5 => 'أفضل 5%';
	@override String get total => 'المجموع';
	@override String get grade => 'التقدير';
	@override String get mmm_dd_yyyy => 'MMM dd, yyyy';
	@override String get no_projects_available_yet => 'No projects available yet';
	@override String get details => 'Details';
	@override String get completed => 'Completed';
	@override String get paused => 'Paused';
	@override String get cancelled => 'Cancelled';
	@override String get faculty_members => 'Faculty Members';
	@override String get please_assign_an_assistant_head_for_the => 'Please assign an assistant head for the department';
	@override String get roles => 'Roles';
	@override String get permissions_2 => 'Permissions';
	@override String get academic_leadership => 'Academic Leadership';
	@override String get administration => 'Administration';
	@override String get manage_grades => 'Manage Grades';
	@override String get manage_attendance => 'Manage Attendance';
	@override String get manage_tas => 'Manage TAs';
	@override String get loading_profile => 'Loading Profile...';
	@override String get manage_groups => 'Manage Groups';
	@override String get upload_materials => 'Upload Materials';
	@override String get professor_chat => 'Professor Chat';
	@override String get manage_courses => 'Manage Courses';
	@override String get manage_schedules => 'Manage Schedules';
	@override String get approve_enrollments => 'Approve Enrollments';
	@override String get announcements => 'Announcements';
	@override String get manage_enrollments => 'Manage Enrollments';
	@override String get academic_advising => 'Academic Advising';
	@override String get manage_library => 'Manage Library';
	@override String get student_records => 'Student Records';
	@override String get manage_users => 'Manage Users';
	@override String get manage_colleges => 'Manage Colleges';
	@override String get manage_departments => 'Manage Departments';
	@override String get audit_logs => 'Audit Logs';
	@override String get manage_roles => 'Manage Roles';
	@override String get finances => 'Finances';
	@override String get you_do_not_have_permission_to_access_this_section => 'You do not have permission to access this section';
	@override String get personal_details => 'Personal Details';
	@override String get account_credentials => 'Account Credentials';
	@override String get roles_permissions => 'Roles & Permissions';
	@override String get academic_affiliation => 'Academic Affiliation';
	@override String get gender => 'Gender';
	@override String get male => 'Male';
	@override String get female => 'Female';
	@override String get enter_prefix_only => 'Enter prefix only (e.g., ahmed123)';
	@override String get previous => 'Previous';
	@override String get create_account => 'Create Account';
	@override String get next => 'Next';
	@override String get about_college => 'About College';
	@override String get origins_roots => 'Origins & Roots';
	@override String get vision_mission => 'Vision & Mission';
	@override String get strategic_goals => 'Strategic Goals';
	@override String get faculty_management => 'Faculty Management';
	@override String get faculty_staff => 'Faculty & Staff';
	@override String get no_staff_registered_yet => 'No staff registered yet';
	@override String get scientific_departments => 'Scientific Departments';
	@override String get posted_successfully => 'Posted Successfully!';
	@override String get your_post_is_now_live_on_the_feed => 'Your post is now live on the feed';
	@override String get create_post => 'Create Post';
	@override String get post => 'Post';
	@override String get as_college => 'As College';
	@override String get public => 'Public';
	@override String get mention_collegedept => 'Mention College/Dept';
	@override String get dept => 'Dept';
	@override String get whats_on_your_mind => 'What\'s on your mind?';
	@override String get paste_link_here => 'Paste link here...';
	@override String get add_to_your_post => 'Add to your post';
	@override String get en => 'en';
	@override String get news => 'News';
	@override String get edit_post => 'Edit Post';
	@override String get write_something => 'Write something...';
	@override String get dashboard => 'Dashboard';
	@override String get share_your_thoughts_to_help_improve_the => 'Share your thoughts to help improve the system';
}

// Path: academic
class _TranslationsAcademicAr implements TranslationsAcademicEn {
	_TranslationsAcademicAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get university_requirements => 'متطلبات الجامعة';
	@override String get academic_progress => 'التقدم الأكاديمي';
	@override String get faculty_requirements => 'متطلبات الكلية';
	@override String get major_requirements => 'المتطلبات الرئيسية';
	@override String get electives => 'الاختيارية';
	@override String get remaining => 'متبقي';
	@override String get completed => 'مكتمل';
	@override String get grades_title => 'الدرجات';
	@override String get exam_schedule_title => 'جدول الامتحانات';
	@override String get subject_results_title => 'نتائج الموضوع';
	@override String get transcript_title => 'النص الأكاديمي';
	@override String get attendance_title => 'حضور';
	@override String get schedule_title => 'جدول';
	@override String get courses_title => 'دوراتي';
	@override String get action_plan_title => 'خطة عمل الدرجة';
	@override String get all_students => 'جميع الطلاب';
	@override String get professor_dashboard => 'لوحة الأستاذ';
	@override String get tas => 'مساعدو التدريس';
	@override String get groups => 'المجموعات';
	@override String get no_groups => 'لا توجد مجموعات';
	@override String get chat => 'محادثة';
	@override String get office_hours => 'ساعات العمل';
	@override String get courses => 'الدورات';
	@override String get active => 'نشيط';
	@override String get upload_file => 'تحميل الملف';
	@override String get inactive => 'غير نشط';
	@override String get view_all => 'عرض الكل';
	@override String get assignments => 'المهام';
	@override String get add_ta => 'أضف تا';
	@override String get section => 'قسم';
	@override String get urgent_announcement => 'إعلان عاجل';
	@override String get send_message => 'أرسل رسالة';
	@override String get group_label => 'مجموعة';
	@override String get remove_ta => 'إزالة تا';
	@override String get manage_groups => 'إدارة المجموعات';
	@override String get all => 'الجميع';
	@override String get profile => 'حساب تعريفي';
	@override String get manage_tas => 'إدارة المساعدات الفنية';
	@override String get semester_grades => 'درجات الفصل الدراسي';
	@override String get grade_summary => 'ملخص الصف';
	@override String get midterm => 'منتصف المدة';
	@override String get credits => 'الاعتمادات';
	@override String get total => 'المجموع';
	@override String get year_1 => 'السنة 1';
	@override String get practical => 'عملي';
	@override String get kFinal => 'الامتحان النهائي';
	@override String get year_2 => 'السنة 2';
	@override String get enrolled => 'مسجل';
	@override String get year_3 => 'السنة 3';
	@override String get available => 'متاح';
	@override String get year_4 => 'السنة 4';
	@override String get time => 'وقت';
	@override String get instructor => 'مدرب';
	@override String get duration => 'مدة';
	@override String get schedule_info => 'جدول';
	@override String get exam_date => 'تاريخ الامتحان';
	@override String get seat => 'مقعد';
	@override String get feedback => 'تعليق';
	@override String get absent => 'غائب';
	@override String get loading => 'تحميل...';
	@override String get room => 'غرفة';
	@override String get ratio => 'نسبة';
	@override String get search => 'يبحث';
	@override String get no_data => 'لا توجد بيانات متاحة';
	@override String get late => 'متأخر';
	@override String get present => 'حاضر';
	@override String get error => 'خطأ';
	@override String get save => 'يحفظ';
	@override String get cancel => 'يلغي';
	@override String get retry => 'أعد المحاولة';
	@override String get filter => 'فلتر';
	@override String get back => 'خلف';
	@override String get confirm => 'يتأكد';
	@override String get delete => 'يمسح';
	@override String get edit => 'يحرر';
	@override String get send => 'يرسل';
	@override String get remove => 'يزيل';
	@override String get add => 'يضيف';
	@override String get close => 'يغلق';
	@override String get academic_journey => 'رحلة أكاديمية';
	@override String get academic_results => 'النتائج الأكاديمية';
	@override String get across_all_groups => 'عبر جميع المجموعات';
	@override String get academic_standing_excellent => 'ممتاز';
	@override String get add_to_calendar => 'أضف إلى التقويم';
	@override String get add_new_ta => 'إضافة تا جديد';
	@override String get advanced_learning => 'التعلم المتقدم';
	@override String get added_successfully => 'تمت الإضافة بنجاح';
	@override String get advanced_mathematics => 'الرياضيات المتقدمة';
	@override String get advisor_assignment => 'تعيين مستشار';
	@override String get action_plan => 'خطة عمل الدرجة';
	@override String get algorithms => 'الخوارزميات';
	@override String get gpa => 'المعدل التراكمي';
	@override String get are_you_sure_you_want_to_remov => 'هل أنت متأكد أنك تريد إزالة TA هذا؟';
	@override String get artificial_intelligence => 'الذكاء الاصطناعي';
	@override String get calculus_i => 'حساب التفاضل والتكامل أنا';
	@override String get clicked => 'تم النقر عليه';
	@override String get code_review => 'مراجعة الكود';
	@override String get completed_1 => 'مكتمل';
	@override String get completion_rate => 'معدل الإنجاز';
	@override String get computer_programming => 'برمجة الكمبيوتر';
	@override String get course_management => 'إدارة الدورة';
	@override String get confirm_removal => 'تأكيد الإزالة';
	@override String get coursework => 'الدورات الدراسية';
	@override String get credits_1 => 'الاعتمادات';
	@override String get cs405_machine_learning => 'التعلم الآلي CS405';
	@override String get cs402_artificial_intelligence => 'الذكاء الاصطناعي CS402';
	@override String get cs410_computer_vision => 'رؤية الكمبيوتر CS410';
	@override String get database_systems => 'أنظمة قواعد البيانات';
	@override String get data_structures => 'هياكل البيانات';
	@override String get d_mmmm => 'د ط ط ط ط';
	@override String get cumulative_gpa => 'المعدل التراكمي';
	@override String get deep_learning => 'التعلم العميق';
	@override String get days => 'أيام';
	@override String get dr_ada_lovelace => 'دكتورة أدا لوفليس';
	@override String get dr_robert_smith => 'دكتور روبرت سميث';
	@override String get ethics_in_it => 'الأخلاقيات في مجال تكنولوجيا المعلومات';
	@override String get dr_sarah_ahmed => 'د/سارة أحمد';
	@override String get english_composition => 'تكوين اللغة الإنجليزية';
	@override String get field_internship => 'التدريب الميداني';
	@override String get exam_schedule => 'جدول الامتحانات';
	@override String get dr_alan_turing => 'الدكتور آلان تورينج';
	@override String get fall_2023 => 'خريف 2023';
	@override String get file_will_be_uploaded_to_cloud => 'سيتم رفع الملف إلى التخزين السحابي';
	@override String get file_title => 'عنوان الملف';
	@override String get final_exam => 'الامتحان النهائي';
	@override String get foundational_skills => 'المهارات التأسيسية';
	@override String get general_physics => 'الفيزياء العامة';
	@override String get graduation_progress => 'تقدم التخرج';
	@override String get graduation_mastery => 'إتقان التخرج';
	@override String get frontend_ui => 'واجهة المستخدم الأمامية';
	@override String get hall_1 => 'القاعة 1';
	@override String get graduation_project => 'مشروع التخرج';
	@override String get hall_4 => 'القاعة 4';
	@override String get hum210_professional_ethics => 'HUM210 الأخلاقيات المهنية';
	@override String get hours => 'ساعات';
	@override String get intro_to_ai => 'مقدمة إلى الذكاء الاصطناعي';
	@override String get intro_to_programming => 'مقدمة في البرمجة';
	@override String get comp_organization => 'منظمة الكمبيوتر';
	@override String get joined => 'انضم';
	@override String get lab_12 => 'المختبر 12';
	@override String get lecture => 'محاضرة';
	@override String get lab_final => 'مختبر نهائي';
	@override String get linear_algebra => 'الجبر الخطي';
	@override String get live_now => 'عش الآن';
	@override String get lecture_hall_2 => 'قاعة المحاضرات 2';
	@override String get live => 'يعيش';
	@override String get logic_design => 'التصميم المنطقي';
	@override String get machine_learning => 'التعلم الآلي';
	@override String get mathematics => 'الرياضيات';
	@override String get mat301_advanced_calculus => 'MAT301 حساب التفاضل والتكامل المتقدم';
	@override String get members => 'أعضاء';
	@override String get midterm_exam => 'الامتحان النصفي';
	@override String get mins => 'دقيقة';
	@override String get network_security => 'أمن الشبكات';
	@override String get next_exam_in => 'الامتحان القادم في';
	@override String get messages => 'رسائل';
	@override String get no_available_tas_currently => 'لا توجد مساعدات مساعدة متاحة حاليًا';
	@override String get overall_attendance => 'الحضور الشامل';
	@override String get no_tas_assigned_yet => 'لم يتم تعيين مساعدات فنية حتى الآن';
	@override String get no_exams_on_this_day => 'لا يوجد امتحانات في هذا اليوم';
	@override String get performance_distribution => 'توزيع الأداء';
	@override String get points => 'نقاط';
	@override String get practical_project => 'مشروع عملي';
	@override String get prof_john_doe => 'البروفيسور جون دو';
	@override String get programming_basics => 'أساسيات البرمجة';
	@override String get overall_progress => 'التقدم الشامل';
	@override String get progress => 'تقدم';
	@override String get psychology => 'علم النفس';
	@override String get quick_actions => 'إجراءات سريعة';
	@override String get quiz_1 => 'الاختبار 1';
	@override String get rank => 'رتبة';
	@override String get quiz_2 => 'الاختبار 2';
	@override String get registration_requests => 'طلبات التسجيل';
	@override String get rating => 'تصنيف';
	@override String get score => 'نتيجة';
	@override String get removed_successfully => 'تمت الإزالة بنجاح';
	@override String get select_a_ta_from_the_list_to_a => 'حدد TA من القائمة لإضافتها';
	@override String get shared_files => 'الملفات المشتركة';
	@override String get sessions_this_week => 'جلسات هذا الأسبوع';
	@override String get results_analysis => 'تحليل النتائج';
	@override String get specialization_projects => 'مشاريع التخصص';
	@override String get start_by_adding_the_first_ta_f => 'ابدأ بإضافة أول TA للدورة التدريبية الخاصة بك';
	@override String get students => 'طلاب';
	@override String get sophomore => 'طالبة';
	@override String get total_students => 'إجمالي الطلاب';
	@override String get ta_team_chat => 'دردشة فريق TA';
	@override String get track_project_i => 'تتبع المشروع I';
	@override String get type_a_message => 'اكتب رسالة...';
	@override String get upload_files => 'تحميل الملفات';
	@override String get upload => 'رفع';
	@override String get upload_new_file => 'تحميل ملف جديد';
	@override String get uploaded_successfully => 'تم الرفع بنجاح';
	@override String get urgent_news => 'أخبار عاجلة';
	@override String get web_programming => 'برمجة الويب';
	@override String get spring_2024 => 'ربيع 2024';
	@override String get summer_2024 => 'صيف 2024';
}

// Path: admin
class _TranslationsAdminAr implements TranslationsAdminEn {
	_TranslationsAdminAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get eeee_mmmm_dd_yyyy => 'EEEE، MMMM ي ي، س س س';
	@override String get system_online => 'النظام عبر الإنترنت';
	@override String get admin_command_center => 'مركز قيادة المشرف';
	@override String get en => 'أون';
	@override String get admin => 'مسؤل';
	@override String get students => 'طلاب';
	@override String get live_statistics => 'الإحصائيات الحية';
	@override String get staff => 'طاقم عمل';
	@override String get faculty => 'كلية';
	@override String get leadership => 'قيادة';
	@override String get admin_it => 'الإدارة وتكنولوجيا المعلومات';
	@override String get system_modules => 'وحدات النظام';
	@override String get users => 'المستخدمين';
	@override String get colleges => 'الكليات';
	@override String get manage_faculties => 'إدارة الكليات';
	@override String get manage_all_accounts => 'إدارة كافة الحسابات';
	@override String get departments => 'الأقسام';
	@override String get roles => 'الأدوار';
	@override String get academic_departments => 'الأقسام الأكاديمية';
	@override String get permission_management => 'إدارة الأذونات';
	@override String get professors => 'الأساتذة';
	@override String get faculty_members => 'أعضاء هيئة التدريس';
	@override String get audit_logs => 'سجلات التدقيق';
	@override String get system_activity_log => 'سجل نشاط النظام';
	@override String get system_settings => 'إعدادات النظام';
	@override String get platform_configuration => 'تكوين المنصة';
	@override String get performance => 'أداء';
	@override String get server_health_metrics => 'مقاييس صحة الخادم';
	@override String get system_pulse => 'نبض النظام';
	@override String get server => 'الخادم';
	@override String get latency => 'كمون';
	@override String get online => 'متصل';
	@override String get status => 'حالة';
	@override String get database => 'قاعدة البيانات';
	@override String get active => 'نشيط';
	@override String get realtime_latency_ms => 'الكمون في الوقت الحقيقي (مللي ثانية)';
	@override String get role_breakdown => 'انهيار الدور';
	@override String get teaching_staff => 'أعضاء هيئة التدريس';
	@override String get student_affairs => 'شؤون الطلاب';
	@override String get system_health => 'صحة النظام';
	@override String get total_users => 'إجمالي المستخدمين';
	@override String get quick_actions => 'إجراءات سريعة';
	@override String get add_user => 'إضافة مستخدم';
	@override String get export_data => 'تصدير البيانات';
	@override String get academic_leadership => 'القيادة الأكاديمية';
	@override String get management => 'إدارة';
	@override String get send_announcement => 'إرسال إعلان';
	@override String get backup_system => 'نظام النسخ الاحتياطي';
	@override String get user_management => 'إدارة المستخدم';
	@override String get user_list => 'قائمة المستخدمين';
	@override String get filter_all => 'الجميع';
	@override String get filter_students => 'طلاب';
	@override String get search_users => 'البحث عن المستخدمين...';
	@override String get filter_staff => 'طاقم عمل';
	@override String get filter_admin => 'مسؤل';
	@override String get no_users => 'لم يتم العثور على مستخدمين';
	@override String user_count({required Object count}) => 'مستخدمي${count}';
	@override String get student_management => 'إدارة الطلاب';
	@override String get faculty_management => 'إدارة الكلية';
	@override String get leadership_management => 'إدارة القيادة';
	@override String get staff_management => 'إدارة الموظفين';
	@override String get admin_it_management => 'الإدارة وإدارة تكنولوجيا المعلومات';
	@override String get department_management => 'إدارة القسم';
	@override String get professor_management => 'إدارة الأستاذ';
	@override String get role_management => 'إدارة الأدوار';
	@override String get audit_log_management => 'إدارة سجل التدقيق';
	@override String get system_configuration => 'تكوين النظام';
	@override String get edit_college => 'تحرير الكلية';
	@override String get add_department => 'إضافة قسم';
	@override String get add_college => 'أضف الكلية';
	@override String get college_name => 'اسم الكلية';
	@override String get delete_department => 'حذف القسم';
	@override String get department_name => 'اسم القسم';
	@override String get delete_college => 'حذف الكلية';
	@override String get head_name => 'اسم الرأس';
	@override String get dean_name => 'اسم العميد';
	@override String get student_count => 'طلاب';
	@override String get ta_count => 'المساعدة التقنية';
	@override String get action => 'فعل';
	@override String get staff_count => 'طاقم عمل';
	@override String get edit_department => 'قسم التحرير';
	@override String get timestamp => 'الطابع الزمني';
	@override String get user => 'مستخدم';
	@override String get details => 'تفاصيل';
	@override String get filter_by_action => 'تصفية حسب العمل';
	@override String get filter_by_date => 'تصفية حسب التاريخ';
	@override String get no_logs => 'لم يتم العثور على سجلات التدقيق';
	@override String get system_version => 'إصدار النظام';
	@override String get maintenance_mode => 'وضع الصيانة';
	@override String get backup_schedule => 'جدول النسخ الاحتياطي';
	@override String get email_server => 'خادم البريد الإلكتروني';
	@override String get storage_quota => 'حصة التخزين';
	@override String get security_level => 'مستوى الأمان';
	@override String get reset_defaults => 'إعادة التعيين إلى الإعدادات الافتراضية';
	@override String get save_settings => 'حفظ الإعدادات';
	@override String get user_email => 'بريد إلكتروني';
	@override String get session_timeout => 'مهلة الجلسة';
	@override String get user_role => 'دور';
	@override String get user_phone => 'هاتف';
	@override String get user_name => 'اسم';
	@override String get user_department => 'قسم';
	@override String get log_retention => 'الاحتفاظ بالسجل';
	@override String get user_college => 'كلية';
	@override String get user_created => 'مخلوق';
	@override String get user_status => 'حالة';
	@override String get add_new_user => 'إضافة مستخدم جديد';
	@override String get user_updated => 'تم تحديث المستخدم بنجاح';
	@override String get edit_user => 'تحرير المستخدم';
	@override String get delete_user => 'حذف المستخدم';
	@override String get save_user => 'يحفظ';
	@override String get cancel => 'يلغي';
	@override String get email_label => 'عنوان البريد الإلكتروني';
	@override String get department_label => 'قسم';
	@override String get phone_label => 'رقم التليفون';
	@override String get role_label => 'حدد الدور';
	@override String get college_label => 'كلية';
	@override String get category_student => 'طالب';
	@override String get confirm_password_label => 'تأكيد كلمة المرور';
	@override String get name_label => 'الاسم الكامل';
	@override String get category_staff => 'طاقم عمل';
	@override String get password_label => 'كلمة المرور';
	@override String get category_faculty => 'كلية';
	@override String get category_leadership => 'قيادة';
	@override String get category_admin => 'مسؤل';
	@override String get no_departments => 'لا توجد أقسام متاحة';
	@override String get select_role => 'حدد دورًا';
	@override String get no_colleges => 'لا توجد كليات متاحة';
	@override String get select_department => 'اختر قسمًا';
	@override String get select_college => 'اختر الكلية';
	@override String get user_added => 'تمت إضافة المستخدم بنجاح';
	@override String get user_deleted => 'تم حذف المستخدم بنجاح';
	@override String get confirm_delete => 'تأكيد الحذف';
	@override String get confirm_delete_message => 'هل أنت متأكد أنك تريد حذف هذا المستخدم؟';
	@override String get error_loading => 'حدث خطأ أثناء تحميل البيانات';
	@override String get error_saving => 'خطأ في حفظ البيانات';
	@override String get academic_leaders => 'القادة الأكاديميون';
	@override String get academic_departments_1 => 'الأقسام الأكاديمية';
	@override String get retry => 'أعد المحاولة';
	@override String get academic_department => 'القسم الأكاديمي';
	@override String get academic_warnings => 'التحذيرات الأكاديمية';
	@override String get account_status => 'حالة الحساب';
	@override String get actor => 'ممثل';
	@override String get add_report => 'إضافة تقرير';
	@override String get admins => 'المشرفين';
	@override String get advanced_management => 'الإدارة المتقدمة';
	@override String get account_verification => 'التحقق من الحساب';
	@override String get all_systems_operational => 'جميع الأنظمة التشغيلية';
	@override String get all_levels => 'جميع المستويات';
	@override String get all => 'الجميع';
	@override String get apply_filters => 'تطبيق المرشحات';
	@override String get assign_dean => 'تعيين عميد';
	@override String get are_you_sure_you_want_to_delet => 'هل أنت متأكد أنك تريد حذف هذا المستخدم؟';
	@override String get assign => 'تعيين';
	@override String get assign_department_head => 'تعيين رئيس القسم';
	@override String get attached_report => 'التقرير المرفق';
	@override String get change => 'يتغير';
	@override String get ban_user => 'حظر المستخدم';
	@override String get banned => 'محظور';
	@override String get change_dean => 'تغيير العميد';
	@override String get changes_saved_successfully => 'تم حفظ التغييرات بنجاح';
	@override String get college => 'كلية';
	@override String get college_dean => 'عميد الكلية';
	@override String get college_details => 'تفاصيل الكلية';
	@override String get colleges_management => 'إدارة الكليات';
	@override String get deactivated => 'معطل';
	@override String get coming_soon => 'قريباً';
	@override String get delete => 'يمسح';
	@override String get department_details => 'تفاصيل القسم';
	@override String get department_projects => 'مشاريع القسم';
	@override String get email_address => 'عنوان البريد الإلكتروني';
	@override String get entity => 'كيان';
	@override String get departments_management => 'إدارة الأقسام';
	@override String get error_snapshoterror => 'خطأ: {خطأ}';
	@override String get faculty_members_1 => 'أعضاء هيئة التدريس';
	@override String get filter_users => 'تصفية المستخدمين';
	@override String get full_name => 'الاسم الكامل';
	@override String get failed_to_load_data => 'فشل في تحميل البيانات';
	@override String get head_of_department => 'رئيس القسم';
	@override String get incidents => 'الحوادث';
	@override String get leadership_stats => 'إحصائيات القيادة';
	@override String level_level({required Object level}) => 'المستوى ${level}';
	@override String get manage_tags => 'إدارة العلامات';
	@override String get min_6_chars => 'دقيقة. 6 أحرف';
	@override String get national_id => 'الهوية الوطنية';
	@override String get no_about_text_available => 'لا يوجد حول النص المتاح';
	@override String get no_colleges_found => 'لم يتم العثور على كليات';
	@override String get nationality => 'جنسية';
	@override String get no_dean_assigned => 'لم يتم تعيين عميد';
	@override String get no_departments_in_this_college => 'لا توجد أقسام في هذه الكلية';
	@override String get no_description_available => 'لا يوجد وصف متاح';
	@override String get no_head_assigned => 'لم يتم تعيين رئيس';
	@override String get no_logs_found => 'لم يتم العثور على سجلات';
	@override String get no_departments_found => 'لم يتم العثور على أقسام';
	@override String get no_faculty_records_found => 'لم يتم العثور على سجلات أعضاء هيئة التدريس';
	@override String get no_projects_added_yet => 'لم تتم إضافة أي مشاريع حتى الآن';
	@override String get no_settings_found_in_the_datab => 'لم يتم العثور على إعدادات في قاعدة البيانات';
	@override String get no_matching_students_found => 'لم يتم العثور على طلاب متطابقين';
	@override String get no_users_found => 'لم يتم العثور على مستخدمين';
	@override String get office => 'مكتب';
	@override String get password => 'كلمة المرور';
	@override String get pending_reg => 'في انتظار التسجيل';
	@override String get permanently_delete_user => 'حذف المستخدم نهائيًا';
	@override String get please_assign_a_dean_for_the_c => 'أرجو تعيين عميد لهذه الكلية';
	@override String get phone_number => 'رقم التليفون';
	@override String get please_assign_a_head_for_the_d => 'يرجى تعيين رئيس لهذا القسم';
	@override String get save => 'يحفظ';
	@override String get roles_management => 'إدارة الأدوار';
	@override String get search_by_name_email_phone_id => 'البحث حسب الاسم أو البريد الإلكتروني أو الهاتف أو الهوية...';
	@override String get search_doctor_name => 'بحث عن اسم الطبيب...';
	@override String get save_changes => 'حفظ التغييرات';
	@override String get search_student_or_id => 'البحث عن الطالب أو الهوية...';
	@override String get select => 'يختار';
	@override String get search_staff_member => 'البحث عن موظف...';
	@override String get select_role_in_widgetinitialca => 'حدد الدور';
	@override String get separate_tags_with_commas => 'علامات منفصلة بفواصل';
	@override String get select_role_permission => 'حدد الدور / الإذن';
	@override String get student_id => 'معرف الطالب';
	@override String get servers => 'الخوادم';
	@override String get system_technical_status => 'الحالة الفنية للنظام';
	@override String get tag1_tag2 => 'العلامة 1، العلامة 2';
	@override String get teaching_assistants => 'مساعدو التدريس';
	@override String get total_students => 'إجمالي الطلاب';
	@override String get unverified => 'لم يتم التحقق منها';
	@override String get user_roles_ranks => 'أدوار المستخدم ورتبه';
	@override String get verified => 'تم التحقق منه';
	@override String get warning_level => 'مستوى التحذير';
	@override String get verification => 'تَحَقّق';
	@override String get you_can_manage_professors_and_ => 'يمكنك إدارة الأساتذة وأكثر هنا';
	@override String get total_staff => 'مجموع الموظفين';
	@override String get college_management => 'إدارة الكلية';
}

// Path: enrollment
class _TranslationsEnrollmentAr implements TranslationsEnrollmentEn {
	_TranslationsEnrollmentAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get registration_title => 'تسجيل الدورة';
	@override String get invoices_title => 'الفواتير المالية';
	@override String get payment_title => 'دفع الرسوم الدراسية';
	@override String get advisor => 'مستشار أكاديمي';
	@override String get advisor_approval => 'موافقة المستشار';
	@override String get dean_assignment => 'تعيين مستشار العميد';
	@override String get approve => 'يعتمد';
	@override String get reject => 'يرفض';
	@override String get approved => 'موافقة';
	@override String get rejected => 'مرفوض';
	@override String get student_name => 'اسم الطالب';
	@override String get pending => 'قيد الانتظار';
	@override String get college => 'كلية';
	@override String get department => 'قسم';
	@override String get student_id => 'معرف الطالب';
	@override String get semester => 'الفصل الدراسي';
	@override String get credits => 'الاعتمادات';
	@override String get status => 'حالة';
	@override String get section => 'قسم';
	@override String get group => 'مجموعة';
	@override String get registration_date => 'تاريخ التسجيل';
	@override String get search_students => 'بحث عن الطلاب...';
	@override String get filter_all => 'الجميع';
	@override String get filter_pending => 'قيد الانتظار';
	@override String get filter_rejected => 'مرفوض';
	@override String get filter_approved => 'موافقة';
	@override String get approve_all => 'الموافقة على الكل';
	@override String get advisor_name => 'اسم المستشار';
	@override String get view_details => 'عرض التفاصيل';
	@override String get assign => 'تعيين';
	@override String get unassign => 'إلغاء التعيين';
	@override String get assigned => 'مُكَلَّف';
	@override String get unassigned => 'غير معين';
	@override String get success_reject => 'تم رفض التسجيل';
	@override String get success_approve => 'تمت الموافقة على التسجيل بنجاح';
	@override String get success_assign => 'تم تعيين المستشار بنجاح';
	@override String get error_loading => 'حدث خطأ أثناء تحميل البيانات';
	@override String get save => 'يحفظ';
	@override String get cancel => 'يلغي';
	@override String get invoice_date => 'تاريخ';
	@override String get invoice_id => 'معرف الفاتورة';
	@override String get invoice_amount => 'كمية';
	@override String get invoice_paid => 'مدفوع';
	@override String get invoice_status => 'حالة';
	@override String get invoice_unpaid => 'غير مدفوعة الأجر';
	@override String get pay_now => 'ادفع الآن';
	@override String get invoice_overdue => 'تأخرت';
	@override String get payment_method => 'طريقة الدفع';
	@override String get credit_card => 'بطاقة إئتمان';
	@override String get bank_transfer => 'التحويل البنكي';
	@override String get fawry => 'فوري';
	@override String get no_invoices => 'لم يتم العثور على فواتير';
	@override String get payment_success => 'تم الدفع بنجاح';
	@override String get outstanding_balance => 'الرصيد المتميز';
	@override String get payment_error => 'فشل الدفع';
	@override String get total_paid => 'إجمالي المبلغ المدفوع';
	@override String get tuition_fee => 'الرسوم الدراسية';
	@override String get late_fee => 'الرسوم المتأخرة';
	@override String get registration_fee => 'رسوم التسجيل';
	@override String get academic_year => 'العام الدراسي';
	@override String semester_label({required Object semester}) => 'الفصل الدراسي${semester}';
	@override String get total => 'المجموع';
	@override String get submit_request => 'إرسال الطلب';
	@override String get all => 'الجميع';
	@override String get request_submitted => 'تم إرسال الطلب بنجاح';
	@override String get loading => 'تحميل...';
	@override String get academic_advisor => 'مستشار أكاديمي';
	@override String get retry => 'أعد المحاولة';
	@override String get advisor_assignment => 'تعيين مستشار';
	@override String get advisor_requestadvisorfullname => 'المستشار: {الاسم}';
	@override String get approved_courses_registered => 'تمت الموافقة عليه - الدورات المسجلة';
	@override String get approved_1 => 'موافقة';
	@override String get awaiting_advisor_review => 'في انتظار مراجعة المستشار';
	@override String get advisor_updated_successfully => 'تم تحديث المستشار بنجاح';
	@override String get choose_schedules => 'اختر الجداول الزمنية';
	@override String get confirm_submit => 'تأكيد وإرسال';
	@override String get cr => 'سي آر';
	@override String get download => 'تحميل';
	@override String get dormitory_fee => 'رسوم السكن';
	@override String get due => 'حق';
	@override String get error_loading_summary => 'حدث خطأ أثناء تحميل الملخص';
	@override String get financial_portal => 'البوابة المالية';
	@override String get exam_fee => 'رسوم الامتحان';
	@override String get failed_to_load_invoices => 'فشل في تحميل الفواتير';
	@override String get financial_summary => 'الملخص المالي';
	@override String get history => 'تاريخ';
	@override String get invoices => 'الفواتير';
	@override String get help => 'يساعد';
	@override String get manage_your_tuition_and_paymen => 'إدارة الرسوم الدراسية والمدفوعات الخاصة بك';
	@override String get library_fee => 'رسوم المكتبة';
	@override String get my_invoices => 'فواتيري';
	@override String get next_pick_schedules => 'التالي: اختيار الجداول الزمنية';
	@override String get no_advisor => 'لا مستشار';
	@override String get no_invoices_found => 'لم يتم العثور على فواتير';
	@override String get no_requests_found => 'لم يتم العثور على أي طلبات';
	@override String get no_students_found => 'لم يتم العثور على أي طلاب';
	@override String get notes_optional => 'ملاحظات (اختياري)';
	@override String get other => 'آخر';
	@override String get no_schedules_available_for_thi => 'لا توجد جداول متاحة لهذه الدورة';
	@override String get overdue => 'تأخرت';
	@override String get paid => 'مدفوع';
	@override String get partial => 'جزئي';
	@override String get pay => 'يدفع';
	@override String get preparing_pdf_statement => 'جارٍ تحضير بيان PDF...';
	@override String get pending_review => 'في انتظار المراجعة';
	@override String get remaining => 'متبقي';
	@override String get registration_requests => 'طلبات التسجيل';
	@override String get request_rejected => 'تم رفض الطلب';
	@override String get reregister => 'إعادة التسجيل';
	@override String get review_final_timetable => 'مراجعة الجدول الزمني النهائي';
	@override String get sec => 'ثانية';
	@override String get review_registration => 'مراجعة التسجيل';
	@override String get room => 'غرفة';
	@override String get requested_courses => 'الدورات المطلوبة';
	@override String get select_the_subjects_you_want_t => 'اختر المواضيع التي تريد تسجيلها';
	@override String get selected_schedule_summary => 'ملخص الجدول المحدد';
	@override String get select_your_courses => 'حدد الدورات الخاصة بك';
	@override String get semester_requestsemester => 'الفصل الدراسي: {فصل دراسي}';
	@override String get sub => 'الفرعية';
	@override String summaryoverduecount_overdue({required Object count}) => '${count} متأخر';
	@override String get unassigned_only => 'غير المعينة فقط';
	@override String get unpaid => 'غير مدفوعة الأجر';
	@override String get withdrawn => 'انسحبت';
	@override String get you_have_successfully_register => 'لقد قمت بتسجيل دوراتك بنجاح!';
	@override String get total_invoices => 'إجمالي الفواتير';
	@override String get your_account_is_clearnno_invoi => 'حسابك واضح لم يتم العثور على فواتير.';
	@override String get no_requests => 'لم يتم العثور على طلبات';
	@override String get mmm_dd_yyyy => 'ط ط ط ي ي، س س س';
	@override String get no_schedules_available => 'No schedules available';
	@override String get registration_success_message => 'Registration successful!';
	@override String advisor_name_label({required Object name}) => 'Advisor: ${name}';
	@override String semester_label_with_value({required Object semester}) => 'Semester: ${semester}';
}

// Path: shared
class _TranslationsSharedAr implements TranslationsSharedEn {
	_TranslationsSharedAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get no_notifications_yet => 'لا توجد إخطارات حتى الآن';
	@override String get notifications => 'إشعارات';
	@override String get notifications_empty => 'لا توجد إشعارات جديدة';
	@override String get security_title => 'إعدادات الأمان';
	@override String get biometrics_title => 'القياسات الحيوية';
	@override String get fingerprint => 'بصمة';
	@override String get face_id => 'معرف الوجه';
	@override String get sessions_title => 'الجلسات النشطة';
	@override String get current_session => 'الجلسة الحالية';
	@override String get enable_biometrics => 'تمكين القياسات الحيوية';
	@override String get end_session => 'نهاية الجلسة';
	@override String get end_all_sessions => 'إنهاء كافة الجلسات';
	@override String get device => 'جهاز';
	@override String get location => 'موقع';
	@override String get contact_us => 'اتصل بنا';
	@override String get support_title => 'الدعم والمساعدة';
	@override String get email_us => 'راسلنا عبر البريد الإلكتروني';
	@override String get call_us => 'اتصل بنا';
	@override String get whatsapp => 'واتساب';
	@override String get report_issue => 'الإبلاغ عن مشكلة';
	@override String get faq => 'التعليمات';
	@override String get tutorials_title => 'دروس وأدلة';
	@override String get last_active => 'آخر نشاط';
	@override String get forums_title => 'المنتديات';
	@override String get search_forums => 'البحث في المنتديات...';
	@override String get no_posts => 'لم يتم العثور على أي مشاركات';
	@override String get transition_title => 'تحميل...';
	@override String get create_post => 'إنشاء مشاركة';
	@override String get placeholder_title => 'قريباً';
	@override String get coming_soon => 'قريباً';
	@override String get placeholder_subtitle => 'هذا القسم قيد التطوير';
	@override String get back => 'خلف';
	@override String get under_development => 'هذه الميزة قيد التطوير';
	@override String get loading => 'تحميل...';
	@override String get retry => 'أعد المحاولة';
	@override String get error => 'خطأ';
	@override String get close => 'يغلق';
	@override String get cancel => 'يلغي';
	@override String get confirm => 'يتأكد';
	@override String get save => 'يحفظ';
	@override String get delete => 'يمسح';
	@override String get active_sessions => 'الجلسات النشطة';
	@override String get authentication => 'المصادقة';
	@override String get call_hotline => 'اتصل بالخط الساخن';
	@override String get edit => 'يحرر';
	@override String get change_password => 'تغيير كلمة المرور';
	@override String get biometric_login => 'تسجيل الدخول البيومتري';
	@override String get device_management => 'إدارة الجهاز';
	@override String get email_support => 'دعم البريد الإلكتروني';
	@override String get financial_aid => 'المساعدات المالية';
	@override String get forums => 'المنتديات';
	@override String get it_support => 'دعم تكنولوجيا المعلومات';
	@override String get library => 'مكتبة';
	@override String get logout => 'تسجيل الخروج';
	@override String get members => 'أعضاء';
	@override String get protect_account_with_2fa => 'حماية الحساب باستخدام 2FA';
	@override String get manage_logged_in_devices => 'إدارة الأجهزة التي تم تسجيل الدخول إليها';
	@override String get please_wait => 'انتظر من فضلك...';
	@override String get student_affairs => 'شؤون الطلاب';
	@override String get security => 'حماية';
	@override String get this_feature_is_under_developm => 'هذه الميزة قيد التطوير';
	@override String get support => 'يدعم';
	@override String get tutorials => 'دروس';
	@override String get threads => 'المواضيع';
	@override String get update_your_login_credentials => 'قم بتحديث بيانات اعتماد تسجيل الدخول الخاصة بك';
	@override String get use_fingerprint_or_face_id => 'استخدام بصمة الإصبع أو Face ID';
	@override String get view_active_sessions => 'عرض الجلسات النشطة';
	@override String get biometrics => 'القياسات الحيوية';
	@override String get twofactor_auth => 'المصادقة الثنائية';
	@override String get sessions => 'الجلسات';
	@override String get security_section => 'حماية';
	@override String get support_section => 'يدعم';
	@override String get contact_us_section => 'اتصل بنا';
	@override String get tutorials_section => 'دروس';
	@override String get forums_section => 'المنتديات';
	@override String get no_new_notifications => 'لا توجد إشعارات جديدة';
	@override String get security_access => 'الوصول الأمني';
}

// Path: students
class _TranslationsStudentsAr implements TranslationsStudentsEn {
	_TranslationsStudentsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get student_name => 'اسم الطالب';
	@override String get digital_id_title => 'بطاقة الهوية الرقمية';
	@override String get department => 'قسم';
	@override String get student_id => 'معرف الطالب';
	@override String get college => 'كلية';
	@override String get level => 'مستوى';
	@override String get gpa => 'المعدل التراكمي';
	@override String get university => 'جامعة حورس';
	@override String get credits => 'الاعتمادات';
	@override String get verified => 'تم التحقق منه';
	@override String get download_id => 'تحميل معرف';
	@override String get share_id => 'معرف المشاركة';
	@override String get qr_code => 'رمز الاستجابة السريعة';
	@override String get scan_to_verify => 'مسح للتحقق';
	@override String get id_theme => 'موضوع الهوية';
	@override String get gradient_theme => 'التدرج';
	@override String get classic_theme => 'كلاسيكي';
	@override String get holographic_theme => 'التصوير المجسم';
	@override String get dark_matter_theme => 'المادة المظلمة';
	@override String get neon_pulse_theme => 'نبض النيون';
	@override String get dashboard_title => 'لوحة تحكم الطالب';
	@override String get enrollment_section => 'التسجيل';
	@override String get utilities_section => 'المرافق';
	@override String get aurora_theme => 'أورورا';
	@override String get progress => 'التقدم الأكاديمي';
	@override String get academic_section => 'أكاديمي';
	@override String get action_plan => 'خطة الدرجة';
	@override String get grades => 'الدرجات';
	@override String get courses => 'الدورات';
	@override String get schedule => 'جدول';
	@override String get transcript => 'نص';
	@override String get exam_schedule => 'جدول الامتحانات';
	@override String get attendance => 'حضور';
	@override String get registration => 'تسجيل';
	@override String get subject_results => 'نتائج الموضوع';
	@override String get invoices => 'الفواتير';
	@override String get payment => 'قسط';
	@override String get tutorials => 'دروس';
	@override String get security => 'حماية';
	@override String get forums => 'المنتديات';
	@override String get support => 'يدعم';
	@override String get digital_id => 'الهوية الرقمية';
	@override String get view_full_schedule => 'عرض الجدول الزمني الكامل';
	@override String get notifications => 'إشعارات';
	@override String get no_lectures_today => 'لا يوجد محاضرات اليوم';
	@override String get gpa_label => 'المعدل التراكمي';
	@override String get credits_label => 'الاعتمادات';
	@override String get quick_stats => 'إحصائيات سريعة';
	@override String get level_label => 'مستوى';
	@override String get upcoming_exams => 'الامتحانات القادمة';
	@override String get recent_grades => 'الدرجات الأخيرة';
	@override String get all => 'الجميع';
	@override String get loading => 'تحميل...';
	@override String get error => 'خطأ';
	@override String get retry => 'أعد المحاولة';
	@override String get back => 'خلف';
	@override String get academic => 'أكاديمي';
	@override String get access_logs => 'سجلات الوصول';
	@override String get active => 'نشيط';
	@override String get artificial_intelligence => 'الذكاء الاصطناعي';
	@override String get copy => 'ينسخ';
	@override String get daily_schedule => 'الجدول اليومي';
	@override String get download => 'تحميل';
	@override String get horus_university => 'جامعة حورس';
	@override String get horus_university_1 => 'جامعة حورس';
	@override String get id_no => 'رقم الهوية';
	@override String get nfc_pass => 'ممر NFC';
	@override String get enrollment_finance => 'التسجيل والتمويل';
	@override String get offline_copy => 'نسخة دون اتصال';
	@override String get scan_for_secure_access => 'المسح للوصول الآمن';
	@override String get identity_active_secure => 'الهوية نشطة وآمنة';
	@override String get send => 'يرسل';
	@override String get settings => 'إعدادات';
	@override String get share_identity => 'مشاركة الهوية';
	@override String get student => 'طالب';
	@override String get status => 'حالة';
	@override String get smart_digital_id => 'الهوية الرقمية الذكية';
	@override String get utilities => 'المرافق';
}

// Path: onboarding.language
class _TranslationsOnboardingLanguageAr implements TranslationsOnboardingLanguageEn {
	_TranslationsOnboardingLanguageAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر لغتك';
	@override String get subtitle => 'اختر لغتك المفضلة';
	@override String get english => 'الإنجليزية (English)';
	@override String get arabic => 'العربية';
	@override String get german => 'الألمانية (Deutsch)';
	@override String get chinese => 'الصينية (中文)';
	@override String get hint => 'يمكنك تغيير هذا لاحقاً من الإعدادات';
}

// Path: onboarding.faculties_directory
class _TranslationsOnboardingFacultiesDirectoryAr implements TranslationsOnboardingFacultiesDirectoryEn {
	_TranslationsOnboardingFacultiesDirectoryAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'كلياتنا';
	@override String get subtitle => 'استكشف بوابة جامعة حورس الأكاديمية المتنوعة';
}

// Path: onboarding.style
class _TranslationsOnboardingStyleAr implements TranslationsOnboardingStyleEn {
	_TranslationsOnboardingStyleAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر النمط';
	@override String get subtitle => 'اختر تصميم الواجهة الذي تفضله';
	@override late final _TranslationsOnboardingStyleClassicAr classic = _TranslationsOnboardingStyleClassicAr._(_root);
	@override late final _TranslationsOnboardingStyleGlassAr glass = _TranslationsOnboardingStyleGlassAr._(_root);
}

// Path: onboarding.theme
class _TranslationsOnboardingThemeAr implements TranslationsOnboardingThemeEn {
	_TranslationsOnboardingThemeAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر السمة';
	@override String get subtitle => 'فاتح أو داكن، الخيار لك';
	@override String get light => 'فاتح';
	@override String get dark => 'داكن';
}

// Path: auth.login
class _TranslationsAuthLoginAr implements TranslationsAuthLoginEn {
	_TranslationsAuthLoginAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'مرحباً بعودتك';
	@override String get subtitle => 'سجل الدخول للمتابعة';
	@override String get email => 'البريد الإلكتروني';
	@override String get password => 'كلمة المرور';
	@override String get forgot_password => 'نسيت كلمة المرور؟';
	@override String get submit => 'تسجيل الدخول';
	@override String get guest => 'تصفح كزائر';
}

// Path: auth.forgot_password
class _TranslationsAuthForgotPasswordAr implements TranslationsAuthForgotPasswordEn {
	_TranslationsAuthForgotPasswordAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'نسيت كلمة المرور';
	@override String get subtitle => 'اختر طريقة الاستعادة';
	@override String get method_admin => 'زيارة الإدارة';
	@override String get method_online => 'طلب إلكتروني';
	@override String get admin_instructions => 'يرجى زيارة مكتب شؤون الطلاب لإعادة تعيين كلمة المرور. احضر بطاقتك الجامعية سارية المفعول.';
	@override String get phone_label => 'رقم الهاتف';
	@override String get upload_id => 'رفع صورة الهوية';
	@override String get upload_id_hint => 'اضغط لرفع صورة واضحة لهويتك الجامعية';
	@override String get submit => 'إرسال الطلب';
	@override String get back => 'العودة لتسجيل الدخول';
	@override String get error_empty_phone => 'الرجاء إدخال رقم الهاتف';
	@override String get error_empty_email => 'الرجاء إدخال البريد الإلكتروني';
	@override String get error_no_id => 'يرجى تحميل صورة الهوية';
	@override String get success => 'تم تقديم الطلب بنجاح';
	@override String get id_uploaded => 'تم تحميل الهوية';
	@override String get back_to_login => 'العودة إلى تسجيل الدخول';
	@override String get choose_account_recovery_method => 'اختر طريقة استرداد الحساب';
}

// Path: home.tabs
class _TranslationsHomeTabsAr implements TranslationsHomeTabsEn {
	_TranslationsHomeTabsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get home => 'الرئيسية';
	@override String get colleges => 'الكليات';
	@override String get student => 'الطالب';
	@override String get admin => 'الإدارة';
	@override String get search => 'بحث';
	@override String get notifications => 'الإشعارات';
	@override String get profile => 'الملف الشخصي';
}

// Path: dashboard.id_card
class _TranslationsDashboardIdCardAr implements TranslationsDashboardIdCardEn {
	_TranslationsDashboardIdCardAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get student_name => 'اسم الطالب';
	@override String get college => 'الكلية';
	@override String get id => 'الرقم الجامعي';
	@override String get gpa => 'المعدل التراكمي';
	@override String get level => 'المستوى';
	@override String get verified => 'موثق';
}

// Path: dashboard.sections
class _TranslationsDashboardSectionsAr implements TranslationsDashboardSectionsEn {
	_TranslationsDashboardSectionsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get academic => 'الأكاديمي';
	@override String get enrollment => 'التسجيل والمالية';
	@override String get utilities => 'أدوات أخرى';
}

// Path: dashboard.items
class _TranslationsDashboardItemsAr implements TranslationsDashboardItemsEn {
	_TranslationsDashboardItemsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get digital_id => 'الهوية الرقمية';
	@override String get transcript => 'السجل الأكاديمي';
	@override String get progress => 'التقدم الدراسي';
	@override String get action_plan => 'الخطة الدراسية';
	@override String get subject_result => 'نتائج المواد';
	@override String get grades => 'الدرجات';
	@override String get courses => 'المقررات';
	@override String get registration => 'التسجيل';
	@override String get invoices => 'فواتير غير مدفوعة';
	@override String get payment => 'الدفع';
	@override String get tutorials => 'شروحات';
	@override String get security => 'الأمان';
	@override String get forums => 'المنتديات';
	@override String get support => 'الدعم الفني';
	@override String get notifications => 'الإشعارات';
	@override String get no_lectures => 'لا توجد محاضرات';
}

// Path: dashboard.labels
class _TranslationsDashboardLabelsAr implements TranslationsDashboardLabelsEn {
	_TranslationsDashboardLabelsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get university_name => 'جامعة حورس';
	@override String get id_short => 'كود';
	@override String get gpa_short => 'معدل';
	@override String get level_short => 'مستوى';
}

// Path: settings.sections
class _TranslationsSettingsSectionsAr implements TranslationsSettingsSectionsEn {
	_TranslationsSettingsSectionsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get account => 'الحساب';
	@override String get display => 'العرض';
	@override String get notifications => 'التنبيهات';
	@override String get about => 'حول';
}

// Path: settings.tiles
class _TranslationsSettingsTilesAr implements TranslationsSettingsTilesEn {
	_TranslationsSettingsTilesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get edit_profile => 'تعديل الملف الشخصي';
	@override String get change_password => 'تغيير كلمة المرور';
	@override String get dark_mode => 'الوضع الليلي';
	@override String get language => 'اللغة';
	@override String get ui_style => 'نمط الواجهة';
	@override String get app_notifications => 'تنبيهات التطبيق';
	@override String get test_notifications => 'تجربة الإشعارات';
	@override String get about_app => 'عن التطبيق';
	@override String get privacy_policy => 'سياسة الخصوصية';
	@override String get logout => 'تسجيل الخروج';
}

// Path: settings.messages
class _TranslationsSettingsMessagesAr implements TranslationsSettingsMessagesEn {
	_TranslationsSettingsMessagesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get switching_theme => 'جاري تغيير المظهر...';
	@override String get changing_language => 'جاري تغيير اللغة...';
	@override String get rebuilding_design => 'جاري إعادة بناء التصميم...';
}

// Path: colleges.details
class _TranslationsCollegesDetailsAr implements TranslationsCollegesDetailsEn {
	_TranslationsCollegesDetailsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get dean => 'عميد الكلية';
	@override String get staff => 'الهيئة التدريسية';
	@override String get view_all => 'عرض الكل';
	@override String get departments => 'الأقسام العلمية';
	@override String get explore_majors => 'استكشف التخصصات المتاحة';
	@override String get majors => 'تخصص';
	@override String get dean_title => 'العميد';
	@override String get staff_member => 'عضو هيئة تدريس';
	@override String get vice_dean => 'وكيل الكلية';
	@override String get head_of_dept => 'رئيس قسم';
	@override String get assoc_prof => 'أستاذ مشارك';
	@override String get academic_statistics => 'الإحصائيات الأكاديمية';
	@override String get students => 'الطلاب';
	@override String get academic_staff => 'أعضاء هيئة التدريس';
	@override String get teaching_assistants => 'الهيئة المعاونة';
	@override String get published_articles => 'الأبحاث المنشورة';
}

// Path: colleges.departments
class _TranslationsCollegesDepartmentsAr implements TranslationsCollegesDepartmentsEn {
	_TranslationsCollegesDepartmentsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get medical_laboratories_technology => 'تكنولوجيا المختبرات الطبية';
	@override String get radiology_and_imaging_technology => 'تكنولوجيا الأشعة والتصوير الطبي';
	@override String get respiratory_care_technology => 'تكنولوجيا الرعاية التنفسية';
	@override String get dental_prosthetics_technology => 'تكنولوجيا تركيبات الأسنان';
	@override String get health_administration_and_informatics_technology => 'تكنولوجيا الإدارة والمعلوماتية الصحية';
	@override String get accounting => 'المحاسبة';
	@override String get business_management => 'إدارة الأعمال';
	@override String get economics => 'الاقتصاد';
	@override String get marketing => 'التسويق';
	@override String get accounting_program_english => 'برنامج المحاسبة باللغة الإنجليزية';
	@override String get business_administration_program_english => 'برنامج إدارة الأعمال باللغة الإنجليزية';
	@override String get basic_sciences_in_dentistry => 'قسم العلوم الاساسية فى طب الاسنان';
	@override String get basic_medical_and_clinical_sciences => 'قسم العلوم الطبية الاساسية و السريرية';
	@override String get oral_and_maxillofacial_surgery => 'قسم جراحة الفم و الوجه و الفكين';
	@override String get orthodontics_and_pediatric_dentistry => 'قسم التقويم و طب اسنان الاطفال';
	@override String get periodontics_and_oral_medicine => 'قسم امراض اللثة وطب الفم';
	@override String get prosthodontics => 'قسم الاستعاضة الصناعية';
	@override String get conservative_dentistry_and_endodontics => 'قسم العلاج التحفظى وترميم الاسنان';
	@override String get architectural_engineering => 'قسم الهندسة المعمارية';
	@override String get basic_sciences => 'قسم العلوم الأساسية';
	@override String get civil_engineering => 'قسم الهندسة المدنية';
	@override String get mechanical_engineering => 'قسم الهندسة الميكانيكية';
	@override String get electrical_engineering => 'قسم الهندسة الكهربائية';
	@override String get artificial_intelligence_engineering => 'قسم هندسة الذكاء الاصطناعي';
	@override String get interior_design_and_architecture => 'برنامج التصميم والعمارة الداخلية';
	@override String get furniture_design_and_production_technology => 'برنامج تكنولوجيا تصميم وانتاج الاثاث';
	@override String get graphics_and_digital_arts => 'برنامج الجرافيك والفنون الرقمية';
	@override String get animation_and_multimedia => 'برنامج الرسوم المتحركة والوسائط المتعددة';
	@override String get medical_education => 'قسم التعليم الطبي';
	@override String get histology_and_cell_biology => 'قسم علم الأنسجة وبيولوجيا الخلية';
	@override String get clinical_pharmacy => 'قسم الصيدلة السريرية';
	@override String get human_anatomy_and_embryology => 'قسم التشريح البشري وعلم الأجنة';
	@override String get medical_physiology => 'قسم علم وظائف الأعضاء الطبية';
	@override String get medical_microbiology_and_immunology => 'قسم علم الأحياء الدقيقة الطبية وعلم المناعة';
	@override String get forensic_medicine_and_toxicology => 'قسم الطب الشرعي وعلم السموم السريري';
	@override String get community_medicine_and_public_health => 'قسم الطب المجتمعي والصحة العامة';
	@override String get biochemistry => 'قسم الكيمياء الحيوية';
	@override String get pathology => 'قسم علم الأمراض';
	@override String get english_language_program => 'برنامج اللغة الإنجليزية';
	@override String get german_language_program => 'برنامج اللغة الألمانية';
	@override String get chinese_language_program => 'برنامج اللغة الصينية';
	@override String get french_department => 'قسم اللغة الفرنسية';
	@override String get translation_department => 'قسم الترجمة';
	@override String get pharmaceutical_chemistry => 'الكيمياء الصيدلية';
	@override String get pharmacology_and_biochemistry => 'الأدوية و الكيمياء الحيوية';
	@override String get pharmacognosy => 'العقاقير';
	@override String get microbiology_and_immunology => 'الميكروبيولوجي والمناعة';
	@override String get pharmaceutical_technology => 'التكنولوجيا الصيدلية';
	@override String get pharmacy_practice => 'الممارسة الصيدلية';
	@override String get basic_sciences_pt => 'قسم العلوم الاساسية';
	@override String get biomechanics => 'قسم الميكانيكا الحيوية';
	@override String get pt_internal_medicine_and_geriatrics => 'قسم العلاج الطبيعي للأمراض الباطنية والمسنين';
	@override String get pt_womens_health => 'قسم العلاج الطبيعي لصحة المرأة';
	@override String get pt_surgery_and_integumentary => 'قسم العلاج الطبيعي للجراحة والأغشية';
	@override String get pt_orthopedics => 'قسم العلاج الطبيعي لأمراض العظام وجراحتها';
	@override String get pt_neurology => 'قسم العلاج الطبيعي لأمراض الأعصاب وجراحتها';
	@override String get pt_pediatrics => 'قسم العلاج الطبيعي لأمراض الأطفال';
	@override String get artificial_biomedical_computing => 'الحوسبة الطبية الحيوية الاصطناعية';
	@override String get artificial_cybersecurity => 'الأمن السيبراني';
	@override String get ai_and_data_science => 'الذكاء الاصطناعي وعلوم البيانات';
	@override String get ai_for_robotics => 'الذكاء الاصطناعي للروبوتات';
	@override String get smart_systems => 'الأنظمة الذكية';
}

// Path: transcript.overview
class _TranslationsTranscriptOverviewAr implements TranslationsTranscriptOverviewEn {
	_TranslationsTranscriptOverviewAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get gpa => 'المعدل التراكمي';
	@override String get credits => 'الساعات المكتسبة';
	@override String get standing => 'الحالة الأكاديمية';
	@override String get active => 'وضع جيد';
}

// Path: transcript.semester
class _TranslationsTranscriptSemesterAr implements TranslationsTranscriptSemesterEn {
	_TranslationsTranscriptSemesterAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get fall => 'الفصل الدراسي الأول';
	@override String get spring => 'الفصل الدراسي الثاني';
	@override String get summer => 'فصل دراسي صيفي';
}

// Path: transcript.course
class _TranslationsTranscriptCourseAr implements TranslationsTranscriptCourseEn {
	_TranslationsTranscriptCourseAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get grade => 'الدرجة';
	@override String get credits => 'ساعة';
	@override late final _TranslationsTranscriptCourseStatusAr status = _TranslationsTranscriptCourseStatusAr._(_root);
}

// Path: academic_progress.categories
class _TranslationsAcademicProgressCategoriesAr implements TranslationsAcademicProgressCategoriesEn {
	_TranslationsAcademicProgressCategoriesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get university => 'متطلبات جامعة حورس';
	@override String get faculty => 'متطلبات الكلية';
	@override String get major => 'متطلبات التخصص';
	@override String get electives => 'المواد الاختيارية';
	@override String get university_name => 'جامعة حورس';
}

// Path: academic_progress.status
class _TranslationsAcademicProgressStatusAr implements TranslationsAcademicProgressStatusEn {
	_TranslationsAcademicProgressStatusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get completed => 'مكتمل';
	@override String get in_progress => 'قيد الدراسة';
	@override String get remaining => 'متبقي';
	@override String get requirement_met => 'تم استيفاء المتطلب';
}

// Path: attendance.subjects
class _TranslationsAttendanceSubjectsAr implements TranslationsAttendanceSubjectsEn {
	_TranslationsAttendanceSubjectsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get ai => 'الذكاء الاصطناعي';
	@override String get machine_learning => 'تعلم الآلة';
	@override String get ethics => 'أخلاقيات المهنة';
	@override String get calculus => 'تفاضل متقدم';
}

// Path: administration.audit_logs
class _TranslationsAdministrationAuditLogsAr implements TranslationsAdministrationAuditLogsEn {
	_TranslationsAdministrationAuditLogsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'سجلات النظام';
	@override String get no_logs_found => 'لم يتم العثور على سجلات تطابق المعايير.';
	@override late final _TranslationsAdministrationAuditLogsTabsAr tabs = _TranslationsAdministrationAuditLogsTabsAr._(_root);
	@override late final _TranslationsAdministrationAuditLogsLabelsAr labels = _TranslationsAdministrationAuditLogsLabelsAr._(_root);
}

// Path: professor.stats
class _TranslationsProfessorStatsAr implements TranslationsProfessorStatsEn {
	_TranslationsProfessorStatsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get groups => 'المجموعات';
	@override String get students => 'إجمالي الطلاب';
	@override String get tas => 'المعيدين';
	@override String get rating => 'التقييم';
	@override String get shared_files => 'الملفات المشتركة';
	@override String get office_hours => 'الساعات المكتبية';
}

// Path: professor.quick_actions
class _TranslationsProfessorQuickActionsAr implements TranslationsProfessorQuickActionsEn {
	_TranslationsProfessorQuickActionsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get urgent => 'عاجل';
	@override String get upload => 'رفع';
	@override String get message => 'مراسلة';
	@override String get action_clicked => 'تم النقر';
}

// Path: professor.profile
class _TranslationsProfessorProfileAr implements TranslationsProfessorProfileEn {
	_TranslationsProfessorProfileAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get urgent_announcements => 'التنبيهات العاجلة';
	@override String get teaching_assistants => 'المعيدين';
	@override String get shared_resources => 'المصادر المشتركة';
	@override String get office_hours => 'الساعات المكتبية';
}

// Path: roles.categories
class _TranslationsRolesCategoriesAr implements TranslationsRolesCategoriesEn {
	_TranslationsRolesCategoriesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get admin_it => 'الإدارة والتقنية';
	@override String get academic_leadership => 'القيادة الأكاديمية';
	@override String get teaching_staff => 'الكادر التعليمي';
	@override String get student_affairs => 'الخدمات الطلابية';
	@override String get student_roles => 'رتب الطلاب';
	@override String get facilities_security => 'المرافق والأمن';
	@override String get external_roles => 'الخبراء الخارجيين';
}

// Path: roles.names
class _TranslationsRolesNamesAr implements TranslationsRolesNamesEn {
	_TranslationsRolesNamesAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get super_admin => 'مدير النظام العام';
	@override String get admin => 'مسؤول نظام';
	@override String get it_support => 'المسؤول التقني';
	@override String get financial_auditor => 'المراقب المالي';
	@override String get rector => 'مدير الجامعة';
	@override String get dean => 'عميد الكلية';
	@override String get department_head => 'رئيس القسم';
	@override String get academic_coordinator => 'المنسق الأكاديمي';
	@override String get professor => 'عضو هيئة تدريس';
	@override String get lecturer => 'محاضر';
	@override String get teaching_assistant => 'معيد / مساعد باحث';
	@override String get registrar_officer => 'مشرف القبول والتسجيل';
	@override String get academic_advisor => 'المرشد الأكاديمي';
	@override String get librarian => 'أمين المكتبة';
	@override String get freshman => 'طالب مستجد';
	@override String get regular_student => 'طالب منتظم';
	@override String get student => 'طالب';
	@override String get class_representative => 'رئيس الدفعة';
	@override String get alumni => 'خريج';
	@override String get dorm_supervisor => 'مشرف السكن';
	@override String get security_officer => 'مسؤول الأمن';
	@override String get guest => 'زائر';
	@override String get parent => 'ولي الأمر';
	@override String get recruiter => 'جهة توظيف';
}

// Path: roles.descriptions
class _TranslationsRolesDescriptionsAr implements TranslationsRolesDescriptionsEn {
	_TranslationsRolesDescriptionsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get super_admin => 'تحكم كامل في النظام بأكمله';
	@override String get admin => 'مسؤول نظام بصلاحيات عالية';
	@override String get it_support => 'دعم وصيانة النظام التقني';
	@override String get financial_auditor => 'مراقبة السجلات المالية والفواتير';
	@override String get rector => 'مدير الجامعة مع إشراف أكاديمي كامل';
	@override String get dean => 'رئيس كلية أو مجمع أكاديمي';
	@override String get department_head => 'رئيس قسم أكاديمي';
	@override String get academic_coordinator => 'تنسيق البرامج الأكاديمية والجداول';
	@override String get professor => 'عضو هيئة تدريس يقوم بالتدريس وإدارة المقررات';
	@override String get lecturer => 'يقوم بالتدريس بدون صلاحيات الأستاذ الكاملة';
	@override String get teaching_assistant => 'يساعد الأساتذة في التصحيح والمعامل والتمارين';
	@override String get registrar_officer => 'إدارة قبول وتسجيل الطلاب';
	@override String get academic_advisor => 'يرشد الطلاب خلال التخطيط الأكاديمي';
	@override String get librarian => 'إدارة الموارد والمواد المكتبية';
	@override String get freshman => 'طالب في السنة الأولى مع صلاحيات محدودة';
	@override String get regular_student => 'طالب منتظم مع جميع الصلاحيات الأكاديمية المعتادة';
	@override String get student => 'طالب عام';
	@override String get class_representative => 'قائد طلابي يمثل مجموعته الدراسية';
	@override String get alumni => 'طالب خريج مع صلاحيات محدودة';
	@override String get dorm_supervisor => 'إدارة عمليات السكن الطلابي';
	@override String get security_officer => 'أمن الحرم الجامعي والتحكم في الدخول';
	@override String get guest => 'زائر مؤقت مع صلاحيات محدودة';
	@override String get parent => 'يمكنه متابعة تقدم الطالب المرتبط ودرجاته';
	@override String get recruiter => 'جهة توظيف خارجية';
}

// Path: onboarding.style.classic
class _TranslationsOnboardingStyleClassicAr implements TranslationsOnboardingStyleClassicEn {
	_TranslationsOnboardingStyleClassicAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'كلاسيكي';
	@override String get desc => 'تصميم نظيف، بسيط، ومألوف';
}

// Path: onboarding.style.glass
class _TranslationsOnboardingStyleGlassAr implements TranslationsOnboardingStyleGlassEn {
	_TranslationsOnboardingStyleGlassAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'زجاجي';
	@override String get desc => 'جماليات حديثة، شفافة، وحيوية';
}

// Path: transcript.course.status
class _TranslationsTranscriptCourseStatusAr implements TranslationsTranscriptCourseStatusEn {
	_TranslationsTranscriptCourseStatusAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get completed => 'مكتمل';
	@override String get transferred => 'معادلة';
}

// Path: administration.audit_logs.tabs
class _TranslationsAdministrationAuditLogsTabsAr implements TranslationsAdministrationAuditLogsTabsEn {
	_TranslationsAdministrationAuditLogsTabsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get all => 'سجل العمليات الكامل';
	@override String get security => 'الأمان والدخول';
	@override String get user_management => 'إدارة المستخدمين';
	@override String get data_updates => 'تحديثات البيانات';
}

// Path: administration.audit_logs.labels
class _TranslationsAdministrationAuditLogsLabelsAr implements TranslationsAdministrationAuditLogsLabelsEn {
	_TranslationsAdministrationAuditLogsLabelsAr._(this._root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get actor => 'الفاعل';
	@override String get table => 'الجدول';
	@override String get record => 'السجل';
	@override String get action => 'الإجراء';
	@override String get old_data => 'البيانات القديمة';
	@override String get new_data => 'البيانات الجديدة';
	@override String get notes => 'ملاحظات';
	@override String get performed_by => 'تم بواسطة';
	@override String get close_details => 'إغلاق التفاصيل';
	@override String get view_details => 'عرض التفاصيل';
}

/// The flat map containing all translations for locale <ar>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsAr {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.close' => 'إغلاق',
			'common.cancel' => 'إلغاء',
			'common.confirm' => 'تأكيد',
			'common.save' => 'حفظ',
			'common.back' => 'رجوع',
			'welcome.title' => 'مرحبا بك في Hue',
			'welcome.subtitle' => 'أنر عالمك باتصالات ذات مغزى.',
			'welcome.get_started' => 'ابدأ الآن',
			'welcome.have_account' => 'لدي حساب بالفعل',
			'welcome.i_already_have_an_account' => 'لدي حساب بالفعل',
			'welcome.student_portal' => 'بوابة HUE',
			'welcome.welcome_to_the_smart_universit' => 'مرحبا بكم في الجامعة الذكية',
			'onboarding.language.title' => 'اختر لغتك',
			'onboarding.language.subtitle' => 'اختر لغتك المفضلة',
			'onboarding.language.english' => 'الإنجليزية (English)',
			'onboarding.language.arabic' => 'العربية',
			'onboarding.language.german' => 'الألمانية (Deutsch)',
			'onboarding.language.chinese' => 'الصينية (中文)',
			'onboarding.language.hint' => 'يمكنك تغيير هذا لاحقاً من الإعدادات',
			'onboarding.faculties_directory.title' => 'كلياتنا',
			'onboarding.faculties_directory.subtitle' => 'استكشف بوابة جامعة حورس الأكاديمية المتنوعة',
			'onboarding.style.title' => 'اختر النمط',
			'onboarding.style.subtitle' => 'اختر تصميم الواجهة الذي تفضله',
			'onboarding.style.classic.title' => 'كلاسيكي',
			'onboarding.style.classic.desc' => 'تصميم نظيف، بسيط، ومألوف',
			'onboarding.style.glass.title' => 'زجاجي',
			'onboarding.style.glass.desc' => 'جماليات حديثة، شفافة، وحيوية',
			'onboarding.theme.title' => 'اختر السمة',
			'onboarding.theme.subtitle' => 'فاتح أو داكن، الخيار لك',
			'onboarding.theme.light' => 'فاتح',
			'onboarding.theme.dark' => 'داكن',
			'onboarding.you_can_switch_styles_later_in' => 'يمكنك تبديل الأنماط لاحقًا في الإعدادات',
			'onboarding.select_the_lighting_that_suits' => 'اختر الإضاءة التي تناسبك',
			'onboarding.title' => 'الإعداد',
			'onboarding.high_performance_flat_solid_co' => 'ألوان صلبة مسطحة عالية الأداء',
			'onboarding.modern_glass' => 'الزجاج الحديث',
			'onboarding.you_can_change_this_later_in_s' => 'يمكنك تغيير هذا لاحقًا في الإعدادات',
			'onboarding.almost_there_just_one_more_ste' => 'تقريبا هناك! مجرد خطوة واحدة أخرى.',
			'onboarding.recommended' => 'مُستَحسَن',
			'onboarding.choose_app_theme' => 'اختر الموضوع الخاص بك',
			'onboarding.dark_mode' => 'الوضع المظلم',
			'onboarding.choose_app_style' => 'اختر نمط التطبيق الخاص بك',
			'onboarding.light_mode' => 'وضع الضوء',
			'onboarding.choose_language' => 'اختر لغتك',
			'onboarding.classic_solid' => 'كلاسيكي',
			'onboarding.premium_frosted_glass_blur_eff' => 'تأثير طمس زجاجي بلوري ممتاز',
			'auth.login.welcome' => 'مرحباً بعودتك',
			'auth.login.subtitle' => 'سجل الدخول للمتابعة',
			'auth.login.email' => 'البريد الإلكتروني',
			'auth.login.password' => 'كلمة المرور',
			'auth.login.forgot_password' => 'نسيت كلمة المرور؟',
			'auth.login.submit' => 'تسجيل الدخول',
			'auth.login.guest' => 'تصفح كزائر',
			'auth.forgot_password.title' => 'نسيت كلمة المرور',
			'auth.forgot_password.subtitle' => 'اختر طريقة الاستعادة',
			'auth.forgot_password.method_admin' => 'زيارة الإدارة',
			'auth.forgot_password.method_online' => 'طلب إلكتروني',
			'auth.forgot_password.admin_instructions' => 'يرجى زيارة مكتب شؤون الطلاب لإعادة تعيين كلمة المرور. احضر بطاقتك الجامعية سارية المفعول.',
			'auth.forgot_password.phone_label' => 'رقم الهاتف',
			'auth.forgot_password.upload_id' => 'رفع صورة الهوية',
			'auth.forgot_password.upload_id_hint' => 'اضغط لرفع صورة واضحة لهويتك الجامعية',
			'auth.forgot_password.submit' => 'إرسال الطلب',
			'auth.forgot_password.back' => 'العودة لتسجيل الدخول',
			'auth.forgot_password.error_empty_phone' => 'الرجاء إدخال رقم الهاتف',
			'auth.forgot_password.error_empty_email' => 'الرجاء إدخال البريد الإلكتروني',
			'auth.forgot_password.error_no_id' => 'يرجى تحميل صورة الهوية',
			'auth.forgot_password.success' => 'تم تقديم الطلب بنجاح',
			'auth.forgot_password.id_uploaded' => 'تم تحميل الهوية',
			'auth.forgot_password.back_to_login' => 'العودة إلى تسجيل الدخول',
			'auth.forgot_password.choose_account_recovery_method' => 'اختر طريقة استرداد الحساب',
			'auth.back' => 'خلف',
			'auth.choose_account_recovery_method' => 'اختر طريقة استرداد الحساب',
			'home.tabs.home' => 'الرئيسية',
			'home.tabs.colleges' => 'الكليات',
			'home.tabs.student' => 'الطالب',
			'home.tabs.admin' => 'الإدارة',
			'home.tabs.search' => 'بحث',
			'home.tabs.notifications' => 'الإشعارات',
			'home.tabs.profile' => 'الملف الشخصي',
			'home.admin_portal' => 'بوابة المشرف',
			'home.prof' => 'أستاذ',
			'home.home' => 'الرئيسية',
			'home.student_portal' => 'بوابة الطالب',
			'home.student' => 'طالب',
			'home.colleges' => 'الكليات',
			'home.admin' => 'إدارة',
			'home.faculty_portal' => 'بوابة الكلية',
			'feed.likes' => 'إعجابات',
			'feed.caption_sample' => 'هذا مثال لشرح المنشور',
			'feed.hours_ago' => 'منذ ساعتين',
			'dashboard.id_card.student_name' => 'اسم الطالب',
			'dashboard.id_card.college' => 'الكلية',
			'dashboard.id_card.id' => 'الرقم الجامعي',
			'dashboard.id_card.gpa' => 'المعدل التراكمي',
			'dashboard.id_card.level' => 'المستوى',
			'dashboard.id_card.verified' => 'موثق',
			'dashboard.sections.academic' => 'الأكاديمي',
			'dashboard.sections.enrollment' => 'التسجيل والمالية',
			'dashboard.sections.utilities' => 'أدوات أخرى',
			'dashboard.items.digital_id' => 'الهوية الرقمية',
			'dashboard.items.transcript' => 'السجل الأكاديمي',
			'dashboard.items.progress' => 'التقدم الدراسي',
			'dashboard.items.action_plan' => 'الخطة الدراسية',
			'dashboard.items.subject_result' => 'نتائج المواد',
			'dashboard.items.grades' => 'الدرجات',
			'dashboard.items.courses' => 'المقررات',
			'dashboard.items.registration' => 'التسجيل',
			'dashboard.items.invoices' => 'فواتير غير مدفوعة',
			'dashboard.items.payment' => 'الدفع',
			'dashboard.items.tutorials' => 'شروحات',
			'dashboard.items.security' => 'الأمان',
			'dashboard.items.forums' => 'المنتديات',
			'dashboard.items.support' => 'الدعم الفني',
			'dashboard.items.notifications' => 'الإشعارات',
			'dashboard.items.no_lectures' => 'لا توجد محاضرات',
			'dashboard.labels.university_name' => 'جامعة حورس',
			'dashboard.labels.id_short' => 'كود',
			'dashboard.labels.gpa_short' => 'معدل',
			'dashboard.labels.level_short' => 'مستوى',
			'settings.title' => 'الإعدادات',
			'settings.sections.account' => 'الحساب',
			'settings.sections.display' => 'العرض',
			'settings.sections.notifications' => 'التنبيهات',
			'settings.sections.about' => 'حول',
			'settings.tiles.edit_profile' => 'تعديل الملف الشخصي',
			'settings.tiles.change_password' => 'تغيير كلمة المرور',
			'settings.tiles.dark_mode' => 'الوضع الليلي',
			'settings.tiles.language' => 'اللغة',
			'settings.tiles.ui_style' => 'نمط الواجهة',
			'settings.tiles.app_notifications' => 'تنبيهات التطبيق',
			'settings.tiles.test_notifications' => 'تجربة الإشعارات',
			'settings.tiles.about_app' => 'عن التطبيق',
			'settings.tiles.privacy_policy' => 'سياسة الخصوصية',
			'settings.tiles.logout' => 'تسجيل الخروج',
			'settings.messages.switching_theme' => 'جاري تغيير المظهر...',
			'settings.messages.changing_language' => 'جاري تغيير اللغة...',
			'settings.messages.rebuilding_design' => 'جاري إعادة بناء التصميم...',
			'settings.about_app' => 'حول التطبيق',
			'settings.university' => 'جامعة حورس',
			'settings.user' => 'مستخدم',
			'settings.horus_university' => 'جامعة حورس – مصر',
			'settings.developer' => 'المطور',
			'settings.platform' => 'منصة',
			'settings.hue_portal_is_a_comprehensive_' => 'بوابة HUE هي نظام إدارة جامعي ذكي شامل.',
			'settings.backend' => 'الخلفية',
			'settings.change_password' => 'تغيير كلمة المرور',
			'settings.passwords_do_not_match' => 'كلمات المرور غير متطابقة',
			'settings.enter_your_new_password' => 'أدخل كلمة المرور الجديدة أدناه',
			'settings.password_must_be_at_least_6_ch' => 'يجب أن تتكون كلمة المرور من 6 أحرف على الأقل',
			'settings.confirm_password' => 'تأكيد كلمة المرور',
			'settings.privacy_policy' => 'سياسة الخصوصية',
			'settings.password_changed_successfully' => 'تم تغيير كلمة المرور بنجاح',
			'settings.new_password' => 'كلمة المرور الجديدة',
			'settings.please_fill_all_fields' => 'يرجى ملء جميع الحقول',
			'settings.last_updated_february_2026' => 'آخر تحديث: فبراير 2026',
			'settings.edit_profile' => 'تحرير الملف الشخصي',
			'settings.role' => 'دور',
			'settings.phone' => 'هاتف',
			'settings.email' => 'بريد إلكتروني',
			'settings.bio' => 'السيرة الذاتية',
			'settings.full_name' => 'الاسم الكامل',
			'settings.update_your_info_and_contact_d' => 'قم بتحديث معلوماتك وتفاصيل الاتصال بك',
			'settings.change_password_and_security_l' => 'تغيير كلمة المرور ومستوى الأمان',
			'settings.save' => 'يحفظ',
			'settings.forgot_password' => 'هل نسيت كلمة السر',
			'settings.send_password_recovery_link_to' => 'أرسل رابط استعادة كلمة المرور إلى بريدك الإلكتروني',
			'settings.toggle_between_dark_and_light_' => 'التبديل بين الوضع الداكن والخفيف',
			'settings.control_the_types_of_incoming_' => 'التحكم في أنواع الإخطارات الواردة',
			'settings.current_glass_design' => 'الحالي: تصميم الزجاج',
			'settings.disable_complex_visual_effects' => 'قم بتعطيل التأثيرات المرئية المعقدة للحصول على أداء أفضل',
			'settings.current_classic_design' => 'الحالي: تصميم كلاسيكي',
			'settings.test_notification_successful' => 'تم إرسال إشعار الاختبار بنجاح!',
			'settings.battery_saver_mode' => 'وضع توفير البطارية',
			'settings.switch_style' => 'تبديل النمط',
			'settings.send_a_test_notification' => 'إرسال إشعار الاختبار',
			'settings.version_details_and_developers' => 'تفاصيل الإصدار ومعلومات المطور',
			'settings.terms_and_rules_for_data_usage' => 'شروط وقواعد استخدام البيانات',
			'settings.help_support_center' => 'مركز المساعدة والدعم',
			'settings.select_app_language' => 'حدد لغة التطبيق',
			'settings.deutsch' => 'الألمانية',
			'settings.dynamic_val' => 'متحرك',
			'settings.contact_us_to_resolve_any_issu' => 'اتصل بنا لحل أي مشكلة',
			'settings.kSwitch' => 'يُحوّل',
			'settings.switch_label' => 'يُحوّل',
			'colleges.details.dean' => 'عميد الكلية',
			'colleges.details.staff' => 'الهيئة التدريسية',
			'colleges.details.view_all' => 'عرض الكل',
			'colleges.details.departments' => 'الأقسام العلمية',
			'colleges.details.explore_majors' => 'استكشف التخصصات المتاحة',
			'colleges.details.majors' => 'تخصص',
			'colleges.details.dean_title' => 'العميد',
			'colleges.details.staff_member' => 'عضو هيئة تدريس',
			'colleges.details.vice_dean' => 'وكيل الكلية',
			'colleges.details.head_of_dept' => 'رئيس قسم',
			'colleges.details.assoc_prof' => 'أستاذ مشارك',
			'colleges.details.academic_statistics' => 'الإحصائيات الأكاديمية',
			'colleges.details.students' => 'الطلاب',
			'colleges.details.academic_staff' => 'أعضاء هيئة التدريس',
			'colleges.details.teaching_assistants' => 'الهيئة المعاونة',
			'colleges.details.published_articles' => 'الأبحاث المنشورة',
			'colleges.applied_health_sciences' => 'كلية تكنولوجيا العلوم الصحية التطبيقية',
			'colleges.business_administration' => 'كلية إدارة الأعمال',
			'colleges.dentistry' => 'كلية طب الفم والأسنان',
			'colleges.engineering' => 'كلية الهندسة',
			'colleges.fine_arts' => 'كلية الفنون الجميلة',
			'colleges.human_medicine' => 'كلية الطب البشري',
			'colleges.linguistics' => 'كلية الألسن والترجمة',
			'colleges.pharmacy' => 'كلية الصيدلة',
			'colleges.physical_therapy' => 'كلية العلاج الطبيعي',
			'colleges.ai' => 'كلية الذكاء الاصطناعي',
			'colleges.departments.medical_laboratories_technology' => 'تكنولوجيا المختبرات الطبية',
			'colleges.departments.radiology_and_imaging_technology' => 'تكنولوجيا الأشعة والتصوير الطبي',
			'colleges.departments.respiratory_care_technology' => 'تكنولوجيا الرعاية التنفسية',
			'colleges.departments.dental_prosthetics_technology' => 'تكنولوجيا تركيبات الأسنان',
			'colleges.departments.health_administration_and_informatics_technology' => 'تكنولوجيا الإدارة والمعلوماتية الصحية',
			'colleges.departments.accounting' => 'المحاسبة',
			'colleges.departments.business_management' => 'إدارة الأعمال',
			'colleges.departments.economics' => 'الاقتصاد',
			'colleges.departments.marketing' => 'التسويق',
			'colleges.departments.accounting_program_english' => 'برنامج المحاسبة باللغة الإنجليزية',
			'colleges.departments.business_administration_program_english' => 'برنامج إدارة الأعمال باللغة الإنجليزية',
			'colleges.departments.basic_sciences_in_dentistry' => 'قسم العلوم الاساسية فى طب الاسنان',
			'colleges.departments.basic_medical_and_clinical_sciences' => 'قسم العلوم الطبية الاساسية و السريرية',
			'colleges.departments.oral_and_maxillofacial_surgery' => 'قسم جراحة الفم و الوجه و الفكين',
			'colleges.departments.orthodontics_and_pediatric_dentistry' => 'قسم التقويم و طب اسنان الاطفال',
			'colleges.departments.periodontics_and_oral_medicine' => 'قسم امراض اللثة وطب الفم',
			'colleges.departments.prosthodontics' => 'قسم الاستعاضة الصناعية',
			'colleges.departments.conservative_dentistry_and_endodontics' => 'قسم العلاج التحفظى وترميم الاسنان',
			'colleges.departments.architectural_engineering' => 'قسم الهندسة المعمارية',
			'colleges.departments.basic_sciences' => 'قسم العلوم الأساسية',
			'colleges.departments.civil_engineering' => 'قسم الهندسة المدنية',
			'colleges.departments.mechanical_engineering' => 'قسم الهندسة الميكانيكية',
			'colleges.departments.electrical_engineering' => 'قسم الهندسة الكهربائية',
			'colleges.departments.artificial_intelligence_engineering' => 'قسم هندسة الذكاء الاصطناعي',
			'colleges.departments.interior_design_and_architecture' => 'برنامج التصميم والعمارة الداخلية',
			'colleges.departments.furniture_design_and_production_technology' => 'برنامج تكنولوجيا تصميم وانتاج الاثاث',
			'colleges.departments.graphics_and_digital_arts' => 'برنامج الجرافيك والفنون الرقمية',
			'colleges.departments.animation_and_multimedia' => 'برنامج الرسوم المتحركة والوسائط المتعددة',
			'colleges.departments.medical_education' => 'قسم التعليم الطبي',
			'colleges.departments.histology_and_cell_biology' => 'قسم علم الأنسجة وبيولوجيا الخلية',
			'colleges.departments.clinical_pharmacy' => 'قسم الصيدلة السريرية',
			'colleges.departments.human_anatomy_and_embryology' => 'قسم التشريح البشري وعلم الأجنة',
			'colleges.departments.medical_physiology' => 'قسم علم وظائف الأعضاء الطبية',
			'colleges.departments.medical_microbiology_and_immunology' => 'قسم علم الأحياء الدقيقة الطبية وعلم المناعة',
			'colleges.departments.forensic_medicine_and_toxicology' => 'قسم الطب الشرعي وعلم السموم السريري',
			'colleges.departments.community_medicine_and_public_health' => 'قسم الطب المجتمعي والصحة العامة',
			'colleges.departments.biochemistry' => 'قسم الكيمياء الحيوية',
			'colleges.departments.pathology' => 'قسم علم الأمراض',
			'colleges.departments.english_language_program' => 'برنامج اللغة الإنجليزية',
			'colleges.departments.german_language_program' => 'برنامج اللغة الألمانية',
			'colleges.departments.chinese_language_program' => 'برنامج اللغة الصينية',
			'colleges.departments.french_department' => 'قسم اللغة الفرنسية',
			'colleges.departments.translation_department' => 'قسم الترجمة',
			'colleges.departments.pharmaceutical_chemistry' => 'الكيمياء الصيدلية',
			'colleges.departments.pharmacology_and_biochemistry' => 'الأدوية و الكيمياء الحيوية',
			'colleges.departments.pharmacognosy' => 'العقاقير',
			'colleges.departments.microbiology_and_immunology' => 'الميكروبيولوجي والمناعة',
			'colleges.departments.pharmaceutical_technology' => 'التكنولوجيا الصيدلية',
			'colleges.departments.pharmacy_practice' => 'الممارسة الصيدلية',
			'colleges.departments.basic_sciences_pt' => 'قسم العلوم الاساسية',
			'colleges.departments.biomechanics' => 'قسم الميكانيكا الحيوية',
			'colleges.departments.pt_internal_medicine_and_geriatrics' => 'قسم العلاج الطبيعي للأمراض الباطنية والمسنين',
			'colleges.departments.pt_womens_health' => 'قسم العلاج الطبيعي لصحة المرأة',
			'colleges.departments.pt_surgery_and_integumentary' => 'قسم العلاج الطبيعي للجراحة والأغشية',
			'colleges.departments.pt_orthopedics' => 'قسم العلاج الطبيعي لأمراض العظام وجراحتها',
			'colleges.departments.pt_neurology' => 'قسم العلاج الطبيعي لأمراض الأعصاب وجراحتها',
			'colleges.departments.pt_pediatrics' => 'قسم العلاج الطبيعي لأمراض الأطفال',
			'colleges.departments.artificial_biomedical_computing' => 'الحوسبة الطبية الحيوية الاصطناعية',
			'colleges.departments.artificial_cybersecurity' => 'الأمن السيبراني',
			'colleges.departments.ai_and_data_science' => 'الذكاء الاصطناعي وعلوم البيانات',
			'colleges.departments.ai_for_robotics' => 'الذكاء الاصطناعي للروبوتات',
			'colleges.departments.smart_systems' => 'الأنظمة الذكية',
			'transcript.title' => 'السجل الأكاديمي',
			'transcript.overview.gpa' => 'المعدل التراكمي',
			'transcript.overview.credits' => 'الساعات المكتسبة',
			'transcript.overview.standing' => 'الحالة الأكاديمية',
			'transcript.overview.active' => 'وضع جيد',
			'transcript.semester.fall' => 'الفصل الدراسي الأول',
			'transcript.semester.spring' => 'الفصل الدراسي الثاني',
			'transcript.semester.summer' => 'فصل دراسي صيفي',
			'transcript.course.grade' => 'الدرجة',
			'transcript.course.credits' => 'ساعة',
			'transcript.course.status.completed' => 'مكتمل',
			'transcript.course.status.transferred' => 'معادلة',
			'academic_progress.title' => 'التقدم الدراسي',
			'academic_progress.completion' => 'نسبة إنجاز الدرجة العلمية',
			'academic_progress.total_credits' => 'إجمالي الساعات',
			'academic_progress.categories.university' => 'متطلبات جامعة حورس',
			'academic_progress.categories.faculty' => 'متطلبات الكلية',
			'academic_progress.categories.major' => 'متطلبات التخصص',
			'academic_progress.categories.electives' => 'المواد الاختيارية',
			'academic_progress.categories.university_name' => 'جامعة حورس',
			'academic_progress.status.completed' => 'مكتمل',
			'academic_progress.status.in_progress' => 'قيد الدراسة',
			'academic_progress.status.remaining' => 'متبقي',
			'academic_progress.status.requirement_met' => 'تم استيفاء المتطلب',
			'grades.title' => 'الدرجات',
			'grades.summary' => 'ملخص الدرجات',
			'grades.cumulative_gpa' => 'المعدل التراكمي',
			'grades.gpa' => 'المعدل الفصلي',
			'grades.credits' => 'ساعات',
			'grades.grade_point' => 'النقاط',
			'grades.letter_grade' => 'التقدير',
			'subject_results.title' => 'نتائج المواد',
			'subject_results.midterm' => 'منتصف الفصل',
			'subject_results.kFinal' => 'الاختبار النهائي',
			'subject_results.practical' => 'العملي',
			'subject_results.activities' => 'أعمال الفصل',
			'subject_results.total' => 'المجموع الكلي',
			'action_plan.title' => 'الخطة الدراسية',
			'action_plan.roadmap' => 'خريطة المقررات',
			'action_plan.year_1' => 'السنة الأولى',
			'action_plan.year_2' => 'السنة الثانية',
			'action_plan.year_3' => 'السنة الثالثة',
			'action_plan.year_4' => 'السنة الرابعة',
			'courses.title' => 'مقرراتي',
			'courses.enrolled' => 'المسجلة',
			'courses.available' => 'المتاحة',
			'courses.instructor' => 'المحاضر',
			'courses.schedule' => 'الموعد',
			'schedule.title' => 'جدول المحاضرات',
			'schedule.daily_title' => 'الجدول اليومي',
			'schedule.no_lectures' => 'لا توجد محاضرات اليوم',
			'schedule.time' => 'الوقت',
			'schedule.room' => 'القاعة',
			'schedule.monday' => 'الاثنين',
			'schedule.tuesday' => 'الثلاثاء',
			'schedule.wednesday' => 'الأربعاء',
			'schedule.thursday' => 'الخميس',
			'schedule.friday' => 'الجمعة',
			'schedule.saturday' => 'السبت',
			'schedule.sunday' => 'الأحد',
			'schedule.instructor' => 'المحاضر',
			'schedule.doctor' => 'د.',
			'schedule.type_lecture' => 'محاضرة',
			'schedule.type_section' => 'سكشن',
			'schedule.status_active' => 'قادمة',
			'schedule.status_started' => 'بدأت',
			'schedule.status_cancelled' => 'ملغاة',
			'schedule.status_online' => 'أونلاين',
			'schedule.status_substitute' => 'دكتور بديل',
			'schedule.morning' => 'صباحي',
			'schedule.afternoon' => 'مسائي',
			'schedule.evening' => 'ليلي',
			'schedule.all_periods' => 'كل الفترات',
			'schedule.floor' => 'الدور',
			'schedule.direction' => 'الاتجاه',
			'schedule.east' => 'شرق',
			'schedule.west' => 'غرب',
			'schedule.south' => 'جنوب',
			'schedule.north' => 'شمال',
			'exam_schedule.title' => 'جدول الامتحانات',
			'exam_schedule.date' => 'التاريخ',
			'exam_schedule.duration' => 'المدة',
			'exam_schedule.seat' => 'رقم الجلوس',
			'attendance.title' => 'إحصائيات الحضور',
			'attendance.present' => 'حاضر',
			'attendance.absent' => 'غائب',
			'attendance.late' => 'متأخر',
			'attendance.ratio' => 'نسبة الحضور',
			'attendance.subjects.ai' => 'الذكاء الاصطناعي',
			'attendance.subjects.machine_learning' => 'تعلم الآلة',
			'attendance.subjects.ethics' => 'أخلاقيات المهنة',
			'attendance.subjects.calculus' => 'تفاضل متقدم',
			'registration.title' => 'التسجيل الأكاديمي',
			'registration.submit' => 'إرسال طلب التسجيل',
			'registration.enrolled_credits' => 'الساعات المسجلة',
			'registration.step1_title' => 'الخطوة ١: اختر المجموعة الرئيسية',
			'registration.step1_subtitle' => 'اختر المجموعة التي ترغب بالتسجيل فيها لهذا الفصل الدراسي.',
			'registration.group_label' => ({required Object group}) => 'المجموعة ${group}',
			'registration.main_cohort' => 'تسجيل المجموعة الرئيسية',
			'registration.step2_title' => 'الخطوة ٢: اختر القسم الفرعي (السكشن)',
			'registration.step2_subtitle' => ({required Object group}) => 'المجموعة المختارة: ${group}. الآن اختر السكشن العملي والتطبيقي.',
			'registration.section_label' => ({required Object section}) => 'سكشن ${section}',
			'registration.labs_sessions' => 'المعامل والدروس العملية',
			'registration.step3_title' => 'الخطوة ٣: تأكيد التسجيل',
			'registration.review' => 'مراجعة خياراتك',
			'registration.semester' => 'الفصل',
			'registration.group' => 'المجموعة',
			'registration.section' => 'السكشن',
			'registration.auto_registered' => 'المقررات التي سيتم تسجيلها تلقائياً:',
			'registration.credits_count' => ({required Object credits}) => '${credits} ساعات',
			'registration.confirm_final' => 'تأكيد التسجيل النهائي',
			'registration.already_registered_title' => 'مسجل بالفعل!',
			'registration.success_message' => ({required Object group, required Object section}) => 'لقد قمت بالتسجيل المسبق بنجاح في هذا الفصل.\nالمجموعة: ${group} | السكشن: ${section}',
			'registration.back_home' => 'العودة للرئيسية',
			'registration.registration_success' => 'تم التسجيل بنجاح!',
			'registration.error_loading' => ({required Object error}) => 'خطأ: ${error}\n\nاضغط لإعادة المحاولة',
			'payment.title' => 'الدفع الإلكتروني',
			'payment.outstanding' => 'المبلغ المستحق',
			'payment.pay_now' => 'سداد الآن',
			'payment.methods' => 'طرق الدفع',
			'payment.university_guaranteed' => 'طرق الدفع بضمان الجامعة',
			'payment.credit_debit' => 'بطاقة ائتمان / خصم مباشر',
			'payment.fawry' => 'فوري / دفع إلكتروني',
			'payment.bank_transfer' => 'تحويل بنكي',
			'payment.currency' => ({required Object amount}) => '${amount} ج.م',
			'invoices.title' => 'الفواتير والمالية',
			'invoices.history' => 'سجل الدفع',
			'invoices.unpaid' => 'غير مدفوع',
			'invoices.paid' => 'تم الدفع',
			'invoices.id' => 'رقم الفاتورة',
			'invoices.date' => 'التاريخ',
			'invoices.amount' => 'المبلغ',
			'invoices.status' => 'الحالة',
			'notifications.title' => 'الإشعارات',
			'notifications.empty' => 'لا توجد إشعارات جديدة',
			'support.title' => 'الدعم والمساعدة',
			'support.contact_us' => 'اتصل بنا',
			'security.title' => 'الأمان',
			'security.biometrics' => 'البصمة',
			'security.sessions' => 'الجلسات النشطة',
			'tutorials.title' => 'التعليمات والدروس',
			'forums.title' => 'المنتديات',
			'administration.title' => 'إدارة الطلاب',
			'administration.stats' => 'إحصائيات النظام',
			'administration.users' => 'المستخدمين',
			'administration.reports' => 'التقارير',
			'administration.audit_logs.title' => 'سجلات النظام',
			'administration.audit_logs.no_logs_found' => 'لم يتم العثور على سجلات تطابق المعايير.',
			'administration.audit_logs.tabs.all' => 'سجل العمليات الكامل',
			'administration.audit_logs.tabs.security' => 'الأمان والدخول',
			'administration.audit_logs.tabs.user_management' => 'إدارة المستخدمين',
			'administration.audit_logs.tabs.data_updates' => 'تحديثات البيانات',
			'administration.audit_logs.labels.actor' => 'الفاعل',
			'administration.audit_logs.labels.table' => 'الجدول',
			'administration.audit_logs.labels.record' => 'السجل',
			'administration.audit_logs.labels.action' => 'الإجراء',
			'administration.audit_logs.labels.old_data' => 'البيانات القديمة',
			'administration.audit_logs.labels.new_data' => 'البيانات الجديدة',
			'administration.audit_logs.labels.notes' => 'ملاحظات',
			'administration.audit_logs.labels.performed_by' => 'تم بواسطة',
			'administration.audit_logs.labels.close_details' => 'إغلاق التفاصيل',
			'administration.audit_logs.labels.view_details' => 'عرض التفاصيل',
			'professor.dashboard_title' => 'لوحة تحكم الدكتور',
			'professor.welcome_back_name' => ({required Object name}) => 'مرحباً بعودتك، ${name}',
			'professor.active_tas_count' => ({required Object count}) => '${count} معيد حالي',
			'professor.total_students_count' => ({required Object count}) => '${count} إجمالي الطلاب',
			'professor.uploaded_files_count' => ({required Object count}) => '${count} ملف مرفوع',
			'professor.weekly_slots_count' => ({required Object count}) => '${count} مواعيد أسبوعية',
			'professor.announcement_to' => ({required Object count}) => 'إرسال إعلان لـ ${count}',
			'professor.preparing_announcement' => 'جاري تجهيز الإعلان...',
			'professor.no_groups' => 'لا توجد مجموعات',
			'professor.select_all' => 'تحديد الكل',
			'professor.deselect_all' => 'إلغاء التحديد',
			'professor.selected_count' => ({required Object count}) => '${count} محدد',
			'professor.action_clicked' => ({required Object action}) => 'تم النقر: ${action}',
			'professor.activating' => ({required Object target}) => 'تفعيل: ${target}',
			'professor.add_new_ta' => 'إضافة معيد جديد',
			'professor.no_available_tas' => 'لا يوجد معيدون متاحون',
			'professor.no_active_tas' => 'لا يوجد معيدون حالياً',
			'professor.added' => ({required Object name}) => 'تم إضافة: ${name}',
			'professor.removed' => ({required Object name}) => 'تم إزالة: ${name}',
			'professor.add' => 'إضافة',
			'professor.urgent' => 'عاجل',
			'professor.upload' => 'رفع',
			'professor.message' => 'مراسلة',
			'professor.downloading' => 'جاري التحميل...',
			'professor.walk_in' => 'بدون موعد',
			'professor.joined' => ({required Object name}) => 'تم الانضمام: ${name}',
			'professor.join' => 'انضمام',
			'professor.stats.groups' => 'المجموعات',
			'professor.stats.students' => 'إجمالي الطلاب',
			'professor.stats.tas' => 'المعيدين',
			'professor.stats.rating' => 'التقييم',
			'professor.stats.shared_files' => 'الملفات المشتركة',
			'professor.stats.office_hours' => 'الساعات المكتبية',
			'professor.quick_actions.urgent' => 'عاجل',
			'professor.quick_actions.upload' => 'رفع',
			'professor.quick_actions.message' => 'مراسلة',
			'professor.quick_actions.action_clicked' => 'تم النقر',
			'professor.profile.urgent_announcements' => 'التنبيهات العاجلة',
			'professor.profile.teaching_assistants' => 'المعيدين',
			'professor.profile.shared_resources' => 'المصادر المشتركة',
			'professor.profile.office_hours' => 'الساعات المكتبية',
			'roles.categories.admin_it' => 'الإدارة والتقنية',
			'roles.categories.academic_leadership' => 'القيادة الأكاديمية',
			'roles.categories.teaching_staff' => 'الكادر التعليمي',
			'roles.categories.student_affairs' => 'الخدمات الطلابية',
			'roles.categories.student_roles' => 'رتب الطلاب',
			'roles.categories.facilities_security' => 'المرافق والأمن',
			'roles.categories.external_roles' => 'الخبراء الخارجيين',
			'roles.names.super_admin' => 'مدير النظام العام',
			'roles.names.admin' => 'مسؤول نظام',
			'roles.names.it_support' => 'المسؤول التقني',
			'roles.names.financial_auditor' => 'المراقب المالي',
			'roles.names.rector' => 'مدير الجامعة',
			'roles.names.dean' => 'عميد الكلية',
			'roles.names.department_head' => 'رئيس القسم',
			'roles.names.academic_coordinator' => 'المنسق الأكاديمي',
			'roles.names.professor' => 'عضو هيئة تدريس',
			'roles.names.lecturer' => 'محاضر',
			'roles.names.teaching_assistant' => 'معيد / مساعد باحث',
			'roles.names.registrar_officer' => 'مشرف القبول والتسجيل',
			'roles.names.academic_advisor' => 'المرشد الأكاديمي',
			'roles.names.librarian' => 'أمين المكتبة',
			'roles.names.freshman' => 'طالب مستجد',
			'roles.names.regular_student' => 'طالب منتظم',
			'roles.names.student' => 'طالب',
			'roles.names.class_representative' => 'رئيس الدفعة',
			'roles.names.alumni' => 'خريج',
			'roles.names.dorm_supervisor' => 'مشرف السكن',
			'roles.names.security_officer' => 'مسؤول الأمن',
			'roles.names.guest' => 'زائر',
			'roles.names.parent' => 'ولي الأمر',
			'roles.names.recruiter' => 'جهة توظيف',
			'roles.descriptions.super_admin' => 'تحكم كامل في النظام بأكمله',
			'roles.descriptions.admin' => 'مسؤول نظام بصلاحيات عالية',
			'roles.descriptions.it_support' => 'دعم وصيانة النظام التقني',
			'roles.descriptions.financial_auditor' => 'مراقبة السجلات المالية والفواتير',
			'roles.descriptions.rector' => 'مدير الجامعة مع إشراف أكاديمي كامل',
			'roles.descriptions.dean' => 'رئيس كلية أو مجمع أكاديمي',
			_ => null,
		} ?? switch (path) {
			'roles.descriptions.department_head' => 'رئيس قسم أكاديمي',
			'roles.descriptions.academic_coordinator' => 'تنسيق البرامج الأكاديمية والجداول',
			'roles.descriptions.professor' => 'عضو هيئة تدريس يقوم بالتدريس وإدارة المقررات',
			'roles.descriptions.lecturer' => 'يقوم بالتدريس بدون صلاحيات الأستاذ الكاملة',
			'roles.descriptions.teaching_assistant' => 'يساعد الأساتذة في التصحيح والمعامل والتمارين',
			'roles.descriptions.registrar_officer' => 'إدارة قبول وتسجيل الطلاب',
			'roles.descriptions.academic_advisor' => 'يرشد الطلاب خلال التخطيط الأكاديمي',
			'roles.descriptions.librarian' => 'إدارة الموارد والمواد المكتبية',
			'roles.descriptions.freshman' => 'طالب في السنة الأولى مع صلاحيات محدودة',
			'roles.descriptions.regular_student' => 'طالب منتظم مع جميع الصلاحيات الأكاديمية المعتادة',
			'roles.descriptions.student' => 'طالب عام',
			'roles.descriptions.class_representative' => 'قائد طلابي يمثل مجموعته الدراسية',
			'roles.descriptions.alumni' => 'طالب خريج مع صلاحيات محدودة',
			'roles.descriptions.dorm_supervisor' => 'إدارة عمليات السكن الطلابي',
			'roles.descriptions.security_officer' => 'أمن الحرم الجامعي والتحكم في الدخول',
			'roles.descriptions.guest' => 'زائر مؤقت مع صلاحيات محدودة',
			'roles.descriptions.parent' => 'يمكنه متابعة تقدم الطالب المرتبط ودرجاته',
			'roles.descriptions.recruiter' => 'جهة توظيف خارجية',
			'extracted.change_profile_photo' => 'تغيير الصورة الشخصية',
			'extracted.take_photo' => 'التقاط صورة',
			'extracted.choose_from_gallery' => 'اختيار من المعرض',
			'extracted.remove_photo' => 'حذف الصورة',
			'extracted.save' => 'حفظ',
			'extracted.user' => 'المستخدم',
			'extracted.personal_info' => 'المعلومات الشخصية',
			'extracted.full_name' => 'الاسم الكامل',
			'extracted.required' => 'مطلوب',
			'extracted.email' => 'البريد الإلكتروني',
			'extracted.phone_number' => 'رقم الجوال',
			'extracted.national_id' => 'رقم الهوية',
			'extracted.about_me' => 'نبذة شخصية',
			'extracted.write_something_about_yourself' => 'اكتب نبذة عن نفسك...',
			'extracted.account_info' => 'معلومات الحساب',
			'extracted.role' => 'الدور',
			'extracted.account_status' => 'حالة الحساب',
			'extracted.active' => 'نشط',
			'extracted.save_changes' => 'حفظ التغييرات',
			'extracted.account' => 'بيانات الحساب',
			'extracted.appearance' => 'المظهر',
			'extracted.notifications' => 'الإشعارات',
			'extracted.language_region' => 'اللغة والمنطقة',
			'extracted.support_feedback' => 'الدعم والتواصل',
			'extracted.about' => 'حول التطبيق',
			'extracted.edit_profile' => 'تعديل الملف الشخصي',
			'extracted.update_your_personal_info_and_photo' => 'تحديث معلوماتك وبياناتك الشخصية',
			'extracted.password_recovery' => 'استعادة كلمة المرور',
			'extracted.send_password_recovery_link_to_your_emai' => 'إرسال رابط استعادة كلمة المرور لبريدك الإلكتروني',
			'extracted.dark_mode' => 'الوضع المظلم',
			'extracted.toggle_between_dark_and_light_mode' => 'التبديل بين الوضع الداكن والفاتح',
			'extracted.ui_style' => 'نمط الواجهة',
			'extracted.current_glass_design' => 'الحالي: تصميم الزجاج',
			'extracted.current_classic_design' => 'الحالي: التصميم الكلاسيكي',
			'extracted.kSwitch' => 'تبديل',
			'extracted.battery_saver_mode' => 'وضع توفير البطارية',
			'extracted.disable_complex_visual_effects' => 'تعطيل التأثيرات البصرية لأداء أفضل',
			'extracted.app_notifications' => 'إشعارات التطبيق',
			'extracted.notifications_are_active' => 'الإشعارات مفعّلة',
			'extracted.notifications_are_off' => 'الإشعارات موقوفة',
			'extracted.notification_center' => 'مركز الإشعارات',
			'extracted.view_all_your_notifications' => 'عرض جميع الإشعارات والتنبيهات',
			'extracted.test_notification' => 'اختبار الإشعارات',
			'extracted.send_a_test_notification' => 'إرسال إشعار تجريبي',
			'extracted.test_notification_sent' => 'تم إرسال الإشعار بنجاح!',
			'extracted.app_language' => 'لغة التطبيق',
			'extracted.support_center' => 'مركز الدعم',
			'extracted.get_help_and_resolve_any_issues' => 'تواصل معنا لحل أي مشكلة',
			'extracted.send_feedback' => 'إرسال ملاحظة',
			'extracted.share_your_thoughts_to_help_improve_the_' => 'شاركنا رأيك لتحسين التطبيق',
			'extracted.rate_the_app' => 'تقييم التطبيق',
			'extracted.your_support_matters' => '⭐ دعمك يهمنا',
			'extracted.thank_you_for_your_support' => 'شكراً على دعمك! 🎉',
			'extracted.about_app' => 'حول التطبيق',
			'extracted.version_details_and_developer_info' => 'تفاصيل الإصدار والمطورين',
			'extracted.privacy_policy' => 'سياسة الخصوصية',
			'extracted.terms_and_rules_for_data_usage' => 'شروط وقواعد استخدام بياناتك',
			'extracted.log_out' => 'تسجيل الخروج',
			'extracted.how_can_we_help_you' => 'كيف يمكننا مساعدتك؟',
			'extracted.email_support' => 'البريد الإلكتروني',
			'extracted.call_hotline' => 'خط الدعم الساخن',
			'extracted.chat_with_us_on_whatsapp' => 'تواصل معنا عبر واتساب',
			'extracted.your_opinion_helps_us_improve' => 'رأيك يساعدنا على التطوير',
			'extracted.write_your_feedback_here' => 'اكتب ملاحظتك هنا...',
			'extracted.thank_you_feedback_submitted' => '✅ شكراً! تم إرسال ملاحظتك بنجاح',
			'extracted.submit_feedback' => 'إرسال الملاحظة',
			'extracted.departments' => 'أقسام',
			'extracted.students' => 'الطلاب',
			'extracted.est' => 'تأسيس',
			'extracted.add_department' => 'إضافة قسم جديد',
			'extracted.add_new_department' => 'إضافة قسم جديد',
			'extracted.department_name_en' => 'اسم القسم (إنجليزي)',
			'extracted.department_name_ar' => 'اسم القسم (عربي)',
			'extracted.department_code' => 'رمز القسم',
			'extracted.description' => 'الوصف',
			'extracted.cancel' => 'إلغاء',
			'extracted.add' => 'إضافة',
			'extracted.staff' => 'أعضاء',
			'extracted.building' => 'مبنى',
			'extracted.assistant_head' => 'مساعد رئيس القسم',
			'extracted.no_assistant_assigned' => 'لم يتم تعيين مساعد',
			'extracted.please_assign_an_assistant_head_for_the_' => 'يرجى تعيين مساعد لرئيس القسم',
			'extracted.add_staff' => 'إضافة عضو',
			'extracted.no_faculty_members_assigned' => 'لا يوجد أعضاء هيئة تدريس',
			'extracted.add_faculty' => 'إضافة عضو هيئة تدريس',
			'extracted.head' => 'رئيس',
			'extracted.asst' => 'مساعد',
			'extracted.remove' => 'إزالة',
			'extracted.add_faculty_member' => 'إضافة عضو هيئة تدريس',
			'extracted.confirm_removal' => 'تأكيد الإزالة',
			'extracted.remove_stafffullname_from_this_department' => ({required Object staff_fullName}) => 'هل تريد إزالة ${staff_fullName} من هذا القسم؟',
			'extracted.roles_management' => 'إدارة الرتب',
			'extracted.merge_roles' => 'دمج رتبتين',
			'extracted.create_role' => 'إنشاء رتبة جديدة',
			'extracted.search_roles' => 'بحث عن رتبة...',
			'extracted.custom' => 'مخصصة',
			'extracted.no_results' => 'لا توجد نتائج',
			'extracted.no_roles' => 'لا توجد رتب',
			'extracted.no_custom_roles_yet' => 'لا توجد رتب مخصصة بعد',
			'extracted.create_a_new_role_or_merge_two_roles' => 'أنشئ رتبة جديدة أو ادمج رتبتين',
			'extracted.create' => 'إنشاء',
			'extracted.merge' => 'دمج',
			'extracted.could_not_load_custom_roles' => 'لا يمكن تحميل الرتب المخصصة',
			'extracted.make_sure_roles_table_exists_in_supabase' => 'تأكد من وجود جدول "roles" في Supabase',
			'extracted.create_new_role' => 'إنشاء رتبة جديدة',
			'extracted.name_english' => 'الاسم بالإنجليزية',
			'extracted.name_arabic' => 'الاسم بالعربية',
			'extracted.category' => 'القسم',
			'extracted.description_english' => 'الوصف بالإنجليزية',
			'extracted.description_arabic' => 'الوصف بالعربية',
			'extracted.permissions' => 'الصلاحيات',
			'extracted.role_created' => 'تم إنشاء الرتبة بنجاح',
			'extracted.merge_two_roles' => 'دمج رتبتين',
			'extracted.select_two_roles_to_combine_their_permis' => 'اختر رتبتين لدمجهما وإنشاء رتبة مدمجة جديدة',
			'extracted.first_role' => 'الرتبة الأولى',
			'extracted.second_role' => 'الرتبة الثانية',
			'extracted.merged_role_name_english' => 'اسم الرتبة المدمجة (إنجليزي)',
			'extracted.merged_role_name_arabic' => 'اسم الرتبة المدمجة (عربي)',
			'extracted.merged_permissions_preview' => 'معاينة الصلاحيات المدمجة',
			'extracted.roles_merged_successfully' => 'تم دمج الرتبتين بنجاح',
			'extracted.edit_role' => 'تعديل الرتبة',
			'extracted.role_updated' => 'تم تحديث الرتبة',
			'extracted.delete_role' => 'حذف الرتبة',
			'extracted.delete_role_rolenameen_this_cannot_be_undone' => ({required Object role_nameEn}) => 'هل تريد حذف "${role_nameEn}"؟ لا يمكن التراجع.',
			'extracted.delete' => 'حذف',
			'extracted.admin_it' => 'الإدارة والتقنية',
			'extracted.leadership' => 'القيادة الأكاديمية',
			'extracted.teaching' => 'الهيئة التدريسية',
			'extracted.student_affairs' => 'شؤون الطلاب',
			'extracted.facilities' => 'المرافق والأمن',
			'extracted.external' => 'خارجي',
			'extracted.permissions_1' => 'الصلاحيات:',
			'extracted.merged' => 'مدمجة',
			'extracted.user_details' => 'تفاصيل المستخدم',
			'extracted.quick_actions' => 'إجراءات سريعة',
			'extracted.verification' => 'التوثيق',
			'extracted.ban_management' => 'الحظر',
			'extracted.tags' => 'العلامات',
			'extracted.warning_level' => 'مستوى التحذير',
			'extracted.danger_zone' => 'منطقة الخطر',
			'extracted.verified' => 'موثق',
			'extracted.banned' => 'محظور',
			'extracted.deactivate' => 'تعطيل',
			'extracted.activate' => 'تفعيل',
			'extracted.unverify' => 'إلغاء التوثيق',
			'extracted.verify' => 'توثيق',
			'extracted.unban' => 'إلغاء الحظر',
			'extracted.ban' => 'حظر',
			'extracted.account_verified' => 'الحساب موثق',
			'extracted.not_verified' => 'الحساب غير موثق',
			'extracted.user_identity_has_been_verified' => 'تم التحقق من هوية المستخدم',
			'extracted.identity_not_yet_verified' => 'لم يتم التحقق بعد',
			'extracted.user_banned' => 'المستخدم محظور',
			'extracted.not_banned' => 'غير محظور',
			'extracted.user_cannot_access_the_system' => 'المستخدم لا يمكنه الوصول للنظام',
			'extracted.user_has_normal_access' => 'المستخدم يمكنه الوصول بشكل طبيعي',
			'extracted.no_tags_assigned' => 'لا توجد علامات',
			'extracted.add_tag' => 'إضافة علامة',
			'extracted.current_level' => 'المستوى الحالي',
			'extracted.created' => 'تاريخ الإنشاء',
			'extracted.last_login' => 'آخر تسجيل دخول',
			'extracted.nationality' => 'الجنسية',
			'extracted.soft_delete_deactivate' => 'تعطيل الحساب',
			'extracted.permanently_delete' => 'حذف نهائي',
			'extracted.verify_account' => 'توثيق الحساب',
			'extracted.remove_verification' => 'إلغاء التوثيق',
			'extracted.verify_userfullname' => ({required Object user_fullName}) => 'هل تريد توثيق حساب ${user_fullName}؟',
			'extracted.remove_verification_from_userfullname' => ({required Object user_fullName}) => 'هل تريد إلغاء توثيق حساب ${user_fullName}؟',
			'extracted.ban_user' => 'حظر المستخدم',
			'extracted.unban_user' => 'إلغاء الحظر',
			'extracted.ban_userfullname_they_will_lose_system_access' => ({required Object user_fullName}) => 'هل تريد حظر ${user_fullName}؟ لن يتمكن من الوصول للنظام.',
			'extracted.unban_userfullname' => ({required Object user_fullName}) => 'هل تريد إلغاء حظر ${user_fullName}؟',
			'extracted.warning_level_set_to_level' => ({required Object level}) => 'تم تحديث مستوى التحذير إلى ${level}',
			'extracted.tag_removed' => 'تم إزالة العلامة',
			'extracted.tag_name' => 'اسم العلامة',
			'extracted.permanent_delete' => 'حذف نهائي',
			'extracted.soft_delete' => 'تعطيل الحساب',
			'extracted.permanently_delete_userfullname_this_cannot_be_undone' => ({required Object user_fullName}) => 'هل أنت متأكد من حذف ${user_fullName} نهائياً؟ لا يمكن التراجع!',
			'extracted.deactivate_userfullname' => ({required Object user_fullName}) => 'هل تريد تعطيل حساب ${user_fullName}؟',
			'extracted.institution' => 'الكلية والقسم',
			'extracted.select_college' => 'اختر الكلية',
			'extracted.college_is_required' => 'الكلية مطلوبة',
			'extracted.select_department' => 'اختر القسم',
			'extracted.department_is_required' => 'القسم مطلوب',
			'extracted.out_of_max' => ({required Object max}) => 'من ${max}',
			'extracted.exceeding' => 'متفوق',
			'extracted.top_5' => 'أفضل 5%',
			'extracted.total' => 'المجموع',
			'extracted.grade' => 'التقدير',
			'extracted.mmm_dd_yyyy' => 'MMM dd, yyyy',
			'extracted.no_projects_available_yet' => 'No projects available yet',
			'extracted.details' => 'Details',
			'extracted.completed' => 'Completed',
			'extracted.paused' => 'Paused',
			'extracted.cancelled' => 'Cancelled',
			'extracted.faculty_members' => 'Faculty Members',
			'extracted.please_assign_an_assistant_head_for_the' => 'Please assign an assistant head for the department',
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
			'extracted.you_do_not_have_permission_to_access_this_section' => 'You do not have permission to access this section',
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
			'extracted.your_post_is_now_live_on_the_feed' => 'Your post is now live on the feed',
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
			'extracted.share_your_thoughts_to_help_improve_the' => 'Share your thoughts to help improve the system',
			'academic.university_requirements' => 'متطلبات الجامعة',
			'academic.academic_progress' => 'التقدم الأكاديمي',
			'academic.faculty_requirements' => 'متطلبات الكلية',
			'academic.major_requirements' => 'المتطلبات الرئيسية',
			'academic.electives' => 'الاختيارية',
			'academic.remaining' => 'متبقي',
			'academic.completed' => 'مكتمل',
			'academic.grades_title' => 'الدرجات',
			'academic.exam_schedule_title' => 'جدول الامتحانات',
			'academic.subject_results_title' => 'نتائج الموضوع',
			'academic.transcript_title' => 'النص الأكاديمي',
			'academic.attendance_title' => 'حضور',
			'academic.schedule_title' => 'جدول',
			'academic.courses_title' => 'دوراتي',
			'academic.action_plan_title' => 'خطة عمل الدرجة',
			'academic.all_students' => 'جميع الطلاب',
			'academic.professor_dashboard' => 'لوحة الأستاذ',
			'academic.tas' => 'مساعدو التدريس',
			'academic.groups' => 'المجموعات',
			'academic.no_groups' => 'لا توجد مجموعات',
			'academic.chat' => 'محادثة',
			'academic.office_hours' => 'ساعات العمل',
			'academic.courses' => 'الدورات',
			'academic.active' => 'نشيط',
			'academic.upload_file' => 'تحميل الملف',
			'academic.inactive' => 'غير نشط',
			'academic.view_all' => 'عرض الكل',
			'academic.assignments' => 'المهام',
			'academic.add_ta' => 'أضف تا',
			'academic.section' => 'قسم',
			'academic.urgent_announcement' => 'إعلان عاجل',
			'academic.send_message' => 'أرسل رسالة',
			'academic.group_label' => 'مجموعة',
			'academic.remove_ta' => 'إزالة تا',
			'academic.manage_groups' => 'إدارة المجموعات',
			'academic.all' => 'الجميع',
			'academic.profile' => 'حساب تعريفي',
			'academic.manage_tas' => 'إدارة المساعدات الفنية',
			'academic.semester_grades' => 'درجات الفصل الدراسي',
			'academic.grade_summary' => 'ملخص الصف',
			'academic.midterm' => 'منتصف المدة',
			'academic.credits' => 'الاعتمادات',
			'academic.total' => 'المجموع',
			'academic.year_1' => 'السنة 1',
			'academic.practical' => 'عملي',
			'academic.kFinal' => 'الامتحان النهائي',
			'academic.year_2' => 'السنة 2',
			'academic.enrolled' => 'مسجل',
			'academic.year_3' => 'السنة 3',
			'academic.available' => 'متاح',
			'academic.year_4' => 'السنة 4',
			'academic.time' => 'وقت',
			'academic.instructor' => 'مدرب',
			'academic.duration' => 'مدة',
			'academic.schedule_info' => 'جدول',
			'academic.exam_date' => 'تاريخ الامتحان',
			'academic.seat' => 'مقعد',
			'academic.feedback' => 'تعليق',
			'academic.absent' => 'غائب',
			'academic.loading' => 'تحميل...',
			'academic.room' => 'غرفة',
			'academic.ratio' => 'نسبة',
			'academic.search' => 'يبحث',
			'academic.no_data' => 'لا توجد بيانات متاحة',
			'academic.late' => 'متأخر',
			'academic.present' => 'حاضر',
			'academic.error' => 'خطأ',
			'academic.save' => 'يحفظ',
			'academic.cancel' => 'يلغي',
			'academic.retry' => 'أعد المحاولة',
			'academic.filter' => 'فلتر',
			'academic.back' => 'خلف',
			'academic.confirm' => 'يتأكد',
			'academic.delete' => 'يمسح',
			'academic.edit' => 'يحرر',
			'academic.send' => 'يرسل',
			'academic.remove' => 'يزيل',
			'academic.add' => 'يضيف',
			'academic.close' => 'يغلق',
			'academic.academic_journey' => 'رحلة أكاديمية',
			'academic.academic_results' => 'النتائج الأكاديمية',
			'academic.across_all_groups' => 'عبر جميع المجموعات',
			'academic.academic_standing_excellent' => 'ممتاز',
			'academic.add_to_calendar' => 'أضف إلى التقويم',
			'academic.add_new_ta' => 'إضافة تا جديد',
			'academic.advanced_learning' => 'التعلم المتقدم',
			'academic.added_successfully' => 'تمت الإضافة بنجاح',
			'academic.advanced_mathematics' => 'الرياضيات المتقدمة',
			'academic.advisor_assignment' => 'تعيين مستشار',
			'academic.action_plan' => 'خطة عمل الدرجة',
			'academic.algorithms' => 'الخوارزميات',
			'academic.gpa' => 'المعدل التراكمي',
			'academic.are_you_sure_you_want_to_remov' => 'هل أنت متأكد أنك تريد إزالة TA هذا؟',
			'academic.artificial_intelligence' => 'الذكاء الاصطناعي',
			'academic.calculus_i' => 'حساب التفاضل والتكامل أنا',
			'academic.clicked' => 'تم النقر عليه',
			'academic.code_review' => 'مراجعة الكود',
			'academic.completed_1' => 'مكتمل',
			'academic.completion_rate' => 'معدل الإنجاز',
			'academic.computer_programming' => 'برمجة الكمبيوتر',
			'academic.course_management' => 'إدارة الدورة',
			'academic.confirm_removal' => 'تأكيد الإزالة',
			'academic.coursework' => 'الدورات الدراسية',
			'academic.credits_1' => 'الاعتمادات',
			'academic.cs405_machine_learning' => 'التعلم الآلي CS405',
			'academic.cs402_artificial_intelligence' => 'الذكاء الاصطناعي CS402',
			'academic.cs410_computer_vision' => 'رؤية الكمبيوتر CS410',
			'academic.database_systems' => 'أنظمة قواعد البيانات',
			'academic.data_structures' => 'هياكل البيانات',
			'academic.d_mmmm' => 'د ط ط ط ط',
			'academic.cumulative_gpa' => 'المعدل التراكمي',
			'academic.deep_learning' => 'التعلم العميق',
			'academic.days' => 'أيام',
			'academic.dr_ada_lovelace' => 'دكتورة أدا لوفليس',
			'academic.dr_robert_smith' => 'دكتور روبرت سميث',
			'academic.ethics_in_it' => 'الأخلاقيات في مجال تكنولوجيا المعلومات',
			'academic.dr_sarah_ahmed' => 'د/سارة أحمد',
			'academic.english_composition' => 'تكوين اللغة الإنجليزية',
			'academic.field_internship' => 'التدريب الميداني',
			'academic.exam_schedule' => 'جدول الامتحانات',
			'academic.dr_alan_turing' => 'الدكتور آلان تورينج',
			'academic.fall_2023' => 'خريف 2023',
			'academic.file_will_be_uploaded_to_cloud' => 'سيتم رفع الملف إلى التخزين السحابي',
			'academic.file_title' => 'عنوان الملف',
			'academic.final_exam' => 'الامتحان النهائي',
			'academic.foundational_skills' => 'المهارات التأسيسية',
			'academic.general_physics' => 'الفيزياء العامة',
			'academic.graduation_progress' => 'تقدم التخرج',
			'academic.graduation_mastery' => 'إتقان التخرج',
			'academic.frontend_ui' => 'واجهة المستخدم الأمامية',
			'academic.hall_1' => 'القاعة 1',
			'academic.graduation_project' => 'مشروع التخرج',
			'academic.hall_4' => 'القاعة 4',
			'academic.hum210_professional_ethics' => 'HUM210 الأخلاقيات المهنية',
			'academic.hours' => 'ساعات',
			'academic.intro_to_ai' => 'مقدمة إلى الذكاء الاصطناعي',
			'academic.intro_to_programming' => 'مقدمة في البرمجة',
			'academic.comp_organization' => 'منظمة الكمبيوتر',
			'academic.joined' => 'انضم',
			'academic.lab_12' => 'المختبر 12',
			'academic.lecture' => 'محاضرة',
			'academic.lab_final' => 'مختبر نهائي',
			'academic.linear_algebra' => 'الجبر الخطي',
			'academic.live_now' => 'عش الآن',
			'academic.lecture_hall_2' => 'قاعة المحاضرات 2',
			'academic.live' => 'يعيش',
			'academic.logic_design' => 'التصميم المنطقي',
			'academic.machine_learning' => 'التعلم الآلي',
			'academic.mathematics' => 'الرياضيات',
			'academic.mat301_advanced_calculus' => 'MAT301 حساب التفاضل والتكامل المتقدم',
			'academic.members' => 'أعضاء',
			'academic.midterm_exam' => 'الامتحان النصفي',
			'academic.mins' => 'دقيقة',
			'academic.network_security' => 'أمن الشبكات',
			'academic.next_exam_in' => 'الامتحان القادم في',
			'academic.messages' => 'رسائل',
			'academic.no_available_tas_currently' => 'لا توجد مساعدات مساعدة متاحة حاليًا',
			'academic.overall_attendance' => 'الحضور الشامل',
			'academic.no_tas_assigned_yet' => 'لم يتم تعيين مساعدات فنية حتى الآن',
			'academic.no_exams_on_this_day' => 'لا يوجد امتحانات في هذا اليوم',
			'academic.performance_distribution' => 'توزيع الأداء',
			'academic.points' => 'نقاط',
			'academic.practical_project' => 'مشروع عملي',
			'academic.prof_john_doe' => 'البروفيسور جون دو',
			'academic.programming_basics' => 'أساسيات البرمجة',
			'academic.overall_progress' => 'التقدم الشامل',
			'academic.progress' => 'تقدم',
			'academic.psychology' => 'علم النفس',
			'academic.quick_actions' => 'إجراءات سريعة',
			'academic.quiz_1' => 'الاختبار 1',
			'academic.rank' => 'رتبة',
			'academic.quiz_2' => 'الاختبار 2',
			'academic.registration_requests' => 'طلبات التسجيل',
			'academic.rating' => 'تصنيف',
			'academic.score' => 'نتيجة',
			'academic.removed_successfully' => 'تمت الإزالة بنجاح',
			'academic.select_a_ta_from_the_list_to_a' => 'حدد TA من القائمة لإضافتها',
			'academic.shared_files' => 'الملفات المشتركة',
			'academic.sessions_this_week' => 'جلسات هذا الأسبوع',
			'academic.results_analysis' => 'تحليل النتائج',
			'academic.specialization_projects' => 'مشاريع التخصص',
			'academic.start_by_adding_the_first_ta_f' => 'ابدأ بإضافة أول TA للدورة التدريبية الخاصة بك',
			'academic.students' => 'طلاب',
			'academic.sophomore' => 'طالبة',
			'academic.total_students' => 'إجمالي الطلاب',
			'academic.ta_team_chat' => 'دردشة فريق TA',
			'academic.track_project_i' => 'تتبع المشروع I',
			'academic.type_a_message' => 'اكتب رسالة...',
			'academic.upload_files' => 'تحميل الملفات',
			'academic.upload' => 'رفع',
			'academic.upload_new_file' => 'تحميل ملف جديد',
			'academic.uploaded_successfully' => 'تم الرفع بنجاح',
			'academic.urgent_news' => 'أخبار عاجلة',
			'academic.web_programming' => 'برمجة الويب',
			'academic.spring_2024' => 'ربيع 2024',
			'academic.summer_2024' => 'صيف 2024',
			'admin.eeee_mmmm_dd_yyyy' => 'EEEE، MMMM ي ي، س س س',
			'admin.system_online' => 'النظام عبر الإنترنت',
			'admin.admin_command_center' => 'مركز قيادة المشرف',
			'admin.en' => 'أون',
			'admin.admin' => 'مسؤل',
			'admin.students' => 'طلاب',
			'admin.live_statistics' => 'الإحصائيات الحية',
			'admin.staff' => 'طاقم عمل',
			'admin.faculty' => 'كلية',
			'admin.leadership' => 'قيادة',
			'admin.admin_it' => 'الإدارة وتكنولوجيا المعلومات',
			'admin.system_modules' => 'وحدات النظام',
			'admin.users' => 'المستخدمين',
			'admin.colleges' => 'الكليات',
			'admin.manage_faculties' => 'إدارة الكليات',
			'admin.manage_all_accounts' => 'إدارة كافة الحسابات',
			'admin.departments' => 'الأقسام',
			'admin.roles' => 'الأدوار',
			'admin.academic_departments' => 'الأقسام الأكاديمية',
			'admin.permission_management' => 'إدارة الأذونات',
			'admin.professors' => 'الأساتذة',
			'admin.faculty_members' => 'أعضاء هيئة التدريس',
			'admin.audit_logs' => 'سجلات التدقيق',
			'admin.system_activity_log' => 'سجل نشاط النظام',
			'admin.system_settings' => 'إعدادات النظام',
			'admin.platform_configuration' => 'تكوين المنصة',
			'admin.performance' => 'أداء',
			'admin.server_health_metrics' => 'مقاييس صحة الخادم',
			'admin.system_pulse' => 'نبض النظام',
			'admin.server' => 'الخادم',
			'admin.latency' => 'كمون',
			'admin.online' => 'متصل',
			'admin.status' => 'حالة',
			'admin.database' => 'قاعدة البيانات',
			'admin.active' => 'نشيط',
			'admin.realtime_latency_ms' => 'الكمون في الوقت الحقيقي (مللي ثانية)',
			'admin.role_breakdown' => 'انهيار الدور',
			'admin.teaching_staff' => 'أعضاء هيئة التدريس',
			'admin.student_affairs' => 'شؤون الطلاب',
			_ => null,
		} ?? switch (path) {
			'admin.system_health' => 'صحة النظام',
			'admin.total_users' => 'إجمالي المستخدمين',
			'admin.quick_actions' => 'إجراءات سريعة',
			'admin.add_user' => 'إضافة مستخدم',
			'admin.export_data' => 'تصدير البيانات',
			'admin.academic_leadership' => 'القيادة الأكاديمية',
			'admin.management' => 'إدارة',
			'admin.send_announcement' => 'إرسال إعلان',
			'admin.backup_system' => 'نظام النسخ الاحتياطي',
			'admin.user_management' => 'إدارة المستخدم',
			'admin.user_list' => 'قائمة المستخدمين',
			'admin.filter_all' => 'الجميع',
			'admin.filter_students' => 'طلاب',
			'admin.search_users' => 'البحث عن المستخدمين...',
			'admin.filter_staff' => 'طاقم عمل',
			'admin.filter_admin' => 'مسؤل',
			'admin.no_users' => 'لم يتم العثور على مستخدمين',
			'admin.user_count' => ({required Object count}) => 'مستخدمي${count}',
			'admin.student_management' => 'إدارة الطلاب',
			'admin.faculty_management' => 'إدارة الكلية',
			'admin.leadership_management' => 'إدارة القيادة',
			'admin.staff_management' => 'إدارة الموظفين',
			'admin.admin_it_management' => 'الإدارة وإدارة تكنولوجيا المعلومات',
			'admin.department_management' => 'إدارة القسم',
			'admin.professor_management' => 'إدارة الأستاذ',
			'admin.role_management' => 'إدارة الأدوار',
			'admin.audit_log_management' => 'إدارة سجل التدقيق',
			'admin.system_configuration' => 'تكوين النظام',
			'admin.edit_college' => 'تحرير الكلية',
			'admin.add_department' => 'إضافة قسم',
			'admin.add_college' => 'أضف الكلية',
			'admin.college_name' => 'اسم الكلية',
			'admin.delete_department' => 'حذف القسم',
			'admin.department_name' => 'اسم القسم',
			'admin.delete_college' => 'حذف الكلية',
			'admin.head_name' => 'اسم الرأس',
			'admin.dean_name' => 'اسم العميد',
			'admin.student_count' => 'طلاب',
			'admin.ta_count' => 'المساعدة التقنية',
			'admin.action' => 'فعل',
			'admin.staff_count' => 'طاقم عمل',
			'admin.edit_department' => 'قسم التحرير',
			'admin.timestamp' => 'الطابع الزمني',
			'admin.user' => 'مستخدم',
			'admin.details' => 'تفاصيل',
			'admin.filter_by_action' => 'تصفية حسب العمل',
			'admin.filter_by_date' => 'تصفية حسب التاريخ',
			'admin.no_logs' => 'لم يتم العثور على سجلات التدقيق',
			'admin.system_version' => 'إصدار النظام',
			'admin.maintenance_mode' => 'وضع الصيانة',
			'admin.backup_schedule' => 'جدول النسخ الاحتياطي',
			'admin.email_server' => 'خادم البريد الإلكتروني',
			'admin.storage_quota' => 'حصة التخزين',
			'admin.security_level' => 'مستوى الأمان',
			'admin.reset_defaults' => 'إعادة التعيين إلى الإعدادات الافتراضية',
			'admin.save_settings' => 'حفظ الإعدادات',
			'admin.user_email' => 'بريد إلكتروني',
			'admin.session_timeout' => 'مهلة الجلسة',
			'admin.user_role' => 'دور',
			'admin.user_phone' => 'هاتف',
			'admin.user_name' => 'اسم',
			'admin.user_department' => 'قسم',
			'admin.log_retention' => 'الاحتفاظ بالسجل',
			'admin.user_college' => 'كلية',
			'admin.user_created' => 'مخلوق',
			'admin.user_status' => 'حالة',
			'admin.add_new_user' => 'إضافة مستخدم جديد',
			'admin.user_updated' => 'تم تحديث المستخدم بنجاح',
			'admin.edit_user' => 'تحرير المستخدم',
			'admin.delete_user' => 'حذف المستخدم',
			'admin.save_user' => 'يحفظ',
			'admin.cancel' => 'يلغي',
			'admin.email_label' => 'عنوان البريد الإلكتروني',
			'admin.department_label' => 'قسم',
			'admin.phone_label' => 'رقم التليفون',
			'admin.role_label' => 'حدد الدور',
			'admin.college_label' => 'كلية',
			'admin.category_student' => 'طالب',
			'admin.confirm_password_label' => 'تأكيد كلمة المرور',
			'admin.name_label' => 'الاسم الكامل',
			'admin.category_staff' => 'طاقم عمل',
			'admin.password_label' => 'كلمة المرور',
			'admin.category_faculty' => 'كلية',
			'admin.category_leadership' => 'قيادة',
			'admin.category_admin' => 'مسؤل',
			'admin.no_departments' => 'لا توجد أقسام متاحة',
			'admin.select_role' => 'حدد دورًا',
			'admin.no_colleges' => 'لا توجد كليات متاحة',
			'admin.select_department' => 'اختر قسمًا',
			'admin.select_college' => 'اختر الكلية',
			'admin.user_added' => 'تمت إضافة المستخدم بنجاح',
			'admin.user_deleted' => 'تم حذف المستخدم بنجاح',
			'admin.confirm_delete' => 'تأكيد الحذف',
			'admin.confirm_delete_message' => 'هل أنت متأكد أنك تريد حذف هذا المستخدم؟',
			'admin.error_loading' => 'حدث خطأ أثناء تحميل البيانات',
			'admin.error_saving' => 'خطأ في حفظ البيانات',
			'admin.academic_leaders' => 'القادة الأكاديميون',
			'admin.academic_departments_1' => 'الأقسام الأكاديمية',
			'admin.retry' => 'أعد المحاولة',
			'admin.academic_department' => 'القسم الأكاديمي',
			'admin.academic_warnings' => 'التحذيرات الأكاديمية',
			'admin.account_status' => 'حالة الحساب',
			'admin.actor' => 'ممثل',
			'admin.add_report' => 'إضافة تقرير',
			'admin.admins' => 'المشرفين',
			'admin.advanced_management' => 'الإدارة المتقدمة',
			'admin.account_verification' => 'التحقق من الحساب',
			'admin.all_systems_operational' => 'جميع الأنظمة التشغيلية',
			'admin.all_levels' => 'جميع المستويات',
			'admin.all' => 'الجميع',
			'admin.apply_filters' => 'تطبيق المرشحات',
			'admin.assign_dean' => 'تعيين عميد',
			'admin.are_you_sure_you_want_to_delet' => 'هل أنت متأكد أنك تريد حذف هذا المستخدم؟',
			'admin.assign' => 'تعيين',
			'admin.assign_department_head' => 'تعيين رئيس القسم',
			'admin.attached_report' => 'التقرير المرفق',
			'admin.change' => 'يتغير',
			'admin.ban_user' => 'حظر المستخدم',
			'admin.banned' => 'محظور',
			'admin.change_dean' => 'تغيير العميد',
			'admin.changes_saved_successfully' => 'تم حفظ التغييرات بنجاح',
			'admin.college' => 'كلية',
			'admin.college_dean' => 'عميد الكلية',
			'admin.college_details' => 'تفاصيل الكلية',
			'admin.colleges_management' => 'إدارة الكليات',
			'admin.deactivated' => 'معطل',
			'admin.coming_soon' => 'قريباً',
			'admin.delete' => 'يمسح',
			'admin.department_details' => 'تفاصيل القسم',
			'admin.department_projects' => 'مشاريع القسم',
			'admin.email_address' => 'عنوان البريد الإلكتروني',
			'admin.entity' => 'كيان',
			'admin.departments_management' => 'إدارة الأقسام',
			'admin.error_snapshoterror' => 'خطأ: {خطأ}',
			'admin.faculty_members_1' => 'أعضاء هيئة التدريس',
			'admin.filter_users' => 'تصفية المستخدمين',
			'admin.full_name' => 'الاسم الكامل',
			'admin.failed_to_load_data' => 'فشل في تحميل البيانات',
			'admin.head_of_department' => 'رئيس القسم',
			'admin.incidents' => 'الحوادث',
			'admin.leadership_stats' => 'إحصائيات القيادة',
			'admin.level_level' => ({required Object level}) => 'المستوى ${level}',
			'admin.manage_tags' => 'إدارة العلامات',
			'admin.min_6_chars' => 'دقيقة. 6 أحرف',
			'admin.national_id' => 'الهوية الوطنية',
			'admin.no_about_text_available' => 'لا يوجد حول النص المتاح',
			'admin.no_colleges_found' => 'لم يتم العثور على كليات',
			'admin.nationality' => 'جنسية',
			'admin.no_dean_assigned' => 'لم يتم تعيين عميد',
			'admin.no_departments_in_this_college' => 'لا توجد أقسام في هذه الكلية',
			'admin.no_description_available' => 'لا يوجد وصف متاح',
			'admin.no_head_assigned' => 'لم يتم تعيين رئيس',
			'admin.no_logs_found' => 'لم يتم العثور على سجلات',
			'admin.no_departments_found' => 'لم يتم العثور على أقسام',
			'admin.no_faculty_records_found' => 'لم يتم العثور على سجلات أعضاء هيئة التدريس',
			'admin.no_projects_added_yet' => 'لم تتم إضافة أي مشاريع حتى الآن',
			'admin.no_settings_found_in_the_datab' => 'لم يتم العثور على إعدادات في قاعدة البيانات',
			'admin.no_matching_students_found' => 'لم يتم العثور على طلاب متطابقين',
			'admin.no_users_found' => 'لم يتم العثور على مستخدمين',
			'admin.office' => 'مكتب',
			'admin.password' => 'كلمة المرور',
			'admin.pending_reg' => 'في انتظار التسجيل',
			'admin.permanently_delete_user' => 'حذف المستخدم نهائيًا',
			'admin.please_assign_a_dean_for_the_c' => 'أرجو تعيين عميد لهذه الكلية',
			'admin.phone_number' => 'رقم التليفون',
			'admin.please_assign_a_head_for_the_d' => 'يرجى تعيين رئيس لهذا القسم',
			'admin.save' => 'يحفظ',
			'admin.roles_management' => 'إدارة الأدوار',
			'admin.search_by_name_email_phone_id' => 'البحث حسب الاسم أو البريد الإلكتروني أو الهاتف أو الهوية...',
			'admin.search_doctor_name' => 'بحث عن اسم الطبيب...',
			'admin.save_changes' => 'حفظ التغييرات',
			'admin.search_student_or_id' => 'البحث عن الطالب أو الهوية...',
			'admin.select' => 'يختار',
			'admin.search_staff_member' => 'البحث عن موظف...',
			'admin.select_role_in_widgetinitialca' => 'حدد الدور',
			'admin.separate_tags_with_commas' => 'علامات منفصلة بفواصل',
			'admin.select_role_permission' => 'حدد الدور / الإذن',
			'admin.student_id' => 'معرف الطالب',
			'admin.servers' => 'الخوادم',
			'admin.system_technical_status' => 'الحالة الفنية للنظام',
			'admin.tag1_tag2' => 'العلامة 1، العلامة 2',
			'admin.teaching_assistants' => 'مساعدو التدريس',
			'admin.total_students' => 'إجمالي الطلاب',
			'admin.unverified' => 'لم يتم التحقق منها',
			'admin.user_roles_ranks' => 'أدوار المستخدم ورتبه',
			'admin.verified' => 'تم التحقق منه',
			'admin.warning_level' => 'مستوى التحذير',
			'admin.verification' => 'تَحَقّق',
			'admin.you_can_manage_professors_and_' => 'يمكنك إدارة الأساتذة وأكثر هنا',
			'admin.total_staff' => 'مجموع الموظفين',
			'admin.college_management' => 'إدارة الكلية',
			'enrollment.registration_title' => 'تسجيل الدورة',
			'enrollment.invoices_title' => 'الفواتير المالية',
			'enrollment.payment_title' => 'دفع الرسوم الدراسية',
			'enrollment.advisor' => 'مستشار أكاديمي',
			'enrollment.advisor_approval' => 'موافقة المستشار',
			'enrollment.dean_assignment' => 'تعيين مستشار العميد',
			'enrollment.approve' => 'يعتمد',
			'enrollment.reject' => 'يرفض',
			'enrollment.approved' => 'موافقة',
			'enrollment.rejected' => 'مرفوض',
			'enrollment.student_name' => 'اسم الطالب',
			'enrollment.pending' => 'قيد الانتظار',
			'enrollment.college' => 'كلية',
			'enrollment.department' => 'قسم',
			'enrollment.student_id' => 'معرف الطالب',
			'enrollment.semester' => 'الفصل الدراسي',
			'enrollment.credits' => 'الاعتمادات',
			'enrollment.status' => 'حالة',
			'enrollment.section' => 'قسم',
			'enrollment.group' => 'مجموعة',
			'enrollment.registration_date' => 'تاريخ التسجيل',
			'enrollment.search_students' => 'بحث عن الطلاب...',
			'enrollment.filter_all' => 'الجميع',
			'enrollment.filter_pending' => 'قيد الانتظار',
			'enrollment.filter_rejected' => 'مرفوض',
			'enrollment.filter_approved' => 'موافقة',
			'enrollment.approve_all' => 'الموافقة على الكل',
			'enrollment.advisor_name' => 'اسم المستشار',
			'enrollment.view_details' => 'عرض التفاصيل',
			'enrollment.assign' => 'تعيين',
			'enrollment.unassign' => 'إلغاء التعيين',
			'enrollment.assigned' => 'مُكَلَّف',
			'enrollment.unassigned' => 'غير معين',
			'enrollment.success_reject' => 'تم رفض التسجيل',
			'enrollment.success_approve' => 'تمت الموافقة على التسجيل بنجاح',
			'enrollment.success_assign' => 'تم تعيين المستشار بنجاح',
			'enrollment.error_loading' => 'حدث خطأ أثناء تحميل البيانات',
			'enrollment.save' => 'يحفظ',
			'enrollment.cancel' => 'يلغي',
			'enrollment.invoice_date' => 'تاريخ',
			'enrollment.invoice_id' => 'معرف الفاتورة',
			'enrollment.invoice_amount' => 'كمية',
			'enrollment.invoice_paid' => 'مدفوع',
			'enrollment.invoice_status' => 'حالة',
			'enrollment.invoice_unpaid' => 'غير مدفوعة الأجر',
			'enrollment.pay_now' => 'ادفع الآن',
			'enrollment.invoice_overdue' => 'تأخرت',
			'enrollment.payment_method' => 'طريقة الدفع',
			'enrollment.credit_card' => 'بطاقة إئتمان',
			'enrollment.bank_transfer' => 'التحويل البنكي',
			'enrollment.fawry' => 'فوري',
			'enrollment.no_invoices' => 'لم يتم العثور على فواتير',
			'enrollment.payment_success' => 'تم الدفع بنجاح',
			'enrollment.outstanding_balance' => 'الرصيد المتميز',
			'enrollment.payment_error' => 'فشل الدفع',
			'enrollment.total_paid' => 'إجمالي المبلغ المدفوع',
			'enrollment.tuition_fee' => 'الرسوم الدراسية',
			'enrollment.late_fee' => 'الرسوم المتأخرة',
			'enrollment.registration_fee' => 'رسوم التسجيل',
			'enrollment.academic_year' => 'العام الدراسي',
			'enrollment.semester_label' => ({required Object semester}) => 'الفصل الدراسي${semester}',
			'enrollment.total' => 'المجموع',
			'enrollment.submit_request' => 'إرسال الطلب',
			'enrollment.all' => 'الجميع',
			'enrollment.request_submitted' => 'تم إرسال الطلب بنجاح',
			'enrollment.loading' => 'تحميل...',
			'enrollment.academic_advisor' => 'مستشار أكاديمي',
			'enrollment.retry' => 'أعد المحاولة',
			'enrollment.advisor_assignment' => 'تعيين مستشار',
			'enrollment.advisor_requestadvisorfullname' => 'المستشار: {الاسم}',
			'enrollment.approved_courses_registered' => 'تمت الموافقة عليه - الدورات المسجلة',
			'enrollment.approved_1' => 'موافقة',
			'enrollment.awaiting_advisor_review' => 'في انتظار مراجعة المستشار',
			'enrollment.advisor_updated_successfully' => 'تم تحديث المستشار بنجاح',
			'enrollment.choose_schedules' => 'اختر الجداول الزمنية',
			'enrollment.confirm_submit' => 'تأكيد وإرسال',
			'enrollment.cr' => 'سي آر',
			'enrollment.download' => 'تحميل',
			'enrollment.dormitory_fee' => 'رسوم السكن',
			'enrollment.due' => 'حق',
			'enrollment.error_loading_summary' => 'حدث خطأ أثناء تحميل الملخص',
			'enrollment.financial_portal' => 'البوابة المالية',
			'enrollment.exam_fee' => 'رسوم الامتحان',
			'enrollment.failed_to_load_invoices' => 'فشل في تحميل الفواتير',
			'enrollment.financial_summary' => 'الملخص المالي',
			'enrollment.history' => 'تاريخ',
			'enrollment.invoices' => 'الفواتير',
			'enrollment.help' => 'يساعد',
			'enrollment.manage_your_tuition_and_paymen' => 'إدارة الرسوم الدراسية والمدفوعات الخاصة بك',
			'enrollment.library_fee' => 'رسوم المكتبة',
			'enrollment.my_invoices' => 'فواتيري',
			'enrollment.next_pick_schedules' => 'التالي: اختيار الجداول الزمنية',
			'enrollment.no_advisor' => 'لا مستشار',
			'enrollment.no_invoices_found' => 'لم يتم العثور على فواتير',
			'enrollment.no_requests_found' => 'لم يتم العثور على أي طلبات',
			'enrollment.no_students_found' => 'لم يتم العثور على أي طلاب',
			'enrollment.notes_optional' => 'ملاحظات (اختياري)',
			'enrollment.other' => 'آخر',
			'enrollment.no_schedules_available_for_thi' => 'لا توجد جداول متاحة لهذه الدورة',
			'enrollment.overdue' => 'تأخرت',
			'enrollment.paid' => 'مدفوع',
			'enrollment.partial' => 'جزئي',
			'enrollment.pay' => 'يدفع',
			'enrollment.preparing_pdf_statement' => 'جارٍ تحضير بيان PDF...',
			'enrollment.pending_review' => 'في انتظار المراجعة',
			'enrollment.remaining' => 'متبقي',
			'enrollment.registration_requests' => 'طلبات التسجيل',
			'enrollment.request_rejected' => 'تم رفض الطلب',
			'enrollment.reregister' => 'إعادة التسجيل',
			'enrollment.review_final_timetable' => 'مراجعة الجدول الزمني النهائي',
			'enrollment.sec' => 'ثانية',
			'enrollment.review_registration' => 'مراجعة التسجيل',
			'enrollment.room' => 'غرفة',
			'enrollment.requested_courses' => 'الدورات المطلوبة',
			'enrollment.select_the_subjects_you_want_t' => 'اختر المواضيع التي تريد تسجيلها',
			'enrollment.selected_schedule_summary' => 'ملخص الجدول المحدد',
			'enrollment.select_your_courses' => 'حدد الدورات الخاصة بك',
			'enrollment.semester_requestsemester' => 'الفصل الدراسي: {فصل دراسي}',
			'enrollment.sub' => 'الفرعية',
			'enrollment.summaryoverduecount_overdue' => ({required Object count}) => '${count} متأخر',
			'enrollment.unassigned_only' => 'غير المعينة فقط',
			'enrollment.unpaid' => 'غير مدفوعة الأجر',
			'enrollment.withdrawn' => 'انسحبت',
			'enrollment.you_have_successfully_register' => 'لقد قمت بتسجيل دوراتك بنجاح!',
			'enrollment.total_invoices' => 'إجمالي الفواتير',
			'enrollment.your_account_is_clearnno_invoi' => 'حسابك واضح لم يتم العثور على فواتير.',
			'enrollment.no_requests' => 'لم يتم العثور على طلبات',
			'enrollment.mmm_dd_yyyy' => 'ط ط ط ي ي، س س س',
			'enrollment.no_schedules_available' => 'No schedules available',
			'enrollment.registration_success_message' => 'Registration successful!',
			'enrollment.advisor_name_label' => ({required Object name}) => 'Advisor: ${name}',
			'enrollment.semester_label_with_value' => ({required Object semester}) => 'Semester: ${semester}',
			'shared.no_notifications_yet' => 'لا توجد إخطارات حتى الآن',
			'shared.notifications' => 'إشعارات',
			'shared.notifications_empty' => 'لا توجد إشعارات جديدة',
			'shared.security_title' => 'إعدادات الأمان',
			'shared.biometrics_title' => 'القياسات الحيوية',
			'shared.fingerprint' => 'بصمة',
			'shared.face_id' => 'معرف الوجه',
			'shared.sessions_title' => 'الجلسات النشطة',
			'shared.current_session' => 'الجلسة الحالية',
			'shared.enable_biometrics' => 'تمكين القياسات الحيوية',
			'shared.end_session' => 'نهاية الجلسة',
			'shared.end_all_sessions' => 'إنهاء كافة الجلسات',
			'shared.device' => 'جهاز',
			'shared.location' => 'موقع',
			'shared.contact_us' => 'اتصل بنا',
			'shared.support_title' => 'الدعم والمساعدة',
			'shared.email_us' => 'راسلنا عبر البريد الإلكتروني',
			'shared.call_us' => 'اتصل بنا',
			'shared.whatsapp' => 'واتساب',
			'shared.report_issue' => 'الإبلاغ عن مشكلة',
			'shared.faq' => 'التعليمات',
			'shared.tutorials_title' => 'دروس وأدلة',
			'shared.last_active' => 'آخر نشاط',
			'shared.forums_title' => 'المنتديات',
			'shared.search_forums' => 'البحث في المنتديات...',
			'shared.no_posts' => 'لم يتم العثور على أي مشاركات',
			'shared.transition_title' => 'تحميل...',
			'shared.create_post' => 'إنشاء مشاركة',
			'shared.placeholder_title' => 'قريباً',
			'shared.coming_soon' => 'قريباً',
			'shared.placeholder_subtitle' => 'هذا القسم قيد التطوير',
			'shared.back' => 'خلف',
			'shared.under_development' => 'هذه الميزة قيد التطوير',
			'shared.loading' => 'تحميل...',
			'shared.retry' => 'أعد المحاولة',
			'shared.error' => 'خطأ',
			'shared.close' => 'يغلق',
			'shared.cancel' => 'يلغي',
			'shared.confirm' => 'يتأكد',
			'shared.save' => 'يحفظ',
			'shared.delete' => 'يمسح',
			'shared.active_sessions' => 'الجلسات النشطة',
			'shared.authentication' => 'المصادقة',
			'shared.call_hotline' => 'اتصل بالخط الساخن',
			'shared.edit' => 'يحرر',
			'shared.change_password' => 'تغيير كلمة المرور',
			'shared.biometric_login' => 'تسجيل الدخول البيومتري',
			'shared.device_management' => 'إدارة الجهاز',
			'shared.email_support' => 'دعم البريد الإلكتروني',
			'shared.financial_aid' => 'المساعدات المالية',
			'shared.forums' => 'المنتديات',
			'shared.it_support' => 'دعم تكنولوجيا المعلومات',
			'shared.library' => 'مكتبة',
			'shared.logout' => 'تسجيل الخروج',
			'shared.members' => 'أعضاء',
			'shared.protect_account_with_2fa' => 'حماية الحساب باستخدام 2FA',
			'shared.manage_logged_in_devices' => 'إدارة الأجهزة التي تم تسجيل الدخول إليها',
			'shared.please_wait' => 'انتظر من فضلك...',
			'shared.student_affairs' => 'شؤون الطلاب',
			'shared.security' => 'حماية',
			'shared.this_feature_is_under_developm' => 'هذه الميزة قيد التطوير',
			'shared.support' => 'يدعم',
			'shared.tutorials' => 'دروس',
			'shared.threads' => 'المواضيع',
			'shared.update_your_login_credentials' => 'قم بتحديث بيانات اعتماد تسجيل الدخول الخاصة بك',
			'shared.use_fingerprint_or_face_id' => 'استخدام بصمة الإصبع أو Face ID',
			'shared.view_active_sessions' => 'عرض الجلسات النشطة',
			'shared.biometrics' => 'القياسات الحيوية',
			'shared.twofactor_auth' => 'المصادقة الثنائية',
			'shared.sessions' => 'الجلسات',
			'shared.security_section' => 'حماية',
			'shared.support_section' => 'يدعم',
			'shared.contact_us_section' => 'اتصل بنا',
			'shared.tutorials_section' => 'دروس',
			'shared.forums_section' => 'المنتديات',
			'shared.no_new_notifications' => 'لا توجد إشعارات جديدة',
			'shared.security_access' => 'الوصول الأمني',
			'students.student_name' => 'اسم الطالب',
			'students.digital_id_title' => 'بطاقة الهوية الرقمية',
			'students.department' => 'قسم',
			'students.student_id' => 'معرف الطالب',
			'students.college' => 'كلية',
			'students.level' => 'مستوى',
			'students.gpa' => 'المعدل التراكمي',
			'students.university' => 'جامعة حورس',
			'students.credits' => 'الاعتمادات',
			'students.verified' => 'تم التحقق منه',
			'students.download_id' => 'تحميل معرف',
			'students.share_id' => 'معرف المشاركة',
			'students.qr_code' => 'رمز الاستجابة السريعة',
			'students.scan_to_verify' => 'مسح للتحقق',
			'students.id_theme' => 'موضوع الهوية',
			'students.gradient_theme' => 'التدرج',
			'students.classic_theme' => 'كلاسيكي',
			'students.holographic_theme' => 'التصوير المجسم',
			'students.dark_matter_theme' => 'المادة المظلمة',
			'students.neon_pulse_theme' => 'نبض النيون',
			'students.dashboard_title' => 'لوحة تحكم الطالب',
			'students.enrollment_section' => 'التسجيل',
			'students.utilities_section' => 'المرافق',
			'students.aurora_theme' => 'أورورا',
			'students.progress' => 'التقدم الأكاديمي',
			'students.academic_section' => 'أكاديمي',
			'students.action_plan' => 'خطة الدرجة',
			'students.grades' => 'الدرجات',
			'students.courses' => 'الدورات',
			'students.schedule' => 'جدول',
			'students.transcript' => 'نص',
			'students.exam_schedule' => 'جدول الامتحانات',
			'students.attendance' => 'حضور',
			'students.registration' => 'تسجيل',
			'students.subject_results' => 'نتائج الموضوع',
			'students.invoices' => 'الفواتير',
			'students.payment' => 'قسط',
			'students.tutorials' => 'دروس',
			'students.security' => 'حماية',
			'students.forums' => 'المنتديات',
			'students.support' => 'يدعم',
			'students.digital_id' => 'الهوية الرقمية',
			'students.view_full_schedule' => 'عرض الجدول الزمني الكامل',
			'students.notifications' => 'إشعارات',
			'students.no_lectures_today' => 'لا يوجد محاضرات اليوم',
			'students.gpa_label' => 'المعدل التراكمي',
			'students.credits_label' => 'الاعتمادات',
			'students.quick_stats' => 'إحصائيات سريعة',
			'students.level_label' => 'مستوى',
			'students.upcoming_exams' => 'الامتحانات القادمة',
			'students.recent_grades' => 'الدرجات الأخيرة',
			'students.all' => 'الجميع',
			'students.loading' => 'تحميل...',
			'students.error' => 'خطأ',
			'students.retry' => 'أعد المحاولة',
			'students.back' => 'خلف',
			'students.academic' => 'أكاديمي',
			'students.access_logs' => 'سجلات الوصول',
			'students.active' => 'نشيط',
			'students.artificial_intelligence' => 'الذكاء الاصطناعي',
			'students.copy' => 'ينسخ',
			'students.daily_schedule' => 'الجدول اليومي',
			'students.download' => 'تحميل',
			'students.horus_university' => 'جامعة حورس',
			'students.horus_university_1' => 'جامعة حورس',
			'students.id_no' => 'رقم الهوية',
			'students.nfc_pass' => 'ممر NFC',
			'students.enrollment_finance' => 'التسجيل والتمويل',
			'students.offline_copy' => 'نسخة دون اتصال',
			'students.scan_for_secure_access' => 'المسح للوصول الآمن',
			'students.identity_active_secure' => 'الهوية نشطة وآمنة',
			'students.send' => 'يرسل',
			'students.settings' => 'إعدادات',
			'students.share_identity' => 'مشاركة الهوية',
			'students.student' => 'طالب',
			'students.status' => 'حالة',
			'students.smart_digital_id' => 'الهوية الرقمية الذكية',
			'students.utilities' => 'المرافق',
			_ => null,
		};
	}
}

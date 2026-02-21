// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

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
class TranslationsAr extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.ar,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <ar>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

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
}

// Path: common
class _TranslationsCommonAr extends TranslationsCommonEn {
	_TranslationsCommonAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get close => 'إغلاق';
	@override String get cancel => 'إلغاء';
	@override String get confirm => 'تأكيد';
	@override String get save => 'حفظ';
	@override String get back => 'رجوع';
}

// Path: welcome
class _TranslationsWelcomeAr extends TranslationsWelcomeEn {
	_TranslationsWelcomeAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مرحبا بك في Hue';
	@override String get subtitle => 'أنر عالمك باتصالات ذات مغزى.';
	@override String get get_started => 'ابدأ الآن';
	@override String get have_account => 'لدي حساب بالفعل';
}

// Path: onboarding
class _TranslationsOnboardingAr extends TranslationsOnboardingEn {
	_TranslationsOnboardingAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsOnboardingLanguageAr language = _TranslationsOnboardingLanguageAr._(_root);
	@override late final _TranslationsOnboardingFacultiesDirectoryAr faculties_directory = _TranslationsOnboardingFacultiesDirectoryAr._(_root);
	@override late final _TranslationsOnboardingStyleAr style = _TranslationsOnboardingStyleAr._(_root);
	@override late final _TranslationsOnboardingThemeAr theme = _TranslationsOnboardingThemeAr._(_root);
}

// Path: auth
class _TranslationsAuthAr extends TranslationsAuthEn {
	_TranslationsAuthAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthLoginAr login = _TranslationsAuthLoginAr._(_root);
	@override late final _TranslationsAuthForgotPasswordAr forgot_password = _TranslationsAuthForgotPasswordAr._(_root);
}

// Path: home
class _TranslationsHomeAr extends TranslationsHomeEn {
	_TranslationsHomeAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeTabsAr tabs = _TranslationsHomeTabsAr._(_root);
}

// Path: feed
class _TranslationsFeedAr extends TranslationsFeedEn {
	_TranslationsFeedAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get likes => 'إعجابات';
	@override String get caption_sample => 'هذا مثال لشرح المنشور';
	@override String get hours_ago => 'منذ ساعتين';
}

// Path: dashboard
class _TranslationsDashboardAr extends TranslationsDashboardEn {
	_TranslationsDashboardAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDashboardIdCardAr id_card = _TranslationsDashboardIdCardAr._(_root);
	@override late final _TranslationsDashboardSectionsAr sections = _TranslationsDashboardSectionsAr._(_root);
	@override late final _TranslationsDashboardItemsAr items = _TranslationsDashboardItemsAr._(_root);
	@override late final _TranslationsDashboardLabelsAr labels = _TranslationsDashboardLabelsAr._(_root);
}

// Path: settings
class _TranslationsSettingsAr extends TranslationsSettingsEn {
	_TranslationsSettingsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإعدادات';
	@override late final _TranslationsSettingsSectionsAr sections = _TranslationsSettingsSectionsAr._(_root);
	@override late final _TranslationsSettingsTilesAr tiles = _TranslationsSettingsTilesAr._(_root);
	@override late final _TranslationsSettingsMessagesAr messages = _TranslationsSettingsMessagesAr._(_root);
}

// Path: colleges
class _TranslationsCollegesAr extends TranslationsCollegesEn {
	_TranslationsCollegesAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
class _TranslationsTranscriptAr extends TranslationsTranscriptEn {
	_TranslationsTranscriptAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'السجل الأكاديمي';
	@override late final _TranslationsTranscriptOverviewAr overview = _TranslationsTranscriptOverviewAr._(_root);
	@override late final _TranslationsTranscriptSemesterAr semester = _TranslationsTranscriptSemesterAr._(_root);
	@override late final _TranslationsTranscriptCourseAr course = _TranslationsTranscriptCourseAr._(_root);
}

// Path: academic_progress
class _TranslationsAcademicProgressAr extends TranslationsAcademicProgressEn {
	_TranslationsAcademicProgressAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التقدم الدراسي';
	@override String get completion => 'نسبة إنجاز الدرجة العلمية';
	@override String get total_credits => 'إجمالي الساعات';
	@override late final _TranslationsAcademicProgressCategoriesAr categories = _TranslationsAcademicProgressCategoriesAr._(_root);
	@override late final _TranslationsAcademicProgressStatusAr status = _TranslationsAcademicProgressStatusAr._(_root);
}

// Path: grades
class _TranslationsGradesAr extends TranslationsGradesEn {
	_TranslationsGradesAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'درجات الفصل الدراسي';
	@override String get grade_point => 'نقاط المادة';
	@override String get letter_grade => 'التقدير';
	@override String get gpa => 'المعدل الفصلي';
}

// Path: subject_results
class _TranslationsSubjectResultsAr extends TranslationsSubjectResultsEn {
	_TranslationsSubjectResultsAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
class _TranslationsActionPlanAr extends TranslationsActionPlanEn {
	_TranslationsActionPlanAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
class _TranslationsCoursesAr extends TranslationsCoursesEn {
	_TranslationsCoursesAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'مقرراتي';
	@override String get enrolled => 'المسجلة';
	@override String get available => 'المتاحة';
	@override String get instructor => 'المحاضر';
	@override String get schedule => 'الموعد';
}

// Path: schedule
class _TranslationsScheduleAr extends TranslationsScheduleEn {
	_TranslationsScheduleAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'جدول المحاضرات';
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
	@override String get no_lectures => 'لا توجد محاضرات';
}

// Path: exam_schedule
class _TranslationsExamScheduleAr extends TranslationsExamScheduleEn {
	_TranslationsExamScheduleAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'جدول الامتحانات';
	@override String get date => 'التاريخ';
	@override String get duration => 'المدة';
	@override String get seat => 'رقم الجلوس';
}

// Path: attendance
class _TranslationsAttendanceAr extends TranslationsAttendanceEn {
	_TranslationsAttendanceAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'إحصائيات الحضور';
	@override String get present => 'حاضر';
	@override String get absent => 'غائب';
	@override String get late => 'متأخر';
	@override String get ratio => 'نسبة الحضور';
}

// Path: registration
class _TranslationsRegistrationAr extends TranslationsRegistrationEn {
	_TranslationsRegistrationAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التسجيل الأكاديمي';
	@override String get submit => 'إرسال طلب التسجيل';
	@override String get enrolled_credits => 'الساعات المسجلة';
}

// Path: payment
class _TranslationsPaymentAr extends TranslationsPaymentEn {
	_TranslationsPaymentAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الدفع الإلكتروني';
	@override String get outstanding => 'المبلغ المستحق';
	@override String get pay_now => 'دفع الآن';
	@override String get methods => 'طرق الدفع';
}

// Path: invoices
class _TranslationsInvoicesAr extends TranslationsInvoicesEn {
	_TranslationsInvoicesAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الفواتير';
	@override String get history => 'سجل الدفع';
	@override String get unpaid => 'غير مدفوع';
	@override String get paid => 'تم الدفع';
}

// Path: notifications
class _TranslationsNotificationsAr extends TranslationsNotificationsEn {
	_TranslationsNotificationsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الإشعارات';
	@override String get empty => 'لا توجد إشعارات جديدة';
}

// Path: support
class _TranslationsSupportAr extends TranslationsSupportEn {
	_TranslationsSupportAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الدعم والمساعدة';
	@override String get contact_us => 'اتصل بنا';
}

// Path: security
class _TranslationsSecurityAr extends TranslationsSecurityEn {
	_TranslationsSecurityAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'الأمان';
	@override String get biometrics => 'البصمة';
	@override String get sessions => 'الجلسات النشطة';
}

// Path: tutorials
class _TranslationsTutorialsAr extends TranslationsTutorialsEn {
	_TranslationsTutorialsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'التعليمات والدروس';
}

// Path: forums
class _TranslationsForumsAr extends TranslationsForumsEn {
	_TranslationsForumsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'المنتديات';
}

// Path: administration
class _TranslationsAdministrationAr extends TranslationsAdministrationEn {
	_TranslationsAdministrationAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'إدارة الطلاب';
	@override String get stats => 'إحصائيات النظام';
	@override String get users => 'المستخدمين';
	@override String get reports => 'التقارير';
}

// Path: professor
class _TranslationsProfessorAr extends TranslationsProfessorEn {
	_TranslationsProfessorAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get dashboard => 'لوحة تحكم الدكتور';
	@override String get welcome_back => 'مرحباً بعودتك';
	@override late final _TranslationsProfessorStatsAr stats = _TranslationsProfessorStatsAr._(_root);
	@override late final _TranslationsProfessorQuickActionsAr quick_actions = _TranslationsProfessorQuickActionsAr._(_root);
	@override late final _TranslationsProfessorManageAr manage = _TranslationsProfessorManageAr._(_root);
	@override late final _TranslationsProfessorProfileAr profile = _TranslationsProfessorProfileAr._(_root);
}

// Path: onboarding.language
class _TranslationsOnboardingLanguageAr extends TranslationsOnboardingLanguageEn {
	_TranslationsOnboardingLanguageAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
class _TranslationsOnboardingFacultiesDirectoryAr extends TranslationsOnboardingFacultiesDirectoryEn {
	_TranslationsOnboardingFacultiesDirectoryAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'كلياتنا';
	@override String get subtitle => 'استكشف بوابة جامعة حورس الأكاديمية المتنوعة';
}

// Path: onboarding.style
class _TranslationsOnboardingStyleAr extends TranslationsOnboardingStyleEn {
	_TranslationsOnboardingStyleAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر النمط';
	@override String get subtitle => 'اختر تصميم الواجهة الذي تفضله';
	@override late final _TranslationsOnboardingStyleClassicAr classic = _TranslationsOnboardingStyleClassicAr._(_root);
	@override late final _TranslationsOnboardingStyleGlassAr glass = _TranslationsOnboardingStyleGlassAr._(_root);
}

// Path: onboarding.theme
class _TranslationsOnboardingThemeAr extends TranslationsOnboardingThemeEn {
	_TranslationsOnboardingThemeAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'اختر السمة';
	@override String get subtitle => 'فاتح أو داكن، الخيار لك';
	@override String get light => 'فاتح';
	@override String get dark => 'داكن';
}

// Path: auth.login
class _TranslationsAuthLoginAr extends TranslationsAuthLoginEn {
	_TranslationsAuthLoginAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
class _TranslationsAuthForgotPasswordAr extends TranslationsAuthForgotPasswordEn {
	_TranslationsAuthForgotPasswordAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
}

// Path: home.tabs
class _TranslationsHomeTabsAr extends TranslationsHomeTabsEn {
	_TranslationsHomeTabsAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
class _TranslationsDashboardIdCardAr extends TranslationsDashboardIdCardEn {
	_TranslationsDashboardIdCardAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
class _TranslationsDashboardSectionsAr extends TranslationsDashboardSectionsEn {
	_TranslationsDashboardSectionsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get academic => 'الأكاديمي';
	@override String get enrollment => 'التسجيل والمالية';
	@override String get utilities => 'أدوات أخرى';
}

// Path: dashboard.items
class _TranslationsDashboardItemsAr extends TranslationsDashboardItemsEn {
	_TranslationsDashboardItemsAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
class _TranslationsDashboardLabelsAr extends TranslationsDashboardLabelsEn {
	_TranslationsDashboardLabelsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get university_name => 'جامعة حورس';
	@override String get id_short => 'كود';
	@override String get gpa_short => 'معدل';
	@override String get level_short => 'مستوى';
}

// Path: settings.sections
class _TranslationsSettingsSectionsAr extends TranslationsSettingsSectionsEn {
	_TranslationsSettingsSectionsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get account => 'الحساب';
	@override String get display => 'العرض';
	@override String get notifications => 'التنبيهات';
	@override String get about => 'حول';
}

// Path: settings.tiles
class _TranslationsSettingsTilesAr extends TranslationsSettingsTilesEn {
	_TranslationsSettingsTilesAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get edit_profile => 'تعديل الملف الشخصي';
	@override String get change_password => 'تغيير كلمة المرور';
	@override String get dark_mode => 'الوضع الليلي';
	@override String get language => 'اللغة';
	@override String get ui_style => 'نمط الواجهة';
	@override String get app_notifications => 'تنبيهات التطبيق';
	@override String get about_app => 'عن التطبيق';
	@override String get privacy_policy => 'سياسة الخصوصية';
	@override String get logout => 'تسجيل الخروج';
}

// Path: settings.messages
class _TranslationsSettingsMessagesAr extends TranslationsSettingsMessagesEn {
	_TranslationsSettingsMessagesAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get switching_theme => 'جاري تغيير المظهر...';
	@override String get changing_language => 'جاري تغيير اللغة...';
	@override String get rebuilding_design => 'جاري إعادة بناء التصميم...';
}

// Path: colleges.details
class _TranslationsCollegesDetailsAr extends TranslationsCollegesDetailsEn {
	_TranslationsCollegesDetailsAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
class _TranslationsCollegesDepartmentsAr extends TranslationsCollegesDepartmentsEn {
	_TranslationsCollegesDepartmentsAr._(TranslationsAr root) : this._root = root, super.internal(root);

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
class _TranslationsTranscriptOverviewAr extends TranslationsTranscriptOverviewEn {
	_TranslationsTranscriptOverviewAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get gpa => 'المعدل التراكمي';
	@override String get credits => 'الساعات المكتسبة';
	@override String get standing => 'الحالة الأكاديمية';
	@override String get active => 'وضع جيد';
}

// Path: transcript.semester
class _TranslationsTranscriptSemesterAr extends TranslationsTranscriptSemesterEn {
	_TranslationsTranscriptSemesterAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get fall => 'الفصل الدراسي الأول';
	@override String get spring => 'الفصل الدراسي الثاني';
	@override String get summer => 'فصل دراسي صيفي';
}

// Path: transcript.course
class _TranslationsTranscriptCourseAr extends TranslationsTranscriptCourseEn {
	_TranslationsTranscriptCourseAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get grade => 'الدرجة';
	@override String get credits => 'ساعة';
	@override late final _TranslationsTranscriptCourseStatusAr status = _TranslationsTranscriptCourseStatusAr._(_root);
}

// Path: academic_progress.categories
class _TranslationsAcademicProgressCategoriesAr extends TranslationsAcademicProgressCategoriesEn {
	_TranslationsAcademicProgressCategoriesAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get university => 'متطلبات جامعة حورس';
	@override String get faculty => 'متطلبات الكلية';
	@override String get major => 'متطلبات التخصص';
	@override String get electives => 'المواد الاختيارية';
}

// Path: academic_progress.status
class _TranslationsAcademicProgressStatusAr extends TranslationsAcademicProgressStatusEn {
	_TranslationsAcademicProgressStatusAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get completed => 'مكتمل';
	@override String get in_progress => 'قيد الدراسة';
	@override String get remaining => 'متبقي';
	@override String get requirement_met => 'تم استيفاء المتطلب';
}

// Path: professor.stats
class _TranslationsProfessorStatsAr extends TranslationsProfessorStatsEn {
	_TranslationsProfessorStatsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get groups => 'المجموعات';
	@override String get students => 'إجمالي الطلاب';
	@override String get rating => 'التقييم';
}

// Path: professor.quick_actions
class _TranslationsProfessorQuickActionsAr extends TranslationsProfessorQuickActionsEn {
	_TranslationsProfessorQuickActionsAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get urgent => 'عاجل';
	@override String get upload => 'رفع';
	@override String get message => 'مراسلة';
	@override String get action_clicked => 'تم النقر';
}

// Path: professor.manage
class _TranslationsProfessorManageAr extends TranslationsProfessorManageEn {
	_TranslationsProfessorManageAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get manage_tas => 'إدارة المعيدين';
	@override String get active_tas => 'المعيدين الحاليين';
	@override String get student_groups => 'المجموعات الطلابية';
	@override String get total_students => 'إجمالي الطلاب';
	@override String get shared_files => 'الملفات المشتركة';
	@override String get uploaded_files => 'ملفات مرفوعة';
	@override String get office_hours => 'الساعات المكتبية';
	@override String get weekly_slots => 'مواعيد أسبوعية';
}

// Path: professor.profile
class _TranslationsProfessorProfileAr extends TranslationsProfessorProfileEn {
	_TranslationsProfessorProfileAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get office_hour => 'موعد مكتبي';
	@override String get urgent_announcements => 'إعلانات عاجلة';
	@override String get teaching_assistants => 'الهيئة المعاونة';
	@override String get student_groups => 'المجموعات الطلابية';
	@override String get students => 'طلاب';
	@override String get join => 'انضمام';
	@override String get joined => 'تم الانضمام';
	@override String get shared_resources => 'المصادر المشتركة';
	@override String get office_hours => 'الساعات المكتبية';
	@override String get walk_in => 'بدون موعد';
}

// Path: onboarding.style.classic
class _TranslationsOnboardingStyleClassicAr extends TranslationsOnboardingStyleClassicEn {
	_TranslationsOnboardingStyleClassicAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'كلاسيكي';
	@override String get desc => 'تصميم نظيف، بسيط، ومألوف';
}

// Path: onboarding.style.glass
class _TranslationsOnboardingStyleGlassAr extends TranslationsOnboardingStyleGlassEn {
	_TranslationsOnboardingStyleGlassAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get title => 'زجاجي';
	@override String get desc => 'جماليات حديثة، شفافة، وحيوية';
}

// Path: transcript.course.status
class _TranslationsTranscriptCourseStatusAr extends TranslationsTranscriptCourseStatusEn {
	_TranslationsTranscriptCourseStatusAr._(TranslationsAr root) : this._root = root, super.internal(root);

	final TranslationsAr _root; // ignore: unused_field

	// Translations
	@override String get completed => 'مكتمل';
	@override String get transferred => 'معادلة';
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
			'home.tabs.home' => 'الرئيسية',
			'home.tabs.colleges' => 'الكليات',
			'home.tabs.student' => 'الطالب',
			'home.tabs.admin' => 'الإدارة',
			'home.tabs.search' => 'بحث',
			'home.tabs.notifications' => 'الإشعارات',
			'home.tabs.profile' => 'الملف الشخصي',
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
			'settings.tiles.about_app' => 'عن التطبيق',
			'settings.tiles.privacy_policy' => 'سياسة الخصوصية',
			'settings.tiles.logout' => 'تسجيل الخروج',
			'settings.messages.switching_theme' => 'جاري تغيير المظهر...',
			'settings.messages.changing_language' => 'جاري تغيير اللغة...',
			'settings.messages.rebuilding_design' => 'جاري إعادة بناء التصميم...',
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
			'academic_progress.status.completed' => 'مكتمل',
			'academic_progress.status.in_progress' => 'قيد الدراسة',
			'academic_progress.status.remaining' => 'متبقي',
			'academic_progress.status.requirement_met' => 'تم استيفاء المتطلب',
			'grades.title' => 'درجات الفصل الدراسي',
			'grades.grade_point' => 'نقاط المادة',
			'grades.letter_grade' => 'التقدير',
			'grades.gpa' => 'المعدل الفصلي',
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
			'schedule.no_lectures' => 'لا توجد محاضرات',
			'exam_schedule.title' => 'جدول الامتحانات',
			'exam_schedule.date' => 'التاريخ',
			'exam_schedule.duration' => 'المدة',
			'exam_schedule.seat' => 'رقم الجلوس',
			'attendance.title' => 'إحصائيات الحضور',
			'attendance.present' => 'حاضر',
			'attendance.absent' => 'غائب',
			'attendance.late' => 'متأخر',
			'attendance.ratio' => 'نسبة الحضور',
			'registration.title' => 'التسجيل الأكاديمي',
			'registration.submit' => 'إرسال طلب التسجيل',
			'registration.enrolled_credits' => 'الساعات المسجلة',
			'payment.title' => 'الدفع الإلكتروني',
			'payment.outstanding' => 'المبلغ المستحق',
			'payment.pay_now' => 'دفع الآن',
			'payment.methods' => 'طرق الدفع',
			'invoices.title' => 'الفواتير',
			'invoices.history' => 'سجل الدفع',
			'invoices.unpaid' => 'غير مدفوع',
			'invoices.paid' => 'تم الدفع',
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
			'professor.dashboard' => 'لوحة تحكم الدكتور',
			'professor.welcome_back' => 'مرحباً بعودتك',
			'professor.stats.groups' => 'المجموعات',
			'professor.stats.students' => 'إجمالي الطلاب',
			'professor.stats.rating' => 'التقييم',
			'professor.quick_actions.urgent' => 'عاجل',
			'professor.quick_actions.upload' => 'رفع',
			'professor.quick_actions.message' => 'مراسلة',
			'professor.quick_actions.action_clicked' => 'تم النقر',
			'professor.manage.manage_tas' => 'إدارة المعيدين',
			'professor.manage.active_tas' => 'المعيدين الحاليين',
			'professor.manage.student_groups' => 'المجموعات الطلابية',
			'professor.manage.total_students' => 'إجمالي الطلاب',
			'professor.manage.shared_files' => 'الملفات المشتركة',
			'professor.manage.uploaded_files' => 'ملفات مرفوعة',
			'professor.manage.office_hours' => 'الساعات المكتبية',
			'professor.manage.weekly_slots' => 'مواعيد أسبوعية',
			'professor.profile.office_hour' => 'موعد مكتبي',
			'professor.profile.urgent_announcements' => 'إعلانات عاجلة',
			'professor.profile.teaching_assistants' => 'الهيئة المعاونة',
			'professor.profile.student_groups' => 'المجموعات الطلابية',
			'professor.profile.students' => 'طلاب',
			'professor.profile.join' => 'انضمام',
			'professor.profile.joined' => 'تم الانضمام',
			'professor.profile.shared_resources' => 'المصادر المشتركة',
			'professor.profile.office_hours' => 'الساعات المكتبية',
			'professor.profile.walk_in' => 'بدون موعد',
			_ => null,
		};
	}
}

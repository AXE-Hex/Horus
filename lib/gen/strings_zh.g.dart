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
class TranslationsZh with BaseTranslations<AppLocale, Translations> implements Translations {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsZh({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.zh,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ) {
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <zh>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key);

	late final TranslationsZh _root = this; // ignore: unused_field

	@override 
	TranslationsZh $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsZh(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonZh common = _TranslationsCommonZh._(_root);
	@override late final _TranslationsWelcomeZh welcome = _TranslationsWelcomeZh._(_root);
	@override late final _TranslationsOnboardingZh onboarding = _TranslationsOnboardingZh._(_root);
	@override late final _TranslationsAuthZh auth = _TranslationsAuthZh._(_root);
	@override late final _TranslationsHomeZh home = _TranslationsHomeZh._(_root);
	@override late final _TranslationsDashboardZh dashboard = _TranslationsDashboardZh._(_root);
	@override late final _TranslationsSettingsZh settings = _TranslationsSettingsZh._(_root);
	@override late final _TranslationsCollegesZh colleges = _TranslationsCollegesZh._(_root);
	@override late final _TranslationsTranscriptZh transcript = _TranslationsTranscriptZh._(_root);
	@override late final _TranslationsAcademicProgressZh academic_progress = _TranslationsAcademicProgressZh._(_root);
	@override late final _TranslationsGradesZh grades = _TranslationsGradesZh._(_root);
	@override late final _TranslationsSubjectResultsZh subject_results = _TranslationsSubjectResultsZh._(_root);
	@override late final _TranslationsActionPlanZh action_plan = _TranslationsActionPlanZh._(_root);
	@override late final _TranslationsCoursesZh courses = _TranslationsCoursesZh._(_root);
	@override late final _TranslationsScheduleZh schedule = _TranslationsScheduleZh._(_root);
	@override late final _TranslationsExamScheduleZh exam_schedule = _TranslationsExamScheduleZh._(_root);
	@override late final _TranslationsAttendanceZh attendance = _TranslationsAttendanceZh._(_root);
	@override late final _TranslationsRegistrationZh registration = _TranslationsRegistrationZh._(_root);
	@override late final _TranslationsPaymentZh payment = _TranslationsPaymentZh._(_root);
	@override late final _TranslationsInvoicesZh invoices = _TranslationsInvoicesZh._(_root);
	@override late final _TranslationsNotificationsZh notifications = _TranslationsNotificationsZh._(_root);
	@override late final _TranslationsSupportZh support = _TranslationsSupportZh._(_root);
	@override late final _TranslationsSecurityZh security = _TranslationsSecurityZh._(_root);
	@override late final _TranslationsTutorialsZh tutorials = _TranslationsTutorialsZh._(_root);
	@override late final _TranslationsForumsZh forums = _TranslationsForumsZh._(_root);
	@override late final _TranslationsAdministrationZh administration = _TranslationsAdministrationZh._(_root);
}

// Path: common
class _TranslationsCommonZh implements TranslationsCommonEn {
	_TranslationsCommonZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get close => '关闭';
	@override String get cancel => '取消';
	@override String get confirm => '确认';
	@override String get save => '保存';
	@override String get back => '返回';
}

// Path: welcome
class _TranslationsWelcomeZh implements TranslationsWelcomeEn {
	_TranslationsWelcomeZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '欢迎来到 Hue';
	@override String get subtitle => '用有意义的联系点亮你的世界。';
	@override String get get_started => '开始使用';
	@override String get have_account => '我已经有账号了';
}

// Path: onboarding
class _TranslationsOnboardingZh implements TranslationsOnboardingEn {
	_TranslationsOnboardingZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsOnboardingLanguageZh language = _TranslationsOnboardingLanguageZh._(_root);
	@override late final _TranslationsOnboardingFacultiesDirectoryZh faculties_directory = _TranslationsOnboardingFacultiesDirectoryZh._(_root);
	@override late final _TranslationsOnboardingStyleZh style = _TranslationsOnboardingStyleZh._(_root);
	@override late final _TranslationsOnboardingThemeZh theme = _TranslationsOnboardingThemeZh._(_root);
}

// Path: auth
class _TranslationsAuthZh implements TranslationsAuthEn {
	_TranslationsAuthZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthLoginZh login = _TranslationsAuthLoginZh._(_root);
	@override late final _TranslationsAuthForgotPasswordZh forgot_password = _TranslationsAuthForgotPasswordZh._(_root);
}

// Path: home
class _TranslationsHomeZh implements TranslationsHomeEn {
	_TranslationsHomeZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeTabsZh tabs = _TranslationsHomeTabsZh._(_root);
}

// Path: dashboard
class _TranslationsDashboardZh implements TranslationsDashboardEn {
	_TranslationsDashboardZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDashboardIdCardZh id_card = _TranslationsDashboardIdCardZh._(_root);
	@override late final _TranslationsDashboardSectionsZh sections = _TranslationsDashboardSectionsZh._(_root);
	@override late final _TranslationsDashboardItemsZh items = _TranslationsDashboardItemsZh._(_root);
	@override late final _TranslationsDashboardLabelsZh labels = _TranslationsDashboardLabelsZh._(_root);
}

// Path: settings
class _TranslationsSettingsZh implements TranslationsSettingsEn {
	_TranslationsSettingsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '设置';
	@override late final _TranslationsSettingsSectionsZh sections = _TranslationsSettingsSectionsZh._(_root);
	@override late final _TranslationsSettingsTilesZh tiles = _TranslationsSettingsTilesZh._(_root);
	@override late final _TranslationsSettingsMessagesZh messages = _TranslationsSettingsMessagesZh._(_root);
}

// Path: colleges
class _TranslationsCollegesZh implements TranslationsCollegesEn {
	_TranslationsCollegesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsCollegesDetailsZh details = _TranslationsCollegesDetailsZh._(_root);
	@override String get applied_health_sciences => '应用健康科学学院';
	@override String get business_administration => '工商管理学院';
	@override String get dentistry => '口腔医学院';
	@override String get engineering => '工程学院';
	@override String get fine_arts => '美术学院';
	@override String get human_medicine => '医学院';
	@override String get linguistics => '语言与翻译学院';
	@override String get pharmacy => '药学院';
	@override String get physical_therapy => '物理治疗学院';
	@override String get ai => '人工智能学院';
	@override late final _TranslationsCollegesDepartmentsZh departments = _TranslationsCollegesDepartmentsZh._(_root);
}

// Path: transcript
class _TranslationsTranscriptZh implements TranslationsTranscriptEn {
	_TranslationsTranscriptZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '学术成绩单';
	@override late final _TranslationsTranscriptOverviewZh overview = _TranslationsTranscriptOverviewZh._(_root);
	@override late final _TranslationsTranscriptSemesterZh semester = _TranslationsTranscriptSemesterZh._(_root);
	@override late final _TranslationsTranscriptCourseZh course = _TranslationsTranscriptCourseZh._(_root);
}

// Path: academic_progress
class _TranslationsAcademicProgressZh implements TranslationsAcademicProgressEn {
	_TranslationsAcademicProgressZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '学习进度';
	@override String get completion => '学位完成度';
	@override String get total_credits => '总学分';
	@override late final _TranslationsAcademicProgressCategoriesZh categories = _TranslationsAcademicProgressCategoriesZh._(_root);
	@override late final _TranslationsAcademicProgressStatusZh status = _TranslationsAcademicProgressStatusZh._(_root);
}

// Path: grades
class _TranslationsGradesZh implements TranslationsGradesEn {
	_TranslationsGradesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '学期成绩';
	@override String get grade_point => '绩点';
	@override String get letter_grade => '等第';
	@override String get gpa => '学期 GPA';
}

// Path: subject_results
class _TranslationsSubjectResultsZh implements TranslationsSubjectResultsEn {
	_TranslationsSubjectResultsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '科目结果';
	@override String get midterm => '期中';
	@override String get kFinal => '期末';
	@override String get practical => '实践';
	@override String get activities => '平时活动';
	@override String get total => '总分';
}

// Path: action_plan
class _TranslationsActionPlanZh implements TranslationsActionPlanEn {
	_TranslationsActionPlanZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '学位行动计划';
	@override String get roadmap => '课程路线图';
	@override String get year_1 => '大一';
	@override String get year_2 => '大二';
	@override String get year_3 => '大三';
	@override String get year_4 => '大四';
}

// Path: courses
class _TranslationsCoursesZh implements TranslationsCoursesEn {
	_TranslationsCoursesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我的课程';
	@override String get enrolled => '已修';
	@override String get available => '可选';
	@override String get instructor => '讲师';
	@override String get schedule => '安排';
}

// Path: schedule
class _TranslationsScheduleZh implements TranslationsScheduleEn {
	_TranslationsScheduleZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '课程表';
	@override String get time => '时间';
	@override String get room => '教室';
	@override String get monday => '星期一';
	@override String get tuesday => '星期二';
	@override String get wednesday => '星期三';
	@override String get thursday => '星期四';
	@override String get friday => '星期五';
	@override String get saturday => '星期六';
	@override String get sunday => '星期日';
	@override String get instructor => '讲师';
	@override String get doctor => '博士';
	@override String get type_lecture => '讲座';
	@override String get type_section => '小班课';
	@override String get status_active => '待开始';
	@override String get status_started => '正在进行';
	@override String get status_cancelled => '已取消';
	@override String get status_online => '在线';
	@override String get status_substitute => '代课';
	@override String get morning => '上午';
	@override String get afternoon => '下午';
	@override String get evening => '晚上';
	@override String get all_periods => '全部时段';
	@override String get floor => '楼层';
	@override String get direction => '方位';
	@override String get east => '东方';
	@override String get west => '西方';
	@override String get south => '南方';
	@override String get north => '北方';
	@override String get no_lectures => '未找到课程';
}

// Path: exam_schedule
class _TranslationsExamScheduleZh implements TranslationsExamScheduleEn {
	_TranslationsExamScheduleZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '考试安排';
	@override String get date => '日期';
	@override String get duration => '时长';
	@override String get seat => '座位号';
}

// Path: attendance
class _TranslationsAttendanceZh implements TranslationsAttendanceEn {
	_TranslationsAttendanceZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '出勤统计';
	@override String get present => '出勤';
	@override String get absent => '缺勤';
	@override String get late => '迟到';
	@override String get ratio => '出勤率';
}

// Path: registration
class _TranslationsRegistrationZh implements TranslationsRegistrationEn {
	_TranslationsRegistrationZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '选课注册';
	@override String get submit => '提交注册';
	@override String get enrolled_credits => '已修学分';
}

// Path: payment
class _TranslationsPaymentZh implements TranslationsPaymentEn {
	_TranslationsPaymentZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '学费缴纳';
	@override String get outstanding => '待缴余额';
	@override String get pay_now => '立即支付';
	@override String get methods => '支付方式';
}

// Path: invoices
class _TranslationsInvoicesZh implements TranslationsInvoicesEn {
	_TranslationsInvoicesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '账单';
	@override String get history => '支付历史';
	@override String get unpaid => '未付';
	@override String get paid => '已付';
}

// Path: notifications
class _TranslationsNotificationsZh implements TranslationsNotificationsEn {
	_TranslationsNotificationsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '通知';
	@override String get empty => '无新通知';
}

// Path: support
class _TranslationsSupportZh implements TranslationsSupportEn {
	_TranslationsSupportZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '支持与帮助';
	@override String get contact_us => '联系我们';
}

// Path: security
class _TranslationsSecurityZh implements TranslationsSecurityEn {
	_TranslationsSecurityZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '安全';
	@override String get biometrics => '生物识别';
	@override String get sessions => '活动会话';
}

// Path: tutorials
class _TranslationsTutorialsZh implements TranslationsTutorialsEn {
	_TranslationsTutorialsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '教程与指南';
}

// Path: forums
class _TranslationsForumsZh implements TranslationsForumsEn {
	_TranslationsForumsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '论坛';
}

// Path: administration
class _TranslationsAdministrationZh implements TranslationsAdministrationEn {
	_TranslationsAdministrationZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '学生管理';
	@override String get stats => '系统统计';
	@override String get users => '用户';
	@override String get reports => '报告';
}

// Path: onboarding.language
class _TranslationsOnboardingLanguageZh implements TranslationsOnboardingLanguageEn {
	_TranslationsOnboardingLanguageZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '选择你的语言';
	@override String get subtitle => '选择你喜欢的界面语言';
	@override String get english => '英语';
	@override String get arabic => '阿拉伯语';
	@override String get german => '德语';
	@override String get chinese => '中文';
	@override String get hint => '你以后可以在设置中更改此设置';
}

// Path: onboarding.faculties_directory
class _TranslationsOnboardingFacultiesDirectoryZh implements TranslationsOnboardingFacultiesDirectoryEn {
	_TranslationsOnboardingFacultiesDirectoryZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '我们的学院';
	@override String get subtitle => '探索我们多样化的学术部门';
}

// Path: onboarding.style
class _TranslationsOnboardingStyleZh implements TranslationsOnboardingStyleEn {
	_TranslationsOnboardingStyleZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '选择你的风格';
	@override String get subtitle => '选择你喜欢的界面设计';
	@override late final _TranslationsOnboardingStyleClassicZh classic = _TranslationsOnboardingStyleClassicZh._(_root);
	@override late final _TranslationsOnboardingStyleGlassZh glass = _TranslationsOnboardingStyleGlassZh._(_root);
}

// Path: onboarding.theme
class _TranslationsOnboardingThemeZh implements TranslationsOnboardingThemeEn {
	_TranslationsOnboardingThemeZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '选择一个主题';
	@override String get subtitle => '明亮或黑暗，由你选择';
	@override String get light => '明亮';
	@override String get dark => '黑暗';
}

// Path: auth.login
class _TranslationsAuthLoginZh implements TranslationsAuthLoginEn {
	_TranslationsAuthLoginZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get welcome => '欢迎回来';
	@override String get subtitle => '登录以继续';
	@override String get email => '电子邮件';
	@override String get password => '密码';
	@override String get forgot_password => '忘记密码？';
	@override String get submit => '登录';
	@override String get guest => '作为访客浏览';
}

// Path: auth.forgot_password
class _TranslationsAuthForgotPasswordZh implements TranslationsAuthForgotPasswordEn {
	_TranslationsAuthForgotPasswordZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '忘记密码';
	@override String get subtitle => '选择恢复方法';
	@override String get method_admin => '访问管理部门';
	@override String get method_online => '在线申请';
	@override String get admin_instructions => '请前往学生事务办公室重置密码。请携带有效的大学身份证件。';
	@override String get phone_label => '电话号码';
	@override String get upload_id => '上传证件照';
	@override String get upload_id_hint => '点击上传清晰的大学身份证照片';
	@override String get submit => '提交申请';
	@override String get back => '返回登录';
	@override String get error_empty_phone => '请输入你的电话号码';
	@override String get error_empty_email => '请输入你的电子邮件';
	@override String get error_no_id => '请上传你的证件照';
	@override String get success => '申请提交成功';
	@override String get id_uploaded => '证件已上传';
}

// Path: home.tabs
class _TranslationsHomeTabsZh implements TranslationsHomeTabsEn {
	_TranslationsHomeTabsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get home => '首页';
	@override String get search => '搜索';
	@override String get notifications => '通知';
	@override String get profile => '个人资料';
}

// Path: dashboard.id_card
class _TranslationsDashboardIdCardZh implements TranslationsDashboardIdCardEn {
	_TranslationsDashboardIdCardZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get student_name => '学生姓名';
	@override String get college => '学院';
	@override String get id => '学号';
	@override String get gpa => 'GPA';
	@override String get level => '级别';
	@override String get verified => '已认证';
}

// Path: dashboard.sections
class _TranslationsDashboardSectionsZh implements TranslationsDashboardSectionsEn {
	_TranslationsDashboardSectionsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get academic => '学术';
	@override String get enrollment => '注册';
	@override String get utilities => '工具';
}

// Path: dashboard.items
class _TranslationsDashboardItemsZh implements TranslationsDashboardItemsEn {
	_TranslationsDashboardItemsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get transcript => '成绩单';
	@override String get progress => '学习进度';
	@override String get action_plan => '行动计划';
	@override String get subject_result => '科目成绩';
	@override String get grades => '评分';
	@override String get courses => '课程';
	@override String get registration => '选课注册';
	@override String get invoices => '未付账单';
	@override String get payment => '支付';
	@override String get tutorials => '教程';
	@override String get security => '安全';
	@override String get forums => '论坛';
	@override String get support => '支持';
	@override String get notifications => '通知';
	@override String get no_lectures => '未找到课程';
}

// Path: dashboard.labels
class _TranslationsDashboardLabelsZh implements TranslationsDashboardLabelsEn {
	_TranslationsDashboardLabelsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get university_name => '休大学 (HUE UNIVERSITY)';
	@override String get id_short => '学号';
	@override String get gpa_short => 'GPA';
	@override String get level_short => '级别';
}

// Path: settings.sections
class _TranslationsSettingsSectionsZh implements TranslationsSettingsSectionsEn {
	_TranslationsSettingsSectionsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get account => '账户';
	@override String get display => '显示';
	@override String get notifications => '通知';
	@override String get about => '关于';
}

// Path: settings.tiles
class _TranslationsSettingsTilesZh implements TranslationsSettingsTilesEn {
	_TranslationsSettingsTilesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get edit_profile => '编辑资料';
	@override String get change_password => '修改密码';
	@override String get dark_mode => '深色模式';
	@override String get language => '语言';
	@override String get ui_style => '界面风格';
	@override String get app_notifications => '应用通知';
	@override String get about_app => '关于应用';
	@override String get privacy_policy => '隐私政策';
	@override String get logout => '退出登录';
}

// Path: settings.messages
class _TranslationsSettingsMessagesZh implements TranslationsSettingsMessagesEn {
	_TranslationsSettingsMessagesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get switching_theme => '正在切换主题...';
	@override String get changing_language => '正在更改语言...';
	@override String get rebuilding_design => '正在重建设计系统...';
}

// Path: colleges.details
class _TranslationsCollegesDetailsZh implements TranslationsCollegesDetailsEn {
	_TranslationsCollegesDetailsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get dean => '院長';
	@override String get staff => '学术人员';
	@override String get view_all => '查看全部';
	@override String get departments => '系别';
	@override String get explore_majors => '探索可用专业';
	@override String get majors => '专业';
	@override String get dean_title => '院长';
	@override String get staff_member => '教职员工';
	@override String get vice_dean => '副院长';
	@override String get head_of_dept => '系主任';
	@override String get assoc_prof => '副教授';
	@override String get academic_statistics => '学术统计';
	@override String get students => '学生';
	@override String get academic_staff => '学术人员';
	@override String get teaching_assistants => '助教';
	@override String get published_articles => '已发表文章';
}

// Path: colleges.departments
class _TranslationsCollegesDepartmentsZh implements TranslationsCollegesDepartmentsEn {
	_TranslationsCollegesDepartmentsZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get medical_laboratories_technology => '医学检验技术';
	@override String get radiology_and_imaging_technology => '放射与影像技术';
	@override String get respiratory_care_technology => '呼吸治疗技术';
	@override String get dental_prosthetics_technology => '口腔修复技术';
	@override String get health_administration_and_informatics_technology => '健康管理与信息技术';
	@override String get accounting => '会计学';
	@override String get business_management => '工商管理';
	@override String get economics => '经济学';
	@override String get marketing => '市场营销';
	@override String get accounting_program_english => '会计学项目（英语）';
	@override String get business_administration_program_english => '工商管理项目（英语）';
	@override String get basic_sciences_in_dentistry => '牙科基础科学';
	@override String get basic_medical_and_clinical_sciences => '基础医学与临床科学';
	@override String get oral_and_maxillofacial_surgery => '口腔颌面外科';
	@override String get orthodontics_and_pediatric_dentistry => '正畸与儿童牙科';
	@override String get periodontics_and_oral_medicine => '牙周病与口腔医学';
	@override String get prosthodontics => '口腔修复学';
	@override String get conservative_dentistry_and_endodontics => '牙科保守治疗与牙髓病学';
	@override String get architectural_engineering => '建筑工程';
	@override String get basic_sciences => '基础科学';
	@override String get civil_engineering => '土木工程';
	@override String get mechanical_engineering => '机械工程';
	@override String get electrical_engineering => '电气工程';
	@override String get artificial_intelligence_engineering => '人工智能工程';
	@override String get interior_design_and_architecture => '室内设计与建筑';
	@override String get furniture_design_and_production_technology => '家具设计与生产技术';
	@override String get graphics_and_digital_arts => '平面与数字艺术';
	@override String get animation_and_multimedia => '动画与多媒体';
	@override String get medical_education => '医学教育';
	@override String get histology_and_cell_biology => '组织学与细胞生物学';
	@override String get clinical_pharmacy => '临床药学';
	@override String get human_anatomy_and_embryology => '人体解剖学与胚胎学';
	@override String get medical_physiology => '医学生理学';
	@override String get medical_microbiology_and_immunology => '医学微生物学与免疫学';
	@override String get forensic_medicine_and_toxicology => '法医学与毒理学';
	@override String get community_medicine_and_public_health => '社区医学与公共卫生';
	@override String get biochemistry => '生物化学';
	@override String get pathology => '病理学';
	@override String get english_language_program => '英语语言项目';
	@override String get german_language_program => '德语语言项目';
	@override String get chinese_language_program => '汉语语言项目';
	@override String get french_department => '法语系';
	@override String get translation_department => '翻译系';
	@override String get pharmaceutical_chemistry => '药物化学';
	@override String get pharmacology_and_biochemistry => '药理学与生物化学';
	@override String get pharmacognosy => '生药学';
	@override String get microbiology_and_immunology => '微生物学与免疫学';
	@override String get pharmaceutical_technology => '制药技术';
	@override String get pharmacy_practice => '药剂实践';
	@override String get basic_sciences_pt => '物理治疗基础科学';
	@override String get biomechanics => '生物力学';
	@override String get pt_internal_medicine_and_geriatrics => '内科与老年物理治疗';
	@override String get pt_womens_health => '女性健康物理治疗';
	@override String get pt_surgery_and_integumentary => '外科物理治疗';
	@override String get pt_orthopedics => '骨科物理治疗';
	@override String get pt_neurology => '神经物理治疗';
	@override String get pt_pediatrics => '儿科物理治疗';
	@override String get artificial_biomedical_computing => '人工智能生物医学计算';
	@override String get artificial_cybersecurity => '人工智能网络安全';
	@override String get ai_and_data_science => '人工智能与数据科学';
	@override String get ai_for_robotics => '机器人人工智能';
	@override String get smart_systems => '智能系统';
}

// Path: transcript.overview
class _TranslationsTranscriptOverviewZh implements TranslationsTranscriptOverviewEn {
	_TranslationsTranscriptOverviewZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get gpa => '累计 GPA';
	@override String get credits => '已修学分';
	@override String get standing => '学术状态';
	@override String get active => '状态良好';
}

// Path: transcript.semester
class _TranslationsTranscriptSemesterZh implements TranslationsTranscriptSemesterEn {
	_TranslationsTranscriptSemesterZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get fall => '秋季学期';
	@override String get spring => '春季学期';
	@override String get summer => '夏季学期';
}

// Path: transcript.course
class _TranslationsTranscriptCourseZh implements TranslationsTranscriptCourseEn {
	_TranslationsTranscriptCourseZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get grade => '成绩';
	@override String get credits => '学分';
	@override late final _TranslationsTranscriptCourseStatusZh status = _TranslationsTranscriptCourseStatusZh._(_root);
}

// Path: academic_progress.categories
class _TranslationsAcademicProgressCategoriesZh implements TranslationsAcademicProgressCategoriesEn {
	_TranslationsAcademicProgressCategoriesZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get university => '大学要求';
	@override String get faculty => '学院要求';
	@override String get major => '专业要求';
	@override String get electives => '选修课';
}

// Path: academic_progress.status
class _TranslationsAcademicProgressStatusZh implements TranslationsAcademicProgressStatusEn {
	_TranslationsAcademicProgressStatusZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get completed => '已完成';
	@override String get in_progress => '进行中';
	@override String get remaining => '剩余';
	@override String get requirement_met => '要求已满足';
}

// Path: onboarding.style.classic
class _TranslationsOnboardingStyleClassicZh implements TranslationsOnboardingStyleClassicEn {
	_TranslationsOnboardingStyleClassicZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '经典';
	@override String get desc => '干净、简单且熟悉的 Material 设计';
}

// Path: onboarding.style.glass
class _TranslationsOnboardingStyleGlassZh implements TranslationsOnboardingStyleGlassEn {
	_TranslationsOnboardingStyleGlassZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get title => '玻璃';
	@override String get desc => '现代、半透明且充满活力的美学';
}

// Path: transcript.course.status
class _TranslationsTranscriptCourseStatusZh implements TranslationsTranscriptCourseStatusEn {
	_TranslationsTranscriptCourseStatusZh._(this._root);

	final TranslationsZh _root; // ignore: unused_field

	// Translations
	@override String get completed => '已完成';
	@override String get transferred => '转学分';
}

/// The flat map containing all translations for locale <zh>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsZh {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.close' => '关闭',
			'common.cancel' => '取消',
			'common.confirm' => '确认',
			'common.save' => '保存',
			'common.back' => '返回',
			'welcome.title' => '欢迎来到 Hue',
			'welcome.subtitle' => '用有意义的联系点亮你的世界。',
			'welcome.get_started' => '开始使用',
			'welcome.have_account' => '我已经有账号了',
			'onboarding.language.title' => '选择你的语言',
			'onboarding.language.subtitle' => '选择你喜欢的界面语言',
			'onboarding.language.english' => '英语',
			'onboarding.language.arabic' => '阿拉伯语',
			'onboarding.language.german' => '德语',
			'onboarding.language.chinese' => '中文',
			'onboarding.language.hint' => '你以后可以在设置中更改此设置',
			'onboarding.faculties_directory.title' => '我们的学院',
			'onboarding.faculties_directory.subtitle' => '探索我们多样化的学术部门',
			'onboarding.style.title' => '选择你的风格',
			'onboarding.style.subtitle' => '选择你喜欢的界面设计',
			'onboarding.style.classic.title' => '经典',
			'onboarding.style.classic.desc' => '干净、简单且熟悉的 Material 设计',
			'onboarding.style.glass.title' => '玻璃',
			'onboarding.style.glass.desc' => '现代、半透明且充满活力的美学',
			'onboarding.theme.title' => '选择一个主题',
			'onboarding.theme.subtitle' => '明亮或黑暗，由你选择',
			'onboarding.theme.light' => '明亮',
			'onboarding.theme.dark' => '黑暗',
			'auth.login.welcome' => '欢迎回来',
			'auth.login.subtitle' => '登录以继续',
			'auth.login.email' => '电子邮件',
			'auth.login.password' => '密码',
			'auth.login.forgot_password' => '忘记密码？',
			'auth.login.submit' => '登录',
			'auth.login.guest' => '作为访客浏览',
			'auth.forgot_password.title' => '忘记密码',
			'auth.forgot_password.subtitle' => '选择恢复方法',
			'auth.forgot_password.method_admin' => '访问管理部门',
			'auth.forgot_password.method_online' => '在线申请',
			'auth.forgot_password.admin_instructions' => '请前往学生事务办公室重置密码。请携带有效的大学身份证件。',
			'auth.forgot_password.phone_label' => '电话号码',
			'auth.forgot_password.upload_id' => '上传证件照',
			'auth.forgot_password.upload_id_hint' => '点击上传清晰的大学身份证照片',
			'auth.forgot_password.submit' => '提交申请',
			'auth.forgot_password.back' => '返回登录',
			'auth.forgot_password.error_empty_phone' => '请输入你的电话号码',
			'auth.forgot_password.error_empty_email' => '请输入你的电子邮件',
			'auth.forgot_password.error_no_id' => '请上传你的证件照',
			'auth.forgot_password.success' => '申请提交成功',
			'auth.forgot_password.id_uploaded' => '证件已上传',
			'home.tabs.home' => '首页',
			'home.tabs.search' => '搜索',
			'home.tabs.notifications' => '通知',
			'home.tabs.profile' => '个人资料',
			'dashboard.id_card.student_name' => '学生姓名',
			'dashboard.id_card.college' => '学院',
			'dashboard.id_card.id' => '学号',
			'dashboard.id_card.gpa' => 'GPA',
			'dashboard.id_card.level' => '级别',
			'dashboard.id_card.verified' => '已认证',
			'dashboard.sections.academic' => '学术',
			'dashboard.sections.enrollment' => '注册',
			'dashboard.sections.utilities' => '工具',
			'dashboard.items.transcript' => '成绩单',
			'dashboard.items.progress' => '学习进度',
			'dashboard.items.action_plan' => '行动计划',
			'dashboard.items.subject_result' => '科目成绩',
			'dashboard.items.grades' => '评分',
			'dashboard.items.courses' => '课程',
			'dashboard.items.registration' => '选课注册',
			'dashboard.items.invoices' => '未付账单',
			'dashboard.items.payment' => '支付',
			'dashboard.items.tutorials' => '教程',
			'dashboard.items.security' => '安全',
			'dashboard.items.forums' => '论坛',
			'dashboard.items.support' => '支持',
			'dashboard.items.notifications' => '通知',
			'dashboard.items.no_lectures' => '未找到课程',
			'dashboard.labels.university_name' => '休大学 (HUE UNIVERSITY)',
			'dashboard.labels.id_short' => '学号',
			'dashboard.labels.gpa_short' => 'GPA',
			'dashboard.labels.level_short' => '级别',
			'settings.title' => '设置',
			'settings.sections.account' => '账户',
			'settings.sections.display' => '显示',
			'settings.sections.notifications' => '通知',
			'settings.sections.about' => '关于',
			'settings.tiles.edit_profile' => '编辑资料',
			'settings.tiles.change_password' => '修改密码',
			'settings.tiles.dark_mode' => '深色模式',
			'settings.tiles.language' => '语言',
			'settings.tiles.ui_style' => '界面风格',
			'settings.tiles.app_notifications' => '应用通知',
			'settings.tiles.about_app' => '关于应用',
			'settings.tiles.privacy_policy' => '隐私政策',
			'settings.tiles.logout' => '退出登录',
			'settings.messages.switching_theme' => '正在切换主题...',
			'settings.messages.changing_language' => '正在更改语言...',
			'settings.messages.rebuilding_design' => '正在重建设计系统...',
			'colleges.details.dean' => '院長',
			'colleges.details.staff' => '学术人员',
			'colleges.details.view_all' => '查看全部',
			'colleges.details.departments' => '系别',
			'colleges.details.explore_majors' => '探索可用专业',
			'colleges.details.majors' => '专业',
			'colleges.details.dean_title' => '院长',
			'colleges.details.staff_member' => '教职员工',
			'colleges.details.vice_dean' => '副院长',
			'colleges.details.head_of_dept' => '系主任',
			'colleges.details.assoc_prof' => '副教授',
			'colleges.details.academic_statistics' => '学术统计',
			'colleges.details.students' => '学生',
			'colleges.details.academic_staff' => '学术人员',
			'colleges.details.teaching_assistants' => '助教',
			'colleges.details.published_articles' => '已发表文章',
			'colleges.applied_health_sciences' => '应用健康科学学院',
			'colleges.business_administration' => '工商管理学院',
			'colleges.dentistry' => '口腔医学院',
			'colleges.engineering' => '工程学院',
			'colleges.fine_arts' => '美术学院',
			'colleges.human_medicine' => '医学院',
			'colleges.linguistics' => '语言与翻译学院',
			'colleges.pharmacy' => '药学院',
			'colleges.physical_therapy' => '物理治疗学院',
			'colleges.ai' => '人工智能学院',
			'colleges.departments.medical_laboratories_technology' => '医学检验技术',
			'colleges.departments.radiology_and_imaging_technology' => '放射与影像技术',
			'colleges.departments.respiratory_care_technology' => '呼吸治疗技术',
			'colleges.departments.dental_prosthetics_technology' => '口腔修复技术',
			'colleges.departments.health_administration_and_informatics_technology' => '健康管理与信息技术',
			'colleges.departments.accounting' => '会计学',
			'colleges.departments.business_management' => '工商管理',
			'colleges.departments.economics' => '经济学',
			'colleges.departments.marketing' => '市场营销',
			'colleges.departments.accounting_program_english' => '会计学项目（英语）',
			'colleges.departments.business_administration_program_english' => '工商管理项目（英语）',
			'colleges.departments.basic_sciences_in_dentistry' => '牙科基础科学',
			'colleges.departments.basic_medical_and_clinical_sciences' => '基础医学与临床科学',
			'colleges.departments.oral_and_maxillofacial_surgery' => '口腔颌面外科',
			'colleges.departments.orthodontics_and_pediatric_dentistry' => '正畸与儿童牙科',
			'colleges.departments.periodontics_and_oral_medicine' => '牙周病与口腔医学',
			'colleges.departments.prosthodontics' => '口腔修复学',
			'colleges.departments.conservative_dentistry_and_endodontics' => '牙科保守治疗与牙髓病学',
			'colleges.departments.architectural_engineering' => '建筑工程',
			'colleges.departments.basic_sciences' => '基础科学',
			'colleges.departments.civil_engineering' => '土木工程',
			'colleges.departments.mechanical_engineering' => '机械工程',
			'colleges.departments.electrical_engineering' => '电气工程',
			'colleges.departments.artificial_intelligence_engineering' => '人工智能工程',
			'colleges.departments.interior_design_and_architecture' => '室内设计与建筑',
			'colleges.departments.furniture_design_and_production_technology' => '家具设计与生产技术',
			'colleges.departments.graphics_and_digital_arts' => '平面与数字艺术',
			'colleges.departments.animation_and_multimedia' => '动画与多媒体',
			'colleges.departments.medical_education' => '医学教育',
			'colleges.departments.histology_and_cell_biology' => '组织学与细胞生物学',
			'colleges.departments.clinical_pharmacy' => '临床药学',
			'colleges.departments.human_anatomy_and_embryology' => '人体解剖学与胚胎学',
			'colleges.departments.medical_physiology' => '医学生理学',
			'colleges.departments.medical_microbiology_and_immunology' => '医学微生物学与免疫学',
			'colleges.departments.forensic_medicine_and_toxicology' => '法医学与毒理学',
			'colleges.departments.community_medicine_and_public_health' => '社区医学与公共卫生',
			'colleges.departments.biochemistry' => '生物化学',
			'colleges.departments.pathology' => '病理学',
			'colleges.departments.english_language_program' => '英语语言项目',
			'colleges.departments.german_language_program' => '德语语言项目',
			'colleges.departments.chinese_language_program' => '汉语语言项目',
			'colleges.departments.french_department' => '法语系',
			'colleges.departments.translation_department' => '翻译系',
			'colleges.departments.pharmaceutical_chemistry' => '药物化学',
			'colleges.departments.pharmacology_and_biochemistry' => '药理学与生物化学',
			'colleges.departments.pharmacognosy' => '生药学',
			'colleges.departments.microbiology_and_immunology' => '微生物学与免疫学',
			'colleges.departments.pharmaceutical_technology' => '制药技术',
			'colleges.departments.pharmacy_practice' => '药剂实践',
			'colleges.departments.basic_sciences_pt' => '物理治疗基础科学',
			'colleges.departments.biomechanics' => '生物力学',
			'colleges.departments.pt_internal_medicine_and_geriatrics' => '内科与老年物理治疗',
			'colleges.departments.pt_womens_health' => '女性健康物理治疗',
			'colleges.departments.pt_surgery_and_integumentary' => '外科物理治疗',
			'colleges.departments.pt_orthopedics' => '骨科物理治疗',
			'colleges.departments.pt_neurology' => '神经物理治疗',
			'colleges.departments.pt_pediatrics' => '儿科物理治疗',
			'colleges.departments.artificial_biomedical_computing' => '人工智能生物医学计算',
			'colleges.departments.artificial_cybersecurity' => '人工智能网络安全',
			'colleges.departments.ai_and_data_science' => '人工智能与数据科学',
			'colleges.departments.ai_for_robotics' => '机器人人工智能',
			'colleges.departments.smart_systems' => '智能系统',
			'transcript.title' => '学术成绩单',
			'transcript.overview.gpa' => '累计 GPA',
			'transcript.overview.credits' => '已修学分',
			'transcript.overview.standing' => '学术状态',
			'transcript.overview.active' => '状态良好',
			'transcript.semester.fall' => '秋季学期',
			'transcript.semester.spring' => '春季学期',
			'transcript.semester.summer' => '夏季学期',
			'transcript.course.grade' => '成绩',
			'transcript.course.credits' => '学分',
			'transcript.course.status.completed' => '已完成',
			'transcript.course.status.transferred' => '转学分',
			'academic_progress.title' => '学习进度',
			'academic_progress.completion' => '学位完成度',
			'academic_progress.total_credits' => '总学分',
			'academic_progress.categories.university' => '大学要求',
			'academic_progress.categories.faculty' => '学院要求',
			'academic_progress.categories.major' => '专业要求',
			'academic_progress.categories.electives' => '选修课',
			'academic_progress.status.completed' => '已完成',
			'academic_progress.status.in_progress' => '进行中',
			'academic_progress.status.remaining' => '剩余',
			'academic_progress.status.requirement_met' => '要求已满足',
			'grades.title' => '学期成绩',
			'grades.grade_point' => '绩点',
			'grades.letter_grade' => '等第',
			'grades.gpa' => '学期 GPA',
			'subject_results.title' => '科目结果',
			'subject_results.midterm' => '期中',
			'subject_results.kFinal' => '期末',
			'subject_results.practical' => '实践',
			'subject_results.activities' => '平时活动',
			'subject_results.total' => '总分',
			'action_plan.title' => '学位行动计划',
			'action_plan.roadmap' => '课程路线图',
			'action_plan.year_1' => '大一',
			'action_plan.year_2' => '大二',
			'action_plan.year_3' => '大三',
			'action_plan.year_4' => '大四',
			'courses.title' => '我的课程',
			'courses.enrolled' => '已修',
			'courses.available' => '可选',
			'courses.instructor' => '讲师',
			'courses.schedule' => '安排',
			'schedule.title' => '课程表',
			'schedule.time' => '时间',
			'schedule.room' => '教室',
			'schedule.monday' => '星期一',
			'schedule.tuesday' => '星期二',
			'schedule.wednesday' => '星期三',
			'schedule.thursday' => '星期四',
			'schedule.friday' => '星期五',
			'schedule.saturday' => '星期六',
			'schedule.sunday' => '星期日',
			'schedule.instructor' => '讲师',
			'schedule.doctor' => '博士',
			'schedule.type_lecture' => '讲座',
			'schedule.type_section' => '小班课',
			'schedule.status_active' => '待开始',
			'schedule.status_started' => '正在进行',
			'schedule.status_cancelled' => '已取消',
			'schedule.status_online' => '在线',
			'schedule.status_substitute' => '代课',
			'schedule.morning' => '上午',
			'schedule.afternoon' => '下午',
			'schedule.evening' => '晚上',
			'schedule.all_periods' => '全部时段',
			'schedule.floor' => '楼层',
			'schedule.direction' => '方位',
			'schedule.east' => '东方',
			'schedule.west' => '西方',
			'schedule.south' => '南方',
			'schedule.north' => '北方',
			'schedule.no_lectures' => '未找到课程',
			'exam_schedule.title' => '考试安排',
			'exam_schedule.date' => '日期',
			'exam_schedule.duration' => '时长',
			'exam_schedule.seat' => '座位号',
			'attendance.title' => '出勤统计',
			'attendance.present' => '出勤',
			'attendance.absent' => '缺勤',
			'attendance.late' => '迟到',
			'attendance.ratio' => '出勤率',
			'registration.title' => '选课注册',
			'registration.submit' => '提交注册',
			'registration.enrolled_credits' => '已修学分',
			'payment.title' => '学费缴纳',
			'payment.outstanding' => '待缴余额',
			'payment.pay_now' => '立即支付',
			'payment.methods' => '支付方式',
			'invoices.title' => '账单',
			'invoices.history' => '支付历史',
			'invoices.unpaid' => '未付',
			'invoices.paid' => '已付',
			'notifications.title' => '通知',
			'notifications.empty' => '无新通知',
			'support.title' => '支持与帮助',
			'support.contact_us' => '联系我们',
			'security.title' => '安全',
			'security.biometrics' => '生物识别',
			'security.sessions' => '活动会话',
			'tutorials.title' => '教程与指南',
			'forums.title' => '论坛',
			'administration.title' => '学生管理',
			'administration.stats' => '系统统计',
			'administration.users' => '用户',
			'administration.reports' => '报告',
			_ => null,
		};
	}
}

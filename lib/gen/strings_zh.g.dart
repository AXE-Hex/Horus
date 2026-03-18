import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

class TranslationsZh
    with BaseTranslations<AppLocale, Translations>
    implements Translations {
  TranslationsZh({
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
             locale: AppLocale.zh,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ) {
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  @override
  dynamic operator [](String key) => $meta.getTranslation(key);

  late final TranslationsZh _root = this;

  @override
  TranslationsZh $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => TranslationsZh(meta: meta ?? this.$meta);

  @override
  late final _TranslationsCommonZh common = _TranslationsCommonZh._(_root);
  @override
  late final _TranslationsWelcomeZh welcome = _TranslationsWelcomeZh._(_root);
  @override
  late final _TranslationsOnboardingZh onboarding = _TranslationsOnboardingZh._(
    _root,
  );
  @override
  late final _TranslationsAuthZh auth = _TranslationsAuthZh._(_root);
  @override
  late final _TranslationsHomeZh home = _TranslationsHomeZh._(_root);
  @override
  late final _TranslationsDashboardZh dashboard = _TranslationsDashboardZh._(
    _root,
  );
  @override
  late final _TranslationsSettingsZh settings = _TranslationsSettingsZh._(
    _root,
  );
  @override
  late final _TranslationsCollegesZh colleges = _TranslationsCollegesZh._(
    _root,
  );
  @override
  late final _TranslationsTranscriptZh transcript = _TranslationsTranscriptZh._(
    _root,
  );
  @override
  late final _TranslationsAcademicProgressZh academic_progress =
      _TranslationsAcademicProgressZh._(_root);
  @override
  late final _TranslationsGradesZh grades = _TranslationsGradesZh._(_root);
  @override
  late final _TranslationsSubjectResultsZh subject_results =
      _TranslationsSubjectResultsZh._(_root);
  @override
  late final _TranslationsActionPlanZh action_plan =
      _TranslationsActionPlanZh._(_root);
  @override
  late final _TranslationsCoursesZh courses = _TranslationsCoursesZh._(_root);
  @override
  late final _TranslationsScheduleZh schedule = _TranslationsScheduleZh._(
    _root,
  );
  @override
  late final _TranslationsExamScheduleZh exam_schedule =
      _TranslationsExamScheduleZh._(_root);
  @override
  late final _TranslationsAttendanceZh attendance = _TranslationsAttendanceZh._(
    _root,
  );
  @override
  late final _TranslationsRegistrationZh registration =
      _TranslationsRegistrationZh._(_root);
  @override
  late final _TranslationsPaymentZh payment = _TranslationsPaymentZh._(_root);
  @override
  late final _TranslationsInvoicesZh invoices = _TranslationsInvoicesZh._(
    _root,
  );
  @override
  late final _TranslationsNotificationsZh notifications =
      _TranslationsNotificationsZh._(_root);
  @override
  late final _TranslationsSupportZh support = _TranslationsSupportZh._(_root);
  @override
  late final _TranslationsSecurityZh security = _TranslationsSecurityZh._(
    _root,
  );
  @override
  late final _TranslationsTutorialsZh tutorials = _TranslationsTutorialsZh._(
    _root,
  );
  @override
  late final _TranslationsForumsZh forums = _TranslationsForumsZh._(_root);
  @override
  late final _TranslationsAdministrationZh administration =
      _TranslationsAdministrationZh._(_root);
  @override
  late final _TranslationsFeedZh feed = _TranslationsFeedZh._(_root);
  @override
  late final _TranslationsProfessorZh professor = _TranslationsProfessorZh._(
    _root,
  );
  @override
  late final _TranslationsRolesZh roles = _TranslationsRolesZh._(_root);
  @override
  late final _TranslationsAcademicZh academic = _TranslationsAcademicZh._(
    _root,
  );
  @override
  late final _TranslationsAdminZh admin = _TranslationsAdminZh._(_root);
  @override
  late final _TranslationsEnrollmentZh enrollment = _TranslationsEnrollmentZh._(
    _root,
  );
  @override
  late final _TranslationsSharedZh shared = _TranslationsSharedZh._(_root);
  @override
  late final _TranslationsStudentsZh students = _TranslationsStudentsZh._(
    _root,
  );
  @override
  late final _TranslationsExtractedZh extracted = _TranslationsExtractedZh._(
    _root,
  );
}

class _TranslationsCommonZh implements TranslationsCommonEn {
  _TranslationsCommonZh._(this._root);

  final TranslationsZh _root;

  @override
  String get close => '关闭';
  @override
  String get cancel => '取消';
  @override
  String get confirm => '确认';
  @override
  String get save => '保存';
  @override
  String get back => '返回';
}

class _TranslationsWelcomeZh implements TranslationsWelcomeEn {
  _TranslationsWelcomeZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '欢迎来到 Hue';
  @override
  String get subtitle => '用有意义的联系点亮你的世界。';
  @override
  String get get_started => '开始使用';
  @override
  String get have_account => '我已经有账号了';
  @override
  String get welcome_to_the_smart_universit => '欢迎来到智慧大学';
  @override
  String get i_already_have_an_account => '我已经有一个帐户';
  @override
  String get student_portal => '学生门户';
}

class _TranslationsOnboardingZh implements TranslationsOnboardingEn {
  _TranslationsOnboardingZh._(this._root);

  final TranslationsZh _root;

  @override
  late final _TranslationsOnboardingLanguageZh language =
      _TranslationsOnboardingLanguageZh._(_root);
  @override
  late final _TranslationsOnboardingFacultiesDirectoryZh faculties_directory =
      _TranslationsOnboardingFacultiesDirectoryZh._(_root);
  @override
  late final _TranslationsOnboardingStyleZh style =
      _TranslationsOnboardingStyleZh._(_root);
  @override
  late final _TranslationsOnboardingThemeZh theme =
      _TranslationsOnboardingThemeZh._(_root);
  @override
  String get choose_app_theme => '选择您的主题';
  @override
  String get you_can_change_this_later_in_s => '您可以稍后在“设置”中更改此设置';
  @override
  String get choose_language => '选择您的语言';
  @override
  String get high_performance_flat_solid_co => '高性能平面纯色';
  @override
  String get you_can_switch_styles_later_in => '您可以稍后在“设置”中切换样式';
  @override
  String get recommended => '受到推崇的';
  @override
  String get select_the_lighting_that_suits => '选择最适合您的照明';
  @override
  String get dark_mode => '深色模式';
  @override
  String get classic_solid => '经典的';
  @override
  String get title => '入职';
  @override
  String get modern_glass => '现代玻璃';
  @override
  String get choose_app_style => '选择您的应用程序风格';
  @override
  String get premium_frosted_glass_blur_eff => '优质磨砂玻璃模糊效果';
  @override
  String get almost_there_just_one_more_ste => '快到了！只需多一步。';
  @override
  String get light_mode => '灯光模式';
}

class _TranslationsAuthZh implements TranslationsAuthEn {
  _TranslationsAuthZh._(this._root);

  final TranslationsZh _root;

  @override
  late final _TranslationsAuthLoginZh login = _TranslationsAuthLoginZh._(_root);
  @override
  late final _TranslationsAuthForgotPasswordZh forgot_password =
      _TranslationsAuthForgotPasswordZh._(_root);
  @override
  String get back => '后退';
  @override
  String get choose_account_recovery_method => '选择帐户恢复方法';
}

class _TranslationsHomeZh implements TranslationsHomeEn {
  _TranslationsHomeZh._(this._root);

  final TranslationsZh _root;

  @override
  late final _TranslationsHomeTabsZh tabs = _TranslationsHomeTabsZh._(_root);
  @override
  String get prof => '教授';
  @override
  String get admin => '行政';
  @override
  String get faculty_portal => '教师门户';
  @override
  String get student => '学生';
  @override
  String get home => '家';
  @override
  String get student_portal => '学生门户';
  @override
  String get colleges => '学院';
  @override
  String get admin_portal => '管理门户';
}

class _TranslationsDashboardZh implements TranslationsDashboardEn {
  _TranslationsDashboardZh._(this._root);

  final TranslationsZh _root;

  @override
  late final _TranslationsDashboardIdCardZh id_card =
      _TranslationsDashboardIdCardZh._(_root);
  @override
  late final _TranslationsDashboardSectionsZh sections =
      _TranslationsDashboardSectionsZh._(_root);
  @override
  late final _TranslationsDashboardItemsZh items =
      _TranslationsDashboardItemsZh._(_root);
  @override
  late final _TranslationsDashboardLabelsZh labels =
      _TranslationsDashboardLabelsZh._(_root);
}

class _TranslationsSettingsZh implements TranslationsSettingsEn {
  _TranslationsSettingsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '设置';
  @override
  late final _TranslationsSettingsSectionsZh sections =
      _TranslationsSettingsSectionsZh._(_root);
  @override
  late final _TranslationsSettingsTilesZh tiles =
      _TranslationsSettingsTilesZh._(_root);
  @override
  late final _TranslationsSettingsMessagesZh messages =
      _TranslationsSettingsMessagesZh._(_root);
  @override
  String get about_app => '关于应用程序';
  @override
  String get user => '用户';
  @override
  String get university => '荷鲁斯大学';
  @override
  String get developer => '开发商';
  @override
  String get backend => '后端';
  @override
  String get passwords_do_not_match => '密码不匹配';
  @override
  String get platform => '平台';
  @override
  String get hue_portal_is_a_comprehensive_ => 'HUE Portal是一个综合性的智慧大学管理系统。';
  @override
  String get enter_your_new_password => '在下面输入您的新密码';
  @override
  String get password_changed_successfully => '密码修改成功';
  @override
  String get new_password => '新密码';
  @override
  String get horus_university => '荷鲁斯大学 - 埃及';
  @override
  String get password_must_be_at_least_6_ch => '密码必须至少为 6 个字符';
  @override
  String get please_fill_all_fields => '请填写所有字段';
  @override
  String get privacy_policy => '隐私政策';
  @override
  String get confirm_password => '确认密码';
  @override
  String get last_updated_february_2026 => '最后更新时间：2026 年 2 月';
  @override
  String get change_password => '更改密码';
  @override
  String get edit_profile => '编辑个人资料';
  @override
  String get save => '节省';
  @override
  String get phone => '电话';
  @override
  String get email => '电子邮件';
  @override
  String get bio => '简介';
  @override
  String get update_your_info_and_contact_d => '更新您的信息和联系方式';
  @override
  String get full_name => '姓名';
  @override
  String get send_a_test_notification => '发送测试通知';
  @override
  String get toggle_between_dark_and_light_ => '在深色和浅色模式之间切换';
  @override
  String get change_password_and_security_l => '更改密码和安全级别';
  @override
  String get current_glass_design => '当前： 玻璃设计';
  @override
  String get switch_style => '开关样式';
  @override
  String get control_the_types_of_incoming_ => '控制传入通知的类型';
  @override
  String get forgot_password => '忘记密码';
  @override
  String get role => '角色';
  @override
  String get test_notification_successful => '测试通知发送成功！';
  @override
  String get send_password_recovery_link_to => '将密码恢复链接发送到您的电子邮件';
  @override
  String get current_classic_design => '当前： 经典设计';
  @override
  String get battery_saver_mode => '省电模式';
  @override
  String get disable_complex_visual_effects => '禁用复杂的视觉效果以获得更好的性能';
  @override
  String get help_support_center => '帮助与支持中心';
  @override
  String get contact_us_to_resolve_any_issu => '联系我们解决任何问题';
  @override
  String get version_details_and_developers => '版本详细信息和开发者信息';
  @override
  String get select_app_language => '选择应用程序语言';
  @override
  String get terms_and_rules_for_data_usage => '数据使用条款和规则';
  @override
  String get deutsch => '德语';
  @override
  String get dynamic_val => '动态的';
  @override
  String get kSwitch => '转变';
  @override
  String get switch_label => '转变';
}

class _TranslationsCollegesZh implements TranslationsCollegesEn {
  _TranslationsCollegesZh._(this._root);

  final TranslationsZh _root;

  @override
  late final _TranslationsCollegesDetailsZh details =
      _TranslationsCollegesDetailsZh._(_root);
  @override
  String get applied_health_sciences => '应用健康科学学院';
  @override
  String get business_administration => '工商管理学院';
  @override
  String get dentistry => '口腔医学院';
  @override
  String get engineering => '工程学院';
  @override
  String get fine_arts => '美术学院';
  @override
  String get human_medicine => '医学院';
  @override
  String get linguistics => '语言与翻译学院';
  @override
  String get pharmacy => '药学院';
  @override
  String get physical_therapy => '物理治疗学院';
  @override
  String get ai => '人工智能学院';
  @override
  late final _TranslationsCollegesDepartmentsZh departments =
      _TranslationsCollegesDepartmentsZh._(_root);
}

class _TranslationsTranscriptZh implements TranslationsTranscriptEn {
  _TranslationsTranscriptZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '学术成绩单';
  @override
  late final _TranslationsTranscriptOverviewZh overview =
      _TranslationsTranscriptOverviewZh._(_root);
  @override
  late final _TranslationsTranscriptSemesterZh semester =
      _TranslationsTranscriptSemesterZh._(_root);
  @override
  late final _TranslationsTranscriptCourseZh course =
      _TranslationsTranscriptCourseZh._(_root);
}

class _TranslationsAcademicProgressZh
    implements TranslationsAcademicProgressEn {
  _TranslationsAcademicProgressZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '学习进度';
  @override
  String get completion => '学位完成度';
  @override
  String get total_credits => '总学分';
  @override
  late final _TranslationsAcademicProgressCategoriesZh categories =
      _TranslationsAcademicProgressCategoriesZh._(_root);
  @override
  late final _TranslationsAcademicProgressStatusZh status =
      _TranslationsAcademicProgressStatusZh._(_root);
}

class _TranslationsGradesZh implements TranslationsGradesEn {
  _TranslationsGradesZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '学期成绩';
  @override
  String get grade_point => '绩点';
  @override
  String get letter_grade => '等第';
  @override
  String get gpa => '学期 GPA';
  @override
  String get cumulative_gpa => '累积绩点';
  @override
  String get credits => '制作人员';
  @override
  String get summary => '成绩总结';
}

class _TranslationsSubjectResultsZh implements TranslationsSubjectResultsEn {
  _TranslationsSubjectResultsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '科目结果';
  @override
  String get midterm => '期中';
  @override
  String get kFinal => '期末';
  @override
  String get practical => '实践';
  @override
  String get activities => '平时活动';
  @override
  String get total => '总分';
}

class _TranslationsActionPlanZh implements TranslationsActionPlanEn {
  _TranslationsActionPlanZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '学位行动计划';
  @override
  String get roadmap => '课程路线图';
  @override
  String get year_1 => '大一';
  @override
  String get year_2 => '大二';
  @override
  String get year_3 => '大三';
  @override
  String get year_4 => '大四';
}

class _TranslationsCoursesZh implements TranslationsCoursesEn {
  _TranslationsCoursesZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '我的课程';
  @override
  String get enrolled => '已修';
  @override
  String get available => '可选';
  @override
  String get instructor => '讲师';
  @override
  String get schedule => '安排';
}

class _TranslationsScheduleZh implements TranslationsScheduleEn {
  _TranslationsScheduleZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '课程表';
  @override
  String get time => '时间';
  @override
  String get room => '教室';
  @override
  String get monday => '星期一';
  @override
  String get tuesday => '星期二';
  @override
  String get wednesday => '星期三';
  @override
  String get thursday => '星期四';
  @override
  String get friday => '星期五';
  @override
  String get saturday => '星期六';
  @override
  String get sunday => '星期日';
  @override
  String get instructor => '讲师';
  @override
  String get doctor => '博士';
  @override
  String get type_lecture => '讲座';
  @override
  String get type_section => '小班课';
  @override
  String get status_active => '待开始';
  @override
  String get status_started => '正在进行';
  @override
  String get status_cancelled => '已取消';
  @override
  String get status_online => '在线';
  @override
  String get status_substitute => '代课';
  @override
  String get morning => '上午';
  @override
  String get afternoon => '下午';
  @override
  String get evening => '晚上';
  @override
  String get all_periods => '全部时段';
  @override
  String get floor => '楼层';
  @override
  String get direction => '方位';
  @override
  String get east => '东方';
  @override
  String get west => '西方';
  @override
  String get south => '南方';
  @override
  String get north => '北方';
  @override
  String get no_lectures => '未找到课程';
  @override
  String get daily_title => '每日日程';
}

class _TranslationsExamScheduleZh implements TranslationsExamScheduleEn {
  _TranslationsExamScheduleZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '考试安排';
  @override
  String get date => '日期';
  @override
  String get duration => '时长';
  @override
  String get seat => '座位号';
}

class _TranslationsAttendanceZh implements TranslationsAttendanceEn {
  _TranslationsAttendanceZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '出勤统计';
  @override
  String get present => '出勤';
  @override
  String get absent => '缺勤';
  @override
  String get late => '迟到';
  @override
  String get ratio => '出勤率';
  @override
  late final _TranslationsAttendanceSubjectsZh subjects =
      _TranslationsAttendanceSubjectsZh._(_root);
}

class _TranslationsRegistrationZh implements TranslationsRegistrationEn {
  _TranslationsRegistrationZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '选课注册';
  @override
  String get submit => '提交注册';
  @override
  String get enrolled_credits => '已修学分';
  @override
  String get step1_title => '第 1 步：选择主要组';
  @override
  String get step1_subtitle => '选择您本学期想要注册的主要小组。';
  @override
  String group_label({required Object group}) => '${group}组';
  @override
  String get main_cohort => '主要队列注册';
  @override
  String section_label({required Object section}) => '${section}节';
  @override
  String get step2_title => '第 2 步：选择子部分';
  @override
  String get step3_title => '第三步：确认注册';
  @override
  String get labs_sessions => '实验室和实践课程';
  @override
  String step2_subtitle({required Object group}) => '所选组：${group}。现在选择您的实用子部分。';
  @override
  String credits_count({required Object credits}) => '${credits}CR';
  @override
  String get semester => '学期';
  @override
  String get review => '回顾选择';
  @override
  String get section => '部分';
  @override
  String get already_registered_title => '已经注册！';
  @override
  String get group => '团体';
  @override
  String get confirm_final => '确认最终注册';
  @override
  String get back_home => '返回首页';
  @override
  String success_message({required Object group, required Object section}) =>
      '您已成功注册本学期。\n组：${group}|部分：${section}';
  @override
  String get auto_registered => '自动注册的课程：';
  @override
  String error_loading({required Object error}) => '错误：${error}点击重试';
  @override
  String get registration_success => '注册成功！';
}

class _TranslationsPaymentZh implements TranslationsPaymentEn {
  _TranslationsPaymentZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '学费缴纳';
  @override
  String get outstanding => '待缴余额';
  @override
  String get pay_now => '立即支付';
  @override
  String get methods => '支付方式';
  @override
  String get credit_debit => '信用卡/借记卡';
  @override
  String get university_guaranteed => '大学保证方法';
  @override
  String get fawry => '福里/电子支付';
  @override
  String get bank_transfer => '银行转账';
  @override
  String currency({required Object amount}) => '${amount}EGP';
}

class _TranslationsInvoicesZh implements TranslationsInvoicesEn {
  _TranslationsInvoicesZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '账单';
  @override
  String get history => '支付历史';
  @override
  String get unpaid => '未付';
  @override
  String get paid => '已付';
  @override
  String get date => '日期';
  @override
  String get amount => '数量';
  @override
  String get id => '发票编号';
  @override
  String get status => '地位';
}

class _TranslationsNotificationsZh implements TranslationsNotificationsEn {
  _TranslationsNotificationsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '通知';
  @override
  String get empty => '无新通知';
}

class _TranslationsSupportZh implements TranslationsSupportEn {
  _TranslationsSupportZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '支持与帮助';
  @override
  String get contact_us => '联系我们';
}

class _TranslationsSecurityZh implements TranslationsSecurityEn {
  _TranslationsSecurityZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '安全';
  @override
  String get biometrics => '生物识别';
  @override
  String get sessions => '活动会话';
}

class _TranslationsTutorialsZh implements TranslationsTutorialsEn {
  _TranslationsTutorialsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '教程与指南';
}

class _TranslationsForumsZh implements TranslationsForumsEn {
  _TranslationsForumsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '论坛';
}

class _TranslationsAdministrationZh implements TranslationsAdministrationEn {
  _TranslationsAdministrationZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '学生管理';
  @override
  String get stats => '系统统计';
  @override
  String get users => '用户';
  @override
  String get reports => '报告';
  @override
  late final _TranslationsAdministrationAuditLogsZh audit_logs =
      _TranslationsAdministrationAuditLogsZh._(_root);
}

class _TranslationsFeedZh implements TranslationsFeedEn {
  _TranslationsFeedZh._(this._root);

  final TranslationsZh _root;

  @override
  String get likes => '喜欢';
  @override
  String get hours_ago => '几小时前';
  @override
  String get caption_sample => '这是帖子的示例标题';
}

class _TranslationsProfessorZh implements TranslationsProfessorEn {
  _TranslationsProfessorZh._(this._root);

  final TranslationsZh _root;

  @override
  String get dashboard_title => '教授仪表板';
  @override
  String active_tas_count({required Object count}) => '${count}主动 TA';
  @override
  String uploaded_files_count({required Object count}) => '${count}上传的文件';
  @override
  String total_students_count({required Object count}) => '${count}学生总数';
  @override
  String welcome_back_name({required Object name}) => '欢迎回来，${name}';
  @override
  String weekly_slots_count({required Object count}) => '${count}每周时段';
  @override
  String get select_all => '选择全部';
  @override
  String announcement_to({required Object count}) => '向${count}公告';
  @override
  String get no_groups => '没有可用的组';
  @override
  String get preparing_announcement => '正在准备公告...';
  @override
  String selected_count({required Object count}) => '${count}已选择';
  @override
  String activating({required Object target}) => '激活：${target}';
  @override
  String action_clicked({required Object action}) => '点击：${action}';
  @override
  String get add_new_ta => '添加新助教';
  @override
  String get deselect_all => '取消全选';
  @override
  String get no_available_tas => '没有可用的 TA';
  @override
  String get no_active_tas => '没有活跃的 TA';
  @override
  String added({required Object name}) => '添加：${name}';
  @override
  String removed({required Object name}) => '删除：${name}';
  @override
  String get urgent => '紧迫的';
  @override
  String get add => '添加';
  @override
  String joined({required Object name}) => '加入：${name}';
  @override
  String get message => '信息';
  @override
  String get walk_in => '步入式';
  @override
  String get upload => '上传';
  @override
  late final _TranslationsProfessorStatsZh stats =
      _TranslationsProfessorStatsZh._(_root);
  @override
  String get join => '加入';
  @override
  String get downloading => '正在下载...';
  @override
  late final _TranslationsProfessorQuickActionsZh quick_actions =
      _TranslationsProfessorQuickActionsZh._(_root);
  @override
  late final _TranslationsProfessorProfileZh profile =
      _TranslationsProfessorProfileZh._(_root);
}

class _TranslationsRolesZh implements TranslationsRolesEn {
  _TranslationsRolesZh._(this._root);

  final TranslationsZh _root;

  @override
  late final _TranslationsRolesCategoriesZh categories =
      _TranslationsRolesCategoriesZh._(_root);
  @override
  late final _TranslationsRolesNamesZh names = _TranslationsRolesNamesZh._(
    _root,
  );
  @override
  late final _TranslationsRolesDescriptionsZh descriptions =
      _TranslationsRolesDescriptionsZh._(_root);
}

class _TranslationsAcademicZh implements TranslationsAcademicEn {
  _TranslationsAcademicZh._(this._root);

  final TranslationsZh _root;

  @override
  String get academic_progress => '学业进步';
  @override
  String get university_requirements => '大学要求';
  @override
  String get faculty_requirements => '师资要求';
  @override
  String get major_requirements => '主要要求';
  @override
  String get completed => '完全的';
  @override
  String get remaining => '其余的';
  @override
  String get transcript_title => '学术成绩单';
  @override
  String get grades_title => '成绩';
  @override
  String get courses_title => '我的课程';
  @override
  String get electives => '选修课';
  @override
  String get action_plan_title => '学位行动计划';
  @override
  String get attendance_title => '出席率';
  @override
  String get schedule_title => '日程';
  @override
  String get professor_dashboard => '教授仪表板';
  @override
  String get all_students => '所有学生';
  @override
  String get exam_schedule_title => '考试时间表';
  @override
  String get tas => '助教';
  @override
  String get subject_results_title => '科目结果';
  @override
  String get office_hours => '办公时间';
  @override
  String get no_groups => '没有团体';
  @override
  String get groups => '团体';
  @override
  String get chat => '聊天';
  @override
  String get assignments => '作业';
  @override
  String get courses => '课程';
  @override
  String get view_all => '查看全部';
  @override
  String get feedback => '反馈';
  @override
  String get active => '积极的';
  @override
  String get add_ta => '添加助教';
  @override
  String get remove_ta => '删除TA';
  @override
  String get inactive => '不活跃';
  @override
  String get all => '全部';
  @override
  String get urgent_announcement => '紧急公告';
  @override
  String get send_message => '发送消息';
  @override
  String get section => '部分';
  @override
  String get manage_groups => '管理群组';
  @override
  String get group_label => '团体';
  @override
  String get upload_file => '上传文件';
  @override
  String get manage_tas => '管理助教';
  @override
  String get profile => '轮廓';
  @override
  String get semester_grades => '学期成绩';
  @override
  String get grade_summary => '成绩总结';
  @override
  String get gpa => '平均绩点';
  @override
  String get credits => '制作人员';
  @override
  String get kFinal => '期末考试';
  @override
  String get practical => '实际的';
  @override
  String get total => '全部的';
  @override
  String get midterm => '期中考试';
  @override
  String get year_2 => '第二年';
  @override
  String get year_1 => '第一年';
  @override
  String get year_3 => '第三年';
  @override
  String get available => '可用的';
  @override
  String get instructor => '讲师';
  @override
  String get schedule_info => '日程';
  @override
  String get time => '时间';
  @override
  String get room => '房间';
  @override
  String get enrolled => '已注册';
  @override
  String get year_4 => '第四年';
  @override
  String get seat => '座位';
  @override
  String get exam_date => '考试日期';
  @override
  String get duration => '期间';
  @override
  String get present => '展示';
  @override
  String get absent => '缺席的';
  @override
  String get late => '晚的';
  @override
  String get ratio => '比率';
  @override
  String get back => '后退';
  @override
  String get no_data => '无可用数据';
  @override
  String get error => '错误';
  @override
  String get search => '搜索';
  @override
  String get retry => '重试';
  @override
  String get cancel => '取消';
  @override
  String get save => '节省';
  @override
  String get loading => '加载中...';
  @override
  String get delete => '删除';
  @override
  String get filter => '筛选';
  @override
  String get edit => '编辑';
  @override
  String get confirm => '确认';
  @override
  String get add => '添加';
  @override
  String get remove => '消除';
  @override
  String get close => '关闭';
  @override
  String get academic_journey => '学术之旅';
  @override
  String get academic_results => '学业成绩';
  @override
  String get send => '发送';
  @override
  String get academic_standing_excellent => '出色的';
  @override
  String get add_new_ta => '添加新助教';
  @override
  String get across_all_groups => '跨所有群体';
  @override
  String get add_to_calendar => '添加到日历';
  @override
  String get action_plan => '学位行动计划';
  @override
  String get advanced_learning => '进阶学习';
  @override
  String get advanced_mathematics => '高等数学';
  @override
  String get advisor_assignment => '顾问分配';
  @override
  String get added_successfully => '添加成功';
  @override
  String get algorithms => '算法';
  @override
  String get artificial_intelligence => '人工智能';
  @override
  String get are_you_sure_you_want_to_remov => '您确定要删除该 TA 吗？';
  @override
  String get calculus_i => '微积分一';
  @override
  String get clicked => '点击';
  @override
  String get code_review => '代码审查';
  @override
  String get completed_1 => '完全的';
  @override
  String get completion_rate => '完成率';
  @override
  String get confirm_removal => '确认删除';
  @override
  String get comp_organization => '计算机组织';
  @override
  String get computer_programming => '计算机编程';
  @override
  String get course_management => '课程管理';
  @override
  String get credits_1 => '制作人员';
  @override
  String get coursework => '课程作业';
  @override
  String get cs402_artificial_intelligence => 'CS402 人工智能';
  @override
  String get cs410_computer_vision => 'CS410 计算机视觉';
  @override
  String get cs405_machine_learning => 'CS405 机器学习';
  @override
  String get cumulative_gpa => '累积绩点';
  @override
  String get database_systems => '数据库系统';
  @override
  String get data_structures => '数据结构';
  @override
  String get d_mmmm => 'MMMM';
  @override
  String get deep_learning => '深度学习';
  @override
  String get dr_alan_turing => '艾伦·图灵博士';
  @override
  String get days => '天';
  @override
  String get dr_ada_lovelace => '艾达·洛夫莱斯博士';
  @override
  String get dr_robert_smith => '罗伯特·史密斯博士';
  @override
  String get dr_sarah_ahmed => '萨拉·艾哈迈德博士';
  @override
  String get english_composition => '英语作文';
  @override
  String get ethics_in_it => 'IT 道德';
  @override
  String get fall_2023 => '2023 年秋季';
  @override
  String get exam_schedule => '考试时间表';
  @override
  String get field_internship => '实地实习';
  @override
  String get file_title => '文件标题';
  @override
  String get file_will_be_uploaded_to_cloud => '文件将上传到云存储';
  @override
  String get final_exam => '期末考试';
  @override
  String get foundational_skills => '基础技能';
  @override
  String get general_physics => '普通物理';
  @override
  String get graduation_progress => '毕业进度';
  @override
  String get graduation_mastery => '毕业精通';
  @override
  String get frontend_ui => '前端用户界面';
  @override
  String get graduation_project => '毕业设计';
  @override
  String get hall_1 => '1号馆';
  @override
  String get intro_to_ai => '人工智能简介';
  @override
  String get hum210_professional_ethics => 'HUM210 职业道德';
  @override
  String get hall_4 => '4号馆';
  @override
  String get hours => '时间';
  @override
  String get intro_to_programming => '编程入门';
  @override
  String get joined => '已加入';
  @override
  String get lab_12 => '实验室12';
  @override
  String get lab_final => '实验室决赛';
  @override
  String get lecture => '演讲';
  @override
  String get lecture_hall_2 => '报告厅2';
  @override
  String get linear_algebra => '线性代数';
  @override
  String get live => '居住';
  @override
  String get machine_learning => '机器学习';
  @override
  String get live_now => '现在直播';
  @override
  String get mat301_advanced_calculus => 'MAT301 高级微积分';
  @override
  String get members => '会员';
  @override
  String get messages => '留言';
  @override
  String get next_exam_in => '下次考试时间';
  @override
  String get network_security => '网络安全';
  @override
  String get no_available_tas_currently => '目前没有可用的助教';
  @override
  String get no_exams_on_this_day => '这一天没有考试';
  @override
  String get midterm_exam => '期中考试';
  @override
  String get mins => '分钟';
  @override
  String get mathematics => '数学';
  @override
  String get no_tas_assigned_yet => '尚未分配 TA';
  @override
  String get overall_attendance => '整体出席率';
  @override
  String get overall_progress => '总体进展';
  @override
  String get logic_design => '逻辑设计';
  @override
  String get points => '积分';
  @override
  String get performance_distribution => '业绩分布';
  @override
  String get programming_basics => '编程基础知识';
  @override
  String get prof_john_doe => '约翰·多伊教授';
  @override
  String get progress => '进步';
  @override
  String get psychology => '心理学';
  @override
  String get quick_actions => '快速行动';
  @override
  String get practical_project => '实际项目';
  @override
  String get rank => '秩';
  @override
  String get results_analysis => '结果分析';
  @override
  String get registration_requests => '注册请求';
  @override
  String get rating => '等级';
  @override
  String get score => '分数';
  @override
  String get sessions_this_week => '本周会议';
  @override
  String get removed_successfully => '删除成功';
  @override
  String get quiz_2 => '测验2';
  @override
  String get select_a_ta_from_the_list_to_a => '从列表中选择要添加的 TA';
  @override
  String get quiz_1 => '测验 1';
  @override
  String get shared_files => '共享文件';
  @override
  String get specialization_projects => '专业化项目';
  @override
  String get sophomore => '大二';
  @override
  String get spring_2024 => '2024 年春季';
  @override
  String get summer_2024 => '2024 年夏季';
  @override
  String get track_project_i => '跟踪项目 I';
  @override
  String get students => '学生';
  @override
  String get start_by_adding_the_first_ta_f => '首先为您的课程添加第一个助教';
  @override
  String get ta_team_chat => '助教团队聊天';
  @override
  String get total_students => '学生总数';
  @override
  String get upload_files => '上传文件';
  @override
  String get upload_new_file => '上传新文件';
  @override
  String get type_a_message => '输入消息...';
  @override
  String get web_programming => '网页编程';
  @override
  String get urgent_news => '紧急消息';
  @override
  String get upload => '上传';
  @override
  String get uploaded_successfully => '上传成功';
}

class _TranslationsAdminZh implements TranslationsAdminEn {
  _TranslationsAdminZh._(this._root);

  final TranslationsZh _root;

  @override
  String get system_online => '系统上线';
  @override
  String get en => 'zh';
  @override
  String get admin_command_center => '管理指挥中心';
  @override
  String get eeee_mmmm_dd_yyyy => 'EEEE，MMMM 日，年';
  @override
  String get live_statistics => '实时统计';
  @override
  String get students => '学生';
  @override
  String get admin => '行政';
  @override
  String get faculty => '学院';
  @override
  String get leadership => '领导';
  @override
  String get staff => '职员';
  @override
  String get system_modules => '系统模块';
  @override
  String get users => '用户';
  @override
  String get admin_it => '行政与信息技术';
  @override
  String get manage_all_accounts => '管理所有帐户';
  @override
  String get manage_faculties => '管理院系';
  @override
  String get colleges => '学院';
  @override
  String get departments => '部门';
  @override
  String get academic_departments => '学术部门';
  @override
  String get professors => '教授';
  @override
  String get faculty_members => '教职人员';
  @override
  String get permission_management => '权限管理';
  @override
  String get audit_logs => '审核日志';
  @override
  String get roles => '角色';
  @override
  String get system_activity_log => '系统活动日志';
  @override
  String get system_settings => '系统设置';
  @override
  String get platform_configuration => '平台配置';
  @override
  String get performance => '表现';
  @override
  String get server_health_metrics => '服务器健康指标';
  @override
  String get server => '服务器';
  @override
  String get system_pulse => '系统脉冲';
  @override
  String get latency => '延迟';
  @override
  String get online => '在线的';
  @override
  String get status => '地位';
  @override
  String get active => '积极的';
  @override
  String get realtime_latency_ms => '实时延迟 (MS)';
  @override
  String get teaching_staff => '师资队伍';
  @override
  String get role_breakdown => '角色细分';
  @override
  String get academic_leadership => '学术领导力';
  @override
  String get student_affairs => '学生事务';
  @override
  String get database => '数据库';
  @override
  String get total_users => '用户总数';
  @override
  String get quick_actions => '快速行动';
  @override
  String get system_health => '系统健康状况';
  @override
  String get management => '管理';
  @override
  String get export_data => '导出数据';
  @override
  String get add_user => '添加用户';
  @override
  String get user_management => '用户管理';
  @override
  String get backup_system => '备份系统';
  @override
  String get user_list => '用户列表';
  @override
  String get filter_students => '学生';
  @override
  String get filter_all => '全部';
  @override
  String get filter_admin => '行政';
  @override
  String get filter_staff => '职员';
  @override
  String get search_users => '搜索用户...';
  @override
  String get no_users => '没有找到用户';
  @override
  String get staff_management => '员工管理';
  @override
  String get student_management => '学生管理';
  @override
  String get faculty_management => '师资管理';
  @override
  String user_count({required Object count}) => '${count}用户';
  @override
  String get leadership_management => '领导力管理';
  @override
  String get admin_it_management => '行政和 IT 管理';
  @override
  String get send_announcement => '发送公告';
  @override
  String get college_management => '学院管理';
  @override
  String get department_management => '部门管理';
  @override
  String get professor_management => '教授管理学';
  @override
  String get role_management => '角色管理';
  @override
  String get audit_log_management => '审计日志管理';
  @override
  String get system_configuration => '系统配置';
  @override
  String get add_department => '添加部门';
  @override
  String get add_college => '添加学院';
  @override
  String get edit_college => '编辑学院';
  @override
  String get edit_department => '编辑部门';
  @override
  String get delete_college => '删除学院';
  @override
  String get delete_department => '删除部门';
  @override
  String get college_name => '学院名称';
  @override
  String get department_name => '部门名称';
  @override
  String get student_count => '学生';
  @override
  String get head_name => '头名';
  @override
  String get dean_name => '院长姓名';
  @override
  String get timestamp => '时间戳';
  @override
  String get action => '行动';
  @override
  String get ta_count => 'TA';
  @override
  String get staff_count => '职员';
  @override
  String get user => '用户';
  @override
  String get details => '细节';
  @override
  String get filter_by_date => '按日期过滤';
  @override
  String get filter_by_action => '按操作过滤';
  @override
  String get system_version => '系统版本';
  @override
  String get no_logs => '未找到审核日志';
  @override
  String get maintenance_mode => '维护方式';
  @override
  String get backup_schedule => '备份计划';
  @override
  String get storage_quota => '存储配额';
  @override
  String get email_server => '电子邮件服务器';
  @override
  String get log_retention => '日志保留';
  @override
  String get security_level => '安全等级';
  @override
  String get session_timeout => '会话超时';
  @override
  String get reset_defaults => '重置为默认值';
  @override
  String get save_settings => '保存设置';
  @override
  String get user_name => '姓名';
  @override
  String get user_role => '角色';
  @override
  String get user_phone => '电话';
  @override
  String get user_department => '部门';
  @override
  String get user_email => '电子邮件';
  @override
  String get user_college => '大学';
  @override
  String get user_status => '地位';
  @override
  String get user_updated => '用户更新成功';
  @override
  String get user_created => '已创建';
  @override
  String get add_new_user => '添加新用户';
  @override
  String get edit_user => '编辑用户';
  @override
  String get delete_user => '删除用户';
  @override
  String get save_user => '节省';
  @override
  String get cancel => '取消';
  @override
  String get name_label => '姓名';
  @override
  String get college_label => '大学';
  @override
  String get department_label => '部门';
  @override
  String get email_label => '电子邮件';
  @override
  String get role_label => '选择角色';
  @override
  String get phone_label => '电话号码';
  @override
  String get confirm_password_label => '确认密码';
  @override
  String get password_label => '密码';
  @override
  String get category_faculty => '学院';
  @override
  String get category_student => '学生';
  @override
  String get category_leadership => '领导';
  @override
  String get category_staff => '职员';
  @override
  String get category_admin => '行政';
  @override
  String get select_role => '选择角色';
  @override
  String get select_department => '选择部门';
  @override
  String get select_college => '选择学院';
  @override
  String get user_added => '用户添加成功';
  @override
  String get no_colleges => '没有可用的大学';
  @override
  String get user_deleted => '用户删除成功';
  @override
  String get confirm_delete => '确认删除';
  @override
  String get error_loading => '加载数据时出错';
  @override
  String get retry => '重试';
  @override
  String get confirm_delete_message => '您确定要删除该用户吗？';
  @override
  String get error_saving => '保存数据时出错';
  @override
  String get academic_departments_1 => '学术部门';
  @override
  String get no_departments => '没有可用的部门';
  @override
  String get academic_department => '学术部';
  @override
  String get academic_leaders => '学术带头人';
  @override
  String get academic_warnings => '学术警告';
  @override
  String get account_status => '账户状态';
  @override
  String get account_verification => '账户验证';
  @override
  String get actor => '演员';
  @override
  String get add_report => '添加报告';
  @override
  String get advanced_management => '先进管理';
  @override
  String get admins => '管理员';
  @override
  String get all_levels => '所有级别';
  @override
  String get all_systems_operational => '所有系统均可运行';
  @override
  String get all => '全部';
  @override
  String get apply_filters => '应用过滤器';
  @override
  String get are_you_sure_you_want_to_delet => '您确定要删除该用户吗？';
  @override
  String get assign => '分配';
  @override
  String get assign_dean => '指定院长';
  @override
  String get assign_department_head => '指定部门主管';
  @override
  String get attached_report => '附报告';
  @override
  String get banned => '禁止';
  @override
  String get change => '改变';
  @override
  String get ban_user => '禁止用户';
  @override
  String get change_dean => '更换院长';
  @override
  String get changes_saved_successfully => '更改已成功保存';
  @override
  String get college => '大学';
  @override
  String get college_dean => '学院院长';
  @override
  String get college_details => '学院详情';
  @override
  String get colleges_management => '学院管理';
  @override
  String get coming_soon => '即将推出';
  @override
  String get department_details => '部门详情';
  @override
  String get deactivated => '已停用';
  @override
  String get department_projects => '部门项目';
  @override
  String get delete => '删除';
  @override
  String get departments_management => '部门管理';
  @override
  String get entity => '实体';
  @override
  String get error_snapshoterror => '错误：{错误}';
  @override
  String get email_address => '电子邮件';
  @override
  String get failed_to_load_data => '加载数据失败';
  @override
  String get faculty_members_1 => '教职人员';
  @override
  String get full_name => '姓名';
  @override
  String get head_of_department => '系主任';
  @override
  String get incidents => '事件';
  @override
  String get filter_users => '过滤用户';
  @override
  String get leadership_stats => '领导力统计';
  @override
  String get level_level => '级别{级别}';
  @override
  String get manage_tags => '管理标签';
  @override
  String get national_id => '国民身份证';
  @override
  String get min_6_chars => '分钟。 6 个字符';
  @override
  String get no_about_text_available => '没有可用的关于文本';
  @override
  String get nationality => '国籍';
  @override
  String get no_dean_assigned => '没有指定院长';
  @override
  String get no_colleges_found => '没有找到大学';
  @override
  String get no_departments_in_this_college => '该学院没有院系';
  @override
  String get no_departments_found => '未找到部门';
  @override
  String get no_description_available => '无可用描述';
  @override
  String get no_matching_students_found => '未找到匹配的学生';
  @override
  String get no_faculty_records_found => '未找到教师记录';
  @override
  String get no_head_assigned => '没有分配头';
  @override
  String get no_projects_added_yet => '尚未添加项目';
  @override
  String get no_logs_found => '未找到日志';
  @override
  String get no_settings_found_in_the_datab => '在数据库中找不到设置';
  @override
  String get office => '办公室';
  @override
  String get no_users_found => '未找到用户';
  @override
  String get password => '密码';
  @override
  String get pending_reg => '待注册';
  @override
  String get permanently_delete_user => '永久删除用户';
  @override
  String get phone_number => '电话号码';
  @override
  String get please_assign_a_head_for_the_d => '请指定该部门的负责人';
  @override
  String get please_assign_a_dean_for_the_c => '请为该学院指派一名院长';
  @override
  String get save => '节省';
  @override
  String get roles_management => '角色管理';
  @override
  String get save_changes => '保存更改';
  @override
  String get search_by_name_email_phone_id => '按姓名、电子邮件、电话或 ID 搜索...';
  @override
  String get select_role_in_widgetinitialca => '选择角色';
  @override
  String get search_staff_member => '搜寻工作人员...';
  @override
  String get select => '选择';
  @override
  String get search_doctor_name => '搜索医生姓名...';
  @override
  String get search_student_or_id => '搜索学生或 ID...';
  @override
  String get servers => '服务器';
  @override
  String get select_role_permission => '选择角色/权限';
  @override
  String get separate_tags_with_commas => '用逗号分隔标签';
  @override
  String get student_id => '学生证';
  @override
  String get system_technical_status => '系统技术状况';
  @override
  String get tag1_tag2 => '标签1、标签2';
  @override
  String get teaching_assistants => '助教';
  @override
  String get total_staff => '员工总数';
  @override
  String get total_students => '学生总数';
  @override
  String get unverified => '未验证';
  @override
  String get verified => '已验证';
  @override
  String get verification => '确认';
  @override
  String get warning_level => '警告级别';
  @override
  String get user_roles_ranks => '用户角色和等级';
  @override
  String get you_can_manage_professors_and_ => '您可以在这里管理教授等';
}

class _TranslationsEnrollmentZh implements TranslationsEnrollmentEn {
  _TranslationsEnrollmentZh._(this._root);

  final TranslationsZh _root;

  @override
  String get registration_title => '课程注册';
  @override
  String get invoices_title => '财务发票';
  @override
  String get advisor_approval => '顾问批准';
  @override
  String get advisor => '学术顾问';
  @override
  String get approve => '批准';
  @override
  String get reject => '拒绝';
  @override
  String get dean_assignment => '院长顾问分配';
  @override
  String get payment_title => '缴纳学费';
  @override
  String get pending => '待办的';
  @override
  String get approved => '得到正式认可的';
  @override
  String get rejected => '被拒绝';
  @override
  String get student_name => '学生姓名';
  @override
  String get student_id => '学生证';
  @override
  String get college => '大学';
  @override
  String get department => '部门';
  @override
  String get semester => '学期';
  @override
  String get credits => '制作人员';
  @override
  String get group => '团体';
  @override
  String get section => '部分';
  @override
  String get status => '地位';
  @override
  String get no_requests => '没有找到请求';
  @override
  String get filter_rejected => '被拒绝';
  @override
  String get search_students => '搜索学生...';
  @override
  String get filter_approved => '得到正式认可的';
  @override
  String get registration_date => '报名日期';
  @override
  String get approve_all => '批准全部';
  @override
  String get assign => '分配';
  @override
  String get advisor_name => '顾问姓名';
  @override
  String get filter_all => '全部';
  @override
  String get unassign => '取消分配';
  @override
  String get view_details => '查看详情';
  @override
  String get unassigned => '未分配';
  @override
  String get filter_pending => '待办的';
  @override
  String get cancel => '取消';
  @override
  String get save => '节省';
  @override
  String get success_reject => '注册被拒绝';
  @override
  String get success_approve => '注册审核成功';
  @override
  String get success_assign => '顾问分配成功';
  @override
  String get error_loading => '加载数据时出错';
  @override
  String get assigned => '已分配';
  @override
  String get invoice_amount => '数量';
  @override
  String get invoice_status => '地位';
  @override
  String get invoice_date => '日期';
  @override
  String get invoice_id => '发票编号';
  @override
  String get invoice_paid => '有薪酬的';
  @override
  String get invoice_overdue => '逾期';
  @override
  String get pay_now => '立即付款';
  @override
  String get payment_method => '付款方式';
  @override
  String get invoice_unpaid => '未付';
  @override
  String get fawry => '福里';
  @override
  String get credit_card => '信用卡';
  @override
  String get payment_success => '付款成功';
  @override
  String get bank_transfer => '银行转账';
  @override
  String get payment_error => '付款失败';
  @override
  String get outstanding_balance => '未结余额';
  @override
  String get total_paid => '总付费';
  @override
  String get no_invoices => '没有找到发票';
  @override
  String get tuition_fee => '学费';
  @override
  String get registration_fee => '注册费';
  @override
  String get late_fee => '滞纳金';
  @override
  String get academic_year => '学年';
  @override
  String get submit_request => '提交请求';
  @override
  String get total => '全部的';
  @override
  String semester_label({required Object semester}) => '学期${semester}';
  @override
  String get all => '全部';
  @override
  String get academic_advisor => '学术顾问';
  @override
  String get request_submitted => '请求提交成功';
  @override
  String get approved_1 => '得到正式认可的';
  @override
  String get retry => '重试';
  @override
  String get approved_courses_registered => '批准 - 注册课程';
  @override
  String get advisor_assignment => '顾问分配';
  @override
  String get confirm_submit => '确认并提交';
  @override
  String get cr => 'CR';
  @override
  String get advisor_requestadvisorfullname => '顾问：{姓名}';
  @override
  String get advisor_updated_successfully => '顾问更新成功';
  @override
  String get dormitory_fee => '宿舍费';
  @override
  String get download => '下载';
  @override
  String get failed_to_load_invoices => '加载发票失败';
  @override
  String get exam_fee => '考试费';
  @override
  String get error_loading_summary => '加载摘要时出错';
  @override
  String get due => '到期的';
  @override
  String get financial_portal => '金融门户';
  @override
  String get awaiting_advisor_review => '等待顾问审核';
  @override
  String get choose_schedules => '选择时间表';
  @override
  String get financial_summary => '财务摘要';
  @override
  String get help => '帮助';
  @override
  String get history => '历史';
  @override
  String get library_fee => '图书馆费';
  @override
  String get invoices => '发票';
  @override
  String get manage_your_tuition_and_paymen => '管理您的学费和付款';
  @override
  String get mmm_dd_yyyy => '嗯 日、年';
  @override
  String get my_invoices => '我的发票';
  @override
  String get no_advisor => '无顾问';
  @override
  String get no_invoices_found => '未找到发票';
  @override
  String get next_pick_schedules => '下一页： 选择时间表';
  @override
  String get no_requests_found => '未找到请求';
  @override
  String get no_schedules_available_for_thi => '该课程没有可用的时间表';
  @override
  String get notes_optional => '注释（可选）';
  @override
  String get no_students_found => '没有找到学生';
  @override
  String get overdue => '逾期';
  @override
  String get paid => '有薪酬的';
  @override
  String get partial => '部分的';
  @override
  String get other => '其他';
  @override
  String get loading => '加载中...';
  @override
  String get pay => '支付';
  @override
  String get preparing_pdf_statement => '正在准备 PDF 声明...';
  @override
  String get pending_review => '待审核';
  @override
  String get registration_requests => '注册请求';
  @override
  String get request_rejected => '请求被拒绝';
  @override
  String get remaining => '其余的';
  @override
  String get reregister => '重新注册';
  @override
  String get requested_courses => '要求的课程';
  @override
  String get review_registration => '审核注册';
  @override
  String get room => '房间';
  @override
  String get sec => '秒';
  @override
  String get select_the_subjects_you_want_t => '选择您要报名的科目';
  @override
  String get review_final_timetable => '审查最终时间表';
  @override
  String get selected_schedule_summary => '选定的时间表摘要';
  @override
  String get semester_requestsemester => '学期：{学期}';
  @override
  String get summaryoverduecount_overdue => '{count} 逾期';
  @override
  String get select_your_courses => '选择您的课程';
  @override
  String get total_invoices => '发票总数';
  @override
  String get sub => '子';
  @override
  String get unassigned_only => '仅未分配';
  @override
  String get unpaid => '未付';
  @override
  String get withdrawn => '撤回';
  @override
  String get you_have_successfully_register => '您已成功注册课程！';
  @override
  String get your_account_is_clearnno_invoi => '你的账目清清楚楚。没有找到发票。';
}

class _TranslationsSharedZh implements TranslationsSharedEn {
  _TranslationsSharedZh._(this._root);

  final TranslationsZh _root;

  @override
  String get no_notifications_yet => '还没有通知';
  @override
  String get notifications_empty => '没有新通知';
  @override
  String get notifications => '通知';
  @override
  String get security_title => '安全设置';
  @override
  String get fingerprint => '指纹';
  @override
  String get biometrics_title => '生物识别技术';
  @override
  String get face_id => '人脸识别';
  @override
  String get enable_biometrics => '启用生物识别技术';
  @override
  String get sessions_title => '活跃会话';
  @override
  String get end_session => '结束会议';
  @override
  String get current_session => '当前会话';
  @override
  String get device => '设备';
  @override
  String get end_all_sessions => '结束所有会话';
  @override
  String get location => '地点';
  @override
  String get last_active => '最后活跃';
  @override
  String get contact_us => '联系我们';
  @override
  String get email_us => '给我们发电子邮件';
  @override
  String get whatsapp => 'WhatsApp';
  @override
  String get call_us => '致电我们';
  @override
  String get support_title => '支持与帮助';
  @override
  String get tutorials_title => '教程和指南';
  @override
  String get faq => '常问问题';
  @override
  String get forums_title => '论坛';
  @override
  String get report_issue => '报告问题';
  @override
  String get create_post => '创建帖子';
  @override
  String get search_forums => '搜索论坛...';
  @override
  String get no_posts => '没有找到帖子';
  @override
  String get placeholder_subtitle => '此部分正在开发中';
  @override
  String get back => '后退';
  @override
  String get placeholder_title => '即将推出';
  @override
  String get under_development => '该功能正在开发中';
  @override
  String get coming_soon => '即将推出';
  @override
  String get retry => '重试';
  @override
  String get transition_title => '加载中...';
  @override
  String get error => '错误';
  @override
  String get close => '关闭';
  @override
  String get cancel => '取消';
  @override
  String get confirm => '确认';
  @override
  String get loading => '加载中...';
  @override
  String get active_sessions => '活跃会话';
  @override
  String get authentication => '验证';
  @override
  String get delete => '删除';
  @override
  String get save => '节省';
  @override
  String get call_hotline => '拨打热线';
  @override
  String get biometric_login => '生物识别登录';
  @override
  String get change_password => '更改密码';
  @override
  String get email_support => '电子邮件支持';
  @override
  String get edit => '编辑';
  @override
  String get device_management => '设备管理';
  @override
  String get forums => '论坛';
  @override
  String get financial_aid => '经济援助';
  @override
  String get it_support => '信息技术支持';
  @override
  String get manage_logged_in_devices => '管理登录设备';
  @override
  String get members => '会员';
  @override
  String get logout => '退出';
  @override
  String get please_wait => '请稍等...';
  @override
  String get library => '图书馆';
  @override
  String get protect_account_with_2fa => '使用 2FA 保护帐户';
  @override
  String get security => '安全';
  @override
  String get threads => '线程数';
  @override
  String get student_affairs => '学生事务';
  @override
  String get support => '支持';
  @override
  String get this_feature_is_under_developm => '该功能正在开发中';
  @override
  String get tutorials => '教程';
  @override
  String get twofactor_auth => '双因素身份验证';
  @override
  String get use_fingerprint_or_face_id => '使用指纹或面容 ID';
  @override
  String get update_your_login_credentials => '更新您的登录凭据';
  @override
  String get biometrics => '生物识别技术';
  @override
  String get view_active_sessions => '查看活动会话';
  @override
  String get sessions => '会议';
  @override
  String get security_section => '安全';
  @override
  String get support_section => '支持';
  @override
  String get tutorials_section => '教程';
  @override
  String get contact_us_section => '联系我们';
  @override
  String get forums_section => '论坛';
  @override
  String get security_access => '安全访问';
  @override
  String get no_new_notifications => '没有新通知';
}

class _TranslationsStudentsZh implements TranslationsStudentsEn {
  _TranslationsStudentsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get department => '部门';
  @override
  String get student_name => '学生姓名';
  @override
  String get college => '大学';
  @override
  String get gpa => '平均绩点';
  @override
  String get student_id => '学生证';
  @override
  String get digital_id_title => '数字身份证';
  @override
  String get level => '等级';
  @override
  String get credits => '制作人员';
  @override
  String get verified => '已验证';
  @override
  String get university => '荷鲁斯大学';
  @override
  String get download_id => '下载ID';
  @override
  String get share_id => '分享ID';
  @override
  String get qr_code => '二维码';
  @override
  String get scan_to_verify => '扫描验证';
  @override
  String get classic_theme => '经典的';
  @override
  String get id_theme => '身份主题';
  @override
  String get gradient_theme => '坡度';
  @override
  String get holographic_theme => '全息';
  @override
  String get dark_matter_theme => '暗物质';
  @override
  String get aurora_theme => '极光';
  @override
  String get neon_pulse_theme => '霓虹灯脉冲';
  @override
  String get dashboard_title => '学生仪表板';
  @override
  String get academic_section => '学术的';
  @override
  String get enrollment_section => '注册';
  @override
  String get utilities_section => '公用事业';
  @override
  String get transcript => '成绩单';
  @override
  String get progress => '学业进步';
  @override
  String get subject_results => '科目结果';
  @override
  String get grades => '成绩';
  @override
  String get courses => '课程';
  @override
  String get schedule => '日程';
  @override
  String get action_plan => '学位计划';
  @override
  String get attendance => '出席率';
  @override
  String get exam_schedule => '考试时间表';
  @override
  String get invoices => '发票';
  @override
  String get registration => '登记';
  @override
  String get payment => '支付';
  @override
  String get security => '安全';
  @override
  String get tutorials => '教程';
  @override
  String get forums => '论坛';
  @override
  String get support => '支持';
  @override
  String get notifications => '通知';
  @override
  String get digital_id => '数字身份证';
  @override
  String get no_lectures_today => '今天没有讲座';
  @override
  String get view_full_schedule => '查看完整时间表';
  @override
  String get quick_stats => '快速统计';
  @override
  String get gpa_label => '平均绩点';
  @override
  String get credits_label => '制作人员';
  @override
  String get level_label => '等级';
  @override
  String get all => '全部';
  @override
  String get upcoming_exams => '即将举行的考试';
  @override
  String get error => '错误';
  @override
  String get back => '后退';
  @override
  String get retry => '重试';
  @override
  String get active => '积极的';
  @override
  String get recent_grades => '最近的成绩';
  @override
  String get artificial_intelligence => '人工智能';
  @override
  String get access_logs => '访问日志';
  @override
  String get daily_schedule => '每日日程';
  @override
  String get download => '下载';
  @override
  String get copy => '复制';
  @override
  String get enrollment_finance => '招生与财务';
  @override
  String get horus_university_1 => '荷鲁斯大学';
  @override
  String get academic => '学术的';
  @override
  String get horus_university => '荷鲁斯大学';
  @override
  String get id_no => '身份证号码';
  @override
  String get nfc_pass => 'NFC通行证';
  @override
  String get identity_active_secure => '身份主动且安全';
  @override
  String get offline_copy => '离线复制';
  @override
  String get send => '发送';
  @override
  String get loading => '加载中...';
  @override
  String get share_identity => '分享身份';
  @override
  String get settings => '设置';
  @override
  String get smart_digital_id => '智能数字身份证';
  @override
  String get student => '学生';
  @override
  String get status => '地位';
  @override
  String get utilities => '公用事业';
  @override
  String get scan_for_secure_access => '扫描安全访问';
}

class _TranslationsExtractedZh implements TranslationsExtractedEn {
  _TranslationsExtractedZh._(this._root);

  final TranslationsZh _root;

  @override
  String get full_name => '姓名';
  @override
  String get personal_info => '个人信息';
  @override
  String get about_me => '关于我';
  @override
  String get account_info => '账户信息';
  @override
  String get national_id => '国民身份证';
  @override
  String get take_photo => '拍照';
  @override
  String get required => '必需的';
  @override
  String get save => '节省';
  @override
  String get email => '电子邮件';
  @override
  String get account_status => '账户状态';
  @override
  String get role => '角色';
  @override
  String get choose_from_gallery => '从图库中选择';
  @override
  String get phone_number => '电话号码';
  @override
  String get user => '用户';
  @override
  String get account => '帐户';
  @override
  String get appearance => '外貌';
  @override
  String get edit_profile => '编辑个人资料';
  @override
  String get save_changes => '保存更改';
  @override
  String get notifications => '通知';
  @override
  String get dark_mode => '深色模式';
  @override
  String get toggle_between_dark_and_light_mode => '在深色和浅色模式之间切换';
  @override
  String get about => '关于';
  @override
  String get send_password_recovery_link_to_your_emai => '将密码恢复链接发送到您的电子邮件';
  @override
  String get current_classic_design => '当前： 经典设计';
  @override
  String get active => '积极的';
  @override
  String get current_glass_design => '当前： 玻璃设计';
  @override
  String get language_region => '语言及地区';
  @override
  String get write_something_about_yourself => '写一些关于你自己的事情...';
  @override
  String get password_recovery => '密码恢复';
  @override
  String get update_your_personal_info_and_photo => '更新您的个人信息和照片';
  @override
  String get battery_saver_mode => '省电模式';
  @override
  String get kSwitch => '转变';
  @override
  String get notification_center => '通知中心';
  @override
  String get send_a_test_notification => '发送测试通知';
  @override
  String get change_profile_photo => '更改个人资料照片';
  @override
  String get ui_style => '用户界面风格';
  @override
  String get notifications_are_off => '通知已关闭';
  @override
  String get remove_photo => '删除照片';
  @override
  String get support_feedback => '支持与反馈';
  @override
  String get app_notifications => '应用程序通知';
  @override
  String get notifications_are_active => '通知已激活';
  @override
  String get app_language => '应用程序语言';
  @override
  String get support_center => '支持中心';
  @override
  String get send_feedback => '发送反馈';
  @override
  String get thank_you_for_your_support => '感谢您的支持！ 🎉';
  @override
  String get privacy_policy => '隐私政策';
  @override
  String get terms_and_rules_for_data_usage => '数据使用条款和规则';
  @override
  String get version_details_and_developer_info => '版本详细信息和开发者信息';
  @override
  String get email_support => '电子邮件支持';
  @override
  String get log_out => '退出';
  @override
  String get about_app => '关于应用程序';
  @override
  String get how_can_we_help_you => '我们能为您提供什么帮助？';
  @override
  String get call_hotline => '拨打热线';
  @override
  String get write_your_feedback_here => '在这里写下您的反馈...';
  @override
  String get submit_feedback => '提交反馈';
  @override
  String get add_department => '添加部门';
  @override
  String get students => '学生';
  @override
  String get departments => '部门';
  @override
  String get est => '预计。';
  @override
  String get department_name_ar => '部门名称（AR）';
  @override
  String get chat_with_us_on_whatsapp => '通过 WhatsApp 与我们聊天';
  @override
  String get thank_you_feedback_submitted => '✅ 谢谢！已提交反馈。';
  @override
  String get add_new_department => '添加新部门';
  @override
  String get your_support_matters => '⭐ 您的支持很重要';
  @override
  String get rate_the_app => '评价应用程序';
  @override
  String get test_notification => '测试通知';
  @override
  String get test_notification_sent => '测试通知已发送！';
  @override
  String get staff => '职员';
  @override
  String get add => '添加';
  @override
  String get building => '建筑';
  @override
  String get cancel => '取消';
  @override
  String get description => '描述';
  @override
  String get get_help_and_resolve_any_issues => '获得帮助并解决任何问题';
  @override
  String get disable_complex_visual_effects => '禁用复杂的视觉效果';
  @override
  String get view_all_your_notifications => '查看您的所有通知';
  @override
  String get your_opinion_helps_us_improve => '您的意见有助于我们改进';
  @override
  String get remove => '消除';
  @override
  String get asst => '助理。';
  @override
  String get share_your_thoughts_to_help_improve_the_ => '分享您的想法以帮助改进应用程序';
  @override
  String get confirm_removal => '确认删除';
  @override
  String get roles_management => '角色管理';
  @override
  String get head => '头';
  @override
  String get custom => '风俗';
  @override
  String get create_role => '创建角色';
  @override
  String get no_results => '没有结果';
  @override
  String get merge_roles => '合并角色';
  @override
  String get assistant_head => '副主任';
  @override
  String get add_faculty_member => '添加教员';
  @override
  String get search_roles => '搜索角色...';
  @override
  String get add_staff => '添加员工';
  @override
  String get create => '创造';
  @override
  String get department_name_en => '部门名称（英文）';
  @override
  String get no_assistant_assigned => '没有分配助理';
  @override
  String get department_code => '部门代码';
  @override
  String get add_faculty => '添加教师';
  @override
  String get merge => '合并';
  @override
  String remove_staff_fullname_from_this_departme({
    required Object staffFullName,
  }) => '将${staffFullName}从该部门中删除？';
  @override
  String get no_faculty_members_assigned => '没有分配教职人员';
  @override
  String get create_a_new_role_or_merge_two_roles => '创建新角色或合并两个角色';
  @override
  String get could_not_load_custom_roles => '无法加载自定义角色';
  @override
  String get please_assign_an_assistant_head_for_the_ => '请指派一名部门助理主任';
  @override
  String get category => '类别';
  @override
  String get make_sure_roles_table_exists_in_supabase => '确保 Supabase 中存在“角色”表';
  @override
  String get permissions => '权限';
  @override
  String get name_english => '姓名（英文）';
  @override
  String get role_created => '角色已创建';
  @override
  String get description_arabic => '说明（阿拉伯语）';
  @override
  String get description_english => '说明（英文）';
  @override
  String get no_roles => '没有角色';
  @override
  String get merge_two_roles => '合并两个角色';
  @override
  String get create_new_role => '创建新角色';
  @override
  String get first_role => '第一个角色';
  @override
  String get name_arabic => '姓名（阿拉伯语）';
  @override
  String get second_role => '第二个角色';
  @override
  String get no_custom_roles_yet => '还没有自定义角色';
  @override
  String get edit_role => '编辑角色';
  @override
  String get delete_role => '删除角色';
  @override
  String get facilities => '设施';
  @override
  String get student_affairs => '学生事务';
  @override
  String get teaching => '教学';
  @override
  String get leadership => '领导';
  @override
  String get admin_it => '行政与信息技术';
  @override
  String get external => '外部的';
  @override
  String get quick_actions => '快速行动';
  @override
  String get delete => '删除';
  @override
  String get merged => '合并';
  @override
  String get user_details => '用户详细信息';
  @override
  String get verification => '确认';
  @override
  String get tags => '标签';
  @override
  String get danger_zone => '危险区';
  @override
  String get warning_level => '警告级别';
  @override
  String get activate => '激活';
  @override
  String get verified => '已验证';
  @override
  String get banned => '禁止';
  @override
  String get verify => '核实';
  @override
  String get unban => '解禁';
  @override
  String get permissions_1 => '权限：';
  @override
  String get deactivate => '停用';
  @override
  String get unverify => '取消验证';
  @override
  String delete_role_nameen_this_cannot_be_undone({
    required Object roleNameEn,
  }) => '删除“${roleNameEn}”？此操作无法撤消。';
  @override
  String get role_updated => '角色更新';
  @override
  String get ban_management => '禁令管理';
  @override
  String get ban => '禁止';
  @override
  String get not_verified => '未验证';
  @override
  String get created => '已创建';
  @override
  String get current_level => '当前级别';
  @override
  String get no_tags_assigned => '没有分配标签';
  @override
  String get nationality => '国籍';
  @override
  String get add_tag => '添加标签';
  @override
  String get last_login => '上次登录';
  @override
  String get merged_role_name_arabic => '合并的角色名称（阿拉伯语）';
  @override
  String get merged_role_name_english => '合并后的角色名称（英文）';
  @override
  String get merged_permissions_preview => '合并权限预览';
  @override
  String get roles_merged_successfully => '角色合并成功';
  @override
  String get select_two_roles_to_combine_their_permis => '选择两个角色来组合他们的权限';
  @override
  String get ban_user => '禁止用户';
  @override
  String get permanently_delete => '永久删除';
  @override
  String get verify_account => '验证账户';
  @override
  String unban_user_fullname({required Object userFullName}) =>
      '解禁${userFullName}？';
  @override
  String get user_has_normal_access => '用户可以正常访问';
  @override
  String get soft_delete_deactivate => '软删除（停用）';
  @override
  String get remove_verification => '删除验证';
  @override
  String get not_banned => '未禁止';
  @override
  String verify_user_fullname({required Object userFullName}) =>
      '验证${userFullName}';
  @override
  String get account_verified => '账户已验证';
  @override
  String get user_banned => '用户被禁止';
  @override
  String get tag_name => '标签名称';
  @override
  String warning_level_set_to_level({required Object level}) =>
      '警告级别设置为${level}';
  @override
  String get tag_removed => '标签已删除';
  @override
  String get unban_user => '解封用户';
  @override
  String ban_user_fullname_they_will_lose_system_({
    required Object userFullName,
  }) => '禁止${userFullName}？他们将失去系统访问权限。';
  @override
  String get identity_not_yet_verified => '身份尚未验证';
  @override
  String get user_identity_has_been_verified => '用户身份已验证';
  @override
  String remove_verification_from_user_fullname({
    required Object userFullName,
  }) => '从${userFullName}中删除验证？';
  @override
  String get institution => '机构';
  @override
  String get user_cannot_access_the_system => '用户无法访问系统';
  @override
  String get exceeding => '超越';
  @override
  String get top_5 => '前 5%';
  @override
  String get total => '全部的';
  @override
  String get grade => '年级';
  @override
  String get college_is_required => '需要大学学历';
  @override
  String out_of_max({required Object max}) => '超出${max}';
  @override
  String deactivate_user_fullname({required Object userFullName}) =>
      '停用${userFullName}';
  @override
  String get select_college => '选择学院';
  @override
  String get select_department => '选择部门';
  @override
  String get department_is_required => '部门为必填项';
  @override
  String permanently_delete_user_fullname_this_ca({
    required Object userFullName,
  }) => '永久删除${userFullName}？这无法撤销！';
  @override
  String get soft_delete => '软删除';
  @override
  String get permanent_delete => '永久删除';
}

class _TranslationsOnboardingLanguageZh
    implements TranslationsOnboardingLanguageEn {
  _TranslationsOnboardingLanguageZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '选择你的语言';
  @override
  String get subtitle => '选择你喜欢的界面语言';
  @override
  String get english => '英语';
  @override
  String get arabic => '阿拉伯语';
  @override
  String get german => '德语';
  @override
  String get chinese => '中文';
  @override
  String get hint => '你以后可以在设置中更改此设置';
}

class _TranslationsOnboardingFacultiesDirectoryZh
    implements TranslationsOnboardingFacultiesDirectoryEn {
  _TranslationsOnboardingFacultiesDirectoryZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '我们的学院';
  @override
  String get subtitle => '探索我们多样化的学术部门';
}

class _TranslationsOnboardingStyleZh implements TranslationsOnboardingStyleEn {
  _TranslationsOnboardingStyleZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '选择你的风格';
  @override
  String get subtitle => '选择你喜欢的界面设计';
  @override
  late final _TranslationsOnboardingStyleClassicZh classic =
      _TranslationsOnboardingStyleClassicZh._(_root);
  @override
  late final _TranslationsOnboardingStyleGlassZh glass =
      _TranslationsOnboardingStyleGlassZh._(_root);
}

class _TranslationsOnboardingThemeZh implements TranslationsOnboardingThemeEn {
  _TranslationsOnboardingThemeZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '选择一个主题';
  @override
  String get subtitle => '明亮或黑暗，由你选择';
  @override
  String get light => '明亮';
  @override
  String get dark => '黑暗';
}

class _TranslationsAuthLoginZh implements TranslationsAuthLoginEn {
  _TranslationsAuthLoginZh._(this._root);

  final TranslationsZh _root;

  @override
  String get welcome => '欢迎回来';
  @override
  String get subtitle => '登录以继续';
  @override
  String get email => '电子邮件';
  @override
  String get password => '密码';
  @override
  String get forgot_password => '忘记密码？';
  @override
  String get submit => '登录';
  @override
  String get guest => '作为访客浏览';
}

class _TranslationsAuthForgotPasswordZh
    implements TranslationsAuthForgotPasswordEn {
  _TranslationsAuthForgotPasswordZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '忘记密码';
  @override
  String get subtitle => '选择恢复方法';
  @override
  String get method_admin => '访问管理部门';
  @override
  String get method_online => '在线申请';
  @override
  String get admin_instructions => '请前往学生事务办公室重置密码。请携带有效的大学身份证件。';
  @override
  String get phone_label => '电话号码';
  @override
  String get upload_id => '上传证件照';
  @override
  String get upload_id_hint => '点击上传清晰的大学身份证照片';
  @override
  String get submit => '提交申请';
  @override
  String get back => '返回登录';
  @override
  String get error_empty_phone => '请输入你的电话号码';
  @override
  String get error_empty_email => '请输入你的电子邮件';
  @override
  String get error_no_id => '请上传你的证件照';
  @override
  String get success => '申请提交成功';
  @override
  String get id_uploaded => '证件已上传';
  @override
  String get choose_account_recovery_method => '选择帐户恢复方法';
  @override
  String get back_to_login => '返回登录';
}

class _TranslationsHomeTabsZh implements TranslationsHomeTabsEn {
  _TranslationsHomeTabsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get home => '首页';
  @override
  String get search => '搜索';
  @override
  String get notifications => '通知';
  @override
  String get profile => '个人资料';
  @override
  String get admin => '行政';
  @override
  String get colleges => '学院';
  @override
  String get student => '学生';
}

class _TranslationsDashboardIdCardZh implements TranslationsDashboardIdCardEn {
  _TranslationsDashboardIdCardZh._(this._root);

  final TranslationsZh _root;

  @override
  String get student_name => '学生姓名';
  @override
  String get college => '学院';
  @override
  String get id => '学号';
  @override
  String get gpa => '平均绩点';
  @override
  String get level => '级别';
  @override
  String get verified => '已认证';
}

class _TranslationsDashboardSectionsZh
    implements TranslationsDashboardSectionsEn {
  _TranslationsDashboardSectionsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get academic => '学术';
  @override
  String get enrollment => '注册';
  @override
  String get utilities => '工具';
}

class _TranslationsDashboardItemsZh implements TranslationsDashboardItemsEn {
  _TranslationsDashboardItemsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get transcript => '成绩单';
  @override
  String get progress => '学习进度';
  @override
  String get action_plan => '行动计划';
  @override
  String get subject_result => '科目成绩';
  @override
  String get grades => '评分';
  @override
  String get courses => '课程';
  @override
  String get registration => '选课注册';
  @override
  String get invoices => '未付账单';
  @override
  String get payment => '支付';
  @override
  String get tutorials => '教程';
  @override
  String get security => '安全';
  @override
  String get forums => '论坛';
  @override
  String get support => '支持';
  @override
  String get notifications => '通知';
  @override
  String get no_lectures => '未找到课程';
  @override
  String get digital_id => '数字身份证';
}

class _TranslationsDashboardLabelsZh implements TranslationsDashboardLabelsEn {
  _TranslationsDashboardLabelsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get university_name => '休大学 (HUE UNIVERSITY)';
  @override
  String get id_short => '学号';
  @override
  String get gpa_short => '平均绩点';
  @override
  String get level_short => '级别';
}

class _TranslationsSettingsSectionsZh
    implements TranslationsSettingsSectionsEn {
  _TranslationsSettingsSectionsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get account => '账户';
  @override
  String get display => '显示';
  @override
  String get notifications => '通知';
  @override
  String get about => '关于';
}

class _TranslationsSettingsTilesZh implements TranslationsSettingsTilesEn {
  _TranslationsSettingsTilesZh._(this._root);

  final TranslationsZh _root;

  @override
  String get edit_profile => '编辑资料';
  @override
  String get change_password => '修改密码';
  @override
  String get dark_mode => '深色模式';
  @override
  String get language => '语言';
  @override
  String get ui_style => '界面风格';
  @override
  String get app_notifications => '应用通知';
  @override
  String get test_notifications => '测试通知';
  @override
  String get about_app => '关于应用';
  @override
  String get privacy_policy => '隐私政策';
  @override
  String get logout => '退出登录';
}

class _TranslationsSettingsMessagesZh
    implements TranslationsSettingsMessagesEn {
  _TranslationsSettingsMessagesZh._(this._root);

  final TranslationsZh _root;

  @override
  String get switching_theme => '正在切换主题...';
  @override
  String get changing_language => '正在更改语言...';
  @override
  String get rebuilding_design => '正在重建设计系统...';
}

class _TranslationsCollegesDetailsZh implements TranslationsCollegesDetailsEn {
  _TranslationsCollegesDetailsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get dean => '院長';
  @override
  String get staff => '学术人员';
  @override
  String get view_all => '查看全部';
  @override
  String get departments => '系别';
  @override
  String get explore_majors => '探索可用专业';
  @override
  String get majors => '专业';
  @override
  String get dean_title => '院长';
  @override
  String get staff_member => '教职员工';
  @override
  String get vice_dean => '副院长';
  @override
  String get head_of_dept => '系主任';
  @override
  String get assoc_prof => '副教授';
  @override
  String get academic_statistics => '学术统计';
  @override
  String get students => '学生';
  @override
  String get academic_staff => '学术人员';
  @override
  String get teaching_assistants => '助教';
  @override
  String get published_articles => '已发表文章';
}

class _TranslationsCollegesDepartmentsZh
    implements TranslationsCollegesDepartmentsEn {
  _TranslationsCollegesDepartmentsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get medical_laboratories_technology => '医学检验技术';
  @override
  String get radiology_and_imaging_technology => '放射与影像技术';
  @override
  String get respiratory_care_technology => '呼吸治疗技术';
  @override
  String get dental_prosthetics_technology => '口腔修复技术';
  @override
  String get health_administration_and_informatics_technology => '健康管理与信息技术';
  @override
  String get accounting => '会计学';
  @override
  String get business_management => '工商管理';
  @override
  String get economics => '经济学';
  @override
  String get marketing => '市场营销';
  @override
  String get accounting_program_english => '会计学项目（英语）';
  @override
  String get business_administration_program_english => '工商管理项目（英语）';
  @override
  String get basic_sciences_in_dentistry => '牙科基础科学';
  @override
  String get basic_medical_and_clinical_sciences => '基础医学与临床科学';
  @override
  String get oral_and_maxillofacial_surgery => '口腔颌面外科';
  @override
  String get orthodontics_and_pediatric_dentistry => '正畸与儿童牙科';
  @override
  String get periodontics_and_oral_medicine => '牙周病与口腔医学';
  @override
  String get prosthodontics => '口腔修复学';
  @override
  String get conservative_dentistry_and_endodontics => '牙科保守治疗与牙髓病学';
  @override
  String get architectural_engineering => '建筑工程';
  @override
  String get basic_sciences => '基础科学';
  @override
  String get civil_engineering => '土木工程';
  @override
  String get mechanical_engineering => '机械工程';
  @override
  String get electrical_engineering => '电气工程';
  @override
  String get artificial_intelligence_engineering => '人工智能工程';
  @override
  String get interior_design_and_architecture => '室内设计与建筑';
  @override
  String get furniture_design_and_production_technology => '家具设计与生产技术';
  @override
  String get graphics_and_digital_arts => '平面与数字艺术';
  @override
  String get animation_and_multimedia => '动画与多媒体';
  @override
  String get medical_education => '医学教育';
  @override
  String get histology_and_cell_biology => '组织学与细胞生物学';
  @override
  String get clinical_pharmacy => '临床药学';
  @override
  String get human_anatomy_and_embryology => '人体解剖学与胚胎学';
  @override
  String get medical_physiology => '医学生理学';
  @override
  String get medical_microbiology_and_immunology => '医学微生物学与免疫学';
  @override
  String get forensic_medicine_and_toxicology => '法医学与毒理学';
  @override
  String get community_medicine_and_public_health => '社区医学与公共卫生';
  @override
  String get biochemistry => '生物化学';
  @override
  String get pathology => '病理学';
  @override
  String get english_language_program => '英语语言项目';
  @override
  String get german_language_program => '德语语言项目';
  @override
  String get chinese_language_program => '汉语语言项目';
  @override
  String get french_department => '法语系';
  @override
  String get translation_department => '翻译系';
  @override
  String get pharmaceutical_chemistry => '药物化学';
  @override
  String get pharmacology_and_biochemistry => '药理学与生物化学';
  @override
  String get pharmacognosy => '生药学';
  @override
  String get microbiology_and_immunology => '微生物学与免疫学';
  @override
  String get pharmaceutical_technology => '制药技术';
  @override
  String get pharmacy_practice => '药剂实践';
  @override
  String get basic_sciences_pt => '物理治疗基础科学';
  @override
  String get biomechanics => '生物力学';
  @override
  String get pt_internal_medicine_and_geriatrics => '内科与老年物理治疗';
  @override
  String get pt_womens_health => '女性健康物理治疗';
  @override
  String get pt_surgery_and_integumentary => '外科物理治疗';
  @override
  String get pt_orthopedics => '骨科物理治疗';
  @override
  String get pt_neurology => '神经物理治疗';
  @override
  String get pt_pediatrics => '儿科物理治疗';
  @override
  String get artificial_biomedical_computing => '人工智能生物医学计算';
  @override
  String get artificial_cybersecurity => '人工智能网络安全';
  @override
  String get ai_and_data_science => '人工智能与数据科学';
  @override
  String get ai_for_robotics => '机器人人工智能';
  @override
  String get smart_systems => '智能系统';
}

class _TranslationsTranscriptOverviewZh
    implements TranslationsTranscriptOverviewEn {
  _TranslationsTranscriptOverviewZh._(this._root);

  final TranslationsZh _root;

  @override
  String get gpa => '累计 GPA';
  @override
  String get credits => '已修学分';
  @override
  String get standing => '学术状态';
  @override
  String get active => '状态良好';
}

class _TranslationsTranscriptSemesterZh
    implements TranslationsTranscriptSemesterEn {
  _TranslationsTranscriptSemesterZh._(this._root);

  final TranslationsZh _root;

  @override
  String get fall => '秋季学期';
  @override
  String get spring => '春季学期';
  @override
  String get summer => '夏季学期';
}

class _TranslationsTranscriptCourseZh
    implements TranslationsTranscriptCourseEn {
  _TranslationsTranscriptCourseZh._(this._root);

  final TranslationsZh _root;

  @override
  String get grade => '成绩';
  @override
  String get credits => '学分';
  @override
  late final _TranslationsTranscriptCourseStatusZh status =
      _TranslationsTranscriptCourseStatusZh._(_root);
}

class _TranslationsAcademicProgressCategoriesZh
    implements TranslationsAcademicProgressCategoriesEn {
  _TranslationsAcademicProgressCategoriesZh._(this._root);

  final TranslationsZh _root;

  @override
  String get university => '大学要求';
  @override
  String get faculty => '学院要求';
  @override
  String get major => '专业要求';
  @override
  String get electives => '选修课';
  @override
  String get university_name => '荷鲁斯大学';
}

class _TranslationsAcademicProgressStatusZh
    implements TranslationsAcademicProgressStatusEn {
  _TranslationsAcademicProgressStatusZh._(this._root);

  final TranslationsZh _root;

  @override
  String get completed => '已完成';
  @override
  String get in_progress => '进行中';
  @override
  String get remaining => '剩余';
  @override
  String get requirement_met => '要求已满足';
}

class _TranslationsAttendanceSubjectsZh
    implements TranslationsAttendanceSubjectsEn {
  _TranslationsAttendanceSubjectsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get ai => '人工智能';
  @override
  String get machine_learning => '机器学习';
  @override
  String get calculus => '高级微积分';
  @override
  String get ethics => 'IT 道德';
}

class _TranslationsAdministrationAuditLogsZh
    implements TranslationsAdministrationAuditLogsEn {
  _TranslationsAdministrationAuditLogsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '审核日志';
  @override
  late final _TranslationsAdministrationAuditLogsLabelsZh labels =
      _TranslationsAdministrationAuditLogsLabelsZh._(_root);
  @override
  late final _TranslationsAdministrationAuditLogsTabsZh tabs =
      _TranslationsAdministrationAuditLogsTabsZh._(_root);
  @override
  String get no_logs_found => '未找到符合条件的日志。';
}

class _TranslationsProfessorStatsZh implements TranslationsProfessorStatsEn {
  _TranslationsProfessorStatsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get groups => '团体';
  @override
  String get students => '学生总数';
  @override
  String get tas => '助教';
  @override
  String get rating => '等级';
  @override
  String get shared_files => '共享文件';
  @override
  String get office_hours => '办公时间';
}

class _TranslationsProfessorQuickActionsZh
    implements TranslationsProfessorQuickActionsEn {
  _TranslationsProfessorQuickActionsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get urgent => '紧迫的';
  @override
  String get upload => '上传';
  @override
  String get message => '信息';
  @override
  String get action_clicked => '点击';
}

class _TranslationsProfessorProfileZh
    implements TranslationsProfessorProfileEn {
  _TranslationsProfessorProfileZh._(this._root);

  final TranslationsZh _root;

  @override
  String get urgent_announcements => '紧急公告';
  @override
  String get teaching_assistants => '助教';
  @override
  String get shared_resources => '共享资源';
  @override
  String get office_hours => '办公时间';
}

class _TranslationsRolesCategoriesZh implements TranslationsRolesCategoriesEn {
  _TranslationsRolesCategoriesZh._(this._root);

  final TranslationsZh _root;

  @override
  String get admin_it => '行政与信息技术';
  @override
  String get academic_leadership => '学术领导力';
  @override
  String get teaching_staff => '师资队伍';
  @override
  String get student_affairs => '学生事务';
  @override
  String get facilities_security => '设施与安全';
  @override
  String get student_roles => '学生角色';
  @override
  String get external_roles => '外部角色';
}

class _TranslationsRolesNamesZh implements TranslationsRolesNamesEn {
  _TranslationsRolesNamesZh._(this._root);

  final TranslationsZh _root;

  @override
  String get super_admin => '超级管理员';
  @override
  String get financial_auditor => '财务审计师';
  @override
  String get it_support => '信息技术支持';
  @override
  String get dean => '院长';
  @override
  String get academic_coordinator => '学术协调员';
  @override
  String get rector => '校长/主席';
  @override
  String get department_head => '系主任';
  @override
  String get admin => '行政人员';
  @override
  String get professor => '教授/讲师';
  @override
  String get lecturer => '讲师';
  @override
  String get teaching_assistant => '助教';
  @override
  String get registrar_officer => '登记官';
  @override
  String get academic_advisor => '学术顾问';
  @override
  String get freshman => '新生';
  @override
  String get dorm_supervisor => '宿舍主管';
  @override
  String get student => '学生';
  @override
  String get librarian => '图书管理员';
  @override
  String get class_representative => '班代表';
  @override
  String get parent => '家长/监护人';
  @override
  String get security_officer => '保安员';
  @override
  String get guest => '客人';
  @override
  String get alumni => '校友';
  @override
  String get recruiter => '招聘人员';
  @override
  String get regular_student => '普通学生';
}

class _TranslationsRolesDescriptionsZh
    implements TranslationsRolesDescriptionsEn {
  _TranslationsRolesDescriptionsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get it_support => '技术系统支持与维护';
  @override
  String get super_admin => '完全控制整个系统';
  @override
  String get admin => '具有高权限的系统管理员';
  @override
  String get financial_auditor => '监督财务记录和发票';
  @override
  String get rector => '大学校长拥有全面的学术监督权';
  @override
  String get dean => '学院/学院院长';
  @override
  String get department_head => '学术部门负责人';
  @override
  String get academic_coordinator => '协调学术课程和日程安排';
  @override
  String get professor => '教授和管理课程的教员';
  @override
  String get lecturer => '在没有完全教授特权的情况下教授课程';
  @override
  String get teaching_assistant => '协助教授进行评分、实验室和教程';
  @override
  String get registrar_officer => '管理学生入学和注册';
  @override
  String get librarian => '管理图书馆资源和资料';
  @override
  String get regular_student => '拥有所有标准学术特权的正式学生';
  @override
  String get alumni => '访问权限有限的毕业生';
  @override
  String get class_representative => '代表班级的学生领袖';
  @override
  String get student => '一般学生角色';
  @override
  String get academic_advisor => '指导学生完成学业规划';
  @override
  String get security_officer => '校园安全和访问控制';
  @override
  String get parent => '可以查看链接的学生进度和成绩';
  @override
  String get freshman => '系统访问权限有限的一年级学生';
  @override
  String get dorm_supervisor => '管理学生宿舍运营';
  @override
  String get guest => '具有最小访问权限的临时访客';
  @override
  String get recruiter => '外部招聘机构';
}

class _TranslationsOnboardingStyleClassicZh
    implements TranslationsOnboardingStyleClassicEn {
  _TranslationsOnboardingStyleClassicZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '经典';
  @override
  String get desc => '干净、简单且熟悉的 Material 设计';
}

class _TranslationsOnboardingStyleGlassZh
    implements TranslationsOnboardingStyleGlassEn {
  _TranslationsOnboardingStyleGlassZh._(this._root);

  final TranslationsZh _root;

  @override
  String get title => '玻璃';
  @override
  String get desc => '现代、半透明且充满活力的美学';
}

class _TranslationsTranscriptCourseStatusZh
    implements TranslationsTranscriptCourseStatusEn {
  _TranslationsTranscriptCourseStatusZh._(this._root);

  final TranslationsZh _root;

  @override
  String get completed => '已完成';
  @override
  String get transferred => '转学分';
}

class _TranslationsAdministrationAuditLogsLabelsZh
    implements TranslationsAdministrationAuditLogsLabelsEn {
  _TranslationsAdministrationAuditLogsLabelsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get record => '记录';
  @override
  String get actor => '演员';
  @override
  String get table => '桌子';
  @override
  String get action => '行动';
  @override
  String get old_data => '旧数据';
  @override
  String get notes => '笔记';
  @override
  String get new_data => '新数据';
  @override
  String get performed_by => '表演者';
  @override
  String get close_details => '关闭详情';
  @override
  String get view_details => '查看详情';
}

class _TranslationsAdministrationAuditLogsTabsZh
    implements TranslationsAdministrationAuditLogsTabsEn {
  _TranslationsAdministrationAuditLogsTabsZh._(this._root);

  final TranslationsZh _root;

  @override
  String get security => '安全';
  @override
  String get all => '所有日志';
  @override
  String get user_management => '用户管理';
  @override
  String get data_updates => '数据更新';
}

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
          'welcome.welcome_to_the_smart_universit' => '欢迎来到智慧大学',
          'welcome.i_already_have_an_account' => '我已经有一个帐户',
          'welcome.student_portal' => '学生门户',
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
          'onboarding.choose_app_theme' => '选择您的主题',
          'onboarding.you_can_change_this_later_in_s' => '您可以稍后在“设置”中更改此设置',
          'onboarding.choose_language' => '选择您的语言',
          'onboarding.high_performance_flat_solid_co' => '高性能平面纯色',
          'onboarding.you_can_switch_styles_later_in' => '您可以稍后在“设置”中切换样式',
          'onboarding.recommended' => '受到推崇的',
          'onboarding.select_the_lighting_that_suits' => '选择最适合您的照明',
          'onboarding.dark_mode' => '深色模式',
          'onboarding.classic_solid' => '经典的',
          'onboarding.title' => '入职',
          'onboarding.modern_glass' => '现代玻璃',
          'onboarding.choose_app_style' => '选择您的应用程序风格',
          'onboarding.premium_frosted_glass_blur_eff' => '优质磨砂玻璃模糊效果',
          'onboarding.almost_there_just_one_more_ste' => '快到了！只需多一步。',
          'onboarding.light_mode' => '灯光模式',
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
          'auth.forgot_password.admin_instructions' =>
            '请前往学生事务办公室重置密码。请携带有效的大学身份证件。',
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
          'auth.forgot_password.choose_account_recovery_method' => '选择帐户恢复方法',
          'auth.forgot_password.back_to_login' => '返回登录',
          'auth.back' => '后退',
          'auth.choose_account_recovery_method' => '选择帐户恢复方法',
          'home.tabs.home' => '首页',
          'home.tabs.search' => '搜索',
          'home.tabs.notifications' => '通知',
          'home.tabs.profile' => '个人资料',
          'home.tabs.admin' => '行政',
          'home.tabs.colleges' => '学院',
          'home.tabs.student' => '学生',
          'home.prof' => '教授',
          'home.admin' => '行政',
          'home.faculty_portal' => '教师门户',
          'home.student' => '学生',
          'home.home' => '家',
          'home.student_portal' => '学生门户',
          'home.colleges' => '学院',
          'home.admin_portal' => '管理门户',
          'dashboard.id_card.student_name' => '学生姓名',
          'dashboard.id_card.college' => '学院',
          'dashboard.id_card.id' => '学号',
          'dashboard.id_card.gpa' => '平均绩点',
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
          'dashboard.items.digital_id' => '数字身份证',
          'dashboard.labels.university_name' => '休大学 (HUE UNIVERSITY)',
          'dashboard.labels.id_short' => '学号',
          'dashboard.labels.gpa_short' => '平均绩点',
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
          'settings.tiles.test_notifications' => '测试通知',
          'settings.tiles.about_app' => '关于应用',
          'settings.tiles.privacy_policy' => '隐私政策',
          'settings.tiles.logout' => '退出登录',
          'settings.messages.switching_theme' => '正在切换主题...',
          'settings.messages.changing_language' => '正在更改语言...',
          'settings.messages.rebuilding_design' => '正在重建设计系统...',
          'settings.about_app' => '关于应用程序',
          'settings.user' => '用户',
          'settings.university' => '荷鲁斯大学',
          'settings.developer' => '开发商',
          'settings.backend' => '后端',
          'settings.passwords_do_not_match' => '密码不匹配',
          'settings.platform' => '平台',
          'settings.hue_portal_is_a_comprehensive_' =>
            'HUE Portal是一个综合性的智慧大学管理系统。',
          'settings.enter_your_new_password' => '在下面输入您的新密码',
          'settings.password_changed_successfully' => '密码修改成功',
          'settings.new_password' => '新密码',
          'settings.horus_university' => '荷鲁斯大学 - 埃及',
          'settings.password_must_be_at_least_6_ch' => '密码必须至少为 6 个字符',
          'settings.please_fill_all_fields' => '请填写所有字段',
          'settings.privacy_policy' => '隐私政策',
          'settings.confirm_password' => '确认密码',
          'settings.last_updated_february_2026' => '最后更新时间：2026 年 2 月',
          'settings.change_password' => '更改密码',
          'settings.edit_profile' => '编辑个人资料',
          'settings.save' => '节省',
          'settings.phone' => '电话',
          'settings.email' => '电子邮件',
          'settings.bio' => '简介',
          'settings.update_your_info_and_contact_d' => '更新您的信息和联系方式',
          'settings.full_name' => '姓名',
          'settings.send_a_test_notification' => '发送测试通知',
          'settings.toggle_between_dark_and_light_' => '在深色和浅色模式之间切换',
          'settings.change_password_and_security_l' => '更改密码和安全级别',
          'settings.current_glass_design' => '当前： 玻璃设计',
          'settings.switch_style' => '开关样式',
          'settings.control_the_types_of_incoming_' => '控制传入通知的类型',
          'settings.forgot_password' => '忘记密码',
          'settings.role' => '角色',
          'settings.test_notification_successful' => '测试通知发送成功！',
          'settings.send_password_recovery_link_to' => '将密码恢复链接发送到您的电子邮件',
          'settings.current_classic_design' => '当前： 经典设计',
          'settings.battery_saver_mode' => '省电模式',
          'settings.disable_complex_visual_effects' => '禁用复杂的视觉效果以获得更好的性能',
          'settings.help_support_center' => '帮助与支持中心',
          'settings.contact_us_to_resolve_any_issu' => '联系我们解决任何问题',
          'settings.version_details_and_developers' => '版本详细信息和开发者信息',
          'settings.select_app_language' => '选择应用程序语言',
          'settings.terms_and_rules_for_data_usage' => '数据使用条款和规则',
          'settings.deutsch' => '德语',
          'settings.dynamic_val' => '动态的',
          'settings.kSwitch' => '转变',
          'settings.switch_label' => '转变',
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
          'colleges.departments.health_administration_and_informatics_technology' =>
            '健康管理与信息技术',
          'colleges.departments.accounting' => '会计学',
          'colleges.departments.business_management' => '工商管理',
          'colleges.departments.economics' => '经济学',
          'colleges.departments.marketing' => '市场营销',
          'colleges.departments.accounting_program_english' => '会计学项目（英语）',
          'colleges.departments.business_administration_program_english' =>
            '工商管理项目（英语）',
          'colleges.departments.basic_sciences_in_dentistry' => '牙科基础科学',
          'colleges.departments.basic_medical_and_clinical_sciences' =>
            '基础医学与临床科学',
          'colleges.departments.oral_and_maxillofacial_surgery' => '口腔颌面外科',
          'colleges.departments.orthodontics_and_pediatric_dentistry' =>
            '正畸与儿童牙科',
          'colleges.departments.periodontics_and_oral_medicine' => '牙周病与口腔医学',
          'colleges.departments.prosthodontics' => '口腔修复学',
          'colleges.departments.conservative_dentistry_and_endodontics' =>
            '牙科保守治疗与牙髓病学',
          'colleges.departments.architectural_engineering' => '建筑工程',
          'colleges.departments.basic_sciences' => '基础科学',
          'colleges.departments.civil_engineering' => '土木工程',
          'colleges.departments.mechanical_engineering' => '机械工程',
          'colleges.departments.electrical_engineering' => '电气工程',
          'colleges.departments.artificial_intelligence_engineering' =>
            '人工智能工程',
          'colleges.departments.interior_design_and_architecture' => '室内设计与建筑',
          'colleges.departments.furniture_design_and_production_technology' =>
            '家具设计与生产技术',
          'colleges.departments.graphics_and_digital_arts' => '平面与数字艺术',
          'colleges.departments.animation_and_multimedia' => '动画与多媒体',
          'colleges.departments.medical_education' => '医学教育',
          'colleges.departments.histology_and_cell_biology' => '组织学与细胞生物学',
          'colleges.departments.clinical_pharmacy' => '临床药学',
          'colleges.departments.human_anatomy_and_embryology' => '人体解剖学与胚胎学',
          'colleges.departments.medical_physiology' => '医学生理学',
          'colleges.departments.medical_microbiology_and_immunology' =>
            '医学微生物学与免疫学',
          'colleges.departments.forensic_medicine_and_toxicology' => '法医学与毒理学',
          'colleges.departments.community_medicine_and_public_health' =>
            '社区医学与公共卫生',
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
          'colleges.departments.pt_internal_medicine_and_geriatrics' =>
            '内科与老年物理治疗',
          'colleges.departments.pt_womens_health' => '女性健康物理治疗',
          'colleges.departments.pt_surgery_and_integumentary' => '外科物理治疗',
          'colleges.departments.pt_orthopedics' => '骨科物理治疗',
          'colleges.departments.pt_neurology' => '神经物理治疗',
          'colleges.departments.pt_pediatrics' => '儿科物理治疗',
          'colleges.departments.artificial_biomedical_computing' =>
            '人工智能生物医学计算',
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
          'academic_progress.categories.university_name' => '荷鲁斯大学',
          'academic_progress.status.completed' => '已完成',
          'academic_progress.status.in_progress' => '进行中',
          'academic_progress.status.remaining' => '剩余',
          'academic_progress.status.requirement_met' => '要求已满足',
          'grades.title' => '学期成绩',
          'grades.grade_point' => '绩点',
          'grades.letter_grade' => '等第',
          'grades.gpa' => '学期 GPA',
          'grades.cumulative_gpa' => '累积绩点',
          'grades.credits' => '制作人员',
          'grades.summary' => '成绩总结',
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
          'schedule.daily_title' => '每日日程',
          'exam_schedule.title' => '考试安排',
          'exam_schedule.date' => '日期',
          'exam_schedule.duration' => '时长',
          'exam_schedule.seat' => '座位号',
          'attendance.title' => '出勤统计',
          'attendance.present' => '出勤',
          'attendance.absent' => '缺勤',
          'attendance.late' => '迟到',
          'attendance.ratio' => '出勤率',
          'attendance.subjects.ai' => '人工智能',
          'attendance.subjects.machine_learning' => '机器学习',
          'attendance.subjects.calculus' => '高级微积分',
          'attendance.subjects.ethics' => 'IT 道德',
          'registration.title' => '选课注册',
          'registration.submit' => '提交注册',
          'registration.enrolled_credits' => '已修学分',
          'registration.step1_title' => '第 1 步：选择主要组',
          'registration.step1_subtitle' => '选择您本学期想要注册的主要小组。',
          'registration.group_label' =>
            ({required Object group}) => '${group}组',
          'registration.main_cohort' => '主要队列注册',
          'registration.section_label' =>
            ({required Object section}) => '${section}节',
          'registration.step2_title' => '第 2 步：选择子部分',
          'registration.step3_title' => '第三步：确认注册',
          'registration.labs_sessions' => '实验室和实践课程',
          'registration.step2_subtitle' =>
            ({required Object group}) => '所选组：${group}。现在选择您的实用子部分。',
          'registration.credits_count' =>
            ({required Object credits}) => '${credits}CR',
          'registration.semester' => '学期',
          'registration.review' => '回顾选择',
          'registration.section' => '部分',
          'registration.already_registered_title' => '已经注册！',
          'registration.group' => '团体',
          'registration.confirm_final' => '确认最终注册',
          'registration.back_home' => '返回首页',
          'registration.success_message' =>
            ({required Object group, required Object section}) =>
                '您已成功注册本学期。\n组：${group}|部分：${section}',
          'registration.auto_registered' => '自动注册的课程：',
          'registration.error_loading' =>
            ({required Object error}) => '错误：${error}点击重试',
          'registration.registration_success' => '注册成功！',
          'payment.title' => '学费缴纳',
          'payment.outstanding' => '待缴余额',
          'payment.pay_now' => '立即支付',
          'payment.methods' => '支付方式',
          'payment.credit_debit' => '信用卡/借记卡',
          'payment.university_guaranteed' => '大学保证方法',
          'payment.fawry' => '福里/电子支付',
          'payment.bank_transfer' => '银行转账',
          'payment.currency' => ({required Object amount}) => '${amount}EGP',
          'invoices.title' => '账单',
          'invoices.history' => '支付历史',
          'invoices.unpaid' => '未付',
          'invoices.paid' => '已付',
          'invoices.date' => '日期',
          'invoices.amount' => '数量',
          'invoices.id' => '发票编号',
          'invoices.status' => '地位',
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
          'administration.audit_logs.title' => '审核日志',
          'administration.audit_logs.labels.record' => '记录',
          'administration.audit_logs.labels.actor' => '演员',
          'administration.audit_logs.labels.table' => '桌子',
          'administration.audit_logs.labels.action' => '行动',
          'administration.audit_logs.labels.old_data' => '旧数据',
          'administration.audit_logs.labels.notes' => '笔记',
          'administration.audit_logs.labels.new_data' => '新数据',
          'administration.audit_logs.labels.performed_by' => '表演者',
          'administration.audit_logs.labels.close_details' => '关闭详情',
          'administration.audit_logs.labels.view_details' => '查看详情',
          'administration.audit_logs.tabs.security' => '安全',
          'administration.audit_logs.tabs.all' => '所有日志',
          'administration.audit_logs.tabs.user_management' => '用户管理',
          'administration.audit_logs.tabs.data_updates' => '数据更新',
          'administration.audit_logs.no_logs_found' => '未找到符合条件的日志。',
          'feed.likes' => '喜欢',
          'feed.hours_ago' => '几小时前',
          'feed.caption_sample' => '这是帖子的示例标题',
          'professor.dashboard_title' => '教授仪表板',
          'professor.active_tas_count' =>
            ({required Object count}) => '${count}主动 TA',
          'professor.uploaded_files_count' =>
            ({required Object count}) => '${count}上传的文件',
          'professor.total_students_count' =>
            ({required Object count}) => '${count}学生总数',
          'professor.welcome_back_name' =>
            ({required Object name}) => '欢迎回来，${name}',
          'professor.weekly_slots_count' =>
            ({required Object count}) => '${count}每周时段',
          'professor.select_all' => '选择全部',
          'professor.announcement_to' =>
            ({required Object count}) => '向${count}公告',
          'professor.no_groups' => '没有可用的组',
          'professor.preparing_announcement' => '正在准备公告...',
          'professor.selected_count' =>
            ({required Object count}) => '${count}已选择',
          'professor.activating' =>
            ({required Object target}) => '激活：${target}',
          'professor.action_clicked' =>
            ({required Object action}) => '点击：${action}',
          'professor.add_new_ta' => '添加新助教',
          'professor.deselect_all' => '取消全选',
          'professor.no_available_tas' => '没有可用的 TA',
          'professor.no_active_tas' => '没有活跃的 TA',
          'professor.added' => ({required Object name}) => '添加：${name}',
          'professor.removed' => ({required Object name}) => '删除：${name}',
          'professor.urgent' => '紧迫的',
          'professor.add' => '添加',
          'professor.joined' => ({required Object name}) => '加入：${name}',
          'professor.message' => '信息',
          'professor.walk_in' => '步入式',
          'professor.upload' => '上传',
          'professor.stats.groups' => '团体',
          'professor.stats.students' => '学生总数',
          'professor.stats.tas' => '助教',
          'professor.stats.rating' => '等级',
          'professor.stats.shared_files' => '共享文件',
          'professor.stats.office_hours' => '办公时间',
          'professor.join' => '加入',
          'professor.downloading' => '正在下载...',
          'professor.quick_actions.urgent' => '紧迫的',
          'professor.quick_actions.upload' => '上传',
          'professor.quick_actions.message' => '信息',
          'professor.quick_actions.action_clicked' => '点击',
          'professor.profile.urgent_announcements' => '紧急公告',
          'professor.profile.teaching_assistants' => '助教',
          'professor.profile.shared_resources' => '共享资源',
          'professor.profile.office_hours' => '办公时间',
          'roles.categories.admin_it' => '行政与信息技术',
          'roles.categories.academic_leadership' => '学术领导力',
          'roles.categories.teaching_staff' => '师资队伍',
          'roles.categories.student_affairs' => '学生事务',
          'roles.categories.facilities_security' => '设施与安全',
          'roles.categories.student_roles' => '学生角色',
          'roles.categories.external_roles' => '外部角色',
          'roles.names.super_admin' => '超级管理员',
          'roles.names.financial_auditor' => '财务审计师',
          'roles.names.it_support' => '信息技术支持',
          'roles.names.dean' => '院长',
          'roles.names.academic_coordinator' => '学术协调员',
          'roles.names.rector' => '校长/主席',
          'roles.names.department_head' => '系主任',
          'roles.names.admin' => '行政人员',
          'roles.names.professor' => '教授/讲师',
          'roles.names.lecturer' => '讲师',
          'roles.names.teaching_assistant' => '助教',
          'roles.names.registrar_officer' => '登记官',
          'roles.names.academic_advisor' => '学术顾问',
          'roles.names.freshman' => '新生',
          'roles.names.dorm_supervisor' => '宿舍主管',
          'roles.names.student' => '学生',
          'roles.names.librarian' => '图书管理员',
          'roles.names.class_representative' => '班代表',
          'roles.names.parent' => '家长/监护人',
          'roles.names.security_officer' => '保安员',
          'roles.names.guest' => '客人',
          'roles.names.alumni' => '校友',
          'roles.names.recruiter' => '招聘人员',
          'roles.names.regular_student' => '普通学生',
          'roles.descriptions.it_support' => '技术系统支持与维护',
          'roles.descriptions.super_admin' => '完全控制整个系统',
          'roles.descriptions.admin' => '具有高权限的系统管理员',
          'roles.descriptions.financial_auditor' => '监督财务记录和发票',
          'roles.descriptions.rector' => '大学校长拥有全面的学术监督权',
          'roles.descriptions.dean' => '学院/学院院长',
          _ => null,
        } ??
        switch (path) {
          'roles.descriptions.department_head' => '学术部门负责人',
          'roles.descriptions.academic_coordinator' => '协调学术课程和日程安排',
          'roles.descriptions.professor' => '教授和管理课程的教员',
          'roles.descriptions.lecturer' => '在没有完全教授特权的情况下教授课程',
          'roles.descriptions.teaching_assistant' => '协助教授进行评分、实验室和教程',
          'roles.descriptions.registrar_officer' => '管理学生入学和注册',
          'roles.descriptions.librarian' => '管理图书馆资源和资料',
          'roles.descriptions.regular_student' => '拥有所有标准学术特权的正式学生',
          'roles.descriptions.alumni' => '访问权限有限的毕业生',
          'roles.descriptions.class_representative' => '代表班级的学生领袖',
          'roles.descriptions.student' => '一般学生角色',
          'roles.descriptions.academic_advisor' => '指导学生完成学业规划',
          'roles.descriptions.security_officer' => '校园安全和访问控制',
          'roles.descriptions.parent' => '可以查看链接的学生进度和成绩',
          'roles.descriptions.freshman' => '系统访问权限有限的一年级学生',
          'roles.descriptions.dorm_supervisor' => '管理学生宿舍运营',
          'roles.descriptions.guest' => '具有最小访问权限的临时访客',
          'roles.descriptions.recruiter' => '外部招聘机构',
          'academic.academic_progress' => '学业进步',
          'academic.university_requirements' => '大学要求',
          'academic.faculty_requirements' => '师资要求',
          'academic.major_requirements' => '主要要求',
          'academic.completed' => '完全的',
          'academic.remaining' => '其余的',
          'academic.transcript_title' => '学术成绩单',
          'academic.grades_title' => '成绩',
          'academic.courses_title' => '我的课程',
          'academic.electives' => '选修课',
          'academic.action_plan_title' => '学位行动计划',
          'academic.attendance_title' => '出席率',
          'academic.schedule_title' => '日程',
          'academic.professor_dashboard' => '教授仪表板',
          'academic.all_students' => '所有学生',
          'academic.exam_schedule_title' => '考试时间表',
          'academic.tas' => '助教',
          'academic.subject_results_title' => '科目结果',
          'academic.office_hours' => '办公时间',
          'academic.no_groups' => '没有团体',
          'academic.groups' => '团体',
          'academic.chat' => '聊天',
          'academic.assignments' => '作业',
          'academic.courses' => '课程',
          'academic.view_all' => '查看全部',
          'academic.feedback' => '反馈',
          'academic.active' => '积极的',
          'academic.add_ta' => '添加助教',
          'academic.remove_ta' => '删除TA',
          'academic.inactive' => '不活跃',
          'academic.all' => '全部',
          'academic.urgent_announcement' => '紧急公告',
          'academic.send_message' => '发送消息',
          'academic.section' => '部分',
          'academic.manage_groups' => '管理群组',
          'academic.group_label' => '团体',
          'academic.upload_file' => '上传文件',
          'academic.manage_tas' => '管理助教',
          'academic.profile' => '轮廓',
          'academic.semester_grades' => '学期成绩',
          'academic.grade_summary' => '成绩总结',
          'academic.gpa' => '平均绩点',
          'academic.credits' => '制作人员',
          'academic.kFinal' => '期末考试',
          'academic.practical' => '实际的',
          'academic.total' => '全部的',
          'academic.midterm' => '期中考试',
          'academic.year_2' => '第二年',
          'academic.year_1' => '第一年',
          'academic.year_3' => '第三年',
          'academic.available' => '可用的',
          'academic.instructor' => '讲师',
          'academic.schedule_info' => '日程',
          'academic.time' => '时间',
          'academic.room' => '房间',
          'academic.enrolled' => '已注册',
          'academic.year_4' => '第四年',
          'academic.seat' => '座位',
          'academic.exam_date' => '考试日期',
          'academic.duration' => '期间',
          'academic.present' => '展示',
          'academic.absent' => '缺席的',
          'academic.late' => '晚的',
          'academic.ratio' => '比率',
          'academic.back' => '后退',
          'academic.no_data' => '无可用数据',
          'academic.error' => '错误',
          'academic.search' => '搜索',
          'academic.retry' => '重试',
          'academic.cancel' => '取消',
          'academic.save' => '节省',
          'academic.loading' => '加载中...',
          'academic.delete' => '删除',
          'academic.filter' => '筛选',
          'academic.edit' => '编辑',
          'academic.confirm' => '确认',
          'academic.add' => '添加',
          'academic.remove' => '消除',
          'academic.close' => '关闭',
          'academic.academic_journey' => '学术之旅',
          'academic.academic_results' => '学业成绩',
          'academic.send' => '发送',
          'academic.academic_standing_excellent' => '出色的',
          'academic.add_new_ta' => '添加新助教',
          'academic.across_all_groups' => '跨所有群体',
          'academic.add_to_calendar' => '添加到日历',
          'academic.action_plan' => '学位行动计划',
          'academic.advanced_learning' => '进阶学习',
          'academic.advanced_mathematics' => '高等数学',
          'academic.advisor_assignment' => '顾问分配',
          'academic.added_successfully' => '添加成功',
          'academic.algorithms' => '算法',
          'academic.artificial_intelligence' => '人工智能',
          'academic.are_you_sure_you_want_to_remov' => '您确定要删除该 TA 吗？',
          'academic.calculus_i' => '微积分一',
          'academic.clicked' => '点击',
          'academic.code_review' => '代码审查',
          'academic.completed_1' => '完全的',
          'academic.completion_rate' => '完成率',
          'academic.confirm_removal' => '确认删除',
          'academic.comp_organization' => '计算机组织',
          'academic.computer_programming' => '计算机编程',
          'academic.course_management' => '课程管理',
          'academic.credits_1' => '制作人员',
          'academic.coursework' => '课程作业',
          'academic.cs402_artificial_intelligence' => 'CS402 人工智能',
          'academic.cs410_computer_vision' => 'CS410 计算机视觉',
          'academic.cs405_machine_learning' => 'CS405 机器学习',
          'academic.cumulative_gpa' => '累积绩点',
          'academic.database_systems' => '数据库系统',
          'academic.data_structures' => '数据结构',
          'academic.d_mmmm' => 'MMMM',
          'academic.deep_learning' => '深度学习',
          'academic.dr_alan_turing' => '艾伦·图灵博士',
          'academic.days' => '天',
          'academic.dr_ada_lovelace' => '艾达·洛夫莱斯博士',
          'academic.dr_robert_smith' => '罗伯特·史密斯博士',
          'academic.dr_sarah_ahmed' => '萨拉·艾哈迈德博士',
          'academic.english_composition' => '英语作文',
          'academic.ethics_in_it' => 'IT 道德',
          'academic.fall_2023' => '2023 年秋季',
          'academic.exam_schedule' => '考试时间表',
          'academic.field_internship' => '实地实习',
          'academic.file_title' => '文件标题',
          'academic.file_will_be_uploaded_to_cloud' => '文件将上传到云存储',
          'academic.final_exam' => '期末考试',
          'academic.foundational_skills' => '基础技能',
          'academic.general_physics' => '普通物理',
          'academic.graduation_progress' => '毕业进度',
          'academic.graduation_mastery' => '毕业精通',
          'academic.frontend_ui' => '前端用户界面',
          'academic.graduation_project' => '毕业设计',
          'academic.hall_1' => '1号馆',
          'academic.intro_to_ai' => '人工智能简介',
          'academic.hum210_professional_ethics' => 'HUM210 职业道德',
          'academic.hall_4' => '4号馆',
          'academic.hours' => '时间',
          'academic.intro_to_programming' => '编程入门',
          'academic.joined' => '已加入',
          'academic.lab_12' => '实验室12',
          'academic.lab_final' => '实验室决赛',
          'academic.lecture' => '演讲',
          'academic.lecture_hall_2' => '报告厅2',
          'academic.linear_algebra' => '线性代数',
          'academic.live' => '居住',
          'academic.machine_learning' => '机器学习',
          'academic.live_now' => '现在直播',
          'academic.mat301_advanced_calculus' => 'MAT301 高级微积分',
          'academic.members' => '会员',
          'academic.messages' => '留言',
          'academic.next_exam_in' => '下次考试时间',
          'academic.network_security' => '网络安全',
          'academic.no_available_tas_currently' => '目前没有可用的助教',
          'academic.no_exams_on_this_day' => '这一天没有考试',
          'academic.midterm_exam' => '期中考试',
          'academic.mins' => '分钟',
          'academic.mathematics' => '数学',
          'academic.no_tas_assigned_yet' => '尚未分配 TA',
          'academic.overall_attendance' => '整体出席率',
          'academic.overall_progress' => '总体进展',
          'academic.logic_design' => '逻辑设计',
          'academic.points' => '积分',
          'academic.performance_distribution' => '业绩分布',
          'academic.programming_basics' => '编程基础知识',
          'academic.prof_john_doe' => '约翰·多伊教授',
          'academic.progress' => '进步',
          'academic.psychology' => '心理学',
          'academic.quick_actions' => '快速行动',
          'academic.practical_project' => '实际项目',
          'academic.rank' => '秩',
          'academic.results_analysis' => '结果分析',
          'academic.registration_requests' => '注册请求',
          'academic.rating' => '等级',
          'academic.score' => '分数',
          'academic.sessions_this_week' => '本周会议',
          'academic.removed_successfully' => '删除成功',
          'academic.quiz_2' => '测验2',
          'academic.select_a_ta_from_the_list_to_a' => '从列表中选择要添加的 TA',
          'academic.quiz_1' => '测验 1',
          'academic.shared_files' => '共享文件',
          'academic.specialization_projects' => '专业化项目',
          'academic.sophomore' => '大二',
          'academic.spring_2024' => '2024 年春季',
          'academic.summer_2024' => '2024 年夏季',
          'academic.track_project_i' => '跟踪项目 I',
          'academic.students' => '学生',
          'academic.start_by_adding_the_first_ta_f' => '首先为您的课程添加第一个助教',
          'academic.ta_team_chat' => '助教团队聊天',
          'academic.total_students' => '学生总数',
          'academic.upload_files' => '上传文件',
          'academic.upload_new_file' => '上传新文件',
          'academic.type_a_message' => '输入消息...',
          'academic.web_programming' => '网页编程',
          'academic.urgent_news' => '紧急消息',
          'academic.upload' => '上传',
          'academic.uploaded_successfully' => '上传成功',
          'admin.system_online' => '系统上线',
          'admin.en' => 'zh',
          'admin.admin_command_center' => '管理指挥中心',
          'admin.eeee_mmmm_dd_yyyy' => 'EEEE，MMMM 日，年',
          'admin.live_statistics' => '实时统计',
          'admin.students' => '学生',
          'admin.admin' => '行政',
          'admin.faculty' => '学院',
          'admin.leadership' => '领导',
          'admin.staff' => '职员',
          'admin.system_modules' => '系统模块',
          'admin.users' => '用户',
          'admin.admin_it' => '行政与信息技术',
          'admin.manage_all_accounts' => '管理所有帐户',
          'admin.manage_faculties' => '管理院系',
          'admin.colleges' => '学院',
          'admin.departments' => '部门',
          'admin.academic_departments' => '学术部门',
          'admin.professors' => '教授',
          'admin.faculty_members' => '教职人员',
          'admin.permission_management' => '权限管理',
          'admin.audit_logs' => '审核日志',
          'admin.roles' => '角色',
          'admin.system_activity_log' => '系统活动日志',
          'admin.system_settings' => '系统设置',
          'admin.platform_configuration' => '平台配置',
          'admin.performance' => '表现',
          'admin.server_health_metrics' => '服务器健康指标',
          'admin.server' => '服务器',
          'admin.system_pulse' => '系统脉冲',
          'admin.latency' => '延迟',
          'admin.online' => '在线的',
          'admin.status' => '地位',
          'admin.active' => '积极的',
          'admin.realtime_latency_ms' => '实时延迟 (MS)',
          'admin.teaching_staff' => '师资队伍',
          'admin.role_breakdown' => '角色细分',
          'admin.academic_leadership' => '学术领导力',
          'admin.student_affairs' => '学生事务',
          'admin.database' => '数据库',
          'admin.total_users' => '用户总数',
          'admin.quick_actions' => '快速行动',
          'admin.system_health' => '系统健康状况',
          'admin.management' => '管理',
          'admin.export_data' => '导出数据',
          'admin.add_user' => '添加用户',
          'admin.user_management' => '用户管理',
          'admin.backup_system' => '备份系统',
          'admin.user_list' => '用户列表',
          'admin.filter_students' => '学生',
          'admin.filter_all' => '全部',
          'admin.filter_admin' => '行政',
          'admin.filter_staff' => '职员',
          'admin.search_users' => '搜索用户...',
          'admin.no_users' => '没有找到用户',
          'admin.staff_management' => '员工管理',
          'admin.student_management' => '学生管理',
          'admin.faculty_management' => '师资管理',
          'admin.user_count' => ({required Object count}) => '${count}用户',
          'admin.leadership_management' => '领导力管理',
          'admin.admin_it_management' => '行政和 IT 管理',
          'admin.send_announcement' => '发送公告',
          'admin.college_management' => '学院管理',
          'admin.department_management' => '部门管理',
          'admin.professor_management' => '教授管理学',
          'admin.role_management' => '角色管理',
          'admin.audit_log_management' => '审计日志管理',
          'admin.system_configuration' => '系统配置',
          'admin.add_department' => '添加部门',
          'admin.add_college' => '添加学院',
          'admin.edit_college' => '编辑学院',
          'admin.edit_department' => '编辑部门',
          'admin.delete_college' => '删除学院',
          'admin.delete_department' => '删除部门',
          'admin.college_name' => '学院名称',
          'admin.department_name' => '部门名称',
          'admin.student_count' => '学生',
          'admin.head_name' => '头名',
          'admin.dean_name' => '院长姓名',
          'admin.timestamp' => '时间戳',
          'admin.action' => '行动',
          'admin.ta_count' => 'TA',
          'admin.staff_count' => '职员',
          'admin.user' => '用户',
          'admin.details' => '细节',
          'admin.filter_by_date' => '按日期过滤',
          'admin.filter_by_action' => '按操作过滤',
          'admin.system_version' => '系统版本',
          'admin.no_logs' => '未找到审核日志',
          'admin.maintenance_mode' => '维护方式',
          'admin.backup_schedule' => '备份计划',
          'admin.storage_quota' => '存储配额',
          'admin.email_server' => '电子邮件服务器',
          'admin.log_retention' => '日志保留',
          'admin.security_level' => '安全等级',
          'admin.session_timeout' => '会话超时',
          'admin.reset_defaults' => '重置为默认值',
          'admin.save_settings' => '保存设置',
          'admin.user_name' => '姓名',
          'admin.user_role' => '角色',
          'admin.user_phone' => '电话',
          'admin.user_department' => '部门',
          'admin.user_email' => '电子邮件',
          'admin.user_college' => '大学',
          'admin.user_status' => '地位',
          'admin.user_updated' => '用户更新成功',
          'admin.user_created' => '已创建',
          'admin.add_new_user' => '添加新用户',
          'admin.edit_user' => '编辑用户',
          'admin.delete_user' => '删除用户',
          'admin.save_user' => '节省',
          'admin.cancel' => '取消',
          'admin.name_label' => '姓名',
          'admin.college_label' => '大学',
          'admin.department_label' => '部门',
          'admin.email_label' => '电子邮件',
          'admin.role_label' => '选择角色',
          'admin.phone_label' => '电话号码',
          'admin.confirm_password_label' => '确认密码',
          'admin.password_label' => '密码',
          'admin.category_faculty' => '学院',
          'admin.category_student' => '学生',
          'admin.category_leadership' => '领导',
          'admin.category_staff' => '职员',
          'admin.category_admin' => '行政',
          'admin.select_role' => '选择角色',
          'admin.select_department' => '选择部门',
          'admin.select_college' => '选择学院',
          'admin.user_added' => '用户添加成功',
          'admin.no_colleges' => '没有可用的大学',
          'admin.user_deleted' => '用户删除成功',
          'admin.confirm_delete' => '确认删除',
          'admin.error_loading' => '加载数据时出错',
          'admin.retry' => '重试',
          'admin.confirm_delete_message' => '您确定要删除该用户吗？',
          'admin.error_saving' => '保存数据时出错',
          'admin.academic_departments_1' => '学术部门',
          'admin.no_departments' => '没有可用的部门',
          'admin.academic_department' => '学术部',
          'admin.academic_leaders' => '学术带头人',
          'admin.academic_warnings' => '学术警告',
          'admin.account_status' => '账户状态',
          'admin.account_verification' => '账户验证',
          'admin.actor' => '演员',
          'admin.add_report' => '添加报告',
          'admin.advanced_management' => '先进管理',
          'admin.admins' => '管理员',
          'admin.all_levels' => '所有级别',
          'admin.all_systems_operational' => '所有系统均可运行',
          'admin.all' => '全部',
          'admin.apply_filters' => '应用过滤器',
          'admin.are_you_sure_you_want_to_delet' => '您确定要删除该用户吗？',
          'admin.assign' => '分配',
          'admin.assign_dean' => '指定院长',
          'admin.assign_department_head' => '指定部门主管',
          'admin.attached_report' => '附报告',
          'admin.banned' => '禁止',
          'admin.change' => '改变',
          'admin.ban_user' => '禁止用户',
          'admin.change_dean' => '更换院长',
          'admin.changes_saved_successfully' => '更改已成功保存',
          'admin.college' => '大学',
          'admin.college_dean' => '学院院长',
          'admin.college_details' => '学院详情',
          'admin.colleges_management' => '学院管理',
          'admin.coming_soon' => '即将推出',
          'admin.department_details' => '部门详情',
          'admin.deactivated' => '已停用',
          'admin.department_projects' => '部门项目',
          'admin.delete' => '删除',
          'admin.departments_management' => '部门管理',
          'admin.entity' => '实体',
          'admin.error_snapshoterror' => '错误：{错误}',
          'admin.email_address' => '电子邮件',
          'admin.failed_to_load_data' => '加载数据失败',
          'admin.faculty_members_1' => '教职人员',
          'admin.full_name' => '姓名',
          'admin.head_of_department' => '系主任',
          'admin.incidents' => '事件',
          'admin.filter_users' => '过滤用户',
          'admin.leadership_stats' => '领导力统计',
          'admin.level_level' => '级别{级别}',
          'admin.manage_tags' => '管理标签',
          'admin.national_id' => '国民身份证',
          'admin.min_6_chars' => '分钟。 6 个字符',
          'admin.no_about_text_available' => '没有可用的关于文本',
          'admin.nationality' => '国籍',
          'admin.no_dean_assigned' => '没有指定院长',
          'admin.no_colleges_found' => '没有找到大学',
          'admin.no_departments_in_this_college' => '该学院没有院系',
          'admin.no_departments_found' => '未找到部门',
          'admin.no_description_available' => '无可用描述',
          'admin.no_matching_students_found' => '未找到匹配的学生',
          'admin.no_faculty_records_found' => '未找到教师记录',
          'admin.no_head_assigned' => '没有分配头',
          'admin.no_projects_added_yet' => '尚未添加项目',
          'admin.no_logs_found' => '未找到日志',
          'admin.no_settings_found_in_the_datab' => '在数据库中找不到设置',
          'admin.office' => '办公室',
          'admin.no_users_found' => '未找到用户',
          'admin.password' => '密码',
          'admin.pending_reg' => '待注册',
          'admin.permanently_delete_user' => '永久删除用户',
          'admin.phone_number' => '电话号码',
          'admin.please_assign_a_head_for_the_d' => '请指定该部门的负责人',
          'admin.please_assign_a_dean_for_the_c' => '请为该学院指派一名院长',
          'admin.save' => '节省',
          'admin.roles_management' => '角色管理',
          'admin.save_changes' => '保存更改',
          'admin.search_by_name_email_phone_id' => '按姓名、电子邮件、电话或 ID 搜索...',
          'admin.select_role_in_widgetinitialca' => '选择角色',
          'admin.search_staff_member' => '搜寻工作人员...',
          'admin.select' => '选择',
          'admin.search_doctor_name' => '搜索医生姓名...',
          'admin.search_student_or_id' => '搜索学生或 ID...',
          'admin.servers' => '服务器',
          'admin.select_role_permission' => '选择角色/权限',
          'admin.separate_tags_with_commas' => '用逗号分隔标签',
          'admin.student_id' => '学生证',
          'admin.system_technical_status' => '系统技术状况',
          'admin.tag1_tag2' => '标签1、标签2',
          'admin.teaching_assistants' => '助教',
          'admin.total_staff' => '员工总数',
          'admin.total_students' => '学生总数',
          'admin.unverified' => '未验证',
          'admin.verified' => '已验证',
          'admin.verification' => '确认',
          'admin.warning_level' => '警告级别',
          'admin.user_roles_ranks' => '用户角色和等级',
          'admin.you_can_manage_professors_and_' => '您可以在这里管理教授等',
          'enrollment.registration_title' => '课程注册',
          'enrollment.invoices_title' => '财务发票',
          'enrollment.advisor_approval' => '顾问批准',
          'enrollment.advisor' => '学术顾问',
          'enrollment.approve' => '批准',
          'enrollment.reject' => '拒绝',
          'enrollment.dean_assignment' => '院长顾问分配',
          'enrollment.payment_title' => '缴纳学费',
          'enrollment.pending' => '待办的',
          'enrollment.approved' => '得到正式认可的',
          'enrollment.rejected' => '被拒绝',
          'enrollment.student_name' => '学生姓名',
          'enrollment.student_id' => '学生证',
          'enrollment.college' => '大学',
          'enrollment.department' => '部门',
          'enrollment.semester' => '学期',
          'enrollment.credits' => '制作人员',
          'enrollment.group' => '团体',
          'enrollment.section' => '部分',
          'enrollment.status' => '地位',
          'enrollment.no_requests' => '没有找到请求',
          'enrollment.filter_rejected' => '被拒绝',
          'enrollment.search_students' => '搜索学生...',
          'enrollment.filter_approved' => '得到正式认可的',
          'enrollment.registration_date' => '报名日期',
          'enrollment.approve_all' => '批准全部',
          'enrollment.assign' => '分配',
          'enrollment.advisor_name' => '顾问姓名',
          'enrollment.filter_all' => '全部',
          'enrollment.unassign' => '取消分配',
          'enrollment.view_details' => '查看详情',
          'enrollment.unassigned' => '未分配',
          'enrollment.filter_pending' => '待办的',
          'enrollment.cancel' => '取消',
          'enrollment.save' => '节省',
          'enrollment.success_reject' => '注册被拒绝',
          'enrollment.success_approve' => '注册审核成功',
          'enrollment.success_assign' => '顾问分配成功',
          'enrollment.error_loading' => '加载数据时出错',
          'enrollment.assigned' => '已分配',
          'enrollment.invoice_amount' => '数量',
          'enrollment.invoice_status' => '地位',
          'enrollment.invoice_date' => '日期',
          'enrollment.invoice_id' => '发票编号',
          'enrollment.invoice_paid' => '有薪酬的',
          'enrollment.invoice_overdue' => '逾期',
          'enrollment.pay_now' => '立即付款',
          'enrollment.payment_method' => '付款方式',
          'enrollment.invoice_unpaid' => '未付',
          'enrollment.fawry' => '福里',
          'enrollment.credit_card' => '信用卡',
          'enrollment.payment_success' => '付款成功',
          'enrollment.bank_transfer' => '银行转账',
          'enrollment.payment_error' => '付款失败',
          'enrollment.outstanding_balance' => '未结余额',
          'enrollment.total_paid' => '总付费',
          'enrollment.no_invoices' => '没有找到发票',
          'enrollment.tuition_fee' => '学费',
          'enrollment.registration_fee' => '注册费',
          'enrollment.late_fee' => '滞纳金',
          'enrollment.academic_year' => '学年',
          'enrollment.submit_request' => '提交请求',
          'enrollment.total' => '全部的',
          'enrollment.semester_label' =>
            ({required Object semester}) => '学期${semester}',
          'enrollment.all' => '全部',
          'enrollment.academic_advisor' => '学术顾问',
          'enrollment.request_submitted' => '请求提交成功',
          'enrollment.approved_1' => '得到正式认可的',
          _ => null,
        } ??
        switch (path) {
          'enrollment.retry' => '重试',
          'enrollment.approved_courses_registered' => '批准 - 注册课程',
          'enrollment.advisor_assignment' => '顾问分配',
          'enrollment.confirm_submit' => '确认并提交',
          'enrollment.cr' => 'CR',
          'enrollment.advisor_requestadvisorfullname' => '顾问：{姓名}',
          'enrollment.advisor_updated_successfully' => '顾问更新成功',
          'enrollment.dormitory_fee' => '宿舍费',
          'enrollment.download' => '下载',
          'enrollment.failed_to_load_invoices' => '加载发票失败',
          'enrollment.exam_fee' => '考试费',
          'enrollment.error_loading_summary' => '加载摘要时出错',
          'enrollment.due' => '到期的',
          'enrollment.financial_portal' => '金融门户',
          'enrollment.awaiting_advisor_review' => '等待顾问审核',
          'enrollment.choose_schedules' => '选择时间表',
          'enrollment.financial_summary' => '财务摘要',
          'enrollment.help' => '帮助',
          'enrollment.history' => '历史',
          'enrollment.library_fee' => '图书馆费',
          'enrollment.invoices' => '发票',
          'enrollment.manage_your_tuition_and_paymen' => '管理您的学费和付款',
          'enrollment.mmm_dd_yyyy' => '嗯 日、年',
          'enrollment.my_invoices' => '我的发票',
          'enrollment.no_advisor' => '无顾问',
          'enrollment.no_invoices_found' => '未找到发票',
          'enrollment.next_pick_schedules' => '下一页： 选择时间表',
          'enrollment.no_requests_found' => '未找到请求',
          'enrollment.no_schedules_available_for_thi' => '该课程没有可用的时间表',
          'enrollment.notes_optional' => '注释（可选）',
          'enrollment.no_students_found' => '没有找到学生',
          'enrollment.overdue' => '逾期',
          'enrollment.paid' => '有薪酬的',
          'enrollment.partial' => '部分的',
          'enrollment.other' => '其他',
          'enrollment.loading' => '加载中...',
          'enrollment.pay' => '支付',
          'enrollment.preparing_pdf_statement' => '正在准备 PDF 声明...',
          'enrollment.pending_review' => '待审核',
          'enrollment.registration_requests' => '注册请求',
          'enrollment.request_rejected' => '请求被拒绝',
          'enrollment.remaining' => '其余的',
          'enrollment.reregister' => '重新注册',
          'enrollment.requested_courses' => '要求的课程',
          'enrollment.review_registration' => '审核注册',
          'enrollment.room' => '房间',
          'enrollment.sec' => '秒',
          'enrollment.select_the_subjects_you_want_t' => '选择您要报名的科目',
          'enrollment.review_final_timetable' => '审查最终时间表',
          'enrollment.selected_schedule_summary' => '选定的时间表摘要',
          'enrollment.semester_requestsemester' => '学期：{学期}',
          'enrollment.summaryoverduecount_overdue' => '{count} 逾期',
          'enrollment.select_your_courses' => '选择您的课程',
          'enrollment.total_invoices' => '发票总数',
          'enrollment.sub' => '子',
          'enrollment.unassigned_only' => '仅未分配',
          'enrollment.unpaid' => '未付',
          'enrollment.withdrawn' => '撤回',
          'enrollment.you_have_successfully_register' => '您已成功注册课程！',
          'enrollment.your_account_is_clearnno_invoi' => '你的账目清清楚楚。没有找到发票。',
          'shared.no_notifications_yet' => '还没有通知',
          'shared.notifications_empty' => '没有新通知',
          'shared.notifications' => '通知',
          'shared.security_title' => '安全设置',
          'shared.fingerprint' => '指纹',
          'shared.biometrics_title' => '生物识别技术',
          'shared.face_id' => '人脸识别',
          'shared.enable_biometrics' => '启用生物识别技术',
          'shared.sessions_title' => '活跃会话',
          'shared.end_session' => '结束会议',
          'shared.current_session' => '当前会话',
          'shared.device' => '设备',
          'shared.end_all_sessions' => '结束所有会话',
          'shared.location' => '地点',
          'shared.last_active' => '最后活跃',
          'shared.contact_us' => '联系我们',
          'shared.email_us' => '给我们发电子邮件',
          'shared.whatsapp' => 'WhatsApp',
          'shared.call_us' => '致电我们',
          'shared.support_title' => '支持与帮助',
          'shared.tutorials_title' => '教程和指南',
          'shared.faq' => '常问问题',
          'shared.forums_title' => '论坛',
          'shared.report_issue' => '报告问题',
          'shared.create_post' => '创建帖子',
          'shared.search_forums' => '搜索论坛...',
          'shared.no_posts' => '没有找到帖子',
          'shared.placeholder_subtitle' => '此部分正在开发中',
          'shared.back' => '后退',
          'shared.placeholder_title' => '即将推出',
          'shared.under_development' => '该功能正在开发中',
          'shared.coming_soon' => '即将推出',
          'shared.retry' => '重试',
          'shared.transition_title' => '加载中...',
          'shared.error' => '错误',
          'shared.close' => '关闭',
          'shared.cancel' => '取消',
          'shared.confirm' => '确认',
          'shared.loading' => '加载中...',
          'shared.active_sessions' => '活跃会话',
          'shared.authentication' => '验证',
          'shared.delete' => '删除',
          'shared.save' => '节省',
          'shared.call_hotline' => '拨打热线',
          'shared.biometric_login' => '生物识别登录',
          'shared.change_password' => '更改密码',
          'shared.email_support' => '电子邮件支持',
          'shared.edit' => '编辑',
          'shared.device_management' => '设备管理',
          'shared.forums' => '论坛',
          'shared.financial_aid' => '经济援助',
          'shared.it_support' => '信息技术支持',
          'shared.manage_logged_in_devices' => '管理登录设备',
          'shared.members' => '会员',
          'shared.logout' => '退出',
          'shared.please_wait' => '请稍等...',
          'shared.library' => '图书馆',
          'shared.protect_account_with_2fa' => '使用 2FA 保护帐户',
          'shared.security' => '安全',
          'shared.threads' => '线程数',
          'shared.student_affairs' => '学生事务',
          'shared.support' => '支持',
          'shared.this_feature_is_under_developm' => '该功能正在开发中',
          'shared.tutorials' => '教程',
          'shared.twofactor_auth' => '双因素身份验证',
          'shared.use_fingerprint_or_face_id' => '使用指纹或面容 ID',
          'shared.update_your_login_credentials' => '更新您的登录凭据',
          'shared.biometrics' => '生物识别技术',
          'shared.view_active_sessions' => '查看活动会话',
          'shared.sessions' => '会议',
          'shared.security_section' => '安全',
          'shared.support_section' => '支持',
          'shared.tutorials_section' => '教程',
          'shared.contact_us_section' => '联系我们',
          'shared.forums_section' => '论坛',
          'shared.security_access' => '安全访问',
          'shared.no_new_notifications' => '没有新通知',
          'students.department' => '部门',
          'students.student_name' => '学生姓名',
          'students.college' => '大学',
          'students.gpa' => '平均绩点',
          'students.student_id' => '学生证',
          'students.digital_id_title' => '数字身份证',
          'students.level' => '等级',
          'students.credits' => '制作人员',
          'students.verified' => '已验证',
          'students.university' => '荷鲁斯大学',
          'students.download_id' => '下载ID',
          'students.share_id' => '分享ID',
          'students.qr_code' => '二维码',
          'students.scan_to_verify' => '扫描验证',
          'students.classic_theme' => '经典的',
          'students.id_theme' => '身份主题',
          'students.gradient_theme' => '坡度',
          'students.holographic_theme' => '全息',
          'students.dark_matter_theme' => '暗物质',
          'students.aurora_theme' => '极光',
          'students.neon_pulse_theme' => '霓虹灯脉冲',
          'students.dashboard_title' => '学生仪表板',
          'students.academic_section' => '学术的',
          'students.enrollment_section' => '注册',
          'students.utilities_section' => '公用事业',
          'students.transcript' => '成绩单',
          'students.progress' => '学业进步',
          'students.subject_results' => '科目结果',
          'students.grades' => '成绩',
          'students.courses' => '课程',
          'students.schedule' => '日程',
          'students.action_plan' => '学位计划',
          'students.attendance' => '出席率',
          'students.exam_schedule' => '考试时间表',
          'students.invoices' => '发票',
          'students.registration' => '登记',
          'students.payment' => '支付',
          'students.security' => '安全',
          'students.tutorials' => '教程',
          'students.forums' => '论坛',
          'students.support' => '支持',
          'students.notifications' => '通知',
          'students.digital_id' => '数字身份证',
          'students.no_lectures_today' => '今天没有讲座',
          'students.view_full_schedule' => '查看完整时间表',
          'students.quick_stats' => '快速统计',
          'students.gpa_label' => '平均绩点',
          'students.credits_label' => '制作人员',
          'students.level_label' => '等级',
          'students.all' => '全部',
          'students.upcoming_exams' => '即将举行的考试',
          'students.error' => '错误',
          'students.back' => '后退',
          'students.retry' => '重试',
          'students.active' => '积极的',
          'students.recent_grades' => '最近的成绩',
          'students.artificial_intelligence' => '人工智能',
          'students.access_logs' => '访问日志',
          'students.daily_schedule' => '每日日程',
          'students.download' => '下载',
          'students.copy' => '复制',
          'students.enrollment_finance' => '招生与财务',
          'students.horus_university_1' => '荷鲁斯大学',
          'students.academic' => '学术的',
          'students.horus_university' => '荷鲁斯大学',
          'students.id_no' => '身份证号码',
          'students.nfc_pass' => 'NFC通行证',
          'students.identity_active_secure' => '身份主动且安全',
          'students.offline_copy' => '离线复制',
          'students.send' => '发送',
          'students.loading' => '加载中...',
          'students.share_identity' => '分享身份',
          'students.settings' => '设置',
          'students.smart_digital_id' => '智能数字身份证',
          'students.student' => '学生',
          'students.status' => '地位',
          'students.utilities' => '公用事业',
          'students.scan_for_secure_access' => '扫描安全访问',
          'extracted.full_name' => '姓名',
          'extracted.personal_info' => '个人信息',
          'extracted.about_me' => '关于我',
          'extracted.account_info' => '账户信息',
          'extracted.national_id' => '国民身份证',
          'extracted.take_photo' => '拍照',
          'extracted.required' => '必需的',
          'extracted.save' => '节省',
          'extracted.email' => '电子邮件',
          'extracted.account_status' => '账户状态',
          'extracted.role' => '角色',
          'extracted.choose_from_gallery' => '从图库中选择',
          'extracted.phone_number' => '电话号码',
          'extracted.user' => '用户',
          'extracted.account' => '帐户',
          'extracted.appearance' => '外貌',
          'extracted.edit_profile' => '编辑个人资料',
          'extracted.save_changes' => '保存更改',
          'extracted.notifications' => '通知',
          'extracted.dark_mode' => '深色模式',
          'extracted.toggle_between_dark_and_light_mode' => '在深色和浅色模式之间切换',
          'extracted.about' => '关于',
          'extracted.send_password_recovery_link_to_your_emai' =>
            '将密码恢复链接发送到您的电子邮件',
          'extracted.current_classic_design' => '当前： 经典设计',
          'extracted.active' => '积极的',
          'extracted.current_glass_design' => '当前： 玻璃设计',
          'extracted.language_region' => '语言及地区',
          'extracted.write_something_about_yourself' => '写一些关于你自己的事情...',
          'extracted.password_recovery' => '密码恢复',
          'extracted.update_your_personal_info_and_photo' => '更新您的个人信息和照片',
          'extracted.battery_saver_mode' => '省电模式',
          'extracted.kSwitch' => '转变',
          'extracted.notification_center' => '通知中心',
          'extracted.send_a_test_notification' => '发送测试通知',
          'extracted.change_profile_photo' => '更改个人资料照片',
          'extracted.ui_style' => '用户界面风格',
          'extracted.notifications_are_off' => '通知已关闭',
          'extracted.remove_photo' => '删除照片',
          'extracted.support_feedback' => '支持与反馈',
          'extracted.app_notifications' => '应用程序通知',
          'extracted.notifications_are_active' => '通知已激活',
          'extracted.app_language' => '应用程序语言',
          'extracted.support_center' => '支持中心',
          'extracted.send_feedback' => '发送反馈',
          'extracted.thank_you_for_your_support' => '感谢您的支持！ 🎉',
          'extracted.privacy_policy' => '隐私政策',
          'extracted.terms_and_rules_for_data_usage' => '数据使用条款和规则',
          'extracted.version_details_and_developer_info' => '版本详细信息和开发者信息',
          'extracted.email_support' => '电子邮件支持',
          'extracted.log_out' => '退出',
          'extracted.about_app' => '关于应用程序',
          'extracted.how_can_we_help_you' => '我们能为您提供什么帮助？',
          'extracted.call_hotline' => '拨打热线',
          'extracted.write_your_feedback_here' => '在这里写下您的反馈...',
          'extracted.submit_feedback' => '提交反馈',
          'extracted.add_department' => '添加部门',
          'extracted.students' => '学生',
          'extracted.departments' => '部门',
          'extracted.est' => '预计。',
          'extracted.department_name_ar' => '部门名称（AR）',
          'extracted.chat_with_us_on_whatsapp' => '通过 WhatsApp 与我们聊天',
          'extracted.thank_you_feedback_submitted' => '✅ 谢谢！已提交反馈。',
          'extracted.add_new_department' => '添加新部门',
          'extracted.your_support_matters' => '⭐ 您的支持很重要',
          'extracted.rate_the_app' => '评价应用程序',
          'extracted.test_notification' => '测试通知',
          'extracted.test_notification_sent' => '测试通知已发送！',
          'extracted.staff' => '职员',
          'extracted.add' => '添加',
          'extracted.building' => '建筑',
          'extracted.cancel' => '取消',
          'extracted.description' => '描述',
          'extracted.get_help_and_resolve_any_issues' => '获得帮助并解决任何问题',
          'extracted.disable_complex_visual_effects' => '禁用复杂的视觉效果',
          'extracted.view_all_your_notifications' => '查看您的所有通知',
          'extracted.your_opinion_helps_us_improve' => '您的意见有助于我们改进',
          'extracted.remove' => '消除',
          'extracted.asst' => '助理。',
          'extracted.share_your_thoughts_to_help_improve_the_' =>
            '分享您的想法以帮助改进应用程序',
          'extracted.confirm_removal' => '确认删除',
          'extracted.roles_management' => '角色管理',
          'extracted.head' => '头',
          'extracted.custom' => '风俗',
          'extracted.create_role' => '创建角色',
          'extracted.no_results' => '没有结果',
          'extracted.merge_roles' => '合并角色',
          'extracted.assistant_head' => '副主任',
          'extracted.add_faculty_member' => '添加教员',
          'extracted.search_roles' => '搜索角色...',
          'extracted.add_staff' => '添加员工',
          'extracted.create' => '创造',
          'extracted.department_name_en' => '部门名称（英文）',
          'extracted.no_assistant_assigned' => '没有分配助理',
          'extracted.department_code' => '部门代码',
          'extracted.add_faculty' => '添加教师',
          'extracted.merge' => '合并',
          'extracted.remove_staff_fullname_from_this_departme' =>
            ({required Object staffFullName}) => '将${staffFullName}从该部门中删除？',
          'extracted.no_faculty_members_assigned' => '没有分配教职人员',
          'extracted.create_a_new_role_or_merge_two_roles' => '创建新角色或合并两个角色',
          'extracted.could_not_load_custom_roles' => '无法加载自定义角色',
          'extracted.please_assign_an_assistant_head_for_the_' => '请指派一名部门助理主任',
          'extracted.category' => '类别',
          'extracted.make_sure_roles_table_exists_in_supabase' =>
            '确保 Supabase 中存在“角色”表',
          'extracted.permissions' => '权限',
          'extracted.name_english' => '姓名（英文）',
          'extracted.role_created' => '角色已创建',
          'extracted.description_arabic' => '说明（阿拉伯语）',
          'extracted.description_english' => '说明（英文）',
          'extracted.no_roles' => '没有角色',
          'extracted.merge_two_roles' => '合并两个角色',
          'extracted.create_new_role' => '创建新角色',
          'extracted.first_role' => '第一个角色',
          'extracted.name_arabic' => '姓名（阿拉伯语）',
          'extracted.second_role' => '第二个角色',
          'extracted.no_custom_roles_yet' => '还没有自定义角色',
          'extracted.edit_role' => '编辑角色',
          'extracted.delete_role' => '删除角色',
          'extracted.facilities' => '设施',
          'extracted.student_affairs' => '学生事务',
          'extracted.teaching' => '教学',
          'extracted.leadership' => '领导',
          'extracted.admin_it' => '行政与信息技术',
          'extracted.external' => '外部的',
          'extracted.quick_actions' => '快速行动',
          'extracted.delete' => '删除',
          'extracted.merged' => '合并',
          'extracted.user_details' => '用户详细信息',
          'extracted.verification' => '确认',
          'extracted.tags' => '标签',
          'extracted.danger_zone' => '危险区',
          'extracted.warning_level' => '警告级别',
          'extracted.activate' => '激活',
          'extracted.verified' => '已验证',
          'extracted.banned' => '禁止',
          'extracted.verify' => '核实',
          'extracted.unban' => '解禁',
          'extracted.permissions_1' => '权限：',
          'extracted.deactivate' => '停用',
          'extracted.unverify' => '取消验证',
          'extracted.delete_role_nameen_this_cannot_be_undone' =>
            ({required Object roleNameEn}) => '删除“${roleNameEn}”？此操作无法撤消。',
          'extracted.role_updated' => '角色更新',
          'extracted.ban_management' => '禁令管理',
          'extracted.ban' => '禁止',
          'extracted.not_verified' => '未验证',
          'extracted.created' => '已创建',
          'extracted.current_level' => '当前级别',
          'extracted.no_tags_assigned' => '没有分配标签',
          'extracted.nationality' => '国籍',
          'extracted.add_tag' => '添加标签',
          'extracted.last_login' => '上次登录',
          'extracted.merged_role_name_arabic' => '合并的角色名称（阿拉伯语）',
          'extracted.merged_role_name_english' => '合并后的角色名称（英文）',
          'extracted.merged_permissions_preview' => '合并权限预览',
          'extracted.roles_merged_successfully' => '角色合并成功',
          'extracted.select_two_roles_to_combine_their_permis' =>
            '选择两个角色来组合他们的权限',
          'extracted.ban_user' => '禁止用户',
          'extracted.permanently_delete' => '永久删除',
          'extracted.verify_account' => '验证账户',
          'extracted.unban_user_fullname' =>
            ({required Object userFullName}) => '解禁${userFullName}？',
          'extracted.user_has_normal_access' => '用户可以正常访问',
          'extracted.soft_delete_deactivate' => '软删除（停用）',
          'extracted.remove_verification' => '删除验证',
          'extracted.not_banned' => '未禁止',
          'extracted.verify_user_fullname' =>
            ({required Object userFullName}) => '验证${userFullName}',
          'extracted.account_verified' => '账户已验证',
          'extracted.user_banned' => '用户被禁止',
          'extracted.tag_name' => '标签名称',
          'extracted.warning_level_set_to_level' =>
            ({required Object level}) => '警告级别设置为${level}',
          'extracted.tag_removed' => '标签已删除',
          'extracted.unban_user' => '解封用户',
          'extracted.ban_user_fullname_they_will_lose_system_' =>
            ({required Object userFullName}) =>
                '禁止${userFullName}？他们将失去系统访问权限。',
          'extracted.identity_not_yet_verified' => '身份尚未验证',
          'extracted.user_identity_has_been_verified' => '用户身份已验证',
          'extracted.remove_verification_from_user_fullname' =>
            ({required Object userFullName}) => '从${userFullName}中删除验证？',
          'extracted.institution' => '机构',
          'extracted.user_cannot_access_the_system' => '用户无法访问系统',
          'extracted.exceeding' => '超越',
          'extracted.top_5' => '前 5%',
          'extracted.total' => '全部的',
          'extracted.grade' => '年级',
          'extracted.college_is_required' => '需要大学学历',
          'extracted.out_of_max' => ({required Object max}) => '超出${max}',
          'extracted.deactivate_user_fullname' =>
            ({required Object userFullName}) => '停用${userFullName}',
          'extracted.select_college' => '选择学院',
          'extracted.select_department' => '选择部门',
          'extracted.department_is_required' => '部门为必填项',
          'extracted.permanently_delete_user_fullname_this_ca' =>
            ({required Object userFullName}) => '永久删除${userFullName}？这无法撤销！',
          'extracted.soft_delete' => '软删除',
          'extracted.permanent_delete' => '永久删除',
          _ => null,
        };
  }
}

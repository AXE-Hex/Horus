import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'strings.g.dart';

class TranslationsDe extends Translations
    with BaseTranslations<AppLocale, Translations> {
  TranslationsDe({
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
             locale: AppLocale.de,
             overrides: overrides ?? {},
             cardinalResolver: cardinalResolver,
             ordinalResolver: ordinalResolver,
           ),
       super(
         cardinalResolver: cardinalResolver,
         ordinalResolver: ordinalResolver,
       ) {
    super.$meta.setFlatMapFunction($meta.getTranslation);
    $meta.setFlatMapFunction(_flatMapFunction);
  }

  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  @override
  dynamic operator [](String key) =>
      $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

  late final TranslationsDe _root = this;

  @override
  TranslationsDe $copyWith({
    TranslationMetadata<AppLocale, Translations>? meta,
  }) => TranslationsDe(meta: meta ?? this.$meta);

  @override
  late final _TranslationsCommonDe common = _TranslationsCommonDe._(_root);
  @override
  late final _TranslationsWelcomeDe welcome = _TranslationsWelcomeDe._(_root);
  @override
  late final _TranslationsOnboardingDe onboarding = _TranslationsOnboardingDe._(
    _root,
  );
  @override
  late final _TranslationsAuthDe auth = _TranslationsAuthDe._(_root);
  @override
  late final _TranslationsHomeDe home = _TranslationsHomeDe._(_root);
  @override
  late final _TranslationsDashboardDe dashboard = _TranslationsDashboardDe._(
    _root,
  );
  @override
  late final _TranslationsSettingsDe settings = _TranslationsSettingsDe._(
    _root,
  );
  @override
  late final _TranslationsCollegesDe colleges = _TranslationsCollegesDe._(
    _root,
  );
  @override
  late final _TranslationsTranscriptDe transcript = _TranslationsTranscriptDe._(
    _root,
  );
  @override
  late final _TranslationsAcademicProgressDe academic_progress =
      _TranslationsAcademicProgressDe._(_root);
  @override
  late final _TranslationsGradesDe grades = _TranslationsGradesDe._(_root);
  @override
  late final _TranslationsSubjectResultsDe subject_results =
      _TranslationsSubjectResultsDe._(_root);
  @override
  late final _TranslationsActionPlanDe action_plan =
      _TranslationsActionPlanDe._(_root);
  @override
  late final _TranslationsCoursesDe courses = _TranslationsCoursesDe._(_root);
  @override
  late final _TranslationsScheduleDe schedule = _TranslationsScheduleDe._(
    _root,
  );
  @override
  late final _TranslationsExamScheduleDe exam_schedule =
      _TranslationsExamScheduleDe._(_root);
  @override
  late final _TranslationsAttendanceDe attendance = _TranslationsAttendanceDe._(
    _root,
  );
  @override
  late final _TranslationsRegistrationDe registration =
      _TranslationsRegistrationDe._(_root);
  @override
  late final _TranslationsPaymentDe payment = _TranslationsPaymentDe._(_root);
  @override
  late final _TranslationsInvoicesDe invoices = _TranslationsInvoicesDe._(
    _root,
  );
  @override
  late final _TranslationsNotificationsDe notifications =
      _TranslationsNotificationsDe._(_root);
  @override
  late final _TranslationsSupportDe support = _TranslationsSupportDe._(_root);
  @override
  late final _TranslationsSecurityDe security = _TranslationsSecurityDe._(
    _root,
  );
  @override
  late final _TranslationsTutorialsDe tutorials = _TranslationsTutorialsDe._(
    _root,
  );
  @override
  late final _TranslationsForumsDe forums = _TranslationsForumsDe._(_root);
  @override
  late final _TranslationsAdministrationDe administration =
      _TranslationsAdministrationDe._(_root);
  @override
  late final _TranslationsFeedDe feed = _TranslationsFeedDe._(_root);
  @override
  late final _TranslationsProfessorDe professor = _TranslationsProfessorDe._(
    _root,
  );
  @override
  late final _TranslationsRolesDe roles = _TranslationsRolesDe._(_root);
  @override
  late final _TranslationsAcademicDe academic = _TranslationsAcademicDe._(
    _root,
  );
  @override
  late final _TranslationsAdminDe admin = _TranslationsAdminDe._(_root);
  @override
  late final _TranslationsEnrollmentDe enrollment = _TranslationsEnrollmentDe._(
    _root,
  );
  @override
  late final _TranslationsSharedDe shared = _TranslationsSharedDe._(_root);
  @override
  late final _TranslationsStudentsDe students = _TranslationsStudentsDe._(
    _root,
  );
  @override
  late final _TranslationsExtractedDe extracted = _TranslationsExtractedDe._(
    _root,
  );
}

class _TranslationsCommonDe extends TranslationsCommonEn {
  _TranslationsCommonDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get close => 'Schließen';
  @override
  String get cancel => 'Abbrechen';
  @override
  String get confirm => 'Bestätigen';
  @override
  String get save => 'Speichern';
  @override
  String get back => 'Zurück';
}

class _TranslationsWelcomeDe extends TranslationsWelcomeEn {
  _TranslationsWelcomeDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Willkommen bei Hue';
  @override
  String get subtitle =>
      'Erleuchten Sie Ihre Welt mit bedeutungsvollen Verbindungen.';
  @override
  String get get_started => 'Loslegen';
  @override
  String get have_account => 'Ich habe bereits ein Konto';
  @override
  String get student_portal => 'Studentenportal';
  @override
  String get welcome_to_the_smart_universit =>
      'Willkommen an der Smart University';
  @override
  String get i_already_have_an_account => 'Ich habe bereits ein Konto';
}

class _TranslationsOnboardingDe extends TranslationsOnboardingEn {
  _TranslationsOnboardingDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  late final _TranslationsOnboardingLanguageDe language =
      _TranslationsOnboardingLanguageDe._(_root);
  @override
  late final _TranslationsOnboardingFacultiesDirectoryDe faculties_directory =
      _TranslationsOnboardingFacultiesDirectoryDe._(_root);
  @override
  late final _TranslationsOnboardingStyleDe style =
      _TranslationsOnboardingStyleDe._(_root);
  @override
  late final _TranslationsOnboardingThemeDe theme =
      _TranslationsOnboardingThemeDe._(_root);
  @override
  String get choose_app_style => 'Wählen Sie Ihren App-Stil';
  @override
  String get premium_frosted_glass_blur_eff =>
      'Erstklassiger Unschärfeeffekt aus Milchglas';
  @override
  String get choose_app_theme => 'Wählen Sie Ihr Thema';
  @override
  String get title => 'Onboarding';
  @override
  String get you_can_switch_styles_later_in =>
      'Sie können den Stil später in den Einstellungen ändern';
  @override
  String get choose_language => 'Wählen Sie Ihre Sprache';
  @override
  String get you_can_change_this_later_in_s =>
      'Sie können dies später in den Einstellungen ändern';
  @override
  String get recommended => 'Empfohlen';
  @override
  String get high_performance_flat_solid_co =>
      'Leistungsstarke, flache Volltonfarben';
  @override
  String get select_the_lighting_that_suits =>
      'Wählen Sie die Beleuchtung, die am besten zu Ihnen passt';
  @override
  String get almost_there_just_one_more_ste =>
      'Fast geschafft! Nur noch ein Schritt.';
  @override
  String get classic_solid => 'Klassiker';
  @override
  String get dark_mode => 'Dunkler Modus';
  @override
  String get light_mode => 'Lichtmodus';
  @override
  String get modern_glass => 'Modernes Glas';
}

class _TranslationsAuthDe extends TranslationsAuthEn {
  _TranslationsAuthDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  late final _TranslationsAuthLoginDe login = _TranslationsAuthLoginDe._(_root);
  @override
  late final _TranslationsAuthForgotPasswordDe forgot_password =
      _TranslationsAuthForgotPasswordDe._(_root);
  @override
  String get back => 'Zurück';
  @override
  String get choose_account_recovery_method =>
      'Wählen Sie die Methode zur Kontowiederherstellung';
}

class _TranslationsHomeDe extends TranslationsHomeEn {
  _TranslationsHomeDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  late final _TranslationsHomeTabsDe tabs = _TranslationsHomeTabsDe._(_root);
  @override
  String get student => 'Student';
  @override
  String get colleges => 'Hochschulen';
  @override
  String get admin_portal => 'Admin-Portal';
  @override
  String get admin => 'Admin';
  @override
  String get prof => 'Professor';
  @override
  String get home => 'Heim';
  @override
  String get student_portal => 'Studentenportal';
  @override
  String get faculty_portal => 'Fakultätsportal';
}

class _TranslationsDashboardDe extends TranslationsDashboardEn {
  _TranslationsDashboardDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  late final _TranslationsDashboardIdCardDe id_card =
      _TranslationsDashboardIdCardDe._(_root);
  @override
  late final _TranslationsDashboardSectionsDe sections =
      _TranslationsDashboardSectionsDe._(_root);
  @override
  late final _TranslationsDashboardItemsDe items =
      _TranslationsDashboardItemsDe._(_root);
  @override
  late final _TranslationsDashboardLabelsDe labels =
      _TranslationsDashboardLabelsDe._(_root);
}

class _TranslationsSettingsDe extends TranslationsSettingsEn {
  _TranslationsSettingsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Einstellungen';
  @override
  late final _TranslationsSettingsSectionsDe sections =
      _TranslationsSettingsSectionsDe._(_root);
  @override
  late final _TranslationsSettingsTilesDe tiles =
      _TranslationsSettingsTilesDe._(_root);
  @override
  late final _TranslationsSettingsMessagesDe messages =
      _TranslationsSettingsMessagesDe._(_root);
  @override
  String get about_app => 'Über App';
  @override
  String get university => 'Horus-Universität';
  @override
  String get developer => 'Entwickler';
  @override
  String get horus_university => 'Horus-Universität – Ägypten';
  @override
  String get password_must_be_at_least_6_ch =>
      'Das Passwort muss mindestens 6 Zeichen lang sein';
  @override
  String get backend => 'Backend';
  @override
  String get platform => 'Plattform';
  @override
  String get change_password => 'Kennwort ändern';
  @override
  String get user => 'Benutzer';
  @override
  String get hue_portal_is_a_comprehensive_ =>
      'HUE Portal ist ein umfassendes intelligentes Universitätsverwaltungssystem.';
  @override
  String get password_changed_successfully => 'Passwort erfolgreich geändert';
  @override
  String get passwords_do_not_match => 'Passwörter stimmen nicht überein';
  @override
  String get please_fill_all_fields => 'Bitte füllen Sie alle Felder aus';
  @override
  String get enter_your_new_password =>
      'Geben Sie unten Ihr neues Passwort ein';
  @override
  String get new_password => 'Neues Passwort';
  @override
  String get confirm_password => 'Passwort bestätigen';
  @override
  String get privacy_policy => 'Datenschutzrichtlinie';
  @override
  String get last_updated_february_2026 =>
      'Letzte Aktualisierung: Februar 2026';
  @override
  String get edit_profile => 'Profil bearbeiten';
  @override
  String get full_name => 'Vollständiger Name';
  @override
  String get email => 'E-Mail';
  @override
  String get update_your_info_and_contact_d =>
      'Aktualisieren Sie Ihre Informationen und Kontaktdaten';
  @override
  String get phone => 'Telefon';
  @override
  String get send_password_recovery_link_to =>
      'Senden Sie den Link zur Passwortwiederherstellung per E-Mail';
  @override
  String get change_password_and_security_l =>
      'Passwort und Sicherheitsstufe ändern';
  @override
  String get toggle_between_dark_and_light_ =>
      'Wechseln Sie zwischen dunklem und hellem Modus';
  @override
  String get current_glass_design => 'Aktuell: Glasdesign';
  @override
  String get forgot_password => 'Passwort vergessen';
  @override
  String get role => 'Rolle';
  @override
  String get switch_style => 'Stil wechseln';
  @override
  String get bio => 'Bio';
  @override
  String get current_classic_design => 'Aktuell: Klassisches Design';
  @override
  String get control_the_types_of_incoming_ =>
      'Steuern Sie die Arten eingehender Benachrichtigungen';
  @override
  String get save => 'Speichern';
  @override
  String get test_notification_successful =>
      'Testbenachrichtigung erfolgreich gesendet!';
  @override
  String get send_a_test_notification => 'Senden Sie eine Testbenachrichtigung';
  @override
  String get battery_saver_mode => 'Batteriesparmodus';
  @override
  String get help_support_center => 'Hilfe- und Supportcenter';
  @override
  String get disable_complex_visual_effects =>
      'Deaktivieren Sie komplexe visuelle Effekte für eine bessere Leistung';
  @override
  String get version_details_and_developers =>
      'Versionsdetails und Entwicklerinformationen';
  @override
  String get contact_us_to_resolve_any_issu =>
      'Kontaktieren Sie uns, um jedes Problem zu lösen';
  @override
  String get terms_and_rules_for_data_usage =>
      'Bedingungen und Regeln für die Datennutzung';
  @override
  String get kSwitch => 'Schalten';
  @override
  String get deutsch => 'Deutsch';
  @override
  String get select_app_language => 'Wählen Sie App-Sprache aus';
  @override
  String get switch_label => 'Schalten';
  @override
  String get dynamic_val => 'Dynamisch';
}

class _TranslationsCollegesDe extends TranslationsCollegesEn {
  _TranslationsCollegesDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  late final _TranslationsCollegesDetailsDe details =
      _TranslationsCollegesDetailsDe._(_root);
  @override
  String get applied_health_sciences =>
      'Fakultät für angewandte Gesundheitswissenschaften';
  @override
  String get business_administration => 'Fakultät für Betriebswirtschaft';
  @override
  String get dentistry => 'Fakultät für Zahnmedizin';
  @override
  String get engineering => 'Fakultät für Ingenieurwissenschaften';
  @override
  String get fine_arts => 'Fakultät für Bildende Künste';
  @override
  String get human_medicine => 'Fakultät für Humanmedizin';
  @override
  String get linguistics => 'Fakultät für Linguistik & Übersetzung';
  @override
  String get pharmacy => 'Fakultät für Pharmazie';
  @override
  String get physical_therapy => 'Fakultät für Physiotherapie';
  @override
  String get ai => 'Fakultät für Künstliche Intelligenz';
  @override
  late final _TranslationsCollegesDepartmentsDe departments =
      _TranslationsCollegesDepartmentsDe._(_root);
}

class _TranslationsTranscriptDe extends TranslationsTranscriptEn {
  _TranslationsTranscriptDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Akademisches Transkript';
  @override
  late final _TranslationsTranscriptOverviewDe overview =
      _TranslationsTranscriptOverviewDe._(_root);
  @override
  late final _TranslationsTranscriptSemesterDe semester =
      _TranslationsTranscriptSemesterDe._(_root);
  @override
  late final _TranslationsTranscriptCourseDe course =
      _TranslationsTranscriptCourseDe._(_root);
}

class _TranslationsAcademicProgressDe extends TranslationsAcademicProgressEn {
  _TranslationsAcademicProgressDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Akademischer Fortschritt';
  @override
  String get completion => 'Abschlussgrad';
  @override
  String get total_credits => 'Gesamt-Credits';
  @override
  late final _TranslationsAcademicProgressCategoriesDe categories =
      _TranslationsAcademicProgressCategoriesDe._(_root);
  @override
  late final _TranslationsAcademicProgressStatusDe status =
      _TranslationsAcademicProgressStatusDe._(_root);
}

class _TranslationsGradesDe extends TranslationsGradesEn {
  _TranslationsGradesDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Semesternoten';
  @override
  String get grade_point => 'Notenpunkte';
  @override
  String get letter_grade => 'Notenbuchstabe';
  @override
  String get gpa => 'Semester-GPA';
  @override
  String get summary => 'Notenzusammenfassung';
  @override
  String get cumulative_gpa => 'Kumulierter GPA';
  @override
  String get credits => 'Credits';
}

class _TranslationsSubjectResultsDe extends TranslationsSubjectResultsEn {
  _TranslationsSubjectResultsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Fachergebnisse';
  @override
  String get midterm => 'Zwischenprüfung';
  @override
  String get kFinal => 'Abschlussprüfung';
  @override
  String get practical => 'Praktikum';
  @override
  String get activities => 'Semesteraktivitäten';
  @override
  String get total => 'Gesamtpunktzahl';
}

class _TranslationsActionPlanDe extends TranslationsActionPlanEn {
  _TranslationsActionPlanDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Grad-Aktionsplan';
  @override
  String get roadmap => 'Kurs-Roadmap';
  @override
  String get year_1 => 'Erstes Jahr';
  @override
  String get year_2 => 'Zweites Jahr';
  @override
  String get year_3 => 'Drittes Jahr';
  @override
  String get year_4 => 'Viertes Jahr';
}

class _TranslationsCoursesDe extends TranslationsCoursesEn {
  _TranslationsCoursesDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Meine Kurse';
  @override
  String get enrolled => 'Eingeschrieben';
  @override
  String get available => 'Verfügbar';
  @override
  String get instructor => 'Dozent';
  @override
  String get schedule => 'Zeitplan';
}

class _TranslationsScheduleDe extends TranslationsScheduleEn {
  _TranslationsScheduleDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Stundenplan';
  @override
  String get time => 'Zeit';
  @override
  String get room => 'Raum';
  @override
  String get monday => 'Montag';
  @override
  String get tuesday => 'Dienstag';
  @override
  String get wednesday => 'Mittwoch';
  @override
  String get thursday => 'Donnerstag';
  @override
  String get friday => 'Freitag';
  @override
  String get saturday => 'Samstag';
  @override
  String get sunday => 'Sonntag';
  @override
  String get instructor => 'Dozent';
  @override
  String get doctor => 'Dr.';
  @override
  String get type_lecture => 'Vorlesung';
  @override
  String get type_section => 'Übung';
  @override
  String get status_active => 'Anstehend';
  @override
  String get status_started => 'Jetzt';
  @override
  String get status_cancelled => 'Abgesagt';
  @override
  String get status_online => 'Online';
  @override
  String get status_substitute => 'Ersatz';
  @override
  String get morning => 'Vormittag';
  @override
  String get afternoon => 'Nachmittag';
  @override
  String get evening => 'Abend';
  @override
  String get all_periods => 'Alle Zeiträume';
  @override
  String get floor => 'Etage';
  @override
  String get direction => 'Richtung';
  @override
  String get east => 'Osten';
  @override
  String get west => 'Westen';
  @override
  String get south => 'Süden';
  @override
  String get north => 'Norden';
  @override
  String get no_lectures => 'Keine Vorlesungen gefunden';
  @override
  String get daily_title => 'Tagesplan';
}

class _TranslationsExamScheduleDe extends TranslationsExamScheduleEn {
  _TranslationsExamScheduleDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Prüfungsplan';
  @override
  String get date => 'Datum';
  @override
  String get duration => 'Dauer';
  @override
  String get seat => 'Sitznummer';
}

class _TranslationsAttendanceDe extends TranslationsAttendanceEn {
  _TranslationsAttendanceDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Anwesenheitsstatistik';
  @override
  String get present => 'Anwesend';
  @override
  String get absent => 'Abwesend';
  @override
  String get late => 'Verspätet';
  @override
  String get ratio => 'Anwesenheitsquote';
  @override
  late final _TranslationsAttendanceSubjectsDe subjects =
      _TranslationsAttendanceSubjectsDe._(_root);
}

class _TranslationsRegistrationDe extends TranslationsRegistrationEn {
  _TranslationsRegistrationDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Kursregistrierung';
  @override
  String get submit => 'Registrierung absenden';
  @override
  String get enrolled_credits => 'Eingeschriebene Credits';
  @override
  String group_label({required Object group}) => 'Gruppe${group}';
  @override
  String get step2_title => 'Schritt 2: Wählen Sie Unterabschnitt';
  @override
  String get step1_title => 'Schritt 1: Wählen Sie Hauptgruppe';
  @override
  String get step1_subtitle =>
      'Wählen Sie die Hauptgruppe aus, für die Sie sich in diesem Semester anmelden möchten.';
  @override
  String step2_subtitle({required Object group}) =>
      'Ausgewählte Gruppe:${group}. Wählen Sie nun Ihren praktischen Teilbereich aus.';
  @override
  String section_label({required Object section}) => 'Abschnitt${section}';
  @override
  String get semester => 'Semester';
  @override
  String get labs_sessions => 'Labore und praktische Sitzungen';
  @override
  String get review => 'Überprüfen Sie die Auswahl';
  @override
  String get section => 'Abschnitt';
  @override
  String get step3_title => 'Schritt 3: Bestätigen Sie die Registrierung';
  @override
  String get main_cohort => 'Registrierung der Hauptkohorte';
  @override
  String get group => 'Gruppe';
  @override
  String get auto_registered => 'Automatisch anzumeldende Kurse:';
  @override
  String credits_count({required Object credits}) => '${credits}CR';
  @override
  String get confirm_final => 'Bestätigen Sie die endgültige Registrierung';
  @override
  String get back_home => 'Zurück nach Hause';
  @override
  String success_message({required Object group, required Object section}) =>
      'Sie haben sich erfolgreich für dieses Semester angemeldet.\nGruppe:${group}| Abschnitt:${section}';
  @override
  String get registration_success => 'Registrierung erfolgreich!';
  @override
  String get already_registered_title => 'Bereits registriert!';
  @override
  String error_loading({required Object error}) =>
      'Fehler:${error}Tippen Sie, um es noch einmal zu versuchen';
}

class _TranslationsPaymentDe extends TranslationsPaymentEn {
  _TranslationsPaymentDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Studiengebühren';
  @override
  String get outstanding => 'Offener Betrag';
  @override
  String get pay_now => 'Jetzt bezahlen';
  @override
  String get methods => 'Zahlungsmethoden';
  @override
  String get university_guaranteed =>
      'Von der Universität garantierte Methoden';
  @override
  String get bank_transfer => 'Banküberweisung';
  @override
  String get fawry => 'Fawry / E-Payment';
  @override
  String get credit_debit => 'Kredit-/Debitkarte';
  @override
  String currency({required Object amount}) => '${amount}EGP';
}

class _TranslationsInvoicesDe extends TranslationsInvoicesEn {
  _TranslationsInvoicesDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Rechnungen';
  @override
  String get history => 'Zahlungshistorie';
  @override
  String get unpaid => 'Unbezahlt';
  @override
  String get paid => 'Bezahlt';
  @override
  String get date => 'Datum';
  @override
  String get amount => 'Menge';
  @override
  String get id => 'Rechnungs-ID';
  @override
  String get status => 'Status';
}

class _TranslationsNotificationsDe extends TranslationsNotificationsEn {
  _TranslationsNotificationsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Benachrichtigungen';
  @override
  String get empty => 'Keine neuen Benachrichtigungen';
}

class _TranslationsSupportDe extends TranslationsSupportEn {
  _TranslationsSupportDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Support & Hilfe';
  @override
  String get contact_us => 'Kontaktieren Sie uns';
}

class _TranslationsSecurityDe extends TranslationsSecurityEn {
  _TranslationsSecurityDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Sicherheit';
  @override
  String get biometrics => 'Biometrie';
  @override
  String get sessions => 'Aktive Sitzungen';
}

class _TranslationsTutorialsDe extends TranslationsTutorialsEn {
  _TranslationsTutorialsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Tutorials & Leitfäden';
}

class _TranslationsForumsDe extends TranslationsForumsEn {
  _TranslationsForumsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Foren';
}

class _TranslationsAdministrationDe extends TranslationsAdministrationEn {
  _TranslationsAdministrationDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Studentenverwaltung';
  @override
  String get stats => 'Systemstatistik';
  @override
  String get users => 'Benutzer';
  @override
  String get reports => 'Berichte';
  @override
  late final _TranslationsAdministrationAuditLogsDe audit_logs =
      _TranslationsAdministrationAuditLogsDe._(_root);
}

class _TranslationsFeedDe extends TranslationsFeedEn {
  _TranslationsFeedDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get hours_ago => 'Vor Stunden';
  @override
  String get likes => 'mag';
  @override
  String get caption_sample =>
      'Dies ist eine Beispielbeschriftung für einen Beitrag';
}

class _TranslationsProfessorDe extends TranslationsProfessorEn {
  _TranslationsProfessorDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get dashboard_title => 'Professor-Dashboard';
  @override
  String welcome_back_name({required Object name}) =>
      'Willkommen zurück,${name}';
  @override
  String uploaded_files_count({required Object count}) =>
      'Von${count}hochgeladene Dateien';
  @override
  String announcement_to({required Object count}) => 'An${count}melden';
  @override
  String weekly_slots_count({required Object count}) =>
      'Wöchentliche${count}-Slots';
  @override
  String get preparing_announcement => 'Ankündigung wird vorbereitet...';
  @override
  String active_tas_count({required Object count}) => '${count}Aktive TAs';
  @override
  String total_students_count({required Object count}) =>
      '${count}Gesamtzahl der Studierenden';
  @override
  String get no_groups => 'Keine Gruppen verfügbar';
  @override
  String get select_all => 'Wählen Sie „Alle“ aus';
  @override
  String activating({required Object target}) => 'Aktivieren:${target}';
  @override
  String action_clicked({required Object action}) => 'Angeklickt:${action}';
  @override
  String get deselect_all => 'Alle abwählen';
  @override
  String get add_new_ta => 'Neuen TA hinzufügen';
  @override
  String selected_count({required Object count}) => '${count}Ausgewählt';
  @override
  String get no_available_tas => 'Keine verfügbaren TAs';
  @override
  String added({required Object name}) => 'Hinzugefügt:${name}';
  @override
  String get no_active_tas => 'Keine aktiven TAs';
  @override
  String removed({required Object name}) => 'Entfernt:${name}';
  @override
  String get add => 'Hinzufügen';
  @override
  String get urgent => 'Dringend';
  @override
  String get message => 'Nachricht';
  @override
  String joined({required Object name}) => 'Beigetreten:${name}';
  @override
  String get downloading => 'Herunterladen...';
  @override
  String get walk_in => 'Begehbar';
  @override
  String get join => 'Verbinden';
  @override
  String get upload => 'Hochladen';
  @override
  late final _TranslationsProfessorStatsDe stats =
      _TranslationsProfessorStatsDe._(_root);
  @override
  late final _TranslationsProfessorQuickActionsDe quick_actions =
      _TranslationsProfessorQuickActionsDe._(_root);
  @override
  late final _TranslationsProfessorProfileDe profile =
      _TranslationsProfessorProfileDe._(_root);
}

class _TranslationsRolesDe extends TranslationsRolesEn {
  _TranslationsRolesDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  late final _TranslationsRolesCategoriesDe categories =
      _TranslationsRolesCategoriesDe._(_root);
  @override
  late final _TranslationsRolesNamesDe names = _TranslationsRolesNamesDe._(
    _root,
  );
  @override
  late final _TranslationsRolesDescriptionsDe descriptions =
      _TranslationsRolesDescriptionsDe._(_root);
}

class _TranslationsAcademicDe extends TranslationsAcademicEn {
  _TranslationsAcademicDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get academic_progress => 'Akademischer Fortschritt';
  @override
  String get electives => 'Wahlfächer';
  @override
  String get courses_title => 'Meine Kurse';
  @override
  String get university_requirements => 'Anforderungen der Universität';
  @override
  String get faculty_requirements => 'Anforderungen der Fakultät';
  @override
  String get major_requirements => 'Hauptanforderungen';
  @override
  String get remaining => 'Übrig';
  @override
  String get action_plan_title => 'Abschluss-Aktionsplan';
  @override
  String get grades_title => 'Noten';
  @override
  String get transcript_title => 'Akademisches Transkript';
  @override
  String get completed => 'Vollendet';
  @override
  String get attendance_title => 'Teilnahme';
  @override
  String get subject_results_title => 'Betreffergebnisse';
  @override
  String get schedule_title => 'Zeitplan';
  @override
  String get exam_schedule_title => 'Prüfungsplan';
  @override
  String get professor_dashboard => 'Professor-Dashboard';
  @override
  String get tas => 'Lehrassistenten';
  @override
  String get groups => 'Gruppen';
  @override
  String get all_students => 'Alle Studenten';
  @override
  String get office_hours => 'Bürozeiten';
  @override
  String get no_groups => 'Keine Gruppen';
  @override
  String get chat => 'Chatten';
  @override
  String get courses => 'Kurse';
  @override
  String get inactive => 'Inaktiv';
  @override
  String get assignments => 'Aufgaben';
  @override
  String get active => 'Aktiv';
  @override
  String get add_ta => 'TA hinzufügen';
  @override
  String get remove_ta => 'TA entfernen';
  @override
  String get view_all => 'Alle anzeigen';
  @override
  String get send_message => 'Nachricht senden';
  @override
  String get feedback => 'Rückmeldung';
  @override
  String get all => 'Alle';
  @override
  String get upload_file => 'Datei hochladen';
  @override
  String get urgent_announcement => 'Dringende Ankündigung';
  @override
  String get group_label => 'Gruppe';
  @override
  String get manage_tas => 'TAs verwalten';
  @override
  String get section => 'Abschnitt';
  @override
  String get manage_groups => 'Gruppen verwalten';
  @override
  String get profile => 'Profil';
  @override
  String get gpa => 'Notendurchschnitt';
  @override
  String get grade_summary => 'Notenzusammenfassung';
  @override
  String get credits => 'Credits';
  @override
  String get midterm => 'Halbzeit';
  @override
  String get semester_grades => 'Semesternoten';
  @override
  String get total => 'Gesamt';
  @override
  String get practical => 'Praktisch';
  @override
  String get kFinal => 'Abschlussprüfung';
  @override
  String get year_1 => 'Jahr 1';
  @override
  String get year_2 => 'Jahr 2';
  @override
  String get year_4 => 'Jahr 4';
  @override
  String get year_3 => 'Jahr 3';
  @override
  String get enrolled => 'Eingeschrieben';
  @override
  String get available => 'Verfügbar';
  @override
  String get instructor => 'Lehrer';
  @override
  String get schedule_info => 'Zeitplan';
  @override
  String get time => 'Zeit';
  @override
  String get room => 'Zimmer';
  @override
  String get seat => 'Sitz';
  @override
  String get duration => 'Dauer';
  @override
  String get exam_date => 'Prüfungsdatum';
  @override
  String get present => 'Gegenwärtig';
  @override
  String get absent => 'Abwesend';
  @override
  String get late => 'Spät';
  @override
  String get error => 'Fehler';
  @override
  String get retry => 'Wiederholen';
  @override
  String get no_data => 'Keine Daten verfügbar';
  @override
  String get ratio => 'Verhältnis';
  @override
  String get filter => 'Filter';
  @override
  String get back => 'Zurück';
  @override
  String get search => 'Suchen';
  @override
  String get loading => 'Laden...';
  @override
  String get cancel => 'Stornieren';
  @override
  String get save => 'Speichern';
  @override
  String get delete => 'Löschen';
  @override
  String get edit => 'Bearbeiten';
  @override
  String get add => 'Hinzufügen';
  @override
  String get remove => 'Entfernen';
  @override
  String get send => 'Schicken';
  @override
  String get academic_journey => 'Akademische Reise';
  @override
  String get academic_results => 'Akademische Ergebnisse';
  @override
  String get close => 'Schließen';
  @override
  String get confirm => 'Bestätigen';
  @override
  String get academic_standing_excellent => 'Exzellent';
  @override
  String get across_all_groups => 'Über alle Gruppen hinweg';
  @override
  String get action_plan => 'Abschluss-Aktionsplan';
  @override
  String get add_to_calendar => 'Zum Kalender hinzufügen';
  @override
  String get advanced_learning => 'Fortgeschrittenes Lernen';
  @override
  String get add_new_ta => 'Neuen TA hinzufügen';
  @override
  String get added_successfully => 'Erfolgreich hinzugefügt';
  @override
  String get advanced_mathematics => 'Fortgeschrittene Mathematik';
  @override
  String get advisor_assignment => 'Berateraufgabe';
  @override
  String get algorithms => 'Algorithmen';
  @override
  String get are_you_sure_you_want_to_remov =>
      'Sind Sie sicher, dass Sie diesen TA entfernen möchten?';
  @override
  String get artificial_intelligence => 'Künstliche Intelligenz';
  @override
  String get code_review => 'Codeüberprüfung';
  @override
  String get clicked => 'Angeklickt';
  @override
  String get calculus_i => 'Kalkül I';
  @override
  String get completed_1 => 'Vollendet';
  @override
  String get completion_rate => 'Abschlussrate';
  @override
  String get comp_organization => 'Computerorganisation';
  @override
  String get computer_programming => 'Computerprogrammierung';
  @override
  String get course_management => 'Kursmanagement';
  @override
  String get coursework => 'Kursarbeit';
  @override
  String get confirm_removal => 'Bestätigen Sie das Entfernen';
  @override
  String get cs402_artificial_intelligence => 'CS402 Künstliche Intelligenz';
  @override
  String get credits_1 => 'Credits';
  @override
  String get cs410_computer_vision => 'CS410 Computer Vision';
  @override
  String get d_mmmm => 'd MMMM';
  @override
  String get cumulative_gpa => 'Kumulierter GPA';
  @override
  String get cs405_machine_learning => 'CS405 Maschinelles Lernen';
  @override
  String get data_structures => 'Datenstrukturen';
  @override
  String get database_systems => 'Datenbanksysteme';
  @override
  String get dr_alan_turing => 'Alan Turing';
  @override
  String get days => 'Tage';
  @override
  String get dr_ada_lovelace => 'Ada Lovelace';
  @override
  String get deep_learning => 'Tiefes Lernen';
  @override
  String get dr_sarah_ahmed => 'Dr. Sarah Ahmed';
  @override
  String get english_composition => 'Englische Komposition';
  @override
  String get ethics_in_it => 'Ethik in der IT';
  @override
  String get exam_schedule => 'Prüfungsplan';
  @override
  String get field_internship => 'Feldpraktikum';
  @override
  String get file_title => 'Dateititel';
  @override
  String get dr_robert_smith => 'Dr. Robert Smith';
  @override
  String get file_will_be_uploaded_to_cloud =>
      'Die Datei wird in den Cloud-Speicher hochgeladen';
  @override
  String get fall_2023 => 'Herbst 2023';
  @override
  String get final_exam => 'Abschlussprüfung';
  @override
  String get foundational_skills => 'Grundlegende Fähigkeiten';
  @override
  String get general_physics => 'Allgemeine Physik';
  @override
  String get frontend_ui => 'Frontend-Benutzeroberfläche';
  @override
  String get graduation_mastery => 'Abschluss-Meisterschaft';
  @override
  String get graduation_progress => 'Abschlussfortschritt';
  @override
  String get graduation_project => 'Abschlussprojekt';
  @override
  String get hall_1 => 'Halle 1';
  @override
  String get hum210_professional_ethics => 'HUM210 Berufsethik';
  @override
  String get hours => 'Std';
  @override
  String get hall_4 => 'Halle 4';
  @override
  String get intro_to_programming => 'Einführung in die Programmierung';
  @override
  String get intro_to_ai => 'Einführung in die KI';
  @override
  String get lab_12 => 'Labor 12';
  @override
  String get lab_final => 'Laborfinale';
  @override
  String get lecture_hall_2 => 'Hörsaal 2';
  @override
  String get joined => 'Beigetreten';
  @override
  String get lecture => 'Vortrag';
  @override
  String get live_now => 'Lebe jetzt';
  @override
  String get linear_algebra => 'Lineare Algebra';
  @override
  String get logic_design => 'Logikdesign';
  @override
  String get machine_learning => 'Maschinelles Lernen';
  @override
  String get live => 'Live';
  @override
  String get mathematics => 'Mathematik';
  @override
  String get mat301_advanced_calculus => 'MAT301 Erweiterte Berechnung';
  @override
  String get members => 'Mitglieder';
  @override
  String get messages => 'Nachrichten';
  @override
  String get midterm_exam => 'Zwischenprüfung';
  @override
  String get mins => 'Min';
  @override
  String get next_exam_in => 'Nächste Prüfung in';
  @override
  String get network_security => 'Netzwerksicherheit';
  @override
  String get no_available_tas_currently => 'Derzeit sind keine TAs verfügbar';
  @override
  String get no_exams_on_this_day =>
      'An diesem Tag finden keine Prüfungen statt';
  @override
  String get no_tas_assigned_yet => 'Noch keine TAs zugewiesen';
  @override
  String get performance_distribution => 'Leistungsverteilung';
  @override
  String get points => 'Punkte';
  @override
  String get overall_progress => 'Gesamtfortschritt';
  @override
  String get overall_attendance => 'Gesamtanwesenheit';
  @override
  String get practical_project => 'Praktisches Projekt';
  @override
  String get prof_john_doe => 'Prof. John Doe';
  @override
  String get programming_basics => 'Programmiergrundlagen';
  @override
  String get progress => 'Fortschritt';
  @override
  String get quick_actions => 'Schnelle Aktionen';
  @override
  String get quiz_2 => 'Quiz 2';
  @override
  String get psychology => 'Psychologie';
  @override
  String get quiz_1 => 'Quiz 1';
  @override
  String get rank => 'Rang';
  @override
  String get rating => 'Bewertung';
  @override
  String get removed_successfully => 'Erfolgreich entfernt';
  @override
  String get score => 'Punktzahl';
  @override
  String get select_a_ta_from_the_list_to_a =>
      'Wählen Sie einen TA aus der Liste aus, den Sie hinzufügen möchten';
  @override
  String get results_analysis => 'Ergebnisanalyse';
  @override
  String get sessions_this_week => 'Sitzungen diese Woche';
  @override
  String get shared_files => 'Freigegebene Dateien';
  @override
  String get specialization_projects => 'Spezialisierungsprojekte';
  @override
  String get registration_requests => 'Registrierungsanfragen';
  @override
  String get spring_2024 => 'Frühling 2024';
  @override
  String get start_by_adding_the_first_ta_f =>
      'Fügen Sie zunächst den ersten TA für Ihren Kurs hinzu';
  @override
  String get sophomore => 'Zweitsemester';
  @override
  String get students => 'Studenten';
  @override
  String get summer_2024 => 'Sommer 2024';
  @override
  String get total_students => 'Gesamtzahl der Studierenden';
  @override
  String get track_project_i => 'Verfolgen Sie Projekt I';
  @override
  String get type_a_message => 'Geben Sie eine Nachricht ein...';
  @override
  String get ta_team_chat => 'TA-Team-Chat';
  @override
  String get upload => 'Hochladen';
  @override
  String get upload_files => 'Dateien hochladen';
  @override
  String get uploaded_successfully => 'Erfolgreich hochgeladen';
  @override
  String get urgent_news => 'Dringende Neuigkeiten';
  @override
  String get web_programming => 'Webprogrammierung';
  @override
  String get upload_new_file => 'Neue Datei hochladen';
}

class _TranslationsAdminDe extends TranslationsAdminEn {
  _TranslationsAdminDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get en => 'de';
  @override
  String get eeee_mmmm_dd_yyyy => 'EEEE, MMMM dd, yyyy';
  @override
  String get system_online => 'SYSTEM ONLINE';
  @override
  String get admin_command_center => 'Admin Command Center';
  @override
  String get admin => 'Admin';
  @override
  String get live_statistics => 'Live-Statistiken';
  @override
  String get students => 'Studenten';
  @override
  String get staff => 'Personal';
  @override
  String get faculty => 'Fakultät';
  @override
  String get leadership => 'Führung';
  @override
  String get admin_it => 'Verwaltung und IT';
  @override
  String get users => 'Benutzer';
  @override
  String get manage_all_accounts => 'Alle Konten verwalten';
  @override
  String get system_modules => 'Systemmodule';
  @override
  String get colleges => 'Hochschulen';
  @override
  String get manage_faculties => 'Fakultäten verwalten';
  @override
  String get academic_departments => 'Akademische Abteilungen';
  @override
  String get departments => 'Abteilungen';
  @override
  String get professors => 'Professoren';
  @override
  String get faculty_members => 'Fakultätsmitglieder';
  @override
  String get permission_management => 'Berechtigungsverwaltung';
  @override
  String get roles => 'Rollen';
  @override
  String get audit_logs => 'Audit-Protokolle';
  @override
  String get system_activity_log => 'Systemaktivitätsprotokoll';
  @override
  String get system_settings => 'Systemeinstellungen';
  @override
  String get platform_configuration => 'Plattformkonfiguration';
  @override
  String get performance => 'Leistung';
  @override
  String get server_health_metrics => 'Kennzahlen zum Serverzustand';
  @override
  String get system_pulse => 'Systemimpuls';
  @override
  String get server => 'Server';
  @override
  String get latency => 'Latenz';
  @override
  String get online => 'Online';
  @override
  String get database => 'Datenbank';
  @override
  String get active => 'Aktiv';
  @override
  String get status => 'Status';
  @override
  String get teaching_staff => 'Lehrpersonal';
  @override
  String get total_users => 'Gesamtzahl der Benutzer';
  @override
  String get role_breakdown => 'Rollenaufschlüsselung';
  @override
  String get system_health => 'Systemgesundheit';
  @override
  String get quick_actions => 'Schnelle Aktionen';
  @override
  String get management => 'Management';
  @override
  String get student_affairs => 'Studentenangelegenheiten';
  @override
  String get academic_leadership => 'Akademische Führung';
  @override
  String get realtime_latency_ms => 'ECHTZEITLATENZ (MS)';
  @override
  String get export_data => 'Daten exportieren';
  @override
  String get send_announcement => 'Ankündigung senden';
  @override
  String get backup_system => 'Backup-System';
  @override
  String get user_management => 'Benutzerverwaltung';
  @override
  String get user_list => 'Benutzerliste';
  @override
  String get filter_staff => 'Personal';
  @override
  String get filter_students => 'Studenten';
  @override
  String get filter_all => 'Alle';
  @override
  String get filter_admin => 'Admin';
  @override
  String get add_user => 'Benutzer hinzufügen';
  @override
  String get search_users => 'Benutzer suchen...';
  @override
  String get no_users => 'Keine Benutzer gefunden';
  @override
  String user_count({required Object count}) => '${count}-Benutzer';
  @override
  String get faculty_management => 'Fakultätsmanagement';
  @override
  String get student_management => 'Studentenmanagement';
  @override
  String get staff_management => 'Personalmanagement';
  @override
  String get leadership_management => 'Führungsmanagement';
  @override
  String get college_management => 'Hochschulmanagement';
  @override
  String get audit_log_management => 'Überwachungsprotokollverwaltung';
  @override
  String get department_management => 'Abteilungsleitung';
  @override
  String get role_management => 'Rollenmanagement';
  @override
  String get professor_management => 'Professor Management';
  @override
  String get system_configuration => 'Systemkonfiguration';
  @override
  String get add_college => 'Hochschule hinzufügen';
  @override
  String get admin_it_management => 'Admin- und IT-Management';
  @override
  String get add_department => 'Abteilung hinzufügen';
  @override
  String get edit_department => 'Abteilung bearbeiten';
  @override
  String get delete_college => 'Hochschule löschen';
  @override
  String get edit_college => 'Hochschule bearbeiten';
  @override
  String get delete_department => 'Abteilung löschen';
  @override
  String get college_name => 'Hochschulname';
  @override
  String get department_name => 'Abteilungsname';
  @override
  String get head_name => 'Kopfname';
  @override
  String get dean_name => 'Name des Dekans';
  @override
  String get student_count => 'Studenten';
  @override
  String get ta_count => 'TAs';
  @override
  String get staff_count => 'Personal';
  @override
  String get user => 'Benutzer';
  @override
  String get timestamp => 'Zeitstempel';
  @override
  String get filter_by_action => 'Nach Aktion filtern';
  @override
  String get action => 'Aktion';
  @override
  String get filter_by_date => 'Nach Datum filtern';
  @override
  String get no_logs => 'Keine Überwachungsprotokolle gefunden';
  @override
  String get system_version => 'Systemversion';
  @override
  String get details => 'Details';
  @override
  String get maintenance_mode => 'Wartungsmodus';
  @override
  String get email_server => 'E-Mail-Server';
  @override
  String get backup_schedule => 'Backup-Zeitplan';
  @override
  String get storage_quota => 'Speicherkontingent';
  @override
  String get security_level => 'Sicherheitsstufe';
  @override
  String get log_retention => 'Protokollaufbewahrung';
  @override
  String get session_timeout => 'Sitzungszeitüberschreitung';
  @override
  String get save_settings => 'Einstellungen speichern';
  @override
  String get reset_defaults => 'Auf Standardeinstellungen zurücksetzen';
  @override
  String get user_name => 'Name';
  @override
  String get user_role => 'Rolle';
  @override
  String get user_department => 'Abteilung';
  @override
  String get user_phone => 'Telefon';
  @override
  String get user_status => 'Status';
  @override
  String get user_email => 'E-Mail';
  @override
  String get user_updated => 'Benutzer erfolgreich aktualisiert';
  @override
  String get user_college => 'Hochschule';
  @override
  String get user_created => 'Erstellt';
  @override
  String get add_new_user => 'Neuen Benutzer hinzufügen';
  @override
  String get delete_user => 'Benutzer löschen';
  @override
  String get edit_user => 'Benutzer bearbeiten';
  @override
  String get save_user => 'Speichern';
  @override
  String get name_label => 'Vollständiger Name';
  @override
  String get email_label => 'E-Mail-Adresse';
  @override
  String get cancel => 'Stornieren';
  @override
  String get role_label => 'Wählen Sie Rolle aus';
  @override
  String get phone_label => 'Telefonnummer';
  @override
  String get department_label => 'Abteilung';
  @override
  String get college_label => 'Hochschule';
  @override
  String get password_label => 'Passwort';
  @override
  String get category_student => 'Student';
  @override
  String get category_admin => 'Admin';
  @override
  String get category_staff => 'Personal';
  @override
  String get confirm_password_label => 'Passwort bestätigen';
  @override
  String get category_leadership => 'Führung';
  @override
  String get category_faculty => 'Fakultät';
  @override
  String get select_role => 'Wählen Sie eine Rolle aus';
  @override
  String get no_colleges => 'Keine Hochschulen verfügbar';
  @override
  String get no_departments => 'Keine Abteilungen verfügbar';
  @override
  String get user_added => 'Benutzer erfolgreich hinzugefügt';
  @override
  String get confirm_delete => 'Bestätigen Sie Löschen';
  @override
  String get user_deleted => 'Benutzer erfolgreich gelöscht';
  @override
  String get select_college => 'Wählen Sie eine Hochschule aus';
  @override
  String get select_department => 'Wählen Sie eine Abteilung aus';
  @override
  String get confirm_delete_message =>
      'Sind Sie sicher, dass Sie diesen Benutzer löschen möchten?';
  @override
  String get error_loading => 'Fehler beim Laden der Daten';
  @override
  String get error_saving => 'Fehler beim Speichern der Daten';
  @override
  String get academic_department => 'Akademische Abteilung';
  @override
  String get academic_departments_1 => 'Akademische Abteilungen';
  @override
  String get retry => 'Wiederholen';
  @override
  String get academic_warnings => 'Akademische Warnungen';
  @override
  String get account_status => 'Kontostatus';
  @override
  String get account_verification => 'Kontobestätigung';
  @override
  String get academic_leaders => 'Akademische Leiter';
  @override
  String get actor => 'Schauspieler';
  @override
  String get add_report => 'Bericht hinzufügen';
  @override
  String get admins => 'Administratoren';
  @override
  String get advanced_management => 'Erweitertes Management';
  @override
  String get all => 'Alle';
  @override
  String get all_levels => 'Alle Ebenen';
  @override
  String get apply_filters => 'Filter anwenden';
  @override
  String get all_systems_operational => 'Alle Systeme betriebsbereit';
  @override
  String get assign => 'Zuordnen';
  @override
  String get are_you_sure_you_want_to_delet =>
      'Sind Sie sicher, dass Sie diesen Benutzer löschen möchten?';
  @override
  String get assign_dean => 'Dekan zuweisen';
  @override
  String get assign_department_head => 'Abteilungsleiter ernennen';
  @override
  String get attached_report => 'Angehängter Bericht';
  @override
  String get ban_user => 'Benutzer sperren';
  @override
  String get banned => 'Verboten';
  @override
  String get change_dean => 'Dekan wechseln';
  @override
  String get change => 'Ändern';
  @override
  String get changes_saved_successfully => 'Änderungen erfolgreich gespeichert';
  @override
  String get college => 'Hochschule';
  @override
  String get college_dean => 'Dekan der Hochschule';
  @override
  String get college_details => 'College-Details';
  @override
  String get coming_soon => 'Demnächst verfügbar';
  @override
  String get delete => 'Löschen';
  @override
  String get department_details => 'Abteilungsdetails';
  @override
  String get colleges_management => 'Hochschulmanagement';
  @override
  String get deactivated => 'Deaktiviert';
  @override
  String get departments_management => 'Abteilungsleitung';
  @override
  String get department_projects => 'Abteilungsprojekte';
  @override
  String get entity => 'Juristische Person';
  @override
  String get email_address => 'E-Mail-Adresse';
  @override
  String error_snapshoterror({required Object error}) => 'Fehler: ${error}';
  @override
  String get failed_to_load_data => 'Daten konnten nicht geladen werden';
  @override
  String get faculty_members_1 => 'Fakultätsmitglieder';
  @override
  String get full_name => 'Vollständiger Name';
  @override
  String get filter_users => 'Benutzer filtern';
  @override
  String get head_of_department => 'Abteilungsleiter';
  @override
  String level_level({required Object level}) => 'Ebene ${level}';
  @override
  String get leadership_stats => 'Führungsstatistik';
  @override
  String get incidents => 'Vorfälle';
  @override
  String get national_id => 'Nationaler Ausweis';
  @override
  String get min_6_chars => 'Min. 6 Zeichen';
  @override
  String get no_colleges_found => 'Keine Hochschulen gefunden';
  @override
  String get no_dean_assigned => 'Kein Dekan zugewiesen';
  @override
  String get manage_tags => 'Tags verwalten';
  @override
  String get no_departments_in_this_college =>
      'Keine Abteilungen in diesem College';
  @override
  String get no_about_text_available => 'Kein Infotext verfügbar';
  @override
  String get nationality => 'Nationalität';
  @override
  String get no_departments_found => 'Keine Abteilungen gefunden';
  @override
  String get no_faculty_records_found => 'Keine Fakultätsunterlagen gefunden';
  @override
  String get no_head_assigned => 'Kein Leiter zugewiesen';
  @override
  String get no_matching_students_found => 'Keine passenden Studenten gefunden';
  @override
  String get no_logs_found => 'Keine Protokolle gefunden';
  @override
  String get no_description_available => 'Keine Beschreibung verfügbar';
  @override
  String get no_projects_added_yet => 'Noch keine Projekte hinzugefügt';
  @override
  String get no_users_found => 'Keine Benutzer gefunden';
  @override
  String get no_settings_found_in_the_datab =>
      'In der Datenbank wurden keine Einstellungen gefunden';
  @override
  String get pending_reg => 'Ausstehende Registrierung';
  @override
  String get password => 'Passwort';
  @override
  String get permanently_delete_user => 'Benutzer dauerhaft löschen';
  @override
  String get office => 'Büro';
  @override
  String get phone_number => 'Telefonnummer';
  @override
  String get please_assign_a_head_for_the_d =>
      'Bitte benennen Sie einen Leiter für diese Abteilung';
  @override
  String get please_assign_a_dean_for_the_c =>
      'Bitte benennen Sie einen Dekan für diese Hochschule';
  @override
  String get roles_management => 'Rollenmanagement';
  @override
  String get save => 'Speichern';
  @override
  String get save_changes => 'Änderungen speichern';
  @override
  String get search_doctor_name => 'Arztnamen suchen...';
  @override
  String get search_by_name_email_phone_id =>
      'Suchen Sie nach Name, E-Mail, Telefon oder ID...';
  @override
  String get select => 'Wählen';
  @override
  String get search_staff_member => 'Mitarbeiter suchen...';
  @override
  String get select_role_in_widgetinitialca => 'Rolle auswählen';
  @override
  String get search_student_or_id => 'Schüler oder Ausweis suchen...';
  @override
  String get select_role_permission => 'Wählen Sie Rolle/Berechtigung';
  @override
  String get separate_tags_with_commas => 'Trennen Sie Tags durch Kommas';
  @override
  String get servers => 'Server';
  @override
  String get student_id => 'Studentenausweis';
  @override
  String get tag1_tag2 => 'tag1, tag2';
  @override
  String get teaching_assistants => 'Lehrassistenten';
  @override
  String get system_technical_status => 'Technischer Systemstatus';
  @override
  String get total_staff => 'Gesamtpersonal';
  @override
  String get total_students => 'Gesamtzahl der Studierenden';
  @override
  String get user_roles_ranks => 'Benutzerrollen und Ränge';
  @override
  String get unverified => 'Nicht bestätigt';
  @override
  String get verification => 'Überprüfung';
  @override
  String get you_can_manage_professors_and_ =>
      'Hier können Sie Professoren und mehr verwalten';
  @override
  String get verified => 'Verifiziert';
  @override
  String get warning_level => 'Warnstufe';
}

class _TranslationsEnrollmentDe extends TranslationsEnrollmentEn {
  _TranslationsEnrollmentDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get registration_title => 'Kursanmeldung';
  @override
  String get advisor => 'Akademischer Berater';
  @override
  String get payment_title => 'Studiengebührenzahlung';
  @override
  String get advisor_approval => 'Beratergenehmigung';
  @override
  String get dean_assignment => 'Aufgabe des Dekanatsberaters';
  @override
  String get approve => 'Genehmigen';
  @override
  String get reject => 'Ablehnen';
  @override
  String get pending => 'Ausstehend';
  @override
  String get invoices_title => 'Finanzrechnungen';
  @override
  String get approved => 'Genehmigt';
  @override
  String get student_name => 'Name des Studenten';
  @override
  String get rejected => 'Abgelehnt';
  @override
  String get student_id => 'Studentenausweis';
  @override
  String get department => 'Abteilung';
  @override
  String get college => 'Hochschule';
  @override
  String get semester => 'Semester';
  @override
  String get credits => 'Credits';
  @override
  String get group => 'Gruppe';
  @override
  String get registration_date => 'Anmeldedatum';
  @override
  String get status => 'Status';
  @override
  String get section => 'Abschnitt';
  @override
  String get no_requests => 'Keine Anfragen gefunden';
  @override
  String get search_students => 'Studenten suchen...';
  @override
  String get filter_all => 'Alle';
  @override
  String get filter_pending => 'Ausstehend';
  @override
  String get filter_approved => 'Genehmigt';
  @override
  String get filter_rejected => 'Abgelehnt';
  @override
  String get view_details => 'Details anzeigen';
  @override
  String get approve_all => 'Alle genehmigen';
  @override
  String get advisor_name => 'Name des Beraters';
  @override
  String get unassign => 'Zuweisung aufheben';
  @override
  String get assigned => 'Zugewiesen';
  @override
  String get save => 'Speichern';
  @override
  String get cancel => 'Stornieren';
  @override
  String get assign => 'Zuordnen';
  @override
  String get success_approve => 'Registrierung erfolgreich genehmigt';
  @override
  String get success_reject => 'Registrierung abgelehnt';
  @override
  String get error_loading => 'Fehler beim Laden der Daten';
  @override
  String get success_assign => 'Berater erfolgreich zugewiesen';
  @override
  String get invoice_id => 'Rechnungs-ID';
  @override
  String get invoice_date => 'Datum';
  @override
  String get invoice_amount => 'Menge';
  @override
  String get invoice_paid => 'Bezahlt';
  @override
  String get unassigned => 'Nicht zugewiesen';
  @override
  String get invoice_status => 'Status';
  @override
  String get invoice_unpaid => 'Unbezahlt';
  @override
  String get credit_card => 'Kreditkarte';
  @override
  String get invoice_overdue => 'Überfällig';
  @override
  String get payment_method => 'Zahlungsmethode';
  @override
  String get pay_now => 'Jetzt bezahlen';
  @override
  String get payment_success => 'Zahlung erfolgreich';
  @override
  String get bank_transfer => 'Banküberweisung';
  @override
  String get fawry => 'Fawry';
  @override
  String get outstanding_balance => 'Offener Betrag';
  @override
  String get payment_error => 'Die Zahlung ist fehlgeschlagen';
  @override
  String get total_paid => 'Gesamtbezahlt';
  @override
  String get no_invoices => 'Keine Rechnungen gefunden';
  @override
  String get total => 'Gesamt';
  @override
  String get tuition_fee => 'Studiengebühr';
  @override
  String get late_fee => 'Verspätungsgebühr';
  @override
  String get registration_fee => 'Anmeldegebühr';
  @override
  String semester_label({required Object semester}) => 'Semester${semester}';
  @override
  String get submit_request => 'Anfrage senden';
  @override
  String get request_submitted => 'Anfrage erfolgreich übermittelt';
  @override
  String get all => 'Alle';
  @override
  String get academic_year => 'Akademisches Jahr';
  @override
  String get retry => 'Wiederholen';
  @override
  String get loading => 'Laden...';
  @override
  String get advisor_assignment => 'Berateraufgabe';
  @override
  String get academic_advisor => 'Akademischer Berater';
  @override
  String advisor_requestadvisorfullname({required Object name}) =>
      'Berater: ${name}';
  @override
  String get advisor_updated_successfully => 'Advisor erfolgreich aktualisiert';
  @override
  String get approved_1 => 'Genehmigt';
  @override
  String get approved_courses_registered => 'Genehmigt – Kurse angemeldet';
  @override
  String get choose_schedules => 'Wählen Sie Zeitpläne';
  @override
  String get awaiting_advisor_review =>
      'Warten auf die Bewertung durch den Berater';
  @override
  String get dormitory_fee => 'Wohnheimgebühr';
  @override
  String get due => 'Fällig';
  @override
  String get exam_fee => 'Prüfungsgebühr';
  @override
  String get confirm_submit => 'Bestätigen und absenden';
  @override
  String get error_loading_summary => 'Fehler beim Laden der Zusammenfassung';
  @override
  String get download => 'Herunterladen';
  @override
  String get failed_to_load_invoices =>
      'Rechnungen konnten nicht geladen werden';
  @override
  String get financial_portal => 'Finanzportal';
  @override
  String get cr => 'CR';
  @override
  String get financial_summary => 'Finanzielle Zusammenfassung';
  @override
  String get history => 'Geschichte';
  @override
  String get help => 'Helfen';
  @override
  String get invoices => 'Rechnungen';
  @override
  String get library_fee => 'Bibliotheksgebühr';
  @override
  String get mmm_dd_yyyy => 'MMM dd, yyyy';
  @override
  String get my_invoices => 'Meine Rechnungen';
  @override
  String get next_pick_schedules => 'Als nächstes: Zeitpläne auswählen';
  @override
  String get manage_your_tuition_and_paymen =>
      'Verwalten Sie Ihre Studiengebühren und Zahlungen';
  @override
  String get no_advisor => 'Kein Berater';
  @override
  String get no_requests_found => 'Keine Anfragen gefunden';
  @override
  String get no_invoices_found => 'Keine Rechnungen gefunden';
  @override
  String get no_students_found => 'Keine Studenten gefunden';
  @override
  String get overdue => 'Überfällig';
  @override
  String get pay => 'Zahlen';
  @override
  String get no_schedules_available_for_thi =>
      'Für diesen Kurs sind keine Termine verfügbar';
  @override
  String get partial => 'Teilweise';
  @override
  String get paid => 'Bezahlt';
  @override
  String get pending_review => 'Ausstehende Überprüfung';
  @override
  String get preparing_pdf_statement => 'PDF-Kontoauszug wird vorbereitet...';
  @override
  String get remaining => 'Übrig';
  @override
  String get registration_requests => 'Registrierungsanfragen';
  @override
  String get notes_optional => 'Notizen (optional)';
  @override
  String get other => 'Andere';
  @override
  String get requested_courses => 'Angefragte Kurse';
  @override
  String get request_rejected => 'Anfrage abgelehnt';
  @override
  String get review_final_timetable =>
      'Überprüfen Sie den endgültigen Zeitplan';
  @override
  String get reregister => 'Registrieren Sie sich erneut';
  @override
  String get review_registration => 'Überprüfen Sie die Registrierung';
  @override
  String get sec => 'Sek';
  @override
  String get select_the_subjects_you_want_t =>
      'Wählen Sie die Fächer aus, die Sie anmelden möchten';
  @override
  String get select_your_courses => 'Wählen Sie Ihre Kurse aus';
  @override
  String get sub => 'Sub';
  @override
  String summaryoverduecount_overdue({required Object count}) =>
      '${count} Überfällig';
  @override
  String semester_requestsemester({required Object semester}) =>
      'Semester: ${semester}';
  @override
  String get total_invoices => 'Gesamtrechnungen';
  @override
  String get selected_schedule_summary =>
      'Zusammenfassung des ausgewählten Zeitplans';
  @override
  String get unassigned_only => 'Nur nicht zugewiesen';
  @override
  String get room => 'Zimmer';
  @override
  String get unpaid => 'Unbezahlt';
  @override
  String get you_have_successfully_register =>
      'Sie haben Ihre Kurse erfolgreich angemeldet!';
  @override
  String get your_account_is_clearnno_invoi =>
      'Ihr Konto ist frei. Keine Rechnungen gefunden.';
  @override
  String get withdrawn => 'Zurückgezogen';
}

class _TranslationsSharedDe extends TranslationsSharedEn {
  _TranslationsSharedDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get no_notifications_yet => 'Noch keine Benachrichtigungen';
  @override
  String get security_title => 'Sicherheitseinstellungen';
  @override
  String get notifications_empty => 'Keine neuen Benachrichtigungen';
  @override
  String get biometrics_title => 'Biometrie';
  @override
  String get notifications => 'Benachrichtigungen';
  @override
  String get fingerprint => 'Fingerabdruck';
  @override
  String get face_id => 'Gesichtserkennung';
  @override
  String get enable_biometrics => 'Aktivieren Sie Biometrie';
  @override
  String get end_all_sessions => 'Alle Sitzungen beenden';
  @override
  String get current_session => 'Aktuelle Sitzung';
  @override
  String get device => 'Gerät';
  @override
  String get location => 'Standort';
  @override
  String get sessions_title => 'Aktive Sitzungen';
  @override
  String get last_active => 'Zuletzt aktiv';
  @override
  String get support_title => 'Support & Hilfe';
  @override
  String get end_session => 'Sitzung beenden';
  @override
  String get contact_us => 'Kontaktieren Sie uns';
  @override
  String get call_us => 'Rufen Sie uns an';
  @override
  String get email_us => 'Schicken Sie uns eine E-Mail';
  @override
  String get whatsapp => 'WhatsApp';
  @override
  String get faq => 'FAQ';
  @override
  String get tutorials_title => 'Tutorials und Anleitungen';
  @override
  String get report_issue => 'Melden Sie ein Problem';
  @override
  String get create_post => 'Beitrag erstellen';
  @override
  String get search_forums => 'Foren durchsuchen...';
  @override
  String get no_posts => 'Keine Beiträge gefunden';
  @override
  String get forums_title => 'Foren';
  @override
  String get transition_title => 'Laden...';
  @override
  String get placeholder_title => 'Demnächst verfügbar';
  @override
  String get coming_soon => 'Demnächst verfügbar';
  @override
  String get placeholder_subtitle =>
      'Dieser Abschnitt befindet sich in der Entwicklung';
  @override
  String get retry => 'Wiederholen';
  @override
  String get back => 'Zurück';
  @override
  String get under_development =>
      'Diese Funktion befindet sich in der Entwicklung';
  @override
  String get loading => 'Laden...';
  @override
  String get close => 'Schließen';
  @override
  String get cancel => 'Stornieren';
  @override
  String get save => 'Speichern';
  @override
  String get confirm => 'Bestätigen';
  @override
  String get active_sessions => 'Aktive Sitzungen';
  @override
  String get edit => 'Bearbeiten';
  @override
  String get delete => 'Löschen';
  @override
  String get authentication => 'Authentifizierung';
  @override
  String get biometric_login => 'Biometrische Anmeldung';
  @override
  String get call_hotline => 'Hotline anrufen';
  @override
  String get error => 'Fehler';
  @override
  String get change_password => 'Kennwort ändern';
  @override
  String get financial_aid => 'Finanzielle Hilfe';
  @override
  String get email_support => 'E-Mail-Support';
  @override
  String get forums => 'Foren';
  @override
  String get library => 'Bibliothek';
  @override
  String get logout => 'Abmelden';
  @override
  String get it_support => 'IT-Support';
  @override
  String get manage_logged_in_devices => 'Angemeldete Geräte verwalten';
  @override
  String get members => 'Mitglieder';
  @override
  String get please_wait => 'Bitte warten...';
  @override
  String get security => 'Sicherheit';
  @override
  String get device_management => 'Geräteverwaltung';
  @override
  String get protect_account_with_2fa => 'Konto mit 2FA schützen';
  @override
  String get student_affairs => 'Studentenangelegenheiten';
  @override
  String get support => 'Unterstützung';
  @override
  String get this_feature_is_under_developm =>
      'Diese Funktion befindet sich in der Entwicklung';
  @override
  String get threads => 'Themen';
  @override
  String get twofactor_auth => 'Zwei-Faktor-Authentifizierung';
  @override
  String get tutorials => 'Tutorials';
  @override
  String get update_your_login_credentials =>
      'Aktualisieren Sie Ihre Anmeldedaten';
  @override
  String get view_active_sessions => 'Aktive Sitzungen anzeigen';
  @override
  String get use_fingerprint_or_face_id =>
      'Verwenden Sie Fingerabdruck oder Face ID';
  @override
  String get biometrics => 'Biometrie';
  @override
  String get contact_us_section => 'Kontaktieren Sie uns';
  @override
  String get sessions => 'Sitzungen';
  @override
  String get security_section => 'Sicherheit';
  @override
  String get tutorials_section => 'Tutorials';
  @override
  String get forums_section => 'Foren';
  @override
  String get no_new_notifications => 'Keine neuen Benachrichtigungen';
  @override
  String get support_section => 'Unterstützung';
  @override
  String get security_access => 'Sicherheitszugriff';
}

class _TranslationsStudentsDe extends TranslationsStudentsEn {
  _TranslationsStudentsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get digital_id_title => 'Digitaler Personalausweis';
  @override
  String get student_id => 'Studentenausweis';
  @override
  String get college => 'Hochschule';
  @override
  String get department => 'Abteilung';
  @override
  String get level => 'Ebene';
  @override
  String get gpa => 'Notendurchschnitt';
  @override
  String get credits => 'Credits';
  @override
  String get verified => 'Verifiziert';
  @override
  String get university => 'Horus-Universität';
  @override
  String get download_id => 'ID herunterladen';
  @override
  String get share_id => 'Freigabe-ID';
  @override
  String get id_theme => 'ID-Thema';
  @override
  String get qr_code => 'QR-Code';
  @override
  String get scan_to_verify => 'Zur Überprüfung scannen';
  @override
  String get classic_theme => 'Klassiker';
  @override
  String get gradient_theme => 'Gradient';
  @override
  String get holographic_theme => 'Holografisch';
  @override
  String get dark_matter_theme => 'Dunkle Materie';
  @override
  String get neon_pulse_theme => 'Neonpuls';
  @override
  String get aurora_theme => 'Aurora';
  @override
  String get academic_section => 'Akademisch';
  @override
  String get dashboard_title => 'Studenten-Dashboard';
  @override
  String get enrollment_section => 'Einschreibung';
  @override
  String get utilities_section => 'Dienstprogramme';
  @override
  String get transcript => 'Transkript';
  @override
  String get student_name => 'Name des Studenten';
  @override
  String get progress => 'Akademischer Fortschritt';
  @override
  String get subject_results => 'Betreffergebnisse';
  @override
  String get action_plan => 'Studienplan';
  @override
  String get grades => 'Noten';
  @override
  String get courses => 'Kurse';
  @override
  String get attendance => 'Teilnahme';
  @override
  String get registration => 'Anmeldung';
  @override
  String get invoices => 'Rechnungen';
  @override
  String get schedule => 'Zeitplan';
  @override
  String get exam_schedule => 'Prüfungsplan';
  @override
  String get payment => 'Zahlung';
  @override
  String get security => 'Sicherheit';
  @override
  String get tutorials => 'Tutorials';
  @override
  String get forums => 'Foren';
  @override
  String get support => 'Unterstützung';
  @override
  String get digital_id => 'Digitale ID';
  @override
  String get notifications => 'Benachrichtigungen';
  @override
  String get no_lectures_today => 'Heute keine Vorlesungen';
  @override
  String get quick_stats => 'Schnelle Statistiken';
  @override
  String get gpa_label => 'Notendurchschnitt';
  @override
  String get view_full_schedule => 'Vollständigen Zeitplan anzeigen';
  @override
  String get level_label => 'Ebene';
  @override
  String get recent_grades => 'Aktuelle Noten';
  @override
  String get credits_label => 'Credits';
  @override
  String get all => 'Alle';
  @override
  String get upcoming_exams => 'Kommende Prüfungen';
  @override
  String get error => 'Fehler';
  @override
  String get back => 'Zurück';
  @override
  String get academic => 'Akademisch';
  @override
  String get loading => 'Laden...';
  @override
  String get active => 'Aktiv';
  @override
  String get artificial_intelligence => 'Künstliche Intelligenz';
  @override
  String get copy => 'Kopie';
  @override
  String get download => 'Herunterladen';
  @override
  String get daily_schedule => 'Tagesplan';
  @override
  String get retry => 'Wiederholen';
  @override
  String get access_logs => 'Zugriffsprotokolle';
  @override
  String get enrollment_finance => 'Einschreibung und Finanzen';
  @override
  String get horus_university => 'Horus-Universität';
  @override
  String get horus_university_1 => 'Horus-Universität';
  @override
  String get id_no => 'ID-Nr.';
  @override
  String get identity_active_secure => 'Identität aktiv und sicher';
  @override
  String get offline_copy => 'Offline-Kopie';
  @override
  String get scan_for_secure_access => 'Nach sicherem Zugriff suchen';
  @override
  String get nfc_pass => 'NFC-Pass';
  @override
  String get send => 'Schicken';
  @override
  String get share_identity => 'Identität teilen';
  @override
  String get settings => 'Einstellungen';
  @override
  String get smart_digital_id => 'Intelligente digitale ID';
  @override
  String get student => 'Student';
  @override
  String get status => 'Status';
  @override
  String get utilities => 'Dienstprogramme';
}

class _TranslationsExtractedDe extends TranslationsExtractedEn {
  _TranslationsExtractedDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get change_profile_photo => 'Profilfoto ändern';
  @override
  String get choose_from_gallery => 'Wählen Sie aus der Galerie';
  @override
  String get take_photo => 'Machen Sie ein Foto';
  @override
  String get save => 'Speichern';
  @override
  String get user => 'Benutzer';
  @override
  String get personal_info => 'Persönliche Informationen';
  @override
  String get email => 'E-Mail';
  @override
  String get full_name => 'Vollständiger Name';
  @override
  String get required => 'Erforderlich';
  @override
  String get national_id => 'Nationaler Ausweis';
  @override
  String get phone_number => 'Telefonnummer';
  @override
  String get role => 'Rolle';
  @override
  String get about_me => 'Über mich';
  @override
  String get save_changes => 'Änderungen speichern';
  @override
  String get active => 'Aktiv';
  @override
  String get account => 'Konto';
  @override
  String get account_status => 'Kontostatus';
  @override
  String get notifications => 'Benachrichtigungen';
  @override
  String get appearance => 'Aussehen';
  @override
  String get language_region => 'Sprache und Region';
  @override
  String get about => 'Um';
  @override
  String get edit_profile => 'Profil bearbeiten';
  @override
  String get password_recovery => 'Passwortwiederherstellung';
  @override
  String get send_password_recovery_link_to_your_emai =>
      'Senden Sie den Link zur Passwortwiederherstellung per E-Mail';
  @override
  String get dark_mode => 'Dunkler Modus';
  @override
  String get toggle_between_dark_and_light_mode =>
      'Wechseln Sie zwischen dunklem und hellem Modus';
  @override
  String get ui_style => 'UI-Stil';
  @override
  String get current_classic_design => 'Aktuell: Klassisches Design';
  @override
  String get kSwitch => 'Schalten';
  @override
  String get battery_saver_mode => 'Batteriesparmodus';
  @override
  String get current_glass_design => 'Aktuell: Glasdesign';
  @override
  String get test_notification => 'Testbenachrichtigung';
  @override
  String get send_a_test_notification => 'Senden Sie eine Testbenachrichtigung';
  @override
  String get app_language => 'App-Sprache';
  @override
  String get support_center => 'Support-Center';
  @override
  String get send_feedback => 'Feedback senden';
  @override
  String get rate_the_app => 'Bewerten Sie die App';
  @override
  String get about_app => 'Über App';
  @override
  String get app_notifications => 'App-Benachrichtigungen';
  @override
  String get account_info => 'Kontoinformationen';
  @override
  String get remove_photo => 'Foto entfernen';
  @override
  String get support_feedback => 'Unterstützung und Feedback';
  @override
  String get notifications_are_active => 'Benachrichtigungen sind aktiv';
  @override
  String get privacy_policy => 'Datenschutzrichtlinie';
  @override
  String get thank_you_for_your_support =>
      'Vielen Dank für Ihre Unterstützung! 🎉';
  @override
  String get version_details_and_developer_info =>
      'Versionsdetails und Entwicklerinformationen';
  @override
  String get terms_and_rules_for_data_usage =>
      'Bedingungen und Regeln für die Datennutzung';
  @override
  String get log_out => 'Abmelden';
  @override
  String get how_can_we_help_you => 'Wie können wir Ihnen helfen?';
  @override
  String get write_your_feedback_here => 'Schreiben Sie hier Ihr Feedback...';
  @override
  String get email_support => 'E-Mail-Support';
  @override
  String get write_something_about_yourself =>
      'Schreiben Sie etwas über sich selbst...';
  @override
  String get disable_complex_visual_effects =>
      'Deaktivieren Sie komplexe visuelle Effekte';
  @override
  String get update_your_personal_info_and_photo =>
      'Aktualisieren Sie Ihre persönlichen Daten und Ihr Foto';
  @override
  String get call_hotline => 'Hotline anrufen';
  @override
  String get submit_feedback => 'Geben Sie Feedback ab';
  @override
  String get departments => 'Abteilungen';
  @override
  String get add_department => 'Abteilung hinzufügen';
  @override
  String get description => 'Beschreibung';
  @override
  String get cancel => 'Stornieren';
  @override
  String get students => 'Studenten';
  @override
  String get est => 'Schätzung:';
  @override
  String get add => 'Hinzufügen';
  @override
  String get staff => 'Personal';
  @override
  String get building => 'Gebäude';
  @override
  String get test_notification_sent => 'Testbenachrichtigung gesendet!';
  @override
  String get notifications_are_off => 'Benachrichtigungen sind deaktiviert';
  @override
  String get your_support_matters => '⭐ Ihre Unterstützung ist wichtig';
  @override
  String get notification_center => 'Benachrichtigungscenter';
  @override
  String get chat_with_us_on_whatsapp => 'Chatten Sie mit uns auf WhatsApp';
  @override
  String get thank_you_feedback_submitted => '✅ Danke! Feedback eingereicht.';
  @override
  String get remove => 'Entfernen';
  @override
  String get head => 'Kopf';
  @override
  String get asst => 'Asst.';
  @override
  String get confirm_removal => 'Bestätigen Sie das Entfernen';
  @override
  String get your_opinion_helps_us_improve =>
      'Ihre Meinung hilft uns, uns zu verbessern';
  @override
  String get get_help_and_resolve_any_issues =>
      'Holen Sie sich Hilfe und lösen Sie alle Probleme';
  @override
  String get view_all_your_notifications =>
      'Sehen Sie sich alle Ihre Benachrichtigungen an';
  @override
  String get share_your_thoughts_to_help_improve_the_ =>
      'Teilen Sie Ihre Gedanken mit, um zur Verbesserung der App beizutragen';
  @override
  String get add_new_department => 'Neue Abteilung hinzufügen';
  @override
  String get department_code => 'Abteilungscode';
  @override
  String get no_assistant_assigned => 'Kein Assistent zugewiesen';
  @override
  String get department_name_en => 'Abteilungsname (EN)';
  @override
  String get department_name_ar => 'Abteilungsname (AR)';
  @override
  String get add_staff => 'Personal hinzufügen';
  @override
  String get assistant_head => 'Stellvertretender Leiter';
  @override
  String get roles_management => 'Rollenmanagement';
  @override
  String get create_role => 'Rolle erstellen';
  @override
  String get no_results => 'Keine Ergebnisse';
  @override
  String get custom => 'Brauch';
  @override
  String get create => 'Erstellen';
  @override
  String get merge => 'Verschmelzen';
  @override
  String get please_assign_an_assistant_head_for_the_ =>
      'Bitte benennen Sie einen stellvertretenden Leiter für die Abteilung';
  @override
  String get category => 'Kategorie';
  @override
  String get add_faculty => 'Fakultät hinzufügen';
  @override
  String get add_faculty_member => 'Fakultätsmitglied hinzufügen';
  @override
  String get description_english => 'Beschreibung (Englisch)';
  @override
  String get permissions => 'Berechtigungen';
  @override
  String get description_arabic => 'Beschreibung (Arabisch)';
  @override
  String get search_roles => 'Rollen suchen...';
  @override
  String get merge_roles => 'Rollen zusammenführen';
  @override
  String get make_sure_roles_table_exists_in_supabase =>
      'Stellen Sie sicher, dass die Tabelle „Rollen“ in Supabase vorhanden ist';
  @override
  String get could_not_load_custom_roles =>
      'Benutzerdefinierte Rollen konnten nicht geladen werden';
  @override
  String remove_staff_fullname_from_this_departme({
    required Object staffFullName,
  }) => '${staffFullName}aus dieser Abteilung entfernen?';
  @override
  String get no_faculty_members_assigned =>
      'Keine Fakultätsmitglieder zugewiesen';
  @override
  String get edit_role => 'Rolle bearbeiten';
  @override
  String get no_roles => 'Keine Rollen';
  @override
  String get name_arabic => 'Name (Arabisch)';
  @override
  String get role_created => 'Rolle erstellt';
  @override
  String get name_english => 'Name (Englisch)';
  @override
  String get create_new_role => 'Neue Rolle erstellen';
  @override
  String get no_custom_roles_yet => 'Noch keine benutzerdefinierten Rollen';
  @override
  String get delete_role => 'Rolle löschen';
  @override
  String get delete => 'Löschen';
  @override
  String get role_updated => 'Rolle aktualisiert';
  @override
  String get admin_it => 'Verwaltung und IT';
  @override
  String get leadership => 'Führung';
  @override
  String get teaching => 'Lehre';
  @override
  String get external => 'Extern';
  @override
  String get student_affairs => 'Studentenangelegenheiten';
  @override
  String get facilities => 'Einrichtungen';
  @override
  String get permissions_1 => 'Berechtigungen:';
  @override
  String get merged => 'VERSCHMELZT';
  @override
  String get user_details => 'Benutzerdetails';
  @override
  String get quick_actions => 'Schnelle Aktionen';
  @override
  String get verification => 'Überprüfung';
  @override
  String get second_role => 'Zweite Rolle';
  @override
  String get merge_two_roles => 'Zwei Rollen zusammenführen';
  @override
  String get first_role => 'Erste Rolle';
  @override
  String get tags => 'Schlagworte';
  @override
  String get danger_zone => 'Gefahrenzone';
  @override
  String get warning_level => 'Warnstufe';
  @override
  String get banned => 'Verboten';
  @override
  String get verified => 'Verifiziert';
  @override
  String get deactivate => 'Deaktivieren';
  @override
  String get activate => 'Aktivieren';
  @override
  String get verify => 'Verifizieren';
  @override
  String get merged_role_name_arabic =>
      'Zusammengeführter Rollenname (Arabisch)';
  @override
  String get roles_merged_successfully => 'Rollen erfolgreich zusammengeführt';
  @override
  String get create_a_new_role_or_merge_two_roles =>
      'Erstellen Sie eine neue Rolle oder führen Sie zwei Rollen zusammen';
  @override
  String get ban => 'Verbot';
  @override
  String get unban => 'Verbot aufheben';
  @override
  String get select_two_roles_to_combine_their_permis =>
      'Wählen Sie zwei Rollen aus, um ihre Berechtigungen zu kombinieren';
  @override
  String get merged_permissions_preview =>
      'Vorschau der zusammengeführten Berechtigungen';
  @override
  String get not_verified => 'Nicht verifiziert';
  @override
  String get merged_role_name_english =>
      'Zusammengeführter Rollenname (Englisch)';
  @override
  String get nationality => 'Nationalität';
  @override
  String get add_tag => 'Tag hinzufügen';
  @override
  String get created => 'Erstellt';
  @override
  String get current_level => 'Aktuelles Niveau';
  @override
  String get verify_account => 'Konto bestätigen';
  @override
  String delete_role_nameen_this_cannot_be_undone({
    required Object roleNameEn,
  }) => '„${roleNameEn}“ löschen? Dies kann nicht rückgängig gemacht werden.';
  @override
  String get ban_management => 'Verbotsverwaltung';
  @override
  String get unverify => 'Nicht bestätigen';
  @override
  String get ban_user => 'Benutzer sperren';
  @override
  String get tag_name => 'Tag-Name';
  @override
  String get user_has_normal_access => 'Der Benutzer hat normalen Zugriff';
  @override
  String get not_banned => 'Nicht verboten';
  @override
  String get user_banned => 'Benutzer gesperrt';
  @override
  String get remove_verification => 'Verifizierung entfernen';
  @override
  String get account_verified => 'Konto bestätigt';
  @override
  String get permanently_delete => 'Endgültig löschen';
  @override
  String get no_tags_assigned => 'Keine Tags zugewiesen';
  @override
  String get last_login => 'Letzte Anmeldung';
  @override
  String get soft_delete_deactivate => 'Vorläufiges Löschen (Deaktivieren)';
  @override
  String get soft_delete => 'Vorläufiges Löschen';
  @override
  String get select_department => 'Wählen Sie Abteilung aus';
  @override
  String get institution => 'Institution';
  @override
  String unban_user_fullname({required Object userFullName}) =>
      '${userFullName}entsperren?';
  @override
  String get unban_user => 'Benutzer entsperren';
  @override
  String get tag_removed => 'Tag entfernt';
  @override
  String verify_user_fullname({required Object userFullName}) =>
      'Überprüfen Sie${userFullName}';
  @override
  String warning_level_set_to_level({required Object level}) =>
      'Warnstufe auf ${level}';
  @override
  String get permanent_delete => 'Dauerhafte Löschung';
  @override
  String get exceeding => 'Überschreiten';
  @override
  String get total => 'Gesamt';
  @override
  String get user_cannot_access_the_system =>
      'Der Benutzer kann nicht auf das System zugreifen';
  @override
  String ban_user_fullname_they_will_lose_system_({
    required Object userFullName,
  }) => '${userFullName}verbieten? Sie verlieren den Systemzugriff.';
  @override
  String remove_verification_from_user_fullname({
    required Object userFullName,
  }) => 'Verifizierung von${userFullName}entfernen?';
  @override
  String get user_identity_has_been_verified =>
      'Die Benutzeridentität wurde überprüft';
  @override
  String get grade => 'Grad';
  @override
  String get identity_not_yet_verified => 'Identität noch nicht überprüft';
  @override
  String get department_is_required => 'Abteilung ist erforderlich';
  @override
  String get college_is_required => 'Hochschule ist erforderlich';
  @override
  String deactivate_user_fullname({required Object userFullName}) =>
      '${userFullName}\ deaktivieren';
  @override
  String get select_college => 'Wählen Sie Hochschule';
  @override
  String out_of_max({required Object max}) => 'AUSSERHALB${max}';
  @override
  String permanently_delete_user_fullname_this_ca({
    required Object userFullName,
  }) =>
      '${userFullName}endgültig löschen? Dies kann nicht rückgängig gemacht werden!';
  @override
  String get top_5 => 'Top 5 %';
}

class _TranslationsOnboardingLanguageDe
    extends TranslationsOnboardingLanguageEn {
  _TranslationsOnboardingLanguageDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Wählen Sie Ihre Sprache';
  @override
  String get subtitle => 'Wählen Sie Ihre bevorzugte Sprache';
  @override
  String get english => 'Englisch';
  @override
  String get arabic => 'Arabisch';
  @override
  String get german => 'Deutsch';
  @override
  String get chinese => 'Chinesisch';
  @override
  String get hint => 'Sie können dies später in den Einstellungen ändern';
}

class _TranslationsOnboardingFacultiesDirectoryDe
    extends TranslationsOnboardingFacultiesDirectoryEn {
  _TranslationsOnboardingFacultiesDirectoryDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Unsere Fakultäten';
  @override
  String get subtitle =>
      'Entdecken Sie unsere vielfältigen akademischen Abteilungen';
}

class _TranslationsOnboardingStyleDe extends TranslationsOnboardingStyleEn {
  _TranslationsOnboardingStyleDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Wählen Sie Ihren Stil';
  @override
  String get subtitle => 'Wählen Sie das Interface-Design, das Sie bevorzugen';
  @override
  late final _TranslationsOnboardingStyleClassicDe classic =
      _TranslationsOnboardingStyleClassicDe._(_root);
  @override
  late final _TranslationsOnboardingStyleGlassDe glass =
      _TranslationsOnboardingStyleGlassDe._(_root);
}

class _TranslationsOnboardingThemeDe extends TranslationsOnboardingThemeEn {
  _TranslationsOnboardingThemeDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Wählen Sie ein Thema';
  @override
  String get subtitle => 'Hell oder dunkel, Ihre Wahl';
  @override
  String get light => 'Hell';
  @override
  String get dark => 'Dunkel';
}

class _TranslationsAuthLoginDe extends TranslationsAuthLoginEn {
  _TranslationsAuthLoginDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get welcome => 'Willkommen zurück';
  @override
  String get subtitle => 'Melden Sie sich an, um fortzufahren';
  @override
  String get email => 'E-Mail';
  @override
  String get password => 'Passwort';
  @override
  String get forgot_password => 'Passwort vergessen?';
  @override
  String get submit => 'Anmelden';
  @override
  String get guest => 'Als Gast stöbern';
}

class _TranslationsAuthForgotPasswordDe
    extends TranslationsAuthForgotPasswordEn {
  _TranslationsAuthForgotPasswordDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Passwort vergessen';
  @override
  String get subtitle => 'Wählen Sie eine Wiederherstellungsmethode';
  @override
  String get method_admin => 'Verwaltung besuchen';
  @override
  String get method_online => 'Online-Anfrage';
  @override
  String get admin_instructions =>
      'Bitte besuchen Sie das Büro für studentische Angelegenheiten, um Ihr Passwort zurückzusetzen. Bringen Sie Ihren gültigen Universitätsausweis mit.';
  @override
  String get phone_label => 'Telefonnummer';
  @override
  String get upload_id => 'ID-Foto hochladen';
  @override
  String get upload_id_hint =>
      'Tippen Sie, um ein klares Foto Ihres Universitätsausweises hochzuladen';
  @override
  String get submit => 'Anfrage absenden';
  @override
  String get back => 'Zurück zum Login';
  @override
  String get error_empty_phone => 'Bitte geben Sie Ihre Telefonnummer ein';
  @override
  String get error_empty_email => 'Bitte geben Sie Ihre E-Mail ein';
  @override
  String get error_no_id => 'Bitte laden Sie Ihr ID-Foto hoch';
  @override
  String get success => 'Anfrage erfolgreich gesendet';
  @override
  String get id_uploaded => 'ID hochgeladen';
  @override
  String get choose_account_recovery_method =>
      'Wählen Sie die Methode zur Kontowiederherstellung';
  @override
  String get back_to_login => 'Zurück zum Anmelden';
}

class _TranslationsHomeTabsDe extends TranslationsHomeTabsEn {
  _TranslationsHomeTabsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get home => 'Startseite';
  @override
  String get search => 'Suche';
  @override
  String get notifications => 'Benachrichtigungen';
  @override
  String get profile => 'Profil';
  @override
  String get student => 'Student';
  @override
  String get colleges => 'Hochschulen';
  @override
  String get admin => 'Admin';
}

class _TranslationsDashboardIdCardDe extends TranslationsDashboardIdCardEn {
  _TranslationsDashboardIdCardDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get student_name => 'Studentenname';
  @override
  String get college => 'Fakultät';
  @override
  String get id => 'Studenten-ID';
  @override
  String get gpa => 'Notendurchschnitt';
  @override
  String get level => 'Stufe';
  @override
  String get verified => 'Verifiziert';
}

class _TranslationsDashboardSectionsDe extends TranslationsDashboardSectionsEn {
  _TranslationsDashboardSectionsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get academic => 'Akademisch';
  @override
  String get enrollment => 'Einschreibung';
  @override
  String get utilities => 'Dienstprogramme';
}

class _TranslationsDashboardItemsDe extends TranslationsDashboardItemsEn {
  _TranslationsDashboardItemsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get transcript => 'Transkript';
  @override
  String get progress => 'Fortschritt';
  @override
  String get action_plan => 'Aktionsplan';
  @override
  String get subject_result => 'Ergebnis';
  @override
  String get grades => 'Noten';
  @override
  String get courses => 'Kurse';
  @override
  String get registration => 'Registrierung';
  @override
  String get invoices => 'Rechnungen';
  @override
  String get payment => 'Zahlung';
  @override
  String get tutorials => 'Tutorials';
  @override
  String get security => 'Sicherheit';
  @override
  String get forums => 'Foren';
  @override
  String get support => 'Unterstützung';
  @override
  String get notifications => 'Benachrichtigungen';
  @override
  String get no_lectures => 'Keine Vorlesungen gefunden';
  @override
  String get digital_id => 'Digitale ID';
}

class _TranslationsDashboardLabelsDe extends TranslationsDashboardLabelsEn {
  _TranslationsDashboardLabelsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get university_name => 'UNIVERSITÄT VON HUE';
  @override
  String get id_short => 'AUSWEIS';
  @override
  String get gpa_short => 'Notendurchschnitt';
  @override
  String get level_short => 'LVL';
}

class _TranslationsSettingsSectionsDe extends TranslationsSettingsSectionsEn {
  _TranslationsSettingsSectionsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get account => 'Konto';
  @override
  String get display => 'Anzeige';
  @override
  String get notifications => 'Benachrichtigungen';
  @override
  String get about => 'Über';
}

class _TranslationsSettingsTilesDe extends TranslationsSettingsTilesEn {
  _TranslationsSettingsTilesDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get edit_profile => 'Profil bearbeiten';
  @override
  String get change_password => 'Passwort ändern';
  @override
  String get dark_mode => 'Dunkelmodus';
  @override
  String get language => 'Sprache';
  @override
  String get ui_style => 'UI-Stil';
  @override
  String get app_notifications => 'App-Benachrichtigungen';
  @override
  String get test_notifications => 'Benachrichtigungen testen';
  @override
  String get about_app => 'Über die App';
  @override
  String get privacy_policy => 'Datenschutzrichtlinie';
  @override
  String get logout => 'Abmelden';
}

class _TranslationsSettingsMessagesDe extends TranslationsSettingsMessagesEn {
  _TranslationsSettingsMessagesDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get switching_theme => 'Thema wird gewechselt...';
  @override
  String get changing_language => 'Sprache wird geändert...';
  @override
  String get rebuilding_design => 'Design-System wird neu aufgebaut...';
}

class _TranslationsCollegesDetailsDe extends TranslationsCollegesDetailsEn {
  _TranslationsCollegesDetailsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get dean => 'Dekan der Fakultät';
  @override
  String get staff => 'Lehrpersonal';
  @override
  String get view_all => 'Alle anzeigen';
  @override
  String get departments => 'Abteilungen';
  @override
  String get explore_majors => 'Verfügbare Majors erkunden';
  @override
  String get majors => 'Majors';
  @override
  String get dean_title => 'Der Dekan';
  @override
  String get staff_member => 'Mitarbeiter';
  @override
  String get vice_dean => 'Vizedekan';
  @override
  String get head_of_dept => 'Abteilungsleiter';
  @override
  String get assoc_prof => 'Assoc. Prof.';
  @override
  String get academic_statistics => 'Akademische Statistik';
  @override
  String get students => 'Studenten';
  @override
  String get academic_staff => 'Lehrpersonal';
  @override
  String get teaching_assistants => 'Assistenten';
  @override
  String get published_articles => 'Veröffentlichte Artikel';
}

class _TranslationsCollegesDepartmentsDe
    extends TranslationsCollegesDepartmentsEn {
  _TranslationsCollegesDepartmentsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get medical_laboratories_technology => 'Medizinische Labortechnologie';
  @override
  String get radiology_and_imaging_technology =>
      'Radiologie und Bildgebungstechnologie';
  @override
  String get respiratory_care_technology => 'Atemwegspflege-Technologie';
  @override
  String get dental_prosthetics_technology => 'Zahnprothetische Technologie';
  @override
  String get health_administration_and_informatics_technology =>
      'Gesundheitsverwaltung & Informatik';
  @override
  String get accounting => 'Rechnungswesen';
  @override
  String get business_management => 'Unternehmensführung';
  @override
  String get economics => 'Wirtschaftswissenschaften';
  @override
  String get marketing => 'Marketing';
  @override
  String get accounting_program_english => 'Rechnungswesen (Englisch)';
  @override
  String get business_administration_program_english =>
      'Betriebswirtschaft (Englisch)';
  @override
  String get basic_sciences_in_dentistry => 'Grundlagen der Zahnmedizin';
  @override
  String get basic_medical_and_clinical_sciences => 'Medizinische Grundlagen';
  @override
  String get oral_and_maxillofacial_surgery => 'Mund-Kiefer-Gesichtschirurgie';
  @override
  String get orthodontics_and_pediatric_dentistry =>
      'Kieferorthopädie & Kinderzahnheilkunde';
  @override
  String get periodontics_and_oral_medicine => 'Parodontologie & Oralmedizin';
  @override
  String get prosthodontics => 'Prothetik';
  @override
  String get conservative_dentistry_and_endodontics =>
      'Konservierende Zahnheilkunde';
  @override
  String get architectural_engineering => 'Architektur';
  @override
  String get basic_sciences => 'Grundlagenwissenschaften';
  @override
  String get civil_engineering => 'Bauingenieurwesen';
  @override
  String get mechanical_engineering => 'Maschinenbau';
  @override
  String get electrical_engineering => 'Elektrotechnik';
  @override
  String get artificial_intelligence_engineering => 'KI-Ingenieurwesen';
  @override
  String get interior_design_and_architecture => 'Innenarchitektur';
  @override
  String get furniture_design_and_production_technology =>
      'Möbeldesign-Technologie';
  @override
  String get graphics_and_digital_arts => 'Grafik und digitale Kunst';
  @override
  String get animation_and_multimedia => 'Animation und Multimedia';
  @override
  String get medical_education => 'Medizinische Ausbildung';
  @override
  String get histology_and_cell_biology => 'Histologie und Zellbiologie';
  @override
  String get clinical_pharmacy => 'Klinische Pharmazie';
  @override
  String get human_anatomy_and_embryology => 'Anatomie und Embryologie';
  @override
  String get medical_physiology => 'Medizinische Physiologie';
  @override
  String get medical_microbiology_and_immunology =>
      'Mikrobiologie & Immunologie';
  @override
  String get forensic_medicine_and_toxicology => 'Forensik & Toxikologie';
  @override
  String get community_medicine_and_public_health =>
      'Gemeinschaftsmedizin & Gesundheit';
  @override
  String get biochemistry => 'Biochemie';
  @override
  String get pathology => 'Pathologie';
  @override
  String get english_language_program => 'Englisch-Sprachprogramm';
  @override
  String get german_language_program => 'Deutsch-Sprachprogramm';
  @override
  String get chinese_language_program => 'Chinesisch-Sprachprogramm';
  @override
  String get french_department => 'Französische Abteilung';
  @override
  String get translation_department => 'Übersetzungsabteilung';
  @override
  String get pharmaceutical_chemistry => 'Pharmazeutische Chemie';
  @override
  String get pharmacology_and_biochemistry => 'Pharmakologie & Biochemie';
  @override
  String get pharmacognosy => 'Pharmakognosie';
  @override
  String get microbiology_and_immunology => 'Mikrobiologie & Immunologie';
  @override
  String get pharmaceutical_technology => 'Pharmazeutische Technologie';
  @override
  String get pharmacy_practice => 'Pharmaziepraxis';
  @override
  String get basic_sciences_pt => 'Grundwissenschaften PT';
  @override
  String get biomechanics => 'Biomechanik';
  @override
  String get pt_internal_medicine_and_geriatrics =>
      'PT für Innere Medizin & Geriatrie';
  @override
  String get pt_womens_health => 'PT für Frauengesundheit';
  @override
  String get pt_surgery_and_integumentary => 'PT für Chirurgie';
  @override
  String get pt_orthopedics => 'PT für Orthopädie';
  @override
  String get pt_neurology => 'PT für Neurologie';
  @override
  String get pt_pediatrics => 'PT für Pädiatrie';
  @override
  String get artificial_biomedical_computing => 'KI-Biomedizinisches Computing';
  @override
  String get artificial_cybersecurity => 'KI-Cybersicherheit';
  @override
  String get ai_and_data_science => 'KI & Datenwissenschaft';
  @override
  String get ai_for_robotics => 'KI für Robotik';
  @override
  String get smart_systems => 'Intelligente Systeme';
}

class _TranslationsTranscriptOverviewDe
    extends TranslationsTranscriptOverviewEn {
  _TranslationsTranscriptOverviewDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get gpa => 'Gesamt-GPA';
  @override
  String get credits => 'Erworbene Credits';
  @override
  String get standing => 'Status';
  @override
  String get active => 'Guter Status';
}

class _TranslationsTranscriptSemesterDe
    extends TranslationsTranscriptSemesterEn {
  _TranslationsTranscriptSemesterDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get fall => 'Herbstsemester';
  @override
  String get spring => 'Frühlingssemester';
  @override
  String get summer => 'Sommersemester';
}

class _TranslationsTranscriptCourseDe extends TranslationsTranscriptCourseEn {
  _TranslationsTranscriptCourseDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get grade => 'Note';
  @override
  String get credits => 'Credits';
  @override
  late final _TranslationsTranscriptCourseStatusDe status =
      _TranslationsTranscriptCourseStatusDe._(_root);
}

class _TranslationsAcademicProgressCategoriesDe
    extends TranslationsAcademicProgressCategoriesEn {
  _TranslationsAcademicProgressCategoriesDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get university => 'Universitätsanforderungen';
  @override
  String get faculty => 'Fakultätsanforderungen';
  @override
  String get major => 'Hauptfachanforderungen';
  @override
  String get electives => 'Wahlfächer';
  @override
  String get university_name => 'Horus-Universität';
}

class _TranslationsAcademicProgressStatusDe
    extends TranslationsAcademicProgressStatusEn {
  _TranslationsAcademicProgressStatusDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get completed => 'Abgeschlossen';
  @override
  String get in_progress => 'In Arbeit';
  @override
  String get remaining => 'Verbleibend';
  @override
  String get requirement_met => 'Anforderung erfüllt';
}

class _TranslationsAttendanceSubjectsDe
    extends TranslationsAttendanceSubjectsEn {
  _TranslationsAttendanceSubjectsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get machine_learning => 'Maschinelles Lernen';
  @override
  String get ai => 'Künstliche Intelligenz';
  @override
  String get ethics => 'Ethik in der IT';
  @override
  String get calculus => 'Erweiterte Analysis';
}

class _TranslationsAdministrationAuditLogsDe
    extends TranslationsAdministrationAuditLogsEn {
  _TranslationsAdministrationAuditLogsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get no_logs_found =>
      'Es wurden keine Protokolle gefunden, die den Kriterien entsprechen.';
  @override
  String get title => 'Audit-Protokolle';
  @override
  late final _TranslationsAdministrationAuditLogsTabsDe tabs =
      _TranslationsAdministrationAuditLogsTabsDe._(_root);
  @override
  late final _TranslationsAdministrationAuditLogsLabelsDe labels =
      _TranslationsAdministrationAuditLogsLabelsDe._(_root);
}

class _TranslationsProfessorStatsDe extends TranslationsProfessorStatsEn {
  _TranslationsProfessorStatsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get groups => 'Gruppen';
  @override
  String get students => 'Gesamtzahl der Studierenden';
  @override
  String get rating => 'Bewertung';
  @override
  String get tas => 'Lehrassistenten';
  @override
  String get shared_files => 'Freigegebene Dateien';
  @override
  String get office_hours => 'Bürozeiten';
}

class _TranslationsProfessorQuickActionsDe
    extends TranslationsProfessorQuickActionsEn {
  _TranslationsProfessorQuickActionsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get urgent => 'Dringend';
  @override
  String get message => 'Nachricht';
  @override
  String get upload => 'Hochladen';
  @override
  String get action_clicked => 'Angeklickt';
}

class _TranslationsProfessorProfileDe extends TranslationsProfessorProfileEn {
  _TranslationsProfessorProfileDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get urgent_announcements => 'Dringende Ankündigungen';
  @override
  String get teaching_assistants => 'Lehrassistenten';
  @override
  String get shared_resources => 'Gemeinsame Ressourcen';
  @override
  String get office_hours => 'Bürozeiten';
}

class _TranslationsRolesCategoriesDe extends TranslationsRolesCategoriesEn {
  _TranslationsRolesCategoriesDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get admin_it => 'Verwaltung und IT';
  @override
  String get student_affairs => 'Studentenangelegenheiten';
  @override
  String get academic_leadership => 'Akademische Führung';
  @override
  String get facilities_security => 'Einrichtungen und Sicherheit';
  @override
  String get teaching_staff => 'Lehrpersonal';
  @override
  String get external_roles => 'Externe Rollen';
  @override
  String get student_roles => 'Schülerrollen';
}

class _TranslationsRolesNamesDe extends TranslationsRolesNamesEn {
  _TranslationsRolesNamesDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get super_admin => 'Super Admin';
  @override
  String get admin => 'Administrator';
  @override
  String get financial_auditor => 'Finanzprüfer';
  @override
  String get it_support => 'IT-Support';
  @override
  String get rector => 'Rektor / Präsident';
  @override
  String get academic_coordinator => 'Akademischer Koordinator';
  @override
  String get department_head => 'Abteilungsleiter';
  @override
  String get professor => 'Professor / Dozent';
  @override
  String get teaching_assistant => 'Lehrassistent';
  @override
  String get dean => 'Dean';
  @override
  String get academic_advisor => 'Akademischer Berater';
  @override
  String get registrar_officer => 'Standesbeamter';
  @override
  String get lecturer => 'Dozent';
  @override
  String get regular_student => 'Regulärer Student';
  @override
  String get librarian => 'Bibliothekar';
  @override
  String get student => 'Student';
  @override
  String get class_representative => 'Klassensprecher';
  @override
  String get freshman => 'Erstsemester';
  @override
  String get alumni => 'Alumni';
  @override
  String get dorm_supervisor => 'Wohnheimleiter';
  @override
  String get security_officer => 'Sicherheitsbeauftragter';
  @override
  String get parent => 'Elternteil/Erziehungsberechtigter';
  @override
  String get guest => 'Gast';
  @override
  String get recruiter => 'Personalvermittler';
}

class _TranslationsRolesDescriptionsDe extends TranslationsRolesDescriptionsEn {
  _TranslationsRolesDescriptionsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get super_admin => 'Volle Kontrolle über das gesamte System';
  @override
  String get financial_auditor => 'Überwacht Finanzunterlagen und Rechnungen';
  @override
  String get it_support => 'Technische Systembetreuung und Wartung';
  @override
  String get department_head => 'Leiter einer wissenschaftlichen Abteilung';
  @override
  String get rector => 'Universitätspräsident mit voller akademischer Aufsicht';
  @override
  String get dean => 'Leiter einer Hochschule/Fakultät';
  @override
  String get teaching_assistant =>
      'Unterstützt Professoren bei der Benotung, Laboren und Tutorials';
  @override
  String get academic_coordinator =>
      'Koordiniert akademische Programme und Terminplanung';
  @override
  String get professor =>
      'Fakultätsmitglied, das Kurse unterrichtet und verwaltet';
  @override
  String get librarian => 'Verwaltet Bibliotheksressourcen und -materialien';
  @override
  String get admin => 'Systemadministrator mit hohen Rechten';
  @override
  String get academic_advisor =>
      'Führt Studierende durch die akademische Planung';
  @override
  String get freshman => 'Studienanfänger mit eingeschränktem Systemzugriff';
  @override
  String get lecturer => 'Lehrt Kurse ohne volle Professorenprivilegien';
  @override
  String get registrar_officer =>
      'Verwaltet die Einschreibung und Registrierung von Studenten';
  @override
  String get regular_student =>
      'Vollständiger Student mit allen üblichen akademischen Privilegien';
  @override
  String get alumni => 'Absolvent mit eingeschränktem Zugang';
  @override
  String get student => 'Allgemeine Schülerrolle';
  @override
  String get security_officer => 'Campussicherheit und Zugangskontrolle';
  @override
  String get class_representative =>
      'Schülerführer, der die Klassengemeinschaft vertritt';
  @override
  String get parent =>
      'Kann den Fortschritt und die Noten der verknüpften Schüler anzeigen';
  @override
  String get dorm_supervisor => 'Verwaltet den Betrieb der Studentenwohnheime';
  @override
  String get guest => 'Temporärer Besucher mit minimalem Zugang';
  @override
  String get recruiter => 'Externe Rekrutierungsorganisation';
}

class _TranslationsOnboardingStyleClassicDe
    extends TranslationsOnboardingStyleClassicEn {
  _TranslationsOnboardingStyleClassicDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Klassisch';
  @override
  String get desc => 'Sauberes, einfaches und vertrautes Material Design';
}

class _TranslationsOnboardingStyleGlassDe
    extends TranslationsOnboardingStyleGlassEn {
  _TranslationsOnboardingStyleGlassDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get title => 'Glas';
  @override
  String get desc => 'Moderne, transluzente und lebendige Ästhetik';
}

class _TranslationsTranscriptCourseStatusDe
    extends TranslationsTranscriptCourseStatusEn {
  _TranslationsTranscriptCourseStatusDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get completed => 'Abgeschlossen';
  @override
  String get transferred => 'Übertragen';
}

class _TranslationsAdministrationAuditLogsTabsDe
    extends TranslationsAdministrationAuditLogsTabsEn {
  _TranslationsAdministrationAuditLogsTabsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get all => 'Alle Protokolle';
  @override
  String get security => 'Sicherheit';
  @override
  String get user_management => 'Benutzerverwaltung';
  @override
  String get data_updates => 'Datenaktualisierungen';
}

class _TranslationsAdministrationAuditLogsLabelsDe
    extends TranslationsAdministrationAuditLogsLabelsEn {
  _TranslationsAdministrationAuditLogsLabelsDe._(TranslationsDe root)
    : this._root = root,
      super.internal(root);

  final TranslationsDe _root;

  @override
  String get record => 'Aufzeichnen';
  @override
  String get action => 'Aktion';
  @override
  String get actor => 'Schauspieler';
  @override
  String get old_data => 'Alte Daten';
  @override
  String get new_data => 'Neue Daten';
  @override
  String get performed_by => 'Aufgeführt von';
  @override
  String get table => 'Tisch';
  @override
  String get notes => 'Notizen';
  @override
  String get close_details => 'Details schließen';
  @override
  String get view_details => 'Details anzeigen';
}

extension on TranslationsDe {
  dynamic _flatMapFunction(String path) {
    return switch (path) {
          'common.close' => 'Schließen',
          'common.cancel' => 'Abbrechen',
          'common.confirm' => 'Bestätigen',
          'common.save' => 'Speichern',
          'common.back' => 'Zurück',
          'welcome.title' => 'Willkommen bei Hue',
          'welcome.subtitle' =>
            'Erleuchten Sie Ihre Welt mit bedeutungsvollen Verbindungen.',
          'welcome.get_started' => 'Loslegen',
          'welcome.have_account' => 'Ich habe bereits ein Konto',
          'welcome.student_portal' => 'Studentenportal',
          'welcome.welcome_to_the_smart_universit' =>
            'Willkommen an der Smart University',
          'welcome.i_already_have_an_account' => 'Ich habe bereits ein Konto',
          'onboarding.language.title' => 'Wählen Sie Ihre Sprache',
          'onboarding.language.subtitle' =>
            'Wählen Sie Ihre bevorzugte Sprache',
          'onboarding.language.english' => 'Englisch',
          'onboarding.language.arabic' => 'Arabisch',
          'onboarding.language.german' => 'Deutsch',
          'onboarding.language.chinese' => 'Chinesisch',
          'onboarding.language.hint' =>
            'Sie können dies später in den Einstellungen ändern',
          'onboarding.faculties_directory.title' => 'Unsere Fakultäten',
          'onboarding.faculties_directory.subtitle' =>
            'Entdecken Sie unsere vielfältigen akademischen Abteilungen',
          'onboarding.style.title' => 'Wählen Sie Ihren Stil',
          'onboarding.style.subtitle' =>
            'Wählen Sie das Interface-Design, das Sie bevorzugen',
          'onboarding.style.classic.title' => 'Klassisch',
          'onboarding.style.classic.desc' =>
            'Sauberes, einfaches und vertrautes Material Design',
          'onboarding.style.glass.title' => 'Glas',
          'onboarding.style.glass.desc' =>
            'Moderne, transluzente und lebendige Ästhetik',
          'onboarding.theme.title' => 'Wählen Sie ein Thema',
          'onboarding.theme.subtitle' => 'Hell oder dunkel, Ihre Wahl',
          'onboarding.theme.light' => 'Hell',
          'onboarding.theme.dark' => 'Dunkel',
          'onboarding.choose_app_style' => 'Wählen Sie Ihren App-Stil',
          'onboarding.premium_frosted_glass_blur_eff' =>
            'Erstklassiger Unschärfeeffekt aus Milchglas',
          'onboarding.choose_app_theme' => 'Wählen Sie Ihr Thema',
          'onboarding.title' => 'Onboarding',
          'onboarding.you_can_switch_styles_later_in' =>
            'Sie können den Stil später in den Einstellungen ändern',
          'onboarding.choose_language' => 'Wählen Sie Ihre Sprache',
          'onboarding.you_can_change_this_later_in_s' =>
            'Sie können dies später in den Einstellungen ändern',
          'onboarding.recommended' => 'Empfohlen',
          'onboarding.high_performance_flat_solid_co' =>
            'Leistungsstarke, flache Volltonfarben',
          'onboarding.select_the_lighting_that_suits' =>
            'Wählen Sie die Beleuchtung, die am besten zu Ihnen passt',
          'onboarding.almost_there_just_one_more_ste' =>
            'Fast geschafft! Nur noch ein Schritt.',
          'onboarding.classic_solid' => 'Klassiker',
          'onboarding.dark_mode' => 'Dunkler Modus',
          'onboarding.light_mode' => 'Lichtmodus',
          'onboarding.modern_glass' => 'Modernes Glas',
          'auth.login.welcome' => 'Willkommen zurück',
          'auth.login.subtitle' => 'Melden Sie sich an, um fortzufahren',
          'auth.login.email' => 'E-Mail',
          'auth.login.password' => 'Passwort',
          'auth.login.forgot_password' => 'Passwort vergessen?',
          'auth.login.submit' => 'Anmelden',
          'auth.login.guest' => 'Als Gast stöbern',
          'auth.forgot_password.title' => 'Passwort vergessen',
          'auth.forgot_password.subtitle' =>
            'Wählen Sie eine Wiederherstellungsmethode',
          'auth.forgot_password.method_admin' => 'Verwaltung besuchen',
          'auth.forgot_password.method_online' => 'Online-Anfrage',
          'auth.forgot_password.admin_instructions' =>
            'Bitte besuchen Sie das Büro für studentische Angelegenheiten, um Ihr Passwort zurückzusetzen. Bringen Sie Ihren gültigen Universitätsausweis mit.',
          'auth.forgot_password.phone_label' => 'Telefonnummer',
          'auth.forgot_password.upload_id' => 'ID-Foto hochladen',
          'auth.forgot_password.upload_id_hint' =>
            'Tippen Sie, um ein klares Foto Ihres Universitätsausweises hochzuladen',
          'auth.forgot_password.submit' => 'Anfrage absenden',
          'auth.forgot_password.back' => 'Zurück zum Login',
          'auth.forgot_password.error_empty_phone' =>
            'Bitte geben Sie Ihre Telefonnummer ein',
          'auth.forgot_password.error_empty_email' =>
            'Bitte geben Sie Ihre E-Mail ein',
          'auth.forgot_password.error_no_id' =>
            'Bitte laden Sie Ihr ID-Foto hoch',
          'auth.forgot_password.success' => 'Anfrage erfolgreich gesendet',
          'auth.forgot_password.id_uploaded' => 'ID hochgeladen',
          'auth.forgot_password.choose_account_recovery_method' =>
            'Wählen Sie die Methode zur Kontowiederherstellung',
          'auth.forgot_password.back_to_login' => 'Zurück zum Anmelden',
          'auth.back' => 'Zurück',
          'auth.choose_account_recovery_method' =>
            'Wählen Sie die Methode zur Kontowiederherstellung',
          'home.tabs.home' => 'Startseite',
          'home.tabs.search' => 'Suche',
          'home.tabs.notifications' => 'Benachrichtigungen',
          'home.tabs.profile' => 'Profil',
          'home.tabs.student' => 'Student',
          'home.tabs.colleges' => 'Hochschulen',
          'home.tabs.admin' => 'Admin',
          'home.student' => 'Student',
          'home.colleges' => 'Hochschulen',
          'home.admin_portal' => 'Admin-Portal',
          'home.admin' => 'Admin',
          'home.prof' => 'Professor',
          'home.home' => 'Heim',
          'home.student_portal' => 'Studentenportal',
          'home.faculty_portal' => 'Fakultätsportal',
          'dashboard.id_card.student_name' => 'Studentenname',
          'dashboard.id_card.college' => 'Fakultät',
          'dashboard.id_card.id' => 'Studenten-ID',
          'dashboard.id_card.gpa' => 'Notendurchschnitt',
          'dashboard.id_card.level' => 'Stufe',
          'dashboard.id_card.verified' => 'Verifiziert',
          'dashboard.sections.academic' => 'Akademisch',
          'dashboard.sections.enrollment' => 'Einschreibung',
          'dashboard.sections.utilities' => 'Dienstprogramme',
          'dashboard.items.transcript' => 'Transkript',
          'dashboard.items.progress' => 'Fortschritt',
          'dashboard.items.action_plan' => 'Aktionsplan',
          'dashboard.items.subject_result' => 'Ergebnis',
          'dashboard.items.grades' => 'Noten',
          'dashboard.items.courses' => 'Kurse',
          'dashboard.items.registration' => 'Registrierung',
          'dashboard.items.invoices' => 'Rechnungen',
          'dashboard.items.payment' => 'Zahlung',
          'dashboard.items.tutorials' => 'Tutorials',
          'dashboard.items.security' => 'Sicherheit',
          'dashboard.items.forums' => 'Foren',
          'dashboard.items.support' => 'Unterstützung',
          'dashboard.items.notifications' => 'Benachrichtigungen',
          'dashboard.items.no_lectures' => 'Keine Vorlesungen gefunden',
          'dashboard.items.digital_id' => 'Digitale ID',
          'dashboard.labels.university_name' => 'UNIVERSITÄT VON HUE',
          'dashboard.labels.id_short' => 'AUSWEIS',
          'dashboard.labels.gpa_short' => 'Notendurchschnitt',
          'dashboard.labels.level_short' => 'LVL',
          'settings.title' => 'Einstellungen',
          'settings.sections.account' => 'Konto',
          'settings.sections.display' => 'Anzeige',
          'settings.sections.notifications' => 'Benachrichtigungen',
          'settings.sections.about' => 'Über',
          'settings.tiles.edit_profile' => 'Profil bearbeiten',
          'settings.tiles.change_password' => 'Passwort ändern',
          'settings.tiles.dark_mode' => 'Dunkelmodus',
          'settings.tiles.language' => 'Sprache',
          'settings.tiles.ui_style' => 'UI-Stil',
          'settings.tiles.app_notifications' => 'App-Benachrichtigungen',
          'settings.tiles.test_notifications' => 'Benachrichtigungen testen',
          'settings.tiles.about_app' => 'Über die App',
          'settings.tiles.privacy_policy' => 'Datenschutzrichtlinie',
          'settings.tiles.logout' => 'Abmelden',
          'settings.messages.switching_theme' => 'Thema wird gewechselt...',
          'settings.messages.changing_language' => 'Sprache wird geändert...',
          'settings.messages.rebuilding_design' =>
            'Design-System wird neu aufgebaut...',
          'settings.about_app' => 'Über App',
          'settings.university' => 'Horus-Universität',
          'settings.developer' => 'Entwickler',
          'settings.horus_university' => 'Horus-Universität – Ägypten',
          'settings.password_must_be_at_least_6_ch' =>
            'Das Passwort muss mindestens 6 Zeichen lang sein',
          'settings.backend' => 'Backend',
          'settings.platform' => 'Plattform',
          'settings.change_password' => 'Kennwort ändern',
          'settings.user' => 'Benutzer',
          'settings.hue_portal_is_a_comprehensive_' =>
            'HUE Portal ist ein umfassendes intelligentes Universitätsverwaltungssystem.',
          'settings.password_changed_successfully' =>
            'Passwort erfolgreich geändert',
          'settings.passwords_do_not_match' =>
            'Passwörter stimmen nicht überein',
          'settings.please_fill_all_fields' =>
            'Bitte füllen Sie alle Felder aus',
          'settings.enter_your_new_password' =>
            'Geben Sie unten Ihr neues Passwort ein',
          'settings.new_password' => 'Neues Passwort',
          'settings.confirm_password' => 'Passwort bestätigen',
          'settings.privacy_policy' => 'Datenschutzrichtlinie',
          'settings.last_updated_february_2026' =>
            'Letzte Aktualisierung: Februar 2026',
          'settings.edit_profile' => 'Profil bearbeiten',
          'settings.full_name' => 'Vollständiger Name',
          'settings.email' => 'E-Mail',
          'settings.update_your_info_and_contact_d' =>
            'Aktualisieren Sie Ihre Informationen und Kontaktdaten',
          'settings.phone' => 'Telefon',
          'settings.send_password_recovery_link_to' =>
            'Senden Sie den Link zur Passwortwiederherstellung per E-Mail',
          'settings.change_password_and_security_l' =>
            'Passwort und Sicherheitsstufe ändern',
          'settings.toggle_between_dark_and_light_' =>
            'Wechseln Sie zwischen dunklem und hellem Modus',
          'settings.current_glass_design' => 'Aktuell: Glasdesign',
          'settings.forgot_password' => 'Passwort vergessen',
          'settings.role' => 'Rolle',
          'settings.switch_style' => 'Stil wechseln',
          'settings.bio' => 'Bio',
          'settings.current_classic_design' => 'Aktuell: Klassisches Design',
          'settings.control_the_types_of_incoming_' =>
            'Steuern Sie die Arten eingehender Benachrichtigungen',
          'settings.save' => 'Speichern',
          'settings.test_notification_successful' =>
            'Testbenachrichtigung erfolgreich gesendet!',
          'settings.send_a_test_notification' =>
            'Senden Sie eine Testbenachrichtigung',
          'settings.battery_saver_mode' => 'Batteriesparmodus',
          'settings.help_support_center' => 'Hilfe- und Supportcenter',
          'settings.disable_complex_visual_effects' =>
            'Deaktivieren Sie komplexe visuelle Effekte für eine bessere Leistung',
          'settings.version_details_and_developers' =>
            'Versionsdetails und Entwicklerinformationen',
          'settings.contact_us_to_resolve_any_issu' =>
            'Kontaktieren Sie uns, um jedes Problem zu lösen',
          'settings.terms_and_rules_for_data_usage' =>
            'Bedingungen und Regeln für die Datennutzung',
          'settings.kSwitch' => 'Schalten',
          'settings.deutsch' => 'Deutsch',
          'settings.select_app_language' => 'Wählen Sie App-Sprache aus',
          'settings.switch_label' => 'Schalten',
          'settings.dynamic_val' => 'Dynamisch',
          'colleges.details.dean' => 'Dekan der Fakultät',
          'colleges.details.staff' => 'Lehrpersonal',
          'colleges.details.view_all' => 'Alle anzeigen',
          'colleges.details.departments' => 'Abteilungen',
          'colleges.details.explore_majors' => 'Verfügbare Majors erkunden',
          'colleges.details.majors' => 'Majors',
          'colleges.details.dean_title' => 'Der Dekan',
          'colleges.details.staff_member' => 'Mitarbeiter',
          'colleges.details.vice_dean' => 'Vizedekan',
          'colleges.details.head_of_dept' => 'Abteilungsleiter',
          'colleges.details.assoc_prof' => 'Assoc. Prof.',
          'colleges.details.academic_statistics' => 'Akademische Statistik',
          'colleges.details.students' => 'Studenten',
          'colleges.details.academic_staff' => 'Lehrpersonal',
          'colleges.details.teaching_assistants' => 'Assistenten',
          'colleges.details.published_articles' => 'Veröffentlichte Artikel',
          'colleges.applied_health_sciences' =>
            'Fakultät für angewandte Gesundheitswissenschaften',
          'colleges.business_administration' =>
            'Fakultät für Betriebswirtschaft',
          'colleges.dentistry' => 'Fakultät für Zahnmedizin',
          'colleges.engineering' => 'Fakultät für Ingenieurwissenschaften',
          'colleges.fine_arts' => 'Fakultät für Bildende Künste',
          'colleges.human_medicine' => 'Fakultät für Humanmedizin',
          'colleges.linguistics' => 'Fakultät für Linguistik & Übersetzung',
          'colleges.pharmacy' => 'Fakultät für Pharmazie',
          'colleges.physical_therapy' => 'Fakultät für Physiotherapie',
          'colleges.ai' => 'Fakultät für Künstliche Intelligenz',
          'colleges.departments.medical_laboratories_technology' =>
            'Medizinische Labortechnologie',
          'colleges.departments.radiology_and_imaging_technology' =>
            'Radiologie und Bildgebungstechnologie',
          'colleges.departments.respiratory_care_technology' =>
            'Atemwegspflege-Technologie',
          'colleges.departments.dental_prosthetics_technology' =>
            'Zahnprothetische Technologie',
          'colleges.departments.health_administration_and_informatics_technology' =>
            'Gesundheitsverwaltung & Informatik',
          'colleges.departments.accounting' => 'Rechnungswesen',
          'colleges.departments.business_management' => 'Unternehmensführung',
          'colleges.departments.economics' => 'Wirtschaftswissenschaften',
          'colleges.departments.marketing' => 'Marketing',
          'colleges.departments.accounting_program_english' =>
            'Rechnungswesen (Englisch)',
          'colleges.departments.business_administration_program_english' =>
            'Betriebswirtschaft (Englisch)',
          'colleges.departments.basic_sciences_in_dentistry' =>
            'Grundlagen der Zahnmedizin',
          'colleges.departments.basic_medical_and_clinical_sciences' =>
            'Medizinische Grundlagen',
          'colleges.departments.oral_and_maxillofacial_surgery' =>
            'Mund-Kiefer-Gesichtschirurgie',
          'colleges.departments.orthodontics_and_pediatric_dentistry' =>
            'Kieferorthopädie & Kinderzahnheilkunde',
          'colleges.departments.periodontics_and_oral_medicine' =>
            'Parodontologie & Oralmedizin',
          'colleges.departments.prosthodontics' => 'Prothetik',
          'colleges.departments.conservative_dentistry_and_endodontics' =>
            'Konservierende Zahnheilkunde',
          'colleges.departments.architectural_engineering' => 'Architektur',
          'colleges.departments.basic_sciences' => 'Grundlagenwissenschaften',
          'colleges.departments.civil_engineering' => 'Bauingenieurwesen',
          'colleges.departments.mechanical_engineering' => 'Maschinenbau',
          'colleges.departments.electrical_engineering' => 'Elektrotechnik',
          'colleges.departments.artificial_intelligence_engineering' =>
            'KI-Ingenieurwesen',
          'colleges.departments.interior_design_and_architecture' =>
            'Innenarchitektur',
          'colleges.departments.furniture_design_and_production_technology' =>
            'Möbeldesign-Technologie',
          'colleges.departments.graphics_and_digital_arts' =>
            'Grafik und digitale Kunst',
          'colleges.departments.animation_and_multimedia' =>
            'Animation und Multimedia',
          'colleges.departments.medical_education' => 'Medizinische Ausbildung',
          'colleges.departments.histology_and_cell_biology' =>
            'Histologie und Zellbiologie',
          'colleges.departments.clinical_pharmacy' => 'Klinische Pharmazie',
          'colleges.departments.human_anatomy_and_embryology' =>
            'Anatomie und Embryologie',
          'colleges.departments.medical_physiology' =>
            'Medizinische Physiologie',
          'colleges.departments.medical_microbiology_and_immunology' =>
            'Mikrobiologie & Immunologie',
          'colleges.departments.forensic_medicine_and_toxicology' =>
            'Forensik & Toxikologie',
          'colleges.departments.community_medicine_and_public_health' =>
            'Gemeinschaftsmedizin & Gesundheit',
          'colleges.departments.biochemistry' => 'Biochemie',
          'colleges.departments.pathology' => 'Pathologie',
          'colleges.departments.english_language_program' =>
            'Englisch-Sprachprogramm',
          'colleges.departments.german_language_program' =>
            'Deutsch-Sprachprogramm',
          'colleges.departments.chinese_language_program' =>
            'Chinesisch-Sprachprogramm',
          'colleges.departments.french_department' => 'Französische Abteilung',
          'colleges.departments.translation_department' =>
            'Übersetzungsabteilung',
          'colleges.departments.pharmaceutical_chemistry' =>
            'Pharmazeutische Chemie',
          'colleges.departments.pharmacology_and_biochemistry' =>
            'Pharmakologie & Biochemie',
          'colleges.departments.pharmacognosy' => 'Pharmakognosie',
          'colleges.departments.microbiology_and_immunology' =>
            'Mikrobiologie & Immunologie',
          'colleges.departments.pharmaceutical_technology' =>
            'Pharmazeutische Technologie',
          'colleges.departments.pharmacy_practice' => 'Pharmaziepraxis',
          'colleges.departments.basic_sciences_pt' => 'Grundwissenschaften PT',
          'colleges.departments.biomechanics' => 'Biomechanik',
          'colleges.departments.pt_internal_medicine_and_geriatrics' =>
            'PT für Innere Medizin & Geriatrie',
          'colleges.departments.pt_womens_health' => 'PT für Frauengesundheit',
          'colleges.departments.pt_surgery_and_integumentary' =>
            'PT für Chirurgie',
          'colleges.departments.pt_orthopedics' => 'PT für Orthopädie',
          'colleges.departments.pt_neurology' => 'PT für Neurologie',
          'colleges.departments.pt_pediatrics' => 'PT für Pädiatrie',
          'colleges.departments.artificial_biomedical_computing' =>
            'KI-Biomedizinisches Computing',
          'colleges.departments.artificial_cybersecurity' =>
            'KI-Cybersicherheit',
          'colleges.departments.ai_and_data_science' =>
            'KI & Datenwissenschaft',
          'colleges.departments.ai_for_robotics' => 'KI für Robotik',
          'colleges.departments.smart_systems' => 'Intelligente Systeme',
          'transcript.title' => 'Akademisches Transkript',
          'transcript.overview.gpa' => 'Gesamt-GPA',
          'transcript.overview.credits' => 'Erworbene Credits',
          'transcript.overview.standing' => 'Status',
          'transcript.overview.active' => 'Guter Status',
          'transcript.semester.fall' => 'Herbstsemester',
          'transcript.semester.spring' => 'Frühlingssemester',
          'transcript.semester.summer' => 'Sommersemester',
          'transcript.course.grade' => 'Note',
          'transcript.course.credits' => 'Credits',
          'transcript.course.status.completed' => 'Abgeschlossen',
          'transcript.course.status.transferred' => 'Übertragen',
          'academic_progress.title' => 'Akademischer Fortschritt',
          'academic_progress.completion' => 'Abschlussgrad',
          'academic_progress.total_credits' => 'Gesamt-Credits',
          'academic_progress.categories.university' =>
            'Universitätsanforderungen',
          'academic_progress.categories.faculty' => 'Fakultätsanforderungen',
          'academic_progress.categories.major' => 'Hauptfachanforderungen',
          'academic_progress.categories.electives' => 'Wahlfächer',
          'academic_progress.categories.university_name' => 'Horus-Universität',
          'academic_progress.status.completed' => 'Abgeschlossen',
          'academic_progress.status.in_progress' => 'In Arbeit',
          'academic_progress.status.remaining' => 'Verbleibend',
          'academic_progress.status.requirement_met' => 'Anforderung erfüllt',
          'grades.title' => 'Semesternoten',
          'grades.grade_point' => 'Notenpunkte',
          'grades.letter_grade' => 'Notenbuchstabe',
          'grades.gpa' => 'Semester-GPA',
          'grades.summary' => 'Notenzusammenfassung',
          'grades.cumulative_gpa' => 'Kumulierter GPA',
          'grades.credits' => 'Credits',
          'subject_results.title' => 'Fachergebnisse',
          'subject_results.midterm' => 'Zwischenprüfung',
          'subject_results.kFinal' => 'Abschlussprüfung',
          'subject_results.practical' => 'Praktikum',
          'subject_results.activities' => 'Semesteraktivitäten',
          'subject_results.total' => 'Gesamtpunktzahl',
          'action_plan.title' => 'Grad-Aktionsplan',
          'action_plan.roadmap' => 'Kurs-Roadmap',
          'action_plan.year_1' => 'Erstes Jahr',
          'action_plan.year_2' => 'Zweites Jahr',
          'action_plan.year_3' => 'Drittes Jahr',
          'action_plan.year_4' => 'Viertes Jahr',
          'courses.title' => 'Meine Kurse',
          'courses.enrolled' => 'Eingeschrieben',
          'courses.available' => 'Verfügbar',
          'courses.instructor' => 'Dozent',
          'courses.schedule' => 'Zeitplan',
          'schedule.title' => 'Stundenplan',
          'schedule.time' => 'Zeit',
          'schedule.room' => 'Raum',
          'schedule.monday' => 'Montag',
          'schedule.tuesday' => 'Dienstag',
          'schedule.wednesday' => 'Mittwoch',
          'schedule.thursday' => 'Donnerstag',
          'schedule.friday' => 'Freitag',
          'schedule.saturday' => 'Samstag',
          'schedule.sunday' => 'Sonntag',
          'schedule.instructor' => 'Dozent',
          'schedule.doctor' => 'Dr.',
          'schedule.type_lecture' => 'Vorlesung',
          'schedule.type_section' => 'Übung',
          'schedule.status_active' => 'Anstehend',
          'schedule.status_started' => 'Jetzt',
          'schedule.status_cancelled' => 'Abgesagt',
          'schedule.status_online' => 'Online',
          'schedule.status_substitute' => 'Ersatz',
          'schedule.morning' => 'Vormittag',
          'schedule.afternoon' => 'Nachmittag',
          'schedule.evening' => 'Abend',
          'schedule.all_periods' => 'Alle Zeiträume',
          'schedule.floor' => 'Etage',
          'schedule.direction' => 'Richtung',
          'schedule.east' => 'Osten',
          'schedule.west' => 'Westen',
          'schedule.south' => 'Süden',
          'schedule.north' => 'Norden',
          'schedule.no_lectures' => 'Keine Vorlesungen gefunden',
          'schedule.daily_title' => 'Tagesplan',
          'exam_schedule.title' => 'Prüfungsplan',
          'exam_schedule.date' => 'Datum',
          'exam_schedule.duration' => 'Dauer',
          'exam_schedule.seat' => 'Sitznummer',
          'attendance.title' => 'Anwesenheitsstatistik',
          'attendance.present' => 'Anwesend',
          'attendance.absent' => 'Abwesend',
          'attendance.late' => 'Verspätet',
          'attendance.ratio' => 'Anwesenheitsquote',
          'attendance.subjects.machine_learning' => 'Maschinelles Lernen',
          'attendance.subjects.ai' => 'Künstliche Intelligenz',
          'attendance.subjects.ethics' => 'Ethik in der IT',
          'attendance.subjects.calculus' => 'Erweiterte Analysis',
          'registration.title' => 'Kursregistrierung',
          'registration.submit' => 'Registrierung absenden',
          'registration.enrolled_credits' => 'Eingeschriebene Credits',
          'registration.group_label' =>
            ({required Object group}) => 'Gruppe${group}',
          'registration.step2_title' => 'Schritt 2: Wählen Sie Unterabschnitt',
          'registration.step1_title' => 'Schritt 1: Wählen Sie Hauptgruppe',
          'registration.step1_subtitle' =>
            'Wählen Sie die Hauptgruppe aus, für die Sie sich in diesem Semester anmelden möchten.',
          'registration.step2_subtitle' =>
            ({required Object group}) =>
                'Ausgewählte Gruppe:${group}. Wählen Sie nun Ihren praktischen Teilbereich aus.',
          'registration.section_label' =>
            ({required Object section}) => 'Abschnitt${section}',
          'registration.semester' => 'Semester',
          'registration.labs_sessions' => 'Labore und praktische Sitzungen',
          'registration.review' => 'Überprüfen Sie die Auswahl',
          'registration.section' => 'Abschnitt',
          'registration.step3_title' =>
            'Schritt 3: Bestätigen Sie die Registrierung',
          'registration.main_cohort' => 'Registrierung der Hauptkohorte',
          'registration.group' => 'Gruppe',
          'registration.auto_registered' => 'Automatisch anzumeldende Kurse:',
          'registration.credits_count' =>
            ({required Object credits}) => '${credits}CR',
          'registration.confirm_final' =>
            'Bestätigen Sie die endgültige Registrierung',
          'registration.back_home' => 'Zurück nach Hause',
          'registration.success_message' =>
            ({required Object group, required Object section}) =>
                'Sie haben sich erfolgreich für dieses Semester angemeldet.\nGruppe:${group}| Abschnitt:${section}',
          'registration.registration_success' => 'Registrierung erfolgreich!',
          'registration.already_registered_title' => 'Bereits registriert!',
          'registration.error_loading' =>
            ({required Object error}) =>
                'Fehler:${error}Tippen Sie, um es noch einmal zu versuchen',
          'payment.title' => 'Studiengebühren',
          'payment.outstanding' => 'Offener Betrag',
          'payment.pay_now' => 'Jetzt bezahlen',
          'payment.methods' => 'Zahlungsmethoden',
          'payment.university_guaranteed' =>
            'Von der Universität garantierte Methoden',
          'payment.bank_transfer' => 'Banküberweisung',
          'payment.fawry' => 'Fawry / E-Payment',
          'payment.credit_debit' => 'Kredit-/Debitkarte',
          'payment.currency' => ({required Object amount}) => '${amount}EGP',
          'invoices.title' => 'Rechnungen',
          'invoices.history' => 'Zahlungshistorie',
          'invoices.unpaid' => 'Unbezahlt',
          'invoices.paid' => 'Bezahlt',
          'invoices.date' => 'Datum',
          'invoices.amount' => 'Menge',
          'invoices.id' => 'Rechnungs-ID',
          'invoices.status' => 'Status',
          'notifications.title' => 'Benachrichtigungen',
          'notifications.empty' => 'Keine neuen Benachrichtigungen',
          'support.title' => 'Support & Hilfe',
          'support.contact_us' => 'Kontaktieren Sie uns',
          'security.title' => 'Sicherheit',
          'security.biometrics' => 'Biometrie',
          'security.sessions' => 'Aktive Sitzungen',
          'tutorials.title' => 'Tutorials & Leitfäden',
          'forums.title' => 'Foren',
          'administration.title' => 'Studentenverwaltung',
          'administration.stats' => 'Systemstatistik',
          'administration.users' => 'Benutzer',
          'administration.reports' => 'Berichte',
          'administration.audit_logs.no_logs_found' =>
            'Es wurden keine Protokolle gefunden, die den Kriterien entsprechen.',
          'administration.audit_logs.title' => 'Audit-Protokolle',
          'administration.audit_logs.tabs.all' => 'Alle Protokolle',
          'administration.audit_logs.tabs.security' => 'Sicherheit',
          'administration.audit_logs.tabs.user_management' =>
            'Benutzerverwaltung',
          'administration.audit_logs.tabs.data_updates' =>
            'Datenaktualisierungen',
          'administration.audit_logs.labels.record' => 'Aufzeichnen',
          'administration.audit_logs.labels.action' => 'Aktion',
          'administration.audit_logs.labels.actor' => 'Schauspieler',
          'administration.audit_logs.labels.old_data' => 'Alte Daten',
          'administration.audit_logs.labels.new_data' => 'Neue Daten',
          'administration.audit_logs.labels.performed_by' => 'Aufgeführt von',
          'administration.audit_logs.labels.table' => 'Tisch',
          'administration.audit_logs.labels.notes' => 'Notizen',
          'administration.audit_logs.labels.close_details' =>
            'Details schließen',
          'administration.audit_logs.labels.view_details' => 'Details anzeigen',
          'feed.hours_ago' => 'Vor Stunden',
          'feed.likes' => 'mag',
          'feed.caption_sample' =>
            'Dies ist eine Beispielbeschriftung für einen Beitrag',
          'professor.dashboard_title' => 'Professor-Dashboard',
          'professor.welcome_back_name' =>
            ({required Object name}) => 'Willkommen zurück,${name}',
          'professor.uploaded_files_count' =>
            ({required Object count}) => 'Von${count}hochgeladene Dateien',
          'professor.announcement_to' =>
            ({required Object count}) => 'An${count}melden',
          'professor.weekly_slots_count' =>
            ({required Object count}) => 'Wöchentliche${count}-Slots',
          'professor.preparing_announcement' =>
            'Ankündigung wird vorbereitet...',
          'professor.active_tas_count' =>
            ({required Object count}) => '${count}Aktive TAs',
          'professor.total_students_count' =>
            ({required Object count}) => '${count}Gesamtzahl der Studierenden',
          'professor.no_groups' => 'Keine Gruppen verfügbar',
          'professor.select_all' => 'Wählen Sie „Alle“ aus',
          'professor.activating' =>
            ({required Object target}) => 'Aktivieren:${target}',
          'professor.action_clicked' =>
            ({required Object action}) => 'Angeklickt:${action}',
          'professor.deselect_all' => 'Alle abwählen',
          'professor.add_new_ta' => 'Neuen TA hinzufügen',
          'professor.selected_count' =>
            ({required Object count}) => '${count}Ausgewählt',
          'professor.no_available_tas' => 'Keine verfügbaren TAs',
          'professor.added' =>
            ({required Object name}) => 'Hinzugefügt:${name}',
          'professor.no_active_tas' => 'Keine aktiven TAs',
          'professor.removed' => ({required Object name}) => 'Entfernt:${name}',
          'professor.add' => 'Hinzufügen',
          'professor.urgent' => 'Dringend',
          'professor.message' => 'Nachricht',
          'professor.joined' =>
            ({required Object name}) => 'Beigetreten:${name}',
          'professor.downloading' => 'Herunterladen...',
          'professor.walk_in' => 'Begehbar',
          'professor.join' => 'Verbinden',
          'professor.upload' => 'Hochladen',
          'professor.stats.groups' => 'Gruppen',
          'professor.stats.students' => 'Gesamtzahl der Studierenden',
          'professor.stats.rating' => 'Bewertung',
          'professor.stats.tas' => 'Lehrassistenten',
          'professor.stats.shared_files' => 'Freigegebene Dateien',
          'professor.stats.office_hours' => 'Bürozeiten',
          'professor.quick_actions.urgent' => 'Dringend',
          'professor.quick_actions.message' => 'Nachricht',
          'professor.quick_actions.upload' => 'Hochladen',
          'professor.quick_actions.action_clicked' => 'Angeklickt',
          'professor.profile.urgent_announcements' => 'Dringende Ankündigungen',
          'professor.profile.teaching_assistants' => 'Lehrassistenten',
          'professor.profile.shared_resources' => 'Gemeinsame Ressourcen',
          'professor.profile.office_hours' => 'Bürozeiten',
          'roles.categories.admin_it' => 'Verwaltung und IT',
          'roles.categories.student_affairs' => 'Studentenangelegenheiten',
          'roles.categories.academic_leadership' => 'Akademische Führung',
          'roles.categories.facilities_security' =>
            'Einrichtungen und Sicherheit',
          'roles.categories.teaching_staff' => 'Lehrpersonal',
          'roles.categories.external_roles' => 'Externe Rollen',
          'roles.categories.student_roles' => 'Schülerrollen',
          'roles.names.super_admin' => 'Super Admin',
          'roles.names.admin' => 'Administrator',
          'roles.names.financial_auditor' => 'Finanzprüfer',
          'roles.names.it_support' => 'IT-Support',
          'roles.names.rector' => 'Rektor / Präsident',
          'roles.names.academic_coordinator' => 'Akademischer Koordinator',
          'roles.names.department_head' => 'Abteilungsleiter',
          'roles.names.professor' => 'Professor / Dozent',
          'roles.names.teaching_assistant' => 'Lehrassistent',
          'roles.names.dean' => 'Dean',
          'roles.names.academic_advisor' => 'Akademischer Berater',
          'roles.names.registrar_officer' => 'Standesbeamter',
          'roles.names.lecturer' => 'Dozent',
          'roles.names.regular_student' => 'Regulärer Student',
          'roles.names.librarian' => 'Bibliothekar',
          'roles.names.student' => 'Student',
          'roles.names.class_representative' => 'Klassensprecher',
          'roles.names.freshman' => 'Erstsemester',
          'roles.names.alumni' => 'Alumni',
          'roles.names.dorm_supervisor' => 'Wohnheimleiter',
          'roles.names.security_officer' => 'Sicherheitsbeauftragter',
          'roles.names.parent' => 'Elternteil/Erziehungsberechtigter',
          'roles.names.guest' => 'Gast',
          'roles.names.recruiter' => 'Personalvermittler',
          'roles.descriptions.super_admin' =>
            'Volle Kontrolle über das gesamte System',
          'roles.descriptions.financial_auditor' =>
            'Überwacht Finanzunterlagen und Rechnungen',
          'roles.descriptions.it_support' =>
            'Technische Systembetreuung und Wartung',
          'roles.descriptions.department_head' =>
            'Leiter einer wissenschaftlichen Abteilung',
          'roles.descriptions.rector' =>
            'Universitätspräsident mit voller akademischer Aufsicht',
          'roles.descriptions.dean' => 'Leiter einer Hochschule/Fakultät',
          _ => null,
        } ??
        switch (path) {
          'roles.descriptions.teaching_assistant' =>
            'Unterstützt Professoren bei der Benotung, Laboren und Tutorials',
          'roles.descriptions.academic_coordinator' =>
            'Koordiniert akademische Programme und Terminplanung',
          'roles.descriptions.professor' =>
            'Fakultätsmitglied, das Kurse unterrichtet und verwaltet',
          'roles.descriptions.librarian' =>
            'Verwaltet Bibliotheksressourcen und -materialien',
          'roles.descriptions.admin' => 'Systemadministrator mit hohen Rechten',
          'roles.descriptions.academic_advisor' =>
            'Führt Studierende durch die akademische Planung',
          'roles.descriptions.freshman' =>
            'Studienanfänger mit eingeschränktem Systemzugriff',
          'roles.descriptions.lecturer' =>
            'Lehrt Kurse ohne volle Professorenprivilegien',
          'roles.descriptions.registrar_officer' =>
            'Verwaltet die Einschreibung und Registrierung von Studenten',
          'roles.descriptions.regular_student' =>
            'Vollständiger Student mit allen üblichen akademischen Privilegien',
          'roles.descriptions.alumni' => 'Absolvent mit eingeschränktem Zugang',
          'roles.descriptions.student' => 'Allgemeine Schülerrolle',
          'roles.descriptions.security_officer' =>
            'Campussicherheit und Zugangskontrolle',
          'roles.descriptions.class_representative' =>
            'Schülerführer, der die Klassengemeinschaft vertritt',
          'roles.descriptions.parent' =>
            'Kann den Fortschritt und die Noten der verknüpften Schüler anzeigen',
          'roles.descriptions.dorm_supervisor' =>
            'Verwaltet den Betrieb der Studentenwohnheime',
          'roles.descriptions.guest' =>
            'Temporärer Besucher mit minimalem Zugang',
          'roles.descriptions.recruiter' => 'Externe Rekrutierungsorganisation',
          'academic.academic_progress' => 'Akademischer Fortschritt',
          'academic.electives' => 'Wahlfächer',
          'academic.courses_title' => 'Meine Kurse',
          'academic.university_requirements' => 'Anforderungen der Universität',
          'academic.faculty_requirements' => 'Anforderungen der Fakultät',
          'academic.major_requirements' => 'Hauptanforderungen',
          'academic.remaining' => 'Übrig',
          'academic.action_plan_title' => 'Abschluss-Aktionsplan',
          'academic.grades_title' => 'Noten',
          'academic.transcript_title' => 'Akademisches Transkript',
          'academic.completed' => 'Vollendet',
          'academic.attendance_title' => 'Teilnahme',
          'academic.subject_results_title' => 'Betreffergebnisse',
          'academic.schedule_title' => 'Zeitplan',
          'academic.exam_schedule_title' => 'Prüfungsplan',
          'academic.professor_dashboard' => 'Professor-Dashboard',
          'academic.tas' => 'Lehrassistenten',
          'academic.groups' => 'Gruppen',
          'academic.all_students' => 'Alle Studenten',
          'academic.office_hours' => 'Bürozeiten',
          'academic.no_groups' => 'Keine Gruppen',
          'academic.chat' => 'Chatten',
          'academic.courses' => 'Kurse',
          'academic.inactive' => 'Inaktiv',
          'academic.assignments' => 'Aufgaben',
          'academic.active' => 'Aktiv',
          'academic.add_ta' => 'TA hinzufügen',
          'academic.remove_ta' => 'TA entfernen',
          'academic.view_all' => 'Alle anzeigen',
          'academic.send_message' => 'Nachricht senden',
          'academic.feedback' => 'Rückmeldung',
          'academic.all' => 'Alle',
          'academic.upload_file' => 'Datei hochladen',
          'academic.urgent_announcement' => 'Dringende Ankündigung',
          'academic.group_label' => 'Gruppe',
          'academic.manage_tas' => 'TAs verwalten',
          'academic.section' => 'Abschnitt',
          'academic.manage_groups' => 'Gruppen verwalten',
          'academic.profile' => 'Profil',
          'academic.gpa' => 'Notendurchschnitt',
          'academic.grade_summary' => 'Notenzusammenfassung',
          'academic.credits' => 'Credits',
          'academic.midterm' => 'Halbzeit',
          'academic.semester_grades' => 'Semesternoten',
          'academic.total' => 'Gesamt',
          'academic.practical' => 'Praktisch',
          'academic.kFinal' => 'Abschlussprüfung',
          'academic.year_1' => 'Jahr 1',
          'academic.year_2' => 'Jahr 2',
          'academic.year_4' => 'Jahr 4',
          'academic.year_3' => 'Jahr 3',
          'academic.enrolled' => 'Eingeschrieben',
          'academic.available' => 'Verfügbar',
          'academic.instructor' => 'Lehrer',
          'academic.schedule_info' => 'Zeitplan',
          'academic.time' => 'Zeit',
          'academic.room' => 'Zimmer',
          'academic.seat' => 'Sitz',
          'academic.duration' => 'Dauer',
          'academic.exam_date' => 'Prüfungsdatum',
          'academic.present' => 'Gegenwärtig',
          'academic.absent' => 'Abwesend',
          'academic.late' => 'Spät',
          'academic.error' => 'Fehler',
          'academic.retry' => 'Wiederholen',
          'academic.no_data' => 'Keine Daten verfügbar',
          'academic.ratio' => 'Verhältnis',
          'academic.filter' => 'Filter',
          'academic.back' => 'Zurück',
          'academic.search' => 'Suchen',
          'academic.loading' => 'Laden...',
          'academic.cancel' => 'Stornieren',
          'academic.save' => 'Speichern',
          'academic.delete' => 'Löschen',
          'academic.edit' => 'Bearbeiten',
          'academic.add' => 'Hinzufügen',
          'academic.remove' => 'Entfernen',
          'academic.send' => 'Schicken',
          'academic.academic_journey' => 'Akademische Reise',
          'academic.academic_results' => 'Akademische Ergebnisse',
          'academic.close' => 'Schließen',
          'academic.confirm' => 'Bestätigen',
          'academic.academic_standing_excellent' => 'Exzellent',
          'academic.across_all_groups' => 'Über alle Gruppen hinweg',
          'academic.action_plan' => 'Abschluss-Aktionsplan',
          'academic.add_to_calendar' => 'Zum Kalender hinzufügen',
          'academic.advanced_learning' => 'Fortgeschrittenes Lernen',
          'academic.add_new_ta' => 'Neuen TA hinzufügen',
          'academic.added_successfully' => 'Erfolgreich hinzugefügt',
          'academic.advanced_mathematics' => 'Fortgeschrittene Mathematik',
          'academic.advisor_assignment' => 'Berateraufgabe',
          'academic.algorithms' => 'Algorithmen',
          'academic.are_you_sure_you_want_to_remov' =>
            'Sind Sie sicher, dass Sie diesen TA entfernen möchten?',
          'academic.artificial_intelligence' => 'Künstliche Intelligenz',
          'academic.code_review' => 'Codeüberprüfung',
          'academic.clicked' => 'Angeklickt',
          'academic.calculus_i' => 'Kalkül I',
          'academic.completed_1' => 'Vollendet',
          'academic.completion_rate' => 'Abschlussrate',
          'academic.comp_organization' => 'Computerorganisation',
          'academic.computer_programming' => 'Computerprogrammierung',
          'academic.course_management' => 'Kursmanagement',
          'academic.coursework' => 'Kursarbeit',
          'academic.confirm_removal' => 'Bestätigen Sie das Entfernen',
          'academic.cs402_artificial_intelligence' =>
            'CS402 Künstliche Intelligenz',
          'academic.credits_1' => 'Credits',
          'academic.cs410_computer_vision' => 'CS410 Computer Vision',
          'academic.d_mmmm' => 'd MMMM',
          'academic.cumulative_gpa' => 'Kumulierter GPA',
          'academic.cs405_machine_learning' => 'CS405 Maschinelles Lernen',
          'academic.data_structures' => 'Datenstrukturen',
          'academic.database_systems' => 'Datenbanksysteme',
          'academic.dr_alan_turing' => 'Alan Turing',
          'academic.days' => 'Tage',
          'academic.dr_ada_lovelace' => 'Ada Lovelace',
          'academic.deep_learning' => 'Tiefes Lernen',
          'academic.dr_sarah_ahmed' => 'Dr. Sarah Ahmed',
          'academic.english_composition' => 'Englische Komposition',
          'academic.ethics_in_it' => 'Ethik in der IT',
          'academic.exam_schedule' => 'Prüfungsplan',
          'academic.field_internship' => 'Feldpraktikum',
          'academic.file_title' => 'Dateititel',
          'academic.dr_robert_smith' => 'Dr. Robert Smith',
          'academic.file_will_be_uploaded_to_cloud' =>
            'Die Datei wird in den Cloud-Speicher hochgeladen',
          'academic.fall_2023' => 'Herbst 2023',
          'academic.final_exam' => 'Abschlussprüfung',
          'academic.foundational_skills' => 'Grundlegende Fähigkeiten',
          'academic.general_physics' => 'Allgemeine Physik',
          'academic.frontend_ui' => 'Frontend-Benutzeroberfläche',
          'academic.graduation_mastery' => 'Abschluss-Meisterschaft',
          'academic.graduation_progress' => 'Abschlussfortschritt',
          'academic.graduation_project' => 'Abschlussprojekt',
          'academic.hall_1' => 'Halle 1',
          'academic.hum210_professional_ethics' => 'HUM210 Berufsethik',
          'academic.hours' => 'Std',
          'academic.hall_4' => 'Halle 4',
          'academic.intro_to_programming' => 'Einführung in die Programmierung',
          'academic.intro_to_ai' => 'Einführung in die KI',
          'academic.lab_12' => 'Labor 12',
          'academic.lab_final' => 'Laborfinale',
          'academic.lecture_hall_2' => 'Hörsaal 2',
          'academic.joined' => 'Beigetreten',
          'academic.lecture' => 'Vortrag',
          'academic.live_now' => 'Lebe jetzt',
          'academic.linear_algebra' => 'Lineare Algebra',
          'academic.logic_design' => 'Logikdesign',
          'academic.machine_learning' => 'Maschinelles Lernen',
          'academic.live' => 'Live',
          'academic.mathematics' => 'Mathematik',
          'academic.mat301_advanced_calculus' => 'MAT301 Erweiterte Berechnung',
          'academic.members' => 'Mitglieder',
          'academic.messages' => 'Nachrichten',
          'academic.midterm_exam' => 'Zwischenprüfung',
          'academic.mins' => 'Min',
          'academic.next_exam_in' => 'Nächste Prüfung in',
          'academic.network_security' => 'Netzwerksicherheit',
          'academic.no_available_tas_currently' =>
            'Derzeit sind keine TAs verfügbar',
          'academic.no_exams_on_this_day' =>
            'An diesem Tag finden keine Prüfungen statt',
          'academic.no_tas_assigned_yet' => 'Noch keine TAs zugewiesen',
          'academic.performance_distribution' => 'Leistungsverteilung',
          'academic.points' => 'Punkte',
          'academic.overall_progress' => 'Gesamtfortschritt',
          'academic.overall_attendance' => 'Gesamtanwesenheit',
          'academic.practical_project' => 'Praktisches Projekt',
          'academic.prof_john_doe' => 'Prof. John Doe',
          'academic.programming_basics' => 'Programmiergrundlagen',
          'academic.progress' => 'Fortschritt',
          'academic.quick_actions' => 'Schnelle Aktionen',
          'academic.quiz_2' => 'Quiz 2',
          'academic.psychology' => 'Psychologie',
          'academic.quiz_1' => 'Quiz 1',
          'academic.rank' => 'Rang',
          'academic.rating' => 'Bewertung',
          'academic.removed_successfully' => 'Erfolgreich entfernt',
          'academic.score' => 'Punktzahl',
          'academic.select_a_ta_from_the_list_to_a' =>
            'Wählen Sie einen TA aus der Liste aus, den Sie hinzufügen möchten',
          'academic.results_analysis' => 'Ergebnisanalyse',
          'academic.sessions_this_week' => 'Sitzungen diese Woche',
          'academic.shared_files' => 'Freigegebene Dateien',
          'academic.specialization_projects' => 'Spezialisierungsprojekte',
          'academic.registration_requests' => 'Registrierungsanfragen',
          'academic.spring_2024' => 'Frühling 2024',
          'academic.start_by_adding_the_first_ta_f' =>
            'Fügen Sie zunächst den ersten TA für Ihren Kurs hinzu',
          'academic.sophomore' => 'Zweitsemester',
          'academic.students' => 'Studenten',
          'academic.summer_2024' => 'Sommer 2024',
          'academic.total_students' => 'Gesamtzahl der Studierenden',
          'academic.track_project_i' => 'Verfolgen Sie Projekt I',
          'academic.type_a_message' => 'Geben Sie eine Nachricht ein...',
          'academic.ta_team_chat' => 'TA-Team-Chat',
          'academic.upload' => 'Hochladen',
          'academic.upload_files' => 'Dateien hochladen',
          'academic.uploaded_successfully' => 'Erfolgreich hochgeladen',
          'academic.urgent_news' => 'Dringende Neuigkeiten',
          'academic.web_programming' => 'Webprogrammierung',
          'academic.upload_new_file' => 'Neue Datei hochladen',
          'admin.en' => 'de',
          'admin.eeee_mmmm_dd_yyyy' => 'EEEE, MMMM dd, yyyy',
          'admin.system_online' => 'SYSTEM ONLINE',
          'admin.admin_command_center' => 'Admin Command Center',
          'admin.admin' => 'Admin',
          'admin.live_statistics' => 'Live-Statistiken',
          'admin.students' => 'Studenten',
          'admin.staff' => 'Personal',
          'admin.faculty' => 'Fakultät',
          'admin.leadership' => 'Führung',
          'admin.admin_it' => 'Verwaltung und IT',
          'admin.users' => 'Benutzer',
          'admin.manage_all_accounts' => 'Alle Konten verwalten',
          'admin.system_modules' => 'Systemmodule',
          'admin.colleges' => 'Hochschulen',
          'admin.manage_faculties' => 'Fakultäten verwalten',
          'admin.academic_departments' => 'Akademische Abteilungen',
          'admin.departments' => 'Abteilungen',
          'admin.professors' => 'Professoren',
          'admin.faculty_members' => 'Fakultätsmitglieder',
          'admin.permission_management' => 'Berechtigungsverwaltung',
          'admin.roles' => 'Rollen',
          'admin.audit_logs' => 'Audit-Protokolle',
          'admin.system_activity_log' => 'Systemaktivitätsprotokoll',
          'admin.system_settings' => 'Systemeinstellungen',
          'admin.platform_configuration' => 'Plattformkonfiguration',
          'admin.performance' => 'Leistung',
          'admin.server_health_metrics' => 'Kennzahlen zum Serverzustand',
          'admin.system_pulse' => 'Systemimpuls',
          'admin.server' => 'Server',
          'admin.latency' => 'Latenz',
          'admin.online' => 'Online',
          'admin.database' => 'Datenbank',
          'admin.active' => 'Aktiv',
          'admin.status' => 'Status',
          'admin.teaching_staff' => 'Lehrpersonal',
          'admin.total_users' => 'Gesamtzahl der Benutzer',
          'admin.role_breakdown' => 'Rollenaufschlüsselung',
          'admin.system_health' => 'Systemgesundheit',
          'admin.quick_actions' => 'Schnelle Aktionen',
          'admin.management' => 'Management',
          'admin.student_affairs' => 'Studentenangelegenheiten',
          'admin.academic_leadership' => 'Akademische Führung',
          'admin.realtime_latency_ms' => 'ECHTZEITLATENZ (MS)',
          'admin.export_data' => 'Daten exportieren',
          'admin.send_announcement' => 'Ankündigung senden',
          'admin.backup_system' => 'Backup-System',
          'admin.user_management' => 'Benutzerverwaltung',
          'admin.user_list' => 'Benutzerliste',
          'admin.filter_staff' => 'Personal',
          'admin.filter_students' => 'Studenten',
          'admin.filter_all' => 'Alle',
          'admin.filter_admin' => 'Admin',
          'admin.add_user' => 'Benutzer hinzufügen',
          'admin.search_users' => 'Benutzer suchen...',
          'admin.no_users' => 'Keine Benutzer gefunden',
          'admin.user_count' =>
            ({required Object count}) => '${count}-Benutzer',
          'admin.faculty_management' => 'Fakultätsmanagement',
          'admin.student_management' => 'Studentenmanagement',
          'admin.staff_management' => 'Personalmanagement',
          'admin.leadership_management' => 'Führungsmanagement',
          'admin.college_management' => 'Hochschulmanagement',
          'admin.audit_log_management' => 'Überwachungsprotokollverwaltung',
          'admin.department_management' => 'Abteilungsleitung',
          'admin.role_management' => 'Rollenmanagement',
          'admin.professor_management' => 'Professor Management',
          'admin.system_configuration' => 'Systemkonfiguration',
          'admin.add_college' => 'Hochschule hinzufügen',
          'admin.admin_it_management' => 'Admin- und IT-Management',
          'admin.add_department' => 'Abteilung hinzufügen',
          'admin.edit_department' => 'Abteilung bearbeiten',
          'admin.delete_college' => 'Hochschule löschen',
          'admin.edit_college' => 'Hochschule bearbeiten',
          'admin.delete_department' => 'Abteilung löschen',
          'admin.college_name' => 'Hochschulname',
          'admin.department_name' => 'Abteilungsname',
          'admin.head_name' => 'Kopfname',
          'admin.dean_name' => 'Name des Dekans',
          'admin.student_count' => 'Studenten',
          'admin.ta_count' => 'TAs',
          'admin.staff_count' => 'Personal',
          'admin.user' => 'Benutzer',
          'admin.timestamp' => 'Zeitstempel',
          'admin.filter_by_action' => 'Nach Aktion filtern',
          'admin.action' => 'Aktion',
          'admin.filter_by_date' => 'Nach Datum filtern',
          'admin.no_logs' => 'Keine Überwachungsprotokolle gefunden',
          'admin.system_version' => 'Systemversion',
          'admin.details' => 'Details',
          'admin.maintenance_mode' => 'Wartungsmodus',
          'admin.email_server' => 'E-Mail-Server',
          'admin.backup_schedule' => 'Backup-Zeitplan',
          'admin.storage_quota' => 'Speicherkontingent',
          'admin.security_level' => 'Sicherheitsstufe',
          'admin.log_retention' => 'Protokollaufbewahrung',
          'admin.session_timeout' => 'Sitzungszeitüberschreitung',
          'admin.save_settings' => 'Einstellungen speichern',
          'admin.reset_defaults' => 'Auf Standardeinstellungen zurücksetzen',
          'admin.user_name' => 'Name',
          'admin.user_role' => 'Rolle',
          'admin.user_department' => 'Abteilung',
          'admin.user_phone' => 'Telefon',
          'admin.user_status' => 'Status',
          'admin.user_email' => 'E-Mail',
          'admin.user_updated' => 'Benutzer erfolgreich aktualisiert',
          'admin.user_college' => 'Hochschule',
          'admin.user_created' => 'Erstellt',
          'admin.add_new_user' => 'Neuen Benutzer hinzufügen',
          'admin.delete_user' => 'Benutzer löschen',
          'admin.edit_user' => 'Benutzer bearbeiten',
          'admin.save_user' => 'Speichern',
          'admin.name_label' => 'Vollständiger Name',
          'admin.email_label' => 'E-Mail-Adresse',
          'admin.cancel' => 'Stornieren',
          'admin.role_label' => 'Wählen Sie Rolle aus',
          'admin.phone_label' => 'Telefonnummer',
          'admin.department_label' => 'Abteilung',
          'admin.college_label' => 'Hochschule',
          'admin.password_label' => 'Passwort',
          'admin.category_student' => 'Student',
          'admin.category_admin' => 'Admin',
          'admin.category_staff' => 'Personal',
          'admin.confirm_password_label' => 'Passwort bestätigen',
          'admin.category_leadership' => 'Führung',
          'admin.category_faculty' => 'Fakultät',
          'admin.select_role' => 'Wählen Sie eine Rolle aus',
          'admin.no_colleges' => 'Keine Hochschulen verfügbar',
          'admin.no_departments' => 'Keine Abteilungen verfügbar',
          'admin.user_added' => 'Benutzer erfolgreich hinzugefügt',
          'admin.confirm_delete' => 'Bestätigen Sie Löschen',
          'admin.user_deleted' => 'Benutzer erfolgreich gelöscht',
          'admin.select_college' => 'Wählen Sie eine Hochschule aus',
          'admin.select_department' => 'Wählen Sie eine Abteilung aus',
          'admin.confirm_delete_message' =>
            'Sind Sie sicher, dass Sie diesen Benutzer löschen möchten?',
          'admin.error_loading' => 'Fehler beim Laden der Daten',
          'admin.error_saving' => 'Fehler beim Speichern der Daten',
          'admin.academic_department' => 'Akademische Abteilung',
          'admin.academic_departments_1' => 'Akademische Abteilungen',
          'admin.retry' => 'Wiederholen',
          'admin.academic_warnings' => 'Akademische Warnungen',
          'admin.account_status' => 'Kontostatus',
          'admin.account_verification' => 'Kontobestätigung',
          'admin.academic_leaders' => 'Akademische Leiter',
          'admin.actor' => 'Schauspieler',
          'admin.add_report' => 'Bericht hinzufügen',
          'admin.admins' => 'Administratoren',
          'admin.advanced_management' => 'Erweitertes Management',
          'admin.all' => 'Alle',
          'admin.all_levels' => 'Alle Ebenen',
          'admin.apply_filters' => 'Filter anwenden',
          'admin.all_systems_operational' => 'Alle Systeme betriebsbereit',
          'admin.assign' => 'Zuordnen',
          'admin.are_you_sure_you_want_to_delet' =>
            'Sind Sie sicher, dass Sie diesen Benutzer löschen möchten?',
          'admin.assign_dean' => 'Dekan zuweisen',
          'admin.assign_department_head' => 'Abteilungsleiter ernennen',
          'admin.attached_report' => 'Angehängter Bericht',
          'admin.ban_user' => 'Benutzer sperren',
          'admin.banned' => 'Verboten',
          'admin.change_dean' => 'Dekan wechseln',
          'admin.change' => 'Ändern',
          'admin.changes_saved_successfully' =>
            'Änderungen erfolgreich gespeichert',
          'admin.college' => 'Hochschule',
          'admin.college_dean' => 'Dekan der Hochschule',
          'admin.college_details' => 'College-Details',
          'admin.coming_soon' => 'Demnächst verfügbar',
          'admin.delete' => 'Löschen',
          'admin.department_details' => 'Abteilungsdetails',
          'admin.colleges_management' => 'Hochschulmanagement',
          'admin.deactivated' => 'Deaktiviert',
          'admin.departments_management' => 'Abteilungsleitung',
          'admin.department_projects' => 'Abteilungsprojekte',
          'admin.entity' => 'Juristische Person',
          'admin.email_address' => 'E-Mail-Adresse',
          'admin.error_snapshoterror' =>
            ({required Object error}) => 'Fehler: ${error}',
          'admin.failed_to_load_data' => 'Daten konnten nicht geladen werden',
          'admin.faculty_members_1' => 'Fakultätsmitglieder',
          'admin.full_name' => 'Vollständiger Name',
          'admin.filter_users' => 'Benutzer filtern',
          'admin.head_of_department' => 'Abteilungsleiter',
          'admin.level_level' => ({required Object level}) => 'Ebene ${level}',
          'admin.leadership_stats' => 'Führungsstatistik',
          'admin.incidents' => 'Vorfälle',
          'admin.national_id' => 'Nationaler Ausweis',
          'admin.min_6_chars' => 'Min. 6 Zeichen',
          'admin.no_colleges_found' => 'Keine Hochschulen gefunden',
          'admin.no_dean_assigned' => 'Kein Dekan zugewiesen',
          'admin.manage_tags' => 'Tags verwalten',
          'admin.no_departments_in_this_college' =>
            'Keine Abteilungen in diesem College',
          'admin.no_about_text_available' => 'Kein Infotext verfügbar',
          'admin.nationality' => 'Nationalität',
          'admin.no_departments_found' => 'Keine Abteilungen gefunden',
          'admin.no_faculty_records_found' =>
            'Keine Fakultätsunterlagen gefunden',
          'admin.no_head_assigned' => 'Kein Leiter zugewiesen',
          'admin.no_matching_students_found' =>
            'Keine passenden Studenten gefunden',
          'admin.no_logs_found' => 'Keine Protokolle gefunden',
          'admin.no_description_available' => 'Keine Beschreibung verfügbar',
          'admin.no_projects_added_yet' => 'Noch keine Projekte hinzugefügt',
          'admin.no_users_found' => 'Keine Benutzer gefunden',
          'admin.no_settings_found_in_the_datab' =>
            'In der Datenbank wurden keine Einstellungen gefunden',
          'admin.pending_reg' => 'Ausstehende Registrierung',
          'admin.password' => 'Passwort',
          'admin.permanently_delete_user' => 'Benutzer dauerhaft löschen',
          'admin.office' => 'Büro',
          'admin.phone_number' => 'Telefonnummer',
          'admin.please_assign_a_head_for_the_d' =>
            'Bitte benennen Sie einen Leiter für diese Abteilung',
          'admin.please_assign_a_dean_for_the_c' =>
            'Bitte benennen Sie einen Dekan für diese Hochschule',
          'admin.roles_management' => 'Rollenmanagement',
          'admin.save' => 'Speichern',
          'admin.save_changes' => 'Änderungen speichern',
          'admin.search_doctor_name' => 'Arztnamen suchen...',
          'admin.search_by_name_email_phone_id' =>
            'Suchen Sie nach Name, E-Mail, Telefon oder ID...',
          'admin.select' => 'Wählen',
          'admin.search_staff_member' => 'Mitarbeiter suchen...',
          'admin.select_role_in_widgetinitialca' => 'Rolle auswählen',
          'admin.search_student_or_id' => 'Schüler oder Ausweis suchen...',
          'admin.select_role_permission' => 'Wählen Sie Rolle/Berechtigung',
          'admin.separate_tags_with_commas' => 'Trennen Sie Tags durch Kommas',
          'admin.servers' => 'Server',
          'admin.student_id' => 'Studentenausweis',
          'admin.tag1_tag2' => 'tag1, tag2',
          'admin.teaching_assistants' => 'Lehrassistenten',
          'admin.system_technical_status' => 'Technischer Systemstatus',
          'admin.total_staff' => 'Gesamtpersonal',
          'admin.total_students' => 'Gesamtzahl der Studierenden',
          'admin.user_roles_ranks' => 'Benutzerrollen und Ränge',
          'admin.unverified' => 'Nicht bestätigt',
          'admin.verification' => 'Überprüfung',
          'admin.you_can_manage_professors_and_' =>
            'Hier können Sie Professoren und mehr verwalten',
          'admin.verified' => 'Verifiziert',
          'admin.warning_level' => 'Warnstufe',
          'enrollment.registration_title' => 'Kursanmeldung',
          'enrollment.advisor' => 'Akademischer Berater',
          'enrollment.payment_title' => 'Studiengebührenzahlung',
          'enrollment.advisor_approval' => 'Beratergenehmigung',
          'enrollment.dean_assignment' => 'Aufgabe des Dekanatsberaters',
          'enrollment.approve' => 'Genehmigen',
          'enrollment.reject' => 'Ablehnen',
          'enrollment.pending' => 'Ausstehend',
          'enrollment.invoices_title' => 'Finanzrechnungen',
          'enrollment.approved' => 'Genehmigt',
          'enrollment.student_name' => 'Name des Studenten',
          'enrollment.rejected' => 'Abgelehnt',
          'enrollment.student_id' => 'Studentenausweis',
          'enrollment.department' => 'Abteilung',
          'enrollment.college' => 'Hochschule',
          'enrollment.semester' => 'Semester',
          'enrollment.credits' => 'Credits',
          'enrollment.group' => 'Gruppe',
          'enrollment.registration_date' => 'Anmeldedatum',
          'enrollment.status' => 'Status',
          'enrollment.section' => 'Abschnitt',
          'enrollment.no_requests' => 'Keine Anfragen gefunden',
          'enrollment.search_students' => 'Studenten suchen...',
          'enrollment.filter_all' => 'Alle',
          'enrollment.filter_pending' => 'Ausstehend',
          'enrollment.filter_approved' => 'Genehmigt',
          'enrollment.filter_rejected' => 'Abgelehnt',
          'enrollment.view_details' => 'Details anzeigen',
          'enrollment.approve_all' => 'Alle genehmigen',
          'enrollment.advisor_name' => 'Name des Beraters',
          'enrollment.unassign' => 'Zuweisung aufheben',
          'enrollment.assigned' => 'Zugewiesen',
          'enrollment.save' => 'Speichern',
          'enrollment.cancel' => 'Stornieren',
          'enrollment.assign' => 'Zuordnen',
          'enrollment.success_approve' => 'Registrierung erfolgreich genehmigt',
          'enrollment.success_reject' => 'Registrierung abgelehnt',
          'enrollment.error_loading' => 'Fehler beim Laden der Daten',
          'enrollment.success_assign' => 'Berater erfolgreich zugewiesen',
          'enrollment.invoice_id' => 'Rechnungs-ID',
          'enrollment.invoice_date' => 'Datum',
          'enrollment.invoice_amount' => 'Menge',
          'enrollment.invoice_paid' => 'Bezahlt',
          'enrollment.unassigned' => 'Nicht zugewiesen',
          'enrollment.invoice_status' => 'Status',
          'enrollment.invoice_unpaid' => 'Unbezahlt',
          'enrollment.credit_card' => 'Kreditkarte',
          'enrollment.invoice_overdue' => 'Überfällig',
          'enrollment.payment_method' => 'Zahlungsmethode',
          'enrollment.pay_now' => 'Jetzt bezahlen',
          'enrollment.payment_success' => 'Zahlung erfolgreich',
          'enrollment.bank_transfer' => 'Banküberweisung',
          'enrollment.fawry' => 'Fawry',
          'enrollment.outstanding_balance' => 'Offener Betrag',
          'enrollment.payment_error' => 'Die Zahlung ist fehlgeschlagen',
          'enrollment.total_paid' => 'Gesamtbezahlt',
          'enrollment.no_invoices' => 'Keine Rechnungen gefunden',
          'enrollment.total' => 'Gesamt',
          'enrollment.tuition_fee' => 'Studiengebühr',
          'enrollment.late_fee' => 'Verspätungsgebühr',
          'enrollment.registration_fee' => 'Anmeldegebühr',
          'enrollment.semester_label' =>
            ({required Object semester}) => 'Semester${semester}',
          'enrollment.submit_request' => 'Anfrage senden',
          'enrollment.request_submitted' => 'Anfrage erfolgreich übermittelt',
          'enrollment.all' => 'Alle',
          'enrollment.academic_year' => 'Akademisches Jahr',
          'enrollment.retry' => 'Wiederholen',
          'enrollment.loading' => 'Laden...',
          _ => null,
        } ??
        switch (path) {
          'enrollment.advisor_assignment' => 'Berateraufgabe',
          'enrollment.academic_advisor' => 'Akademischer Berater',
          'enrollment.advisor_requestadvisorfullname' =>
            ({required Object name}) => 'Berater: ${name}',
          'enrollment.advisor_updated_successfully' =>
            'Advisor erfolgreich aktualisiert',
          'enrollment.approved_1' => 'Genehmigt',
          'enrollment.approved_courses_registered' =>
            'Genehmigt – Kurse angemeldet',
          'enrollment.choose_schedules' => 'Wählen Sie Zeitpläne',
          'enrollment.awaiting_advisor_review' =>
            'Warten auf die Bewertung durch den Berater',
          'enrollment.dormitory_fee' => 'Wohnheimgebühr',
          'enrollment.due' => 'Fällig',
          'enrollment.exam_fee' => 'Prüfungsgebühr',
          'enrollment.confirm_submit' => 'Bestätigen und absenden',
          'enrollment.error_loading_summary' =>
            'Fehler beim Laden der Zusammenfassung',
          'enrollment.download' => 'Herunterladen',
          'enrollment.failed_to_load_invoices' =>
            'Rechnungen konnten nicht geladen werden',
          'enrollment.financial_portal' => 'Finanzportal',
          'enrollment.cr' => 'CR',
          'enrollment.financial_summary' => 'Finanzielle Zusammenfassung',
          'enrollment.history' => 'Geschichte',
          'enrollment.help' => 'Helfen',
          'enrollment.invoices' => 'Rechnungen',
          'enrollment.library_fee' => 'Bibliotheksgebühr',
          'enrollment.mmm_dd_yyyy' => 'MMM dd, yyyy',
          'enrollment.my_invoices' => 'Meine Rechnungen',
          'enrollment.next_pick_schedules' =>
            'Als nächstes: Zeitpläne auswählen',
          'enrollment.manage_your_tuition_and_paymen' =>
            'Verwalten Sie Ihre Studiengebühren und Zahlungen',
          'enrollment.no_advisor' => 'Kein Berater',
          'enrollment.no_requests_found' => 'Keine Anfragen gefunden',
          'enrollment.no_invoices_found' => 'Keine Rechnungen gefunden',
          'enrollment.no_students_found' => 'Keine Studenten gefunden',
          'enrollment.overdue' => 'Überfällig',
          'enrollment.pay' => 'Zahlen',
          'enrollment.no_schedules_available_for_thi' =>
            'Für diesen Kurs sind keine Termine verfügbar',
          'enrollment.partial' => 'Teilweise',
          'enrollment.paid' => 'Bezahlt',
          'enrollment.pending_review' => 'Ausstehende Überprüfung',
          'enrollment.preparing_pdf_statement' =>
            'PDF-Kontoauszug wird vorbereitet...',
          'enrollment.remaining' => 'Übrig',
          'enrollment.registration_requests' => 'Registrierungsanfragen',
          'enrollment.notes_optional' => 'Notizen (optional)',
          'enrollment.other' => 'Andere',
          'enrollment.requested_courses' => 'Angefragte Kurse',
          'enrollment.request_rejected' => 'Anfrage abgelehnt',
          'enrollment.review_final_timetable' =>
            'Überprüfen Sie den endgültigen Zeitplan',
          'enrollment.reregister' => 'Registrieren Sie sich erneut',
          'enrollment.review_registration' =>
            'Überprüfen Sie die Registrierung',
          'enrollment.sec' => 'Sek',
          'enrollment.select_the_subjects_you_want_t' =>
            'Wählen Sie die Fächer aus, die Sie anmelden möchten',
          'enrollment.select_your_courses' => 'Wählen Sie Ihre Kurse aus',
          'enrollment.sub' => 'Sub',
          'enrollment.summaryoverduecount_overdue' =>
            ({required Object count}) => '${count} Überfällig',
          'enrollment.semester_requestsemester' =>
            ({required Object semester}) => 'Semester: ${semester}',
          'enrollment.total_invoices' => 'Gesamtrechnungen',
          'enrollment.selected_schedule_summary' =>
            'Zusammenfassung des ausgewählten Zeitplans',
          'enrollment.unassigned_only' => 'Nur nicht zugewiesen',
          'enrollment.room' => 'Zimmer',
          'enrollment.unpaid' => 'Unbezahlt',
          'enrollment.you_have_successfully_register' =>
            'Sie haben Ihre Kurse erfolgreich angemeldet!',
          'enrollment.your_account_is_clearnno_invoi' =>
            'Ihr Konto ist frei. Keine Rechnungen gefunden.',
          'enrollment.withdrawn' => 'Zurückgezogen',
          'shared.no_notifications_yet' => 'Noch keine Benachrichtigungen',
          'shared.security_title' => 'Sicherheitseinstellungen',
          'shared.notifications_empty' => 'Keine neuen Benachrichtigungen',
          'shared.biometrics_title' => 'Biometrie',
          'shared.notifications' => 'Benachrichtigungen',
          'shared.fingerprint' => 'Fingerabdruck',
          'shared.face_id' => 'Gesichtserkennung',
          'shared.enable_biometrics' => 'Aktivieren Sie Biometrie',
          'shared.end_all_sessions' => 'Alle Sitzungen beenden',
          'shared.current_session' => 'Aktuelle Sitzung',
          'shared.device' => 'Gerät',
          'shared.location' => 'Standort',
          'shared.sessions_title' => 'Aktive Sitzungen',
          'shared.last_active' => 'Zuletzt aktiv',
          'shared.support_title' => 'Support & Hilfe',
          'shared.end_session' => 'Sitzung beenden',
          'shared.contact_us' => 'Kontaktieren Sie uns',
          'shared.call_us' => 'Rufen Sie uns an',
          'shared.email_us' => 'Schicken Sie uns eine E-Mail',
          'shared.whatsapp' => 'WhatsApp',
          'shared.faq' => 'FAQ',
          'shared.tutorials_title' => 'Tutorials und Anleitungen',
          'shared.report_issue' => 'Melden Sie ein Problem',
          'shared.create_post' => 'Beitrag erstellen',
          'shared.search_forums' => 'Foren durchsuchen...',
          'shared.no_posts' => 'Keine Beiträge gefunden',
          'shared.forums_title' => 'Foren',
          'shared.transition_title' => 'Laden...',
          'shared.placeholder_title' => 'Demnächst verfügbar',
          'shared.coming_soon' => 'Demnächst verfügbar',
          'shared.placeholder_subtitle' =>
            'Dieser Abschnitt befindet sich in der Entwicklung',
          'shared.retry' => 'Wiederholen',
          'shared.back' => 'Zurück',
          'shared.under_development' =>
            'Diese Funktion befindet sich in der Entwicklung',
          'shared.loading' => 'Laden...',
          'shared.close' => 'Schließen',
          'shared.cancel' => 'Stornieren',
          'shared.save' => 'Speichern',
          'shared.confirm' => 'Bestätigen',
          'shared.active_sessions' => 'Aktive Sitzungen',
          'shared.edit' => 'Bearbeiten',
          'shared.delete' => 'Löschen',
          'shared.authentication' => 'Authentifizierung',
          'shared.biometric_login' => 'Biometrische Anmeldung',
          'shared.call_hotline' => 'Hotline anrufen',
          'shared.error' => 'Fehler',
          'shared.change_password' => 'Kennwort ändern',
          'shared.financial_aid' => 'Finanzielle Hilfe',
          'shared.email_support' => 'E-Mail-Support',
          'shared.forums' => 'Foren',
          'shared.library' => 'Bibliothek',
          'shared.logout' => 'Abmelden',
          'shared.it_support' => 'IT-Support',
          'shared.manage_logged_in_devices' => 'Angemeldete Geräte verwalten',
          'shared.members' => 'Mitglieder',
          'shared.please_wait' => 'Bitte warten...',
          'shared.security' => 'Sicherheit',
          'shared.device_management' => 'Geräteverwaltung',
          'shared.protect_account_with_2fa' => 'Konto mit 2FA schützen',
          'shared.student_affairs' => 'Studentenangelegenheiten',
          'shared.support' => 'Unterstützung',
          'shared.this_feature_is_under_developm' =>
            'Diese Funktion befindet sich in der Entwicklung',
          'shared.threads' => 'Themen',
          'shared.twofactor_auth' => 'Zwei-Faktor-Authentifizierung',
          'shared.tutorials' => 'Tutorials',
          'shared.update_your_login_credentials' =>
            'Aktualisieren Sie Ihre Anmeldedaten',
          'shared.view_active_sessions' => 'Aktive Sitzungen anzeigen',
          'shared.use_fingerprint_or_face_id' =>
            'Verwenden Sie Fingerabdruck oder Face ID',
          'shared.biometrics' => 'Biometrie',
          'shared.contact_us_section' => 'Kontaktieren Sie uns',
          'shared.sessions' => 'Sitzungen',
          'shared.security_section' => 'Sicherheit',
          'shared.tutorials_section' => 'Tutorials',
          'shared.forums_section' => 'Foren',
          'shared.no_new_notifications' => 'Keine neuen Benachrichtigungen',
          'shared.support_section' => 'Unterstützung',
          'shared.security_access' => 'Sicherheitszugriff',
          'students.digital_id_title' => 'Digitaler Personalausweis',
          'students.student_id' => 'Studentenausweis',
          'students.college' => 'Hochschule',
          'students.department' => 'Abteilung',
          'students.level' => 'Ebene',
          'students.gpa' => 'Notendurchschnitt',
          'students.credits' => 'Credits',
          'students.verified' => 'Verifiziert',
          'students.university' => 'Horus-Universität',
          'students.download_id' => 'ID herunterladen',
          'students.share_id' => 'Freigabe-ID',
          'students.id_theme' => 'ID-Thema',
          'students.qr_code' => 'QR-Code',
          'students.scan_to_verify' => 'Zur Überprüfung scannen',
          'students.classic_theme' => 'Klassiker',
          'students.gradient_theme' => 'Gradient',
          'students.holographic_theme' => 'Holografisch',
          'students.dark_matter_theme' => 'Dunkle Materie',
          'students.neon_pulse_theme' => 'Neonpuls',
          'students.aurora_theme' => 'Aurora',
          'students.academic_section' => 'Akademisch',
          'students.dashboard_title' => 'Studenten-Dashboard',
          'students.enrollment_section' => 'Einschreibung',
          'students.utilities_section' => 'Dienstprogramme',
          'students.transcript' => 'Transkript',
          'students.student_name' => 'Name des Studenten',
          'students.progress' => 'Akademischer Fortschritt',
          'students.subject_results' => 'Betreffergebnisse',
          'students.action_plan' => 'Studienplan',
          'students.grades' => 'Noten',
          'students.courses' => 'Kurse',
          'students.attendance' => 'Teilnahme',
          'students.registration' => 'Anmeldung',
          'students.invoices' => 'Rechnungen',
          'students.schedule' => 'Zeitplan',
          'students.exam_schedule' => 'Prüfungsplan',
          'students.payment' => 'Zahlung',
          'students.security' => 'Sicherheit',
          'students.tutorials' => 'Tutorials',
          'students.forums' => 'Foren',
          'students.support' => 'Unterstützung',
          'students.digital_id' => 'Digitale ID',
          'students.notifications' => 'Benachrichtigungen',
          'students.no_lectures_today' => 'Heute keine Vorlesungen',
          'students.quick_stats' => 'Schnelle Statistiken',
          'students.gpa_label' => 'Notendurchschnitt',
          'students.view_full_schedule' => 'Vollständigen Zeitplan anzeigen',
          'students.level_label' => 'Ebene',
          'students.recent_grades' => 'Aktuelle Noten',
          'students.credits_label' => 'Credits',
          'students.all' => 'Alle',
          'students.upcoming_exams' => 'Kommende Prüfungen',
          'students.error' => 'Fehler',
          'students.back' => 'Zurück',
          'students.academic' => 'Akademisch',
          'students.loading' => 'Laden...',
          'students.active' => 'Aktiv',
          'students.artificial_intelligence' => 'Künstliche Intelligenz',
          'students.copy' => 'Kopie',
          'students.download' => 'Herunterladen',
          'students.daily_schedule' => 'Tagesplan',
          'students.retry' => 'Wiederholen',
          'students.access_logs' => 'Zugriffsprotokolle',
          'students.enrollment_finance' => 'Einschreibung und Finanzen',
          'students.horus_university' => 'Horus-Universität',
          'students.horus_university_1' => 'Horus-Universität',
          'students.id_no' => 'ID-Nr.',
          'students.identity_active_secure' => 'Identität aktiv und sicher',
          'students.offline_copy' => 'Offline-Kopie',
          'students.scan_for_secure_access' => 'Nach sicherem Zugriff suchen',
          'students.nfc_pass' => 'NFC-Pass',
          'students.send' => 'Schicken',
          'students.share_identity' => 'Identität teilen',
          'students.settings' => 'Einstellungen',
          'students.smart_digital_id' => 'Intelligente digitale ID',
          'students.student' => 'Student',
          'students.status' => 'Status',
          'students.utilities' => 'Dienstprogramme',
          'extracted.change_profile_photo' => 'Profilfoto ändern',
          'extracted.choose_from_gallery' => 'Wählen Sie aus der Galerie',
          'extracted.take_photo' => 'Machen Sie ein Foto',
          'extracted.save' => 'Speichern',
          'extracted.user' => 'Benutzer',
          'extracted.personal_info' => 'Persönliche Informationen',
          'extracted.email' => 'E-Mail',
          'extracted.full_name' => 'Vollständiger Name',
          'extracted.required' => 'Erforderlich',
          'extracted.national_id' => 'Nationaler Ausweis',
          'extracted.phone_number' => 'Telefonnummer',
          'extracted.role' => 'Rolle',
          'extracted.about_me' => 'Über mich',
          'extracted.save_changes' => 'Änderungen speichern',
          'extracted.active' => 'Aktiv',
          'extracted.account' => 'Konto',
          'extracted.account_status' => 'Kontostatus',
          'extracted.notifications' => 'Benachrichtigungen',
          'extracted.appearance' => 'Aussehen',
          'extracted.language_region' => 'Sprache und Region',
          'extracted.about' => 'Um',
          'extracted.edit_profile' => 'Profil bearbeiten',
          'extracted.password_recovery' => 'Passwortwiederherstellung',
          'extracted.send_password_recovery_link_to_your_emai' =>
            'Senden Sie den Link zur Passwortwiederherstellung per E-Mail',
          'extracted.dark_mode' => 'Dunkler Modus',
          'extracted.toggle_between_dark_and_light_mode' =>
            'Wechseln Sie zwischen dunklem und hellem Modus',
          'extracted.ui_style' => 'UI-Stil',
          'extracted.current_classic_design' => 'Aktuell: Klassisches Design',
          'extracted.kSwitch' => 'Schalten',
          'extracted.battery_saver_mode' => 'Batteriesparmodus',
          'extracted.current_glass_design' => 'Aktuell: Glasdesign',
          'extracted.test_notification' => 'Testbenachrichtigung',
          'extracted.send_a_test_notification' =>
            'Senden Sie eine Testbenachrichtigung',
          'extracted.app_language' => 'App-Sprache',
          'extracted.support_center' => 'Support-Center',
          'extracted.send_feedback' => 'Feedback senden',
          'extracted.rate_the_app' => 'Bewerten Sie die App',
          'extracted.about_app' => 'Über App',
          'extracted.app_notifications' => 'App-Benachrichtigungen',
          'extracted.account_info' => 'Kontoinformationen',
          'extracted.remove_photo' => 'Foto entfernen',
          'extracted.support_feedback' => 'Unterstützung und Feedback',
          'extracted.notifications_are_active' =>
            'Benachrichtigungen sind aktiv',
          'extracted.privacy_policy' => 'Datenschutzrichtlinie',
          'extracted.thank_you_for_your_support' =>
            'Vielen Dank für Ihre Unterstützung! 🎉',
          'extracted.version_details_and_developer_info' =>
            'Versionsdetails und Entwicklerinformationen',
          'extracted.terms_and_rules_for_data_usage' =>
            'Bedingungen und Regeln für die Datennutzung',
          'extracted.log_out' => 'Abmelden',
          'extracted.how_can_we_help_you' => 'Wie können wir Ihnen helfen?',
          'extracted.write_your_feedback_here' =>
            'Schreiben Sie hier Ihr Feedback...',
          'extracted.email_support' => 'E-Mail-Support',
          'extracted.write_something_about_yourself' =>
            'Schreiben Sie etwas über sich selbst...',
          'extracted.disable_complex_visual_effects' =>
            'Deaktivieren Sie komplexe visuelle Effekte',
          'extracted.update_your_personal_info_and_photo' =>
            'Aktualisieren Sie Ihre persönlichen Daten und Ihr Foto',
          'extracted.call_hotline' => 'Hotline anrufen',
          'extracted.submit_feedback' => 'Geben Sie Feedback ab',
          'extracted.departments' => 'Abteilungen',
          'extracted.add_department' => 'Abteilung hinzufügen',
          'extracted.description' => 'Beschreibung',
          'extracted.cancel' => 'Stornieren',
          'extracted.students' => 'Studenten',
          'extracted.est' => 'Schätzung:',
          'extracted.add' => 'Hinzufügen',
          'extracted.staff' => 'Personal',
          'extracted.building' => 'Gebäude',
          'extracted.test_notification_sent' =>
            'Testbenachrichtigung gesendet!',
          'extracted.notifications_are_off' =>
            'Benachrichtigungen sind deaktiviert',
          'extracted.your_support_matters' =>
            '⭐ Ihre Unterstützung ist wichtig',
          'extracted.notification_center' => 'Benachrichtigungscenter',
          'extracted.chat_with_us_on_whatsapp' =>
            'Chatten Sie mit uns auf WhatsApp',
          'extracted.thank_you_feedback_submitted' =>
            '✅ Danke! Feedback eingereicht.',
          'extracted.remove' => 'Entfernen',
          'extracted.head' => 'Kopf',
          'extracted.asst' => 'Asst.',
          'extracted.confirm_removal' => 'Bestätigen Sie das Entfernen',
          'extracted.your_opinion_helps_us_improve' =>
            'Ihre Meinung hilft uns, uns zu verbessern',
          'extracted.get_help_and_resolve_any_issues' =>
            'Holen Sie sich Hilfe und lösen Sie alle Probleme',
          'extracted.view_all_your_notifications' =>
            'Sehen Sie sich alle Ihre Benachrichtigungen an',
          'extracted.share_your_thoughts_to_help_improve_the_' =>
            'Teilen Sie Ihre Gedanken mit, um zur Verbesserung der App beizutragen',
          'extracted.add_new_department' => 'Neue Abteilung hinzufügen',
          'extracted.department_code' => 'Abteilungscode',
          'extracted.no_assistant_assigned' => 'Kein Assistent zugewiesen',
          'extracted.department_name_en' => 'Abteilungsname (EN)',
          'extracted.department_name_ar' => 'Abteilungsname (AR)',
          'extracted.add_staff' => 'Personal hinzufügen',
          'extracted.assistant_head' => 'Stellvertretender Leiter',
          'extracted.roles_management' => 'Rollenmanagement',
          'extracted.create_role' => 'Rolle erstellen',
          'extracted.no_results' => 'Keine Ergebnisse',
          'extracted.custom' => 'Brauch',
          'extracted.create' => 'Erstellen',
          'extracted.merge' => 'Verschmelzen',
          'extracted.please_assign_an_assistant_head_for_the_' =>
            'Bitte benennen Sie einen stellvertretenden Leiter für die Abteilung',
          'extracted.category' => 'Kategorie',
          'extracted.add_faculty' => 'Fakultät hinzufügen',
          'extracted.add_faculty_member' => 'Fakultätsmitglied hinzufügen',
          'extracted.description_english' => 'Beschreibung (Englisch)',
          'extracted.permissions' => 'Berechtigungen',
          'extracted.description_arabic' => 'Beschreibung (Arabisch)',
          'extracted.search_roles' => 'Rollen suchen...',
          'extracted.merge_roles' => 'Rollen zusammenführen',
          'extracted.make_sure_roles_table_exists_in_supabase' =>
            'Stellen Sie sicher, dass die Tabelle „Rollen“ in Supabase vorhanden ist',
          'extracted.could_not_load_custom_roles' =>
            'Benutzerdefinierte Rollen konnten nicht geladen werden',
          'extracted.remove_staff_fullname_from_this_departme' =>
            ({required Object staffFullName}) =>
                '${staffFullName}aus dieser Abteilung entfernen?',
          'extracted.no_faculty_members_assigned' =>
            'Keine Fakultätsmitglieder zugewiesen',
          'extracted.edit_role' => 'Rolle bearbeiten',
          'extracted.no_roles' => 'Keine Rollen',
          'extracted.name_arabic' => 'Name (Arabisch)',
          'extracted.role_created' => 'Rolle erstellt',
          'extracted.name_english' => 'Name (Englisch)',
          'extracted.create_new_role' => 'Neue Rolle erstellen',
          'extracted.no_custom_roles_yet' =>
            'Noch keine benutzerdefinierten Rollen',
          'extracted.delete_role' => 'Rolle löschen',
          'extracted.delete' => 'Löschen',
          'extracted.role_updated' => 'Rolle aktualisiert',
          'extracted.admin_it' => 'Verwaltung und IT',
          'extracted.leadership' => 'Führung',
          'extracted.teaching' => 'Lehre',
          'extracted.external' => 'Extern',
          'extracted.student_affairs' => 'Studentenangelegenheiten',
          'extracted.facilities' => 'Einrichtungen',
          'extracted.permissions_1' => 'Berechtigungen:',
          'extracted.merged' => 'VERSCHMELZT',
          'extracted.user_details' => 'Benutzerdetails',
          'extracted.quick_actions' => 'Schnelle Aktionen',
          'extracted.verification' => 'Überprüfung',
          'extracted.second_role' => 'Zweite Rolle',
          'extracted.merge_two_roles' => 'Zwei Rollen zusammenführen',
          'extracted.first_role' => 'Erste Rolle',
          'extracted.tags' => 'Schlagworte',
          'extracted.danger_zone' => 'Gefahrenzone',
          'extracted.warning_level' => 'Warnstufe',
          'extracted.banned' => 'Verboten',
          'extracted.verified' => 'Verifiziert',
          'extracted.deactivate' => 'Deaktivieren',
          'extracted.activate' => 'Aktivieren',
          'extracted.verify' => 'Verifizieren',
          'extracted.merged_role_name_arabic' =>
            'Zusammengeführter Rollenname (Arabisch)',
          'extracted.roles_merged_successfully' =>
            'Rollen erfolgreich zusammengeführt',
          'extracted.create_a_new_role_or_merge_two_roles' =>
            'Erstellen Sie eine neue Rolle oder führen Sie zwei Rollen zusammen',
          'extracted.ban' => 'Verbot',
          'extracted.unban' => 'Verbot aufheben',
          'extracted.select_two_roles_to_combine_their_permis' =>
            'Wählen Sie zwei Rollen aus, um ihre Berechtigungen zu kombinieren',
          'extracted.merged_permissions_preview' =>
            'Vorschau der zusammengeführten Berechtigungen',
          'extracted.not_verified' => 'Nicht verifiziert',
          'extracted.merged_role_name_english' =>
            'Zusammengeführter Rollenname (Englisch)',
          'extracted.nationality' => 'Nationalität',
          'extracted.add_tag' => 'Tag hinzufügen',
          'extracted.created' => 'Erstellt',
          'extracted.current_level' => 'Aktuelles Niveau',
          'extracted.verify_account' => 'Konto bestätigen',
          'extracted.delete_role_nameen_this_cannot_be_undone' =>
            ({required Object roleNameEn}) =>
                '„${roleNameEn}“ löschen? Dies kann nicht rückgängig gemacht werden.',
          'extracted.ban_management' => 'Verbotsverwaltung',
          'extracted.unverify' => 'Nicht bestätigen',
          'extracted.ban_user' => 'Benutzer sperren',
          'extracted.tag_name' => 'Tag-Name',
          'extracted.user_has_normal_access' =>
            'Der Benutzer hat normalen Zugriff',
          'extracted.not_banned' => 'Nicht verboten',
          'extracted.user_banned' => 'Benutzer gesperrt',
          'extracted.remove_verification' => 'Verifizierung entfernen',
          'extracted.account_verified' => 'Konto bestätigt',
          'extracted.permanently_delete' => 'Endgültig löschen',
          'extracted.no_tags_assigned' => 'Keine Tags zugewiesen',
          'extracted.last_login' => 'Letzte Anmeldung',
          'extracted.soft_delete_deactivate' =>
            'Vorläufiges Löschen (Deaktivieren)',
          'extracted.soft_delete' => 'Vorläufiges Löschen',
          'extracted.select_department' => 'Wählen Sie Abteilung aus',
          'extracted.institution' => 'Institution',
          'extracted.unban_user_fullname' =>
            ({required Object userFullName}) => '${userFullName}entsperren?',
          'extracted.unban_user' => 'Benutzer entsperren',
          'extracted.tag_removed' => 'Tag entfernt',
          'extracted.verify_user_fullname' =>
            ({required Object userFullName}) => 'Überprüfen Sie${userFullName}',
          'extracted.warning_level_set_to_level' =>
            ({required Object level}) => 'Warnstufe auf ${level}',
          'extracted.permanent_delete' => 'Dauerhafte Löschung',
          'extracted.exceeding' => 'Überschreiten',
          'extracted.total' => 'Gesamt',
          'extracted.user_cannot_access_the_system' =>
            'Der Benutzer kann nicht auf das System zugreifen',
          'extracted.ban_user_fullname_they_will_lose_system_' =>
            ({required Object userFullName}) =>
                '${userFullName}verbieten? Sie verlieren den Systemzugriff.',
          'extracted.remove_verification_from_user_fullname' =>
            ({required Object userFullName}) =>
                'Verifizierung von${userFullName}entfernen?',
          'extracted.user_identity_has_been_verified' =>
            'Die Benutzeridentität wurde überprüft',
          'extracted.grade' => 'Grad',
          'extracted.identity_not_yet_verified' =>
            'Identität noch nicht überprüft',
          'extracted.department_is_required' => 'Abteilung ist erforderlich',
          'extracted.college_is_required' => 'Hochschule ist erforderlich',
          'extracted.deactivate_user_fullname' =>
            ({required Object userFullName}) => '${userFullName}\ deaktivieren',
          'extracted.select_college' => 'Wählen Sie Hochschule',
          'extracted.out_of_max' =>
            ({required Object max}) => 'AUSSERHALB${max}',
          'extracted.permanently_delete_user_fullname_this_ca' =>
            ({required Object userFullName}) =>
                '${userFullName}endgültig löschen? Dies kann nicht rückgängig gemacht werden!',
          'extracted.top_5' => 'Top 5 %',
          _ => null,
        };
  }
}

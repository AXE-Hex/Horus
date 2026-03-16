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
class TranslationsDe extends Translations with BaseTranslations<AppLocale, Translations> {
	/// You can call this constructor and build your own translation instance of this locale.
	/// Constructing via the enum [AppLocale.build] is preferred.
	TranslationsDe({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver, TranslationMetadata<AppLocale, Translations>? meta})
		: assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
		  $meta = meta ?? TranslationMetadata(
		    locale: AppLocale.de,
		    overrides: overrides ?? {},
		    cardinalResolver: cardinalResolver,
		    ordinalResolver: ordinalResolver,
		  ),
		  super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver) {
		super.$meta.setFlatMapFunction($meta.getTranslation); // copy base translations to super.$meta
		$meta.setFlatMapFunction(_flatMapFunction);
	}

	/// Metadata for the translations of <de>.
	@override final TranslationMetadata<AppLocale, Translations> $meta;

	/// Access flat map
	@override dynamic operator[](String key) => $meta.getTranslation(key) ?? super.$meta.getTranslation(key);

	late final TranslationsDe _root = this; // ignore: unused_field

	@override 
	TranslationsDe $copyWith({TranslationMetadata<AppLocale, Translations>? meta}) => TranslationsDe(meta: meta ?? this.$meta);

	// Translations
	@override late final _TranslationsCommonDe common = _TranslationsCommonDe._(_root);
	@override late final _TranslationsWelcomeDe welcome = _TranslationsWelcomeDe._(_root);
	@override late final _TranslationsOnboardingDe onboarding = _TranslationsOnboardingDe._(_root);
	@override late final _TranslationsAuthDe auth = _TranslationsAuthDe._(_root);
	@override late final _TranslationsHomeDe home = _TranslationsHomeDe._(_root);
	@override late final _TranslationsDashboardDe dashboard = _TranslationsDashboardDe._(_root);
	@override late final _TranslationsSettingsDe settings = _TranslationsSettingsDe._(_root);
	@override late final _TranslationsCollegesDe colleges = _TranslationsCollegesDe._(_root);
	@override late final _TranslationsTranscriptDe transcript = _TranslationsTranscriptDe._(_root);
	@override late final _TranslationsAcademicProgressDe academic_progress = _TranslationsAcademicProgressDe._(_root);
	@override late final _TranslationsGradesDe grades = _TranslationsGradesDe._(_root);
	@override late final _TranslationsSubjectResultsDe subject_results = _TranslationsSubjectResultsDe._(_root);
	@override late final _TranslationsActionPlanDe action_plan = _TranslationsActionPlanDe._(_root);
	@override late final _TranslationsCoursesDe courses = _TranslationsCoursesDe._(_root);
	@override late final _TranslationsScheduleDe schedule = _TranslationsScheduleDe._(_root);
	@override late final _TranslationsExamScheduleDe exam_schedule = _TranslationsExamScheduleDe._(_root);
	@override late final _TranslationsAttendanceDe attendance = _TranslationsAttendanceDe._(_root);
	@override late final _TranslationsRegistrationDe registration = _TranslationsRegistrationDe._(_root);
	@override late final _TranslationsPaymentDe payment = _TranslationsPaymentDe._(_root);
	@override late final _TranslationsInvoicesDe invoices = _TranslationsInvoicesDe._(_root);
	@override late final _TranslationsNotificationsDe notifications = _TranslationsNotificationsDe._(_root);
	@override late final _TranslationsSupportDe support = _TranslationsSupportDe._(_root);
	@override late final _TranslationsSecurityDe security = _TranslationsSecurityDe._(_root);
	@override late final _TranslationsTutorialsDe tutorials = _TranslationsTutorialsDe._(_root);
	@override late final _TranslationsForumsDe forums = _TranslationsForumsDe._(_root);
	@override late final _TranslationsAdministrationDe administration = _TranslationsAdministrationDe._(_root);
}

// Path: common
class _TranslationsCommonDe extends TranslationsCommonEn {
	_TranslationsCommonDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get close => 'Schließen';
	@override String get cancel => 'Abbrechen';
	@override String get confirm => 'Bestätigen';
	@override String get save => 'Speichern';
	@override String get back => 'Zurück';
}

// Path: welcome
class _TranslationsWelcomeDe extends TranslationsWelcomeEn {
	_TranslationsWelcomeDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Willkommen bei Hue';
	@override String get subtitle => 'Erleuchten Sie Ihre Welt mit bedeutungsvollen Verbindungen.';
	@override String get get_started => 'Loslegen';
	@override String get have_account => 'Ich habe bereits ein Konto';
}

// Path: onboarding
class _TranslationsOnboardingDe extends TranslationsOnboardingEn {
	_TranslationsOnboardingDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsOnboardingLanguageDe language = _TranslationsOnboardingLanguageDe._(_root);
	@override late final _TranslationsOnboardingFacultiesDirectoryDe faculties_directory = _TranslationsOnboardingFacultiesDirectoryDe._(_root);
	@override late final _TranslationsOnboardingStyleDe style = _TranslationsOnboardingStyleDe._(_root);
	@override late final _TranslationsOnboardingThemeDe theme = _TranslationsOnboardingThemeDe._(_root);
}

// Path: auth
class _TranslationsAuthDe extends TranslationsAuthEn {
	_TranslationsAuthDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsAuthLoginDe login = _TranslationsAuthLoginDe._(_root);
	@override late final _TranslationsAuthForgotPasswordDe forgot_password = _TranslationsAuthForgotPasswordDe._(_root);
}

// Path: home
class _TranslationsHomeDe extends TranslationsHomeEn {
	_TranslationsHomeDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsHomeTabsDe tabs = _TranslationsHomeTabsDe._(_root);
}

// Path: dashboard
class _TranslationsDashboardDe extends TranslationsDashboardEn {
	_TranslationsDashboardDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsDashboardIdCardDe id_card = _TranslationsDashboardIdCardDe._(_root);
	@override late final _TranslationsDashboardSectionsDe sections = _TranslationsDashboardSectionsDe._(_root);
	@override late final _TranslationsDashboardItemsDe items = _TranslationsDashboardItemsDe._(_root);
	@override late final _TranslationsDashboardLabelsDe labels = _TranslationsDashboardLabelsDe._(_root);
}

// Path: settings
class _TranslationsSettingsDe extends TranslationsSettingsEn {
	_TranslationsSettingsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Einstellungen';
	@override late final _TranslationsSettingsSectionsDe sections = _TranslationsSettingsSectionsDe._(_root);
	@override late final _TranslationsSettingsTilesDe tiles = _TranslationsSettingsTilesDe._(_root);
	@override late final _TranslationsSettingsMessagesDe messages = _TranslationsSettingsMessagesDe._(_root);
}

// Path: colleges
class _TranslationsCollegesDe extends TranslationsCollegesEn {
	_TranslationsCollegesDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override late final _TranslationsCollegesDetailsDe details = _TranslationsCollegesDetailsDe._(_root);
	@override String get applied_health_sciences => 'Fakultät für angewandte Gesundheitswissenschaften';
	@override String get business_administration => 'Fakultät für Betriebswirtschaft';
	@override String get dentistry => 'Fakultät für Zahnmedizin';
	@override String get engineering => 'Fakultät für Ingenieurwissenschaften';
	@override String get fine_arts => 'Fakultät für Bildende Künste';
	@override String get human_medicine => 'Fakultät für Humanmedizin';
	@override String get linguistics => 'Fakultät für Linguistik & Übersetzung';
	@override String get pharmacy => 'Fakultät für Pharmazie';
	@override String get physical_therapy => 'Fakultät für Physiotherapie';
	@override String get ai => 'Fakultät für Künstliche Intelligenz';
	@override late final _TranslationsCollegesDepartmentsDe departments = _TranslationsCollegesDepartmentsDe._(_root);
}

// Path: transcript
class _TranslationsTranscriptDe extends TranslationsTranscriptEn {
	_TranslationsTranscriptDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Akademisches Transkript';
	@override late final _TranslationsTranscriptOverviewDe overview = _TranslationsTranscriptOverviewDe._(_root);
	@override late final _TranslationsTranscriptSemesterDe semester = _TranslationsTranscriptSemesterDe._(_root);
	@override late final _TranslationsTranscriptCourseDe course = _TranslationsTranscriptCourseDe._(_root);
}

// Path: academic_progress
class _TranslationsAcademicProgressDe extends TranslationsAcademicProgressEn {
	_TranslationsAcademicProgressDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Akademischer Fortschritt';
	@override String get completion => 'Abschlussgrad';
	@override String get total_credits => 'Gesamt-Credits';
	@override late final _TranslationsAcademicProgressCategoriesDe categories = _TranslationsAcademicProgressCategoriesDe._(_root);
	@override late final _TranslationsAcademicProgressStatusDe status = _TranslationsAcademicProgressStatusDe._(_root);
}

// Path: grades
class _TranslationsGradesDe extends TranslationsGradesEn {
	_TranslationsGradesDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Semesternoten';
	@override String get grade_point => 'Notenpunkte';
	@override String get letter_grade => 'Notenbuchstabe';
	@override String get gpa => 'Semester-GPA';
}

// Path: subject_results
class _TranslationsSubjectResultsDe extends TranslationsSubjectResultsEn {
	_TranslationsSubjectResultsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Fachergebnisse';
	@override String get midterm => 'Zwischenprüfung';
	@override String get kFinal => 'Abschlussprüfung';
	@override String get practical => 'Praktikum';
	@override String get activities => 'Semesteraktivitäten';
	@override String get total => 'Gesamtpunktzahl';
}

// Path: action_plan
class _TranslationsActionPlanDe extends TranslationsActionPlanEn {
	_TranslationsActionPlanDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Grad-Aktionsplan';
	@override String get roadmap => 'Kurs-Roadmap';
	@override String get year_1 => 'Erstes Jahr';
	@override String get year_2 => 'Zweites Jahr';
	@override String get year_3 => 'Drittes Jahr';
	@override String get year_4 => 'Viertes Jahr';
}

// Path: courses
class _TranslationsCoursesDe extends TranslationsCoursesEn {
	_TranslationsCoursesDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Meine Kurse';
	@override String get enrolled => 'Eingeschrieben';
	@override String get available => 'Verfügbar';
	@override String get instructor => 'Dozent';
	@override String get schedule => 'Zeitplan';
}

// Path: schedule
class _TranslationsScheduleDe extends TranslationsScheduleEn {
	_TranslationsScheduleDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Stundenplan';
	@override String get time => 'Zeit';
	@override String get room => 'Raum';
	@override String get monday => 'Montag';
	@override String get tuesday => 'Dienstag';
	@override String get wednesday => 'Mittwoch';
	@override String get thursday => 'Donnerstag';
	@override String get friday => 'Freitag';
	@override String get saturday => 'Samstag';
	@override String get sunday => 'Sonntag';
	@override String get instructor => 'Dozent';
	@override String get doctor => 'Dr.';
	@override String get type_lecture => 'Vorlesung';
	@override String get type_section => 'Übung';
	@override String get status_active => 'Anstehend';
	@override String get status_started => 'Jetzt';
	@override String get status_cancelled => 'Abgesagt';
	@override String get status_online => 'Online';
	@override String get status_substitute => 'Ersatz';
	@override String get morning => 'Vormittag';
	@override String get afternoon => 'Nachmittag';
	@override String get evening => 'Abend';
	@override String get all_periods => 'Alle Zeiträume';
	@override String get floor => 'Etage';
	@override String get direction => 'Richtung';
	@override String get east => 'Osten';
	@override String get west => 'Westen';
	@override String get south => 'Süden';
	@override String get north => 'Norden';
	@override String get no_lectures => 'Keine Vorlesungen gefunden';
}

// Path: exam_schedule
class _TranslationsExamScheduleDe extends TranslationsExamScheduleEn {
	_TranslationsExamScheduleDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Prüfungsplan';
	@override String get date => 'Datum';
	@override String get duration => 'Dauer';
	@override String get seat => 'Sitznummer';
}

// Path: attendance
class _TranslationsAttendanceDe extends TranslationsAttendanceEn {
	_TranslationsAttendanceDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Anwesenheitsstatistik';
	@override String get present => 'Anwesend';
	@override String get absent => 'Abwesend';
	@override String get late => 'Verspätet';
	@override String get ratio => 'Anwesenheitsquote';
}

// Path: registration
class _TranslationsRegistrationDe extends TranslationsRegistrationEn {
	_TranslationsRegistrationDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Kursregistrierung';
	@override String get submit => 'Registrierung absenden';
	@override String get enrolled_credits => 'Eingeschriebene Credits';
}

// Path: payment
class _TranslationsPaymentDe extends TranslationsPaymentEn {
	_TranslationsPaymentDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Studiengebühren';
	@override String get outstanding => 'Offener Betrag';
	@override String get pay_now => 'Jetzt bezahlen';
	@override String get methods => 'Zahlungsmethoden';
}

// Path: invoices
class _TranslationsInvoicesDe extends TranslationsInvoicesEn {
	_TranslationsInvoicesDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Rechnungen';
	@override String get history => 'Zahlungshistorie';
	@override String get unpaid => 'Unbezahlt';
	@override String get paid => 'Bezahlt';
}

// Path: notifications
class _TranslationsNotificationsDe extends TranslationsNotificationsEn {
	_TranslationsNotificationsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Benachrichtigungen';
	@override String get empty => 'Keine neuen Benachrichtigungen';
}

// Path: support
class _TranslationsSupportDe extends TranslationsSupportEn {
	_TranslationsSupportDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Support & Hilfe';
	@override String get contact_us => 'Kontaktieren Sie uns';
}

// Path: security
class _TranslationsSecurityDe extends TranslationsSecurityEn {
	_TranslationsSecurityDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Sicherheit';
	@override String get biometrics => 'Biometrie';
	@override String get sessions => 'Aktive Sitzungen';
}

// Path: tutorials
class _TranslationsTutorialsDe extends TranslationsTutorialsEn {
	_TranslationsTutorialsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Tutorials & Leitfäden';
}

// Path: forums
class _TranslationsForumsDe extends TranslationsForumsEn {
	_TranslationsForumsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Foren';
}

// Path: administration
class _TranslationsAdministrationDe extends TranslationsAdministrationEn {
	_TranslationsAdministrationDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Studentenverwaltung';
	@override String get stats => 'Systemstatistik';
	@override String get users => 'Benutzer';
	@override String get reports => 'Berichte';
}

// Path: onboarding.language
class _TranslationsOnboardingLanguageDe extends TranslationsOnboardingLanguageEn {
	_TranslationsOnboardingLanguageDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wählen Sie Ihre Sprache';
	@override String get subtitle => 'Wählen Sie Ihre bevorzugte Sprache';
	@override String get english => 'Englisch';
	@override String get arabic => 'Arabisch';
	@override String get german => 'Deutsch';
	@override String get chinese => 'Chinesisch';
	@override String get hint => 'Sie können dies später in den Einstellungen ändern';
}

// Path: onboarding.faculties_directory
class _TranslationsOnboardingFacultiesDirectoryDe extends TranslationsOnboardingFacultiesDirectoryEn {
	_TranslationsOnboardingFacultiesDirectoryDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Unsere Fakultäten';
	@override String get subtitle => 'Entdecken Sie unsere vielfältigen akademischen Abteilungen';
}

// Path: onboarding.style
class _TranslationsOnboardingStyleDe extends TranslationsOnboardingStyleEn {
	_TranslationsOnboardingStyleDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wählen Sie Ihren Stil';
	@override String get subtitle => 'Wählen Sie das Interface-Design, das Sie bevorzugen';
	@override late final _TranslationsOnboardingStyleClassicDe classic = _TranslationsOnboardingStyleClassicDe._(_root);
	@override late final _TranslationsOnboardingStyleGlassDe glass = _TranslationsOnboardingStyleGlassDe._(_root);
}

// Path: onboarding.theme
class _TranslationsOnboardingThemeDe extends TranslationsOnboardingThemeEn {
	_TranslationsOnboardingThemeDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Wählen Sie ein Thema';
	@override String get subtitle => 'Hell oder dunkel, Ihre Wahl';
	@override String get light => 'Hell';
	@override String get dark => 'Dunkel';
}

// Path: auth.login
class _TranslationsAuthLoginDe extends TranslationsAuthLoginEn {
	_TranslationsAuthLoginDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get welcome => 'Willkommen zurück';
	@override String get subtitle => 'Melden Sie sich an, um fortzufahren';
	@override String get email => 'E-Mail';
	@override String get password => 'Passwort';
	@override String get forgot_password => 'Passwort vergessen?';
	@override String get submit => 'Anmelden';
	@override String get guest => 'Als Gast stöbern';
}

// Path: auth.forgot_password
class _TranslationsAuthForgotPasswordDe extends TranslationsAuthForgotPasswordEn {
	_TranslationsAuthForgotPasswordDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Passwort vergessen';
	@override String get subtitle => 'Wählen Sie eine Wiederherstellungsmethode';
	@override String get method_admin => 'Verwaltung besuchen';
	@override String get method_online => 'Online-Anfrage';
	@override String get admin_instructions => 'Bitte besuchen Sie das Büro für studentische Angelegenheiten, um Ihr Passwort zurückzusetzen. Bringen Sie Ihren gültigen Universitätsausweis mit.';
	@override String get phone_label => 'Telefonnummer';
	@override String get upload_id => 'ID-Foto hochladen';
	@override String get upload_id_hint => 'Tippen Sie, um ein klares Foto Ihres Universitätsausweises hochzuladen';
	@override String get submit => 'Anfrage absenden';
	@override String get back => 'Zurück zum Login';
	@override String get error_empty_phone => 'Bitte geben Sie Ihre Telefonnummer ein';
	@override String get error_empty_email => 'Bitte geben Sie Ihre E-Mail ein';
	@override String get error_no_id => 'Bitte laden Sie Ihr ID-Foto hoch';
	@override String get success => 'Anfrage erfolgreich gesendet';
	@override String get id_uploaded => 'ID hochgeladen';
}

// Path: home.tabs
class _TranslationsHomeTabsDe extends TranslationsHomeTabsEn {
	_TranslationsHomeTabsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get home => 'Startseite';
	@override String get search => 'Suche';
	@override String get notifications => 'Benachrichtigungen';
	@override String get profile => 'Profil';
}

// Path: dashboard.id_card
class _TranslationsDashboardIdCardDe extends TranslationsDashboardIdCardEn {
	_TranslationsDashboardIdCardDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get student_name => 'Studentenname';
	@override String get college => 'Fakultät';
	@override String get id => 'Studenten-ID';
	@override String get gpa => 'Notendurchschnitt';
	@override String get level => 'Stufe';
	@override String get verified => 'Verifiziert';
}

// Path: dashboard.sections
class _TranslationsDashboardSectionsDe extends TranslationsDashboardSectionsEn {
	_TranslationsDashboardSectionsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get academic => 'Akademisch';
	@override String get enrollment => 'Einschreibung';
	@override String get utilities => 'Dienstprogramme';
}

// Path: dashboard.items
class _TranslationsDashboardItemsDe extends TranslationsDashboardItemsEn {
	_TranslationsDashboardItemsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get transcript => 'Transkript';
	@override String get progress => 'Fortschritt';
	@override String get action_plan => 'Aktionsplan';
	@override String get subject_result => 'Ergebnis';
	@override String get grades => 'Noten';
	@override String get courses => 'Kurse';
	@override String get registration => 'Registrierung';
	@override String get invoices => 'Rechnungen';
	@override String get payment => 'Zahlung';
	@override String get tutorials => 'Tutorials';
	@override String get security => 'Sicherheit';
	@override String get forums => 'Foren';
	@override String get support => 'Support';
	@override String get notifications => 'Benachrichtigungen';
	@override String get no_lectures => 'Keine Vorlesungen gefunden';
}

// Path: dashboard.labels
class _TranslationsDashboardLabelsDe extends TranslationsDashboardLabelsEn {
	_TranslationsDashboardLabelsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get university_name => 'UNIVERSITÄT VON HUE';
	@override String get id_short => 'ID';
	@override String get gpa_short => 'GPA';
	@override String get level_short => 'LVL';
}

// Path: settings.sections
class _TranslationsSettingsSectionsDe extends TranslationsSettingsSectionsEn {
	_TranslationsSettingsSectionsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get account => 'Konto';
	@override String get display => 'Anzeige';
	@override String get notifications => 'Benachrichtigungen';
	@override String get about => 'Über';
}

// Path: settings.tiles
class _TranslationsSettingsTilesDe extends TranslationsSettingsTilesEn {
	_TranslationsSettingsTilesDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get edit_profile => 'Profil bearbeiten';
	@override String get change_password => 'Passwort ändern';
	@override String get dark_mode => 'Dunkelmodus';
	@override String get language => 'Sprache';
	@override String get ui_style => 'UI-Stil';
	@override String get app_notifications => 'App-Benachrichtigungen';
	@override String get test_notifications => 'Benachrichtigungen testen';
	@override String get about_app => 'Über die App';
	@override String get privacy_policy => 'Datenschutzrichtlinie';
	@override String get logout => 'Abmelden';
}

// Path: settings.messages
class _TranslationsSettingsMessagesDe extends TranslationsSettingsMessagesEn {
	_TranslationsSettingsMessagesDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get switching_theme => 'Thema wird gewechselt...';
	@override String get changing_language => 'Sprache wird geändert...';
	@override String get rebuilding_design => 'Design-System wird neu aufgebaut...';
}

// Path: colleges.details
class _TranslationsCollegesDetailsDe extends TranslationsCollegesDetailsEn {
	_TranslationsCollegesDetailsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get dean => 'Dekan der Fakultät';
	@override String get staff => 'Lehrpersonal';
	@override String get view_all => 'Alle anzeigen';
	@override String get departments => 'Abteilungen';
	@override String get explore_majors => 'Verfügbare Majors erkunden';
	@override String get majors => 'Majors';
	@override String get dean_title => 'Der Dekan';
	@override String get staff_member => 'Mitarbeiter';
	@override String get vice_dean => 'Vizedekan';
	@override String get head_of_dept => 'Abteilungsleiter';
	@override String get assoc_prof => 'Assoc. Prof.';
	@override String get academic_statistics => 'Akademische Statistik';
	@override String get students => 'Studenten';
	@override String get academic_staff => 'Lehrpersonal';
	@override String get teaching_assistants => 'Assistenten';
	@override String get published_articles => 'Veröffentlichte Artikel';
}

// Path: colleges.departments
class _TranslationsCollegesDepartmentsDe extends TranslationsCollegesDepartmentsEn {
	_TranslationsCollegesDepartmentsDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get medical_laboratories_technology => 'Medizinische Labortechnologie';
	@override String get radiology_and_imaging_technology => 'Radiologie und Bildgebungstechnologie';
	@override String get respiratory_care_technology => 'Atemwegspflege-Technologie';
	@override String get dental_prosthetics_technology => 'Zahnprothetische Technologie';
	@override String get health_administration_and_informatics_technology => 'Gesundheitsverwaltung & Informatik';
	@override String get accounting => 'Rechnungswesen';
	@override String get business_management => 'Unternehmensführung';
	@override String get economics => 'Wirtschaftswissenschaften';
	@override String get marketing => 'Marketing';
	@override String get accounting_program_english => 'Rechnungswesen (Englisch)';
	@override String get business_administration_program_english => 'Betriebswirtschaft (Englisch)';
	@override String get basic_sciences_in_dentistry => 'Grundlagen der Zahnmedizin';
	@override String get basic_medical_and_clinical_sciences => 'Medizinische Grundlagen';
	@override String get oral_and_maxillofacial_surgery => 'Mund-Kiefer-Gesichtschirurgie';
	@override String get orthodontics_and_pediatric_dentistry => 'Kieferorthopädie & Kinderzahnheilkunde';
	@override String get periodontics_and_oral_medicine => 'Parodontologie & Oralmedizin';
	@override String get prosthodontics => 'Prothetik';
	@override String get conservative_dentistry_and_endodontics => 'Konservierende Zahnheilkunde';
	@override String get architectural_engineering => 'Architektur';
	@override String get basic_sciences => 'Grundlagenwissenschaften';
	@override String get civil_engineering => 'Bauingenieurwesen';
	@override String get mechanical_engineering => 'Maschinenbau';
	@override String get electrical_engineering => 'Elektrotechnik';
	@override String get artificial_intelligence_engineering => 'KI-Ingenieurwesen';
	@override String get interior_design_and_architecture => 'Innenarchitektur';
	@override String get furniture_design_and_production_technology => 'Möbeldesign-Technologie';
	@override String get graphics_and_digital_arts => 'Grafik und digitale Kunst';
	@override String get animation_and_multimedia => 'Animation und Multimedia';
	@override String get medical_education => 'Medizinische Ausbildung';
	@override String get histology_and_cell_biology => 'Histologie und Zellbiologie';
	@override String get clinical_pharmacy => 'Klinische Pharmazie';
	@override String get human_anatomy_and_embryology => 'Anatomie und Embryologie';
	@override String get medical_physiology => 'Medizinische Physiologie';
	@override String get medical_microbiology_and_immunology => 'Mikrobiologie & Immunologie';
	@override String get forensic_medicine_and_toxicology => 'Forensik & Toxikologie';
	@override String get community_medicine_and_public_health => 'Gemeinschaftsmedizin & Gesundheit';
	@override String get biochemistry => 'Biochemie';
	@override String get pathology => 'Pathologie';
	@override String get english_language_program => 'Englisch-Sprachprogramm';
	@override String get german_language_program => 'Deutsch-Sprachprogramm';
	@override String get chinese_language_program => 'Chinesisch-Sprachprogramm';
	@override String get french_department => 'Französische Abteilung';
	@override String get translation_department => 'Übersetzungsabteilung';
	@override String get pharmaceutical_chemistry => 'Pharmazeutische Chemie';
	@override String get pharmacology_and_biochemistry => 'Pharmakologie & Biochemie';
	@override String get pharmacognosy => 'Pharmakognosie';
	@override String get microbiology_and_immunology => 'Mikrobiologie & Immunologie';
	@override String get pharmaceutical_technology => 'Pharmazeutische Technologie';
	@override String get pharmacy_practice => 'Pharmaziepraxis';
	@override String get basic_sciences_pt => 'Grundwissenschaften PT';
	@override String get biomechanics => 'Biomechanik';
	@override String get pt_internal_medicine_and_geriatrics => 'PT für Innere Medizin & Geriatrie';
	@override String get pt_womens_health => 'PT für Frauengesundheit';
	@override String get pt_surgery_and_integumentary => 'PT für Chirurgie';
	@override String get pt_orthopedics => 'PT für Orthopädie';
	@override String get pt_neurology => 'PT für Neurologie';
	@override String get pt_pediatrics => 'PT für Pädiatrie';
	@override String get artificial_biomedical_computing => 'KI-Biomedizinisches Computing';
	@override String get artificial_cybersecurity => 'KI-Cybersicherheit';
	@override String get ai_and_data_science => 'KI & Datenwissenschaft';
	@override String get ai_for_robotics => 'KI für Robotik';
	@override String get smart_systems => 'Smart Systems';
}

// Path: transcript.overview
class _TranslationsTranscriptOverviewDe extends TranslationsTranscriptOverviewEn {
	_TranslationsTranscriptOverviewDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get gpa => 'Gesamt-GPA';
	@override String get credits => 'Erworbene Credits';
	@override String get standing => 'Status';
	@override String get active => 'Guter Status';
}

// Path: transcript.semester
class _TranslationsTranscriptSemesterDe extends TranslationsTranscriptSemesterEn {
	_TranslationsTranscriptSemesterDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get fall => 'Herbstsemester';
	@override String get spring => 'Frühlingssemester';
	@override String get summer => 'Sommersemester';
}

// Path: transcript.course
class _TranslationsTranscriptCourseDe extends TranslationsTranscriptCourseEn {
	_TranslationsTranscriptCourseDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get grade => 'Note';
	@override String get credits => 'Credits';
	@override late final _TranslationsTranscriptCourseStatusDe status = _TranslationsTranscriptCourseStatusDe._(_root);
}

// Path: academic_progress.categories
class _TranslationsAcademicProgressCategoriesDe extends TranslationsAcademicProgressCategoriesEn {
	_TranslationsAcademicProgressCategoriesDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get university => 'Universitätsanforderungen';
	@override String get faculty => 'Fakultätsanforderungen';
	@override String get major => 'Hauptfachanforderungen';
	@override String get electives => 'Wahlfächer';
}

// Path: academic_progress.status
class _TranslationsAcademicProgressStatusDe extends TranslationsAcademicProgressStatusEn {
	_TranslationsAcademicProgressStatusDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get completed => 'Abgeschlossen';
	@override String get in_progress => 'In Arbeit';
	@override String get remaining => 'Verbleibend';
	@override String get requirement_met => 'Anforderung erfüllt';
}

// Path: onboarding.style.classic
class _TranslationsOnboardingStyleClassicDe extends TranslationsOnboardingStyleClassicEn {
	_TranslationsOnboardingStyleClassicDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Klassisch';
	@override String get desc => 'Sauberes, einfaches und vertrautes Material Design';
}

// Path: onboarding.style.glass
class _TranslationsOnboardingStyleGlassDe extends TranslationsOnboardingStyleGlassEn {
	_TranslationsOnboardingStyleGlassDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get title => 'Glas';
	@override String get desc => 'Moderne, transluzente und lebendige Ästhetik';
}

// Path: transcript.course.status
class _TranslationsTranscriptCourseStatusDe extends TranslationsTranscriptCourseStatusEn {
	_TranslationsTranscriptCourseStatusDe._(TranslationsDe root) : this._root = root, super.internal(root);

	final TranslationsDe _root; // ignore: unused_field

	// Translations
	@override String get completed => 'Abgeschlossen';
	@override String get transferred => 'Übertragen';
}

/// The flat map containing all translations for locale <de>.
/// Only for edge cases! For simple maps, use the map function of this library.
///
/// The Dart AOT compiler has issues with very large switch statements,
/// so the map is split into smaller functions (512 entries each).
extension on TranslationsDe {
	dynamic _flatMapFunction(String path) {
		return switch (path) {
			'common.close' => 'Schließen',
			'common.cancel' => 'Abbrechen',
			'common.confirm' => 'Bestätigen',
			'common.save' => 'Speichern',
			'common.back' => 'Zurück',
			'welcome.title' => 'Willkommen bei Hue',
			'welcome.subtitle' => 'Erleuchten Sie Ihre Welt mit bedeutungsvollen Verbindungen.',
			'welcome.get_started' => 'Loslegen',
			'welcome.have_account' => 'Ich habe bereits ein Konto',
			'onboarding.language.title' => 'Wählen Sie Ihre Sprache',
			'onboarding.language.subtitle' => 'Wählen Sie Ihre bevorzugte Sprache',
			'onboarding.language.english' => 'Englisch',
			'onboarding.language.arabic' => 'Arabisch',
			'onboarding.language.german' => 'Deutsch',
			'onboarding.language.chinese' => 'Chinesisch',
			'onboarding.language.hint' => 'Sie können dies später in den Einstellungen ändern',
			'onboarding.faculties_directory.title' => 'Unsere Fakultäten',
			'onboarding.faculties_directory.subtitle' => 'Entdecken Sie unsere vielfältigen akademischen Abteilungen',
			'onboarding.style.title' => 'Wählen Sie Ihren Stil',
			'onboarding.style.subtitle' => 'Wählen Sie das Interface-Design, das Sie bevorzugen',
			'onboarding.style.classic.title' => 'Klassisch',
			'onboarding.style.classic.desc' => 'Sauberes, einfaches und vertrautes Material Design',
			'onboarding.style.glass.title' => 'Glas',
			'onboarding.style.glass.desc' => 'Moderne, transluzente und lebendige Ästhetik',
			'onboarding.theme.title' => 'Wählen Sie ein Thema',
			'onboarding.theme.subtitle' => 'Hell oder dunkel, Ihre Wahl',
			'onboarding.theme.light' => 'Hell',
			'onboarding.theme.dark' => 'Dunkel',
			'auth.login.welcome' => 'Willkommen zurück',
			'auth.login.subtitle' => 'Melden Sie sich an, um fortzufahren',
			'auth.login.email' => 'E-Mail',
			'auth.login.password' => 'Passwort',
			'auth.login.forgot_password' => 'Passwort vergessen?',
			'auth.login.submit' => 'Anmelden',
			'auth.login.guest' => 'Als Gast stöbern',
			'auth.forgot_password.title' => 'Passwort vergessen',
			'auth.forgot_password.subtitle' => 'Wählen Sie eine Wiederherstellungsmethode',
			'auth.forgot_password.method_admin' => 'Verwaltung besuchen',
			'auth.forgot_password.method_online' => 'Online-Anfrage',
			'auth.forgot_password.admin_instructions' => 'Bitte besuchen Sie das Büro für studentische Angelegenheiten, um Ihr Passwort zurückzusetzen. Bringen Sie Ihren gültigen Universitätsausweis mit.',
			'auth.forgot_password.phone_label' => 'Telefonnummer',
			'auth.forgot_password.upload_id' => 'ID-Foto hochladen',
			'auth.forgot_password.upload_id_hint' => 'Tippen Sie, um ein klares Foto Ihres Universitätsausweises hochzuladen',
			'auth.forgot_password.submit' => 'Anfrage absenden',
			'auth.forgot_password.back' => 'Zurück zum Login',
			'auth.forgot_password.error_empty_phone' => 'Bitte geben Sie Ihre Telefonnummer ein',
			'auth.forgot_password.error_empty_email' => 'Bitte geben Sie Ihre E-Mail ein',
			'auth.forgot_password.error_no_id' => 'Bitte laden Sie Ihr ID-Foto hoch',
			'auth.forgot_password.success' => 'Anfrage erfolgreich gesendet',
			'auth.forgot_password.id_uploaded' => 'ID hochgeladen',
			'home.tabs.home' => 'Startseite',
			'home.tabs.search' => 'Suche',
			'home.tabs.notifications' => 'Benachrichtigungen',
			'home.tabs.profile' => 'Profil',
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
			'dashboard.items.support' => 'Support',
			'dashboard.items.notifications' => 'Benachrichtigungen',
			'dashboard.items.no_lectures' => 'Keine Vorlesungen gefunden',
			'dashboard.labels.university_name' => 'UNIVERSITÄT VON HUE',
			'dashboard.labels.id_short' => 'ID',
			'dashboard.labels.gpa_short' => 'GPA',
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
			'settings.messages.rebuilding_design' => 'Design-System wird neu aufgebaut...',
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
			'colleges.applied_health_sciences' => 'Fakultät für angewandte Gesundheitswissenschaften',
			'colleges.business_administration' => 'Fakultät für Betriebswirtschaft',
			'colleges.dentistry' => 'Fakultät für Zahnmedizin',
			'colleges.engineering' => 'Fakultät für Ingenieurwissenschaften',
			'colleges.fine_arts' => 'Fakultät für Bildende Künste',
			'colleges.human_medicine' => 'Fakultät für Humanmedizin',
			'colleges.linguistics' => 'Fakultät für Linguistik & Übersetzung',
			'colleges.pharmacy' => 'Fakultät für Pharmazie',
			'colleges.physical_therapy' => 'Fakultät für Physiotherapie',
			'colleges.ai' => 'Fakultät für Künstliche Intelligenz',
			'colleges.departments.medical_laboratories_technology' => 'Medizinische Labortechnologie',
			'colleges.departments.radiology_and_imaging_technology' => 'Radiologie und Bildgebungstechnologie',
			'colleges.departments.respiratory_care_technology' => 'Atemwegspflege-Technologie',
			'colleges.departments.dental_prosthetics_technology' => 'Zahnprothetische Technologie',
			'colleges.departments.health_administration_and_informatics_technology' => 'Gesundheitsverwaltung & Informatik',
			'colleges.departments.accounting' => 'Rechnungswesen',
			'colleges.departments.business_management' => 'Unternehmensführung',
			'colleges.departments.economics' => 'Wirtschaftswissenschaften',
			'colleges.departments.marketing' => 'Marketing',
			'colleges.departments.accounting_program_english' => 'Rechnungswesen (Englisch)',
			'colleges.departments.business_administration_program_english' => 'Betriebswirtschaft (Englisch)',
			'colleges.departments.basic_sciences_in_dentistry' => 'Grundlagen der Zahnmedizin',
			'colleges.departments.basic_medical_and_clinical_sciences' => 'Medizinische Grundlagen',
			'colleges.departments.oral_and_maxillofacial_surgery' => 'Mund-Kiefer-Gesichtschirurgie',
			'colleges.departments.orthodontics_and_pediatric_dentistry' => 'Kieferorthopädie & Kinderzahnheilkunde',
			'colleges.departments.periodontics_and_oral_medicine' => 'Parodontologie & Oralmedizin',
			'colleges.departments.prosthodontics' => 'Prothetik',
			'colleges.departments.conservative_dentistry_and_endodontics' => 'Konservierende Zahnheilkunde',
			'colleges.departments.architectural_engineering' => 'Architektur',
			'colleges.departments.basic_sciences' => 'Grundlagenwissenschaften',
			'colleges.departments.civil_engineering' => 'Bauingenieurwesen',
			'colleges.departments.mechanical_engineering' => 'Maschinenbau',
			'colleges.departments.electrical_engineering' => 'Elektrotechnik',
			'colleges.departments.artificial_intelligence_engineering' => 'KI-Ingenieurwesen',
			'colleges.departments.interior_design_and_architecture' => 'Innenarchitektur',
			'colleges.departments.furniture_design_and_production_technology' => 'Möbeldesign-Technologie',
			'colleges.departments.graphics_and_digital_arts' => 'Grafik und digitale Kunst',
			'colleges.departments.animation_and_multimedia' => 'Animation und Multimedia',
			'colleges.departments.medical_education' => 'Medizinische Ausbildung',
			'colleges.departments.histology_and_cell_biology' => 'Histologie und Zellbiologie',
			'colleges.departments.clinical_pharmacy' => 'Klinische Pharmazie',
			'colleges.departments.human_anatomy_and_embryology' => 'Anatomie und Embryologie',
			'colleges.departments.medical_physiology' => 'Medizinische Physiologie',
			'colleges.departments.medical_microbiology_and_immunology' => 'Mikrobiologie & Immunologie',
			'colleges.departments.forensic_medicine_and_toxicology' => 'Forensik & Toxikologie',
			'colleges.departments.community_medicine_and_public_health' => 'Gemeinschaftsmedizin & Gesundheit',
			'colleges.departments.biochemistry' => 'Biochemie',
			'colleges.departments.pathology' => 'Pathologie',
			'colleges.departments.english_language_program' => 'Englisch-Sprachprogramm',
			'colleges.departments.german_language_program' => 'Deutsch-Sprachprogramm',
			'colleges.departments.chinese_language_program' => 'Chinesisch-Sprachprogramm',
			'colleges.departments.french_department' => 'Französische Abteilung',
			'colleges.departments.translation_department' => 'Übersetzungsabteilung',
			'colleges.departments.pharmaceutical_chemistry' => 'Pharmazeutische Chemie',
			'colleges.departments.pharmacology_and_biochemistry' => 'Pharmakologie & Biochemie',
			'colleges.departments.pharmacognosy' => 'Pharmakognosie',
			'colleges.departments.microbiology_and_immunology' => 'Mikrobiologie & Immunologie',
			'colleges.departments.pharmaceutical_technology' => 'Pharmazeutische Technologie',
			'colleges.departments.pharmacy_practice' => 'Pharmaziepraxis',
			'colleges.departments.basic_sciences_pt' => 'Grundwissenschaften PT',
			'colleges.departments.biomechanics' => 'Biomechanik',
			'colleges.departments.pt_internal_medicine_and_geriatrics' => 'PT für Innere Medizin & Geriatrie',
			'colleges.departments.pt_womens_health' => 'PT für Frauengesundheit',
			'colleges.departments.pt_surgery_and_integumentary' => 'PT für Chirurgie',
			'colleges.departments.pt_orthopedics' => 'PT für Orthopädie',
			'colleges.departments.pt_neurology' => 'PT für Neurologie',
			'colleges.departments.pt_pediatrics' => 'PT für Pädiatrie',
			'colleges.departments.artificial_biomedical_computing' => 'KI-Biomedizinisches Computing',
			'colleges.departments.artificial_cybersecurity' => 'KI-Cybersicherheit',
			'colleges.departments.ai_and_data_science' => 'KI & Datenwissenschaft',
			'colleges.departments.ai_for_robotics' => 'KI für Robotik',
			'colleges.departments.smart_systems' => 'Smart Systems',
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
			'academic_progress.categories.university' => 'Universitätsanforderungen',
			'academic_progress.categories.faculty' => 'Fakultätsanforderungen',
			'academic_progress.categories.major' => 'Hauptfachanforderungen',
			'academic_progress.categories.electives' => 'Wahlfächer',
			'academic_progress.status.completed' => 'Abgeschlossen',
			'academic_progress.status.in_progress' => 'In Arbeit',
			'academic_progress.status.remaining' => 'Verbleibend',
			'academic_progress.status.requirement_met' => 'Anforderung erfüllt',
			'grades.title' => 'Semesternoten',
			'grades.grade_point' => 'Notenpunkte',
			'grades.letter_grade' => 'Notenbuchstabe',
			'grades.gpa' => 'Semester-GPA',
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
			'exam_schedule.title' => 'Prüfungsplan',
			'exam_schedule.date' => 'Datum',
			'exam_schedule.duration' => 'Dauer',
			'exam_schedule.seat' => 'Sitznummer',
			'attendance.title' => 'Anwesenheitsstatistik',
			'attendance.present' => 'Anwesend',
			'attendance.absent' => 'Abwesend',
			'attendance.late' => 'Verspätet',
			'attendance.ratio' => 'Anwesenheitsquote',
			'registration.title' => 'Kursregistrierung',
			'registration.submit' => 'Registrierung absenden',
			'registration.enrolled_credits' => 'Eingeschriebene Credits',
			'payment.title' => 'Studiengebühren',
			'payment.outstanding' => 'Offener Betrag',
			'payment.pay_now' => 'Jetzt bezahlen',
			'payment.methods' => 'Zahlungsmethoden',
			'invoices.title' => 'Rechnungen',
			'invoices.history' => 'Zahlungshistorie',
			'invoices.unpaid' => 'Unbezahlt',
			'invoices.paid' => 'Bezahlt',
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
			_ => null,
		};
	}
}

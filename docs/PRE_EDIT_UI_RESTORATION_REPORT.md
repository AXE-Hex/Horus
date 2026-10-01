# Horus pre-EDIT UI restoration report

## Reference and scope

- PRE_EDIT_UI_COMMIT: `d67200601ffcd0660a73dfde6934e4a28bd348ad` — 2026-09-29 03:31:06 +03:00 — `fix`.
- EDIT_UI_COMMIT: `b6b8a4c373ad04e52496cb963454023435e318a6` — 2026-10-01 01:26:11 +03:00 — `EDIT UI`.
- Starting commit: `22b783be1470ec2c69afaff3ad9902fab589379b` on `restore-ui-pre-edit-safe`.
- Safety checkpoint: tag `safety/ui-restoration-22b783b`.
- The parent relationship and complete changed-file list are recorded in [UI_RESTORATION_REFERENCE.md](UI_RESTORATION_REFERENCE.md).
- All historical screens and their parts were compared directly with Git. Inventory: 179 Dart files; {'EXACT_OLD': 76, 'BACKEND_COMPATIBILITY_REQUIRED': 84, 'NEW_UI': 17, 'REMOVED': 2}.

This restores the historical Flutter screen implementations and mobile navigation, with the current secure backend. It does not assert identical pixels for every live-data screen: real authorized data replaces old sample records, and necessary compatibility differences below are explicit. Every historical screen has a source comparison; screenshots cover major flows and representative roles. Unavailable backend features are unavailable in the UI, with no fabricated success.

## Backend and security preservation

Checked 74 tracked files in Supabase, auth, data/domain and provider families against the starting commit. All security, auth, RBAC, schema, RPC, RLS, storage and database tests are preserved. The only manually adapted repository is `professor_repository.dart`: separate public profile reads from optional professor details and keep scoped reads for TAs, groups, announcements, files and office hours. No grants, policies or privileged keys were changed.

Current local `professor_details` reads return SQLSTATE `42501` / HTTP 403 because that existing policy references private profile columns. This remains denied. The UI shows unavailable ratings/office detail instead of retrying forever or requesting broader privileges. A list projection preserves SQLSTATE; `maybeSingle` in the installed SDK remaps that error to HTTP code 403. Three new SDK-backed regression tests validate denial handling, empty optional details, and propagation of other errors. The seven remaining professor projections return HTTP 200. See [professor projections](ui-restoration/evidence/professor-projections.json).

The sole migration diff removes a trailing space in `20260929205234_complete_database_hardening.sql`; its SQL token stream is unchanged. Two trailing-space locations in `DATABASE_INVENTORY.md` were also removed as requested. No old SQL or old security/data implementation was checked out into this repository.

## Major flow comparison

| Flow | Historical implementation restored | Current compatibility / evidence |
|---|---|---|
| Splash | Original mesh, logo, HORUS lettering, entrance/pulse animations and 3.5 second presentation | Waits for real auth, including late completion; resolves current role destination. Historical/restored splash screenshots. |
| Login | Original HUE logo, heading, rounded white form, fonts, fields, gold button | Current Supabase sign-in and canonical roles; username or full university email supported. Direct historical/restored empty-login screenshot comparison: mean pixel difference RGB approximately 0.336 / 0.273 / 0.220 on 0–255 scale; capture-timed background motion explains residual differences. |
| Welcome/setup | Original welcome, language, style, theme and transition screens | Presentation-only public routes restored; subsequent protected navigation still passes the current guard. |
| Home/navigation | Original home shell, rounded floating bottom navigation, selected states, tabs and IndexedStack | Permission filters apply before mounting tabs. Current chat and management features have permission-filtered toolbar entries; old bottom navigation retained. |
| University Feed | Original header, quick post bar, cards, reaction bar, skeletons, comment sheet and create-post screen | Current repositories/providers retained; raw errors sanitized. Actual local posts displayed. |
| Profile | Original immersive profile header, identity form, editing/photo sheets and save feedback | Current secure profile update/avatar services retained; private data is the signed-in user's current contract. |
| Digital ID | Original front/back artwork, tilt/flip, patterns, theme/department selectors, security decoration, action tiles and share sheet | Actual signed-in identity and schema names; no sample student ID. Fixed card artwork scales down at narrow widths; text action layout accommodates 2× scaling. Visual theme selection does not change authoritative identity. |
| Chat | Original professor chat header, bubbles and composer | Mock messages/autoreply removed; current conversations/messages repository used; send disabled if no authorized real conversation exists. Later conversation list/thread retained as current features. |
| Courses | Original two tabs, course cards and actions | Current catalog; actual enrollment, credits and course names; unavailable instructor shown as a dash. |
| Academic services | Original dashboard, grades, transcript, progress, subject layouts, attendance, schedules/exams/action plan | Current scoped records. No invented rank, requirement totals, component maxima or academic level. Attendance retains bounded page navigation. |
| Settings | Original immersive header, grouped cards, switches, language/style sheets and dialogs | Current persisted locale preference retained. Screenshots and layout tests at 390/768/1440; animations tested with bounded pumps. |
| Role destinations | Original professor, TA/group management, advisor approval, dean assignment and enrollment screens | Current permission/ownership checks remain. Professor/dean/advisor/registrar local sign-in screenshots; current-only control dashboard retained. |

## Required manual adaptations

1. Authentication presentation uses current real Supabase auth; splash listens for late auth completion; password recovery sends a real recovery request rather than displaying simulated success. The historical identity-upload recovery option has no supported secure endpoint and cannot fabricate an upload.
2. Router retains the current explicit permission map, guest/access-pending routes and conversation deep links. It removes the active redesign shell and restores old setup routes. Back buttons pop a real preceding route or navigate through the guarded home route when opened directly; two regression tests cover both paths.
3. Home retains current-role visibility, guards all protected destinations, and exposes later chat/control features through authorized toolbar entries using the restored mobile shell.
4. Academic presentation maps current GradeRecord, Course, AttendanceRecord and AcademicSummary into the old layouts. Missing facts are shown as dashes, not fabricated records. Attendance percentages describe the displayed bounded page.
5. Enrollment uses the current semester code and current Invoice/status model. Payment methods without secure processing are disabled; invoice browsing remains available.
6. Staff/college presentation resolves actual schema IDs before scoped reads; unmatched historical catalog keys return no records. No unscoped directory fallback or fictitious dean/reviews/ratings is restored. Department navigation passes the current typed model.
7. Professor upload restores historical dialog typography/shape/buttons while retaining real file selection, bytes, size checks, authenticated uploader and course scope. The required course field is a current security contract.
8. Shared buttons/cards preserve original wrappers and visuals while retaining current API variants used by later secure features. Extra palette/motion/layout symbols support later features; historical values remain unchanged.
9. Errors are sanitized. Current preference/disposal lifecycle safeguards are retained. Existing responsive helpers continue to support later adaptive features. The current college catalog excludes fabricated static dean/statistics records.
10. Offline fonts are bundled and runtime Google Fonts fetching is disabled in application startup and every Flutter test.

## Assets and fonts

No Cairo-SemiBold asset exists in PRE_EDIT_UI_COMMIT or the repository's earlier font history. Restoring a nonexistent historical file was not possible. Bundled 41 local TTF assets from the official Google Fonts `ofl` sources: Cairo (8 weights), Inter (9), Outfit (9), Tajawal (7), Cinzel (6), Share Tech Mono (1), Noto Sans SC (1), with seven OFL license files (line endings/trailing spaces normalized without changing the license wording). Variable sources were instantiated at the used weights. Cairo/Tajawal Arabic glyphs and the Noto Sans SC Chinese glyph were checked. Every declared asset exists; `flutter pub get` passes. Tests run with runtime network font fetching disabled.

Images/logos used by the old UI are preserved. `assets/Video/HUE.mp4` was deleted by EDIT UI and is not referenced by any historical/current Dart screen; it was not restored as an unused large video. No visual screen depends on it. All existing UI translation values match the historical source; only four fabricated teacher-name keys were removed and 53 current feature/security keys added in each of four locales. The isolated historical renderer uses the old lib tree with the current dependency lock and local fonts; it does not change this repository or restore old authentication/security here.

## Intentional limits and differences

- Later secure guest registration, access-pending, control, conversation list/thread, upload scope and compatibility helper features have no pre-EDIT counterpart and remain supported.
- The unused redesign `HorusAppShell` and unused `AppShadows` were removed. Existing standalone adaptive primitives/tests remain; the restored main app uses the original mobile bottom navigation, including on wider screens.
- `StyleController` in the exact pre-EDIT commit always returns/sets Classic. That historical behavior is restored; the old style-selection screens are present. No new style-switching behavior was invented.
- The old glass-heavy academic/ID layouts use white text even with the light theme, and the old feed header can overlap its subtitle. These historical presentation limitations were preserved, as requested. Their source and screenshots were inspected; they are not evidence of a new design.
- NFC/offline identity/access-log/rating/payment processing features without a current secure endpoint remain unavailable. Decorative QR/security artwork is not a backend-issued access credential.
- The existing denied optional professor-details read remains a backend limitation; the rest of the authorized screen renders. This report does not claim those inaccessible details are verified working.
- Every historical screen was source-compared. Pixel-for-pixel screenshot equivalence was directly checked for login and visually compared for splash/setup; other live-data screens were compared by source plus current rendered screenshots, not asserted as automated pixel goldens.

## Validation

| Check | Result |
|---|---|
| `flutter pub get --offline` | PASS; all font assets bundled |
| `dart format --output=none --set-exit-if-changed lib test` | PASS; zero changes |
| `dart analyze lib test` | PASS; zero issues |
| `dart run custom_lint` | PASS; zero issues |
| `flutter test` | PASS: 91 tests, 0 failures |
| `flutter test --coverage` | PASS: 91 tests, 0 failures; `coverage/lcov.info` generated |
| `flutter build web --release` | PASS |
| `flutter build linux --debug` | PASS |
| `git diff --check` | PASS |
| Local pgTAP/database suite | PASS: 280 assertions, 0 failures, 8 transactional files |
| Development accounts | PASS: 12/12 authenticate; 12/12 canonical roles match |
| Local Storage/REST regression script | PASS: all 9 reported validation groups |
| Professor projections | 7/8 return 200; optional details 403/42501 intentionally preserved and handled |

The replaced theme test now asserts the exact old light/dark colors. Startup tests assert restored welcome routing while all protected role cases remain covered. Infinite old decorative animations use bounded pumps; layout/no-exception assertions are retained. The obsolete desktop settings width cap was removed because it tested the redesign, while viewport-fit assertions remain. Three additional professor compatibility tests and two direct-link back tests were added; no security tests were weakened.

Database assertion counts by suite: audit remediation 39, complete hardening 102, guest regressions 17, phase 2 contracts 9, phase 3 profile security 18, phase 4 authorization 50, phase 5 storage 33, storage hardening 12 = 280.

## Visual evidence

[Historical login](ui-restoration/evidence/reference-login.png) / [restored login](ui-restoration/evidence/final-login.png); [historical splash](ui-restoration/evidence/reference-splash.png) / [restored splash](ui-restoration/evidence/final-splash.png).

[Home/navigation](ui-restoration/evidence/final-home.png), [feed](ui-restoration/evidence/final-feed.png), [profile](ui-restoration/evidence/final-profile.png), [Digital ID](ui-restoration/evidence/final-digital-id.png), [professor chat](ui-restoration/evidence/final-professor-chat.png), [courses](ui-restoration/evidence/final-courses.png), [academic services](ui-restoration/evidence/final-dashboard.png), [settings](ui-restoration/evidence/final-settings.png).

[Professor](ui-restoration/evidence/role-professor-professor-dashboard.png), [dean](ui-restoration/evidence/role-dean-dean-assignment.png), [advisor](ui-restoration/evidence/role-advisor-advisor-approval.png), [registrar](ui-restoration/evidence/role-registrar-registration.png). All screenshots, source inventories and redacted logs are in [ui-restoration/evidence](ui-restoration/evidence).

## Screen-by-screen source comparison

| Screen | Source | Comparison result |
|---|---|---|

| AcademicProgressScreen | `lib/features/academic/presentation/screens/academic_progress_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ActionPlanScreen | `lib/features/academic/presentation/screens/action_plan_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| AttendanceScreen | `lib/features/academic/presentation/screens/attendance_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| CoursesScreen | `lib/features/academic/presentation/screens/courses_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| DailyScheduleScreen | `lib/features/academic/presentation/screens/daily_schedule_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ExamScheduleScreen | `lib/features/academic/presentation/screens/exam_schedule_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| GradesScreen | `lib/features/academic/presentation/screens/grades_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ManageGroupsScreen | `lib/features/academic/presentation/screens/manage_groups_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ManageTasScreen | `lib/features/academic/presentation/screens/manage_tas_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ProfessorChatScreen | `lib/features/academic/presentation/screens/professor_chat_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ProfessorDashboardScreen | `lib/features/academic/presentation/screens/professor_dashboard_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ProfessorProfileScreen | `lib/features/academic/presentation/screens/professor_profile_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| SpecializationProjectsScreen | `lib/features/academic/presentation/screens/specialization_projects_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| SubjectResultsScreen | `lib/features/academic/presentation/screens/subject_results_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| TranscriptScreen | `lib/features/academic/presentation/screens/transcript_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| AccessPendingScreen | `lib/features/auth/presentation/screens/access_pending_screen.dart` | Current-only feature; no historical counterpart; retained secure implementation |
| ForgotPasswordScreen | `lib/features/auth/presentation/screens/forgot_password_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| GuestRegistrationScreen | `lib/features/auth/presentation/screens/guest_registration_screen.dart` | Current-only feature; no historical counterpart; retained secure implementation |
| LoginScreen | `lib/features/auth/presentation/screens/login_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| CollegePortalScreen | `lib/features/colleges/presentation/screens/college_portal_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| AdvisorApprovalScreen | `lib/features/enrollment/presentation/screens/advisor_approval_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| DeanAdvisorAssignmentScreen | `lib/features/enrollment/presentation/screens/dean_advisor_assignment_screen.dart` | Compared directly with PRE_EDIT; byte-for-byte restored |
| InvoicesScreen | `lib/features/enrollment/presentation/screens/invoices_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| PaymentScreen | `lib/features/enrollment/presentation/screens/payment_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| RegistrationScreen | `lib/features/enrollment/presentation/screens/registration_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| CreatePostScreen | `lib/features/feed/presentation/screens/create_post_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| FeedScreen | `lib/features/feed/presentation/screens/feed_screen.dart` | Compared directly with PRE_EDIT; byte-for-byte restored |
| ControlDashboardScreen | `lib/features/home/presentation/screens/control_dashboard_screen.dart` | Current-only feature; no historical counterpart; retained secure implementation |
| HomeScreen | `lib/features/home/presentation/screens/home_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ConversationListScreen | `lib/features/messaging/presentation/screens/conversation_list_screen.dart` | Current-only feature; no historical counterpart; retained secure implementation |
| ConversationThreadScreen | `lib/features/messaging/presentation/screens/conversation_thread_screen.dart` | Current-only feature; no historical counterpart; retained secure implementation |
| AcademicStaffScreen | `lib/features/onboarding/presentation/screens/academic_staff_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| CollegeDepartmentsScreen | `lib/features/onboarding/presentation/screens/college_departments_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| CollegeDetailsScreen | `lib/features/onboarding/presentation/screens/college_details_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| CollegesScreen | `lib/features/onboarding/presentation/screens/colleges_screen.dart` | Compared directly with PRE_EDIT; byte-for-byte restored |
| DepartmentDetailScreen | `lib/features/onboarding/presentation/screens/department_detail_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| LanguageScreen | `lib/features/onboarding/presentation/screens/language_screen.dart` | Compared directly with PRE_EDIT; byte-for-byte restored |
| StaffRatingDetailScreen | `lib/features/onboarding/presentation/screens/staff_rating_detail_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| StyleScreen | `lib/features/onboarding/presentation/screens/style_screen.dart` | Compared directly with PRE_EDIT; byte-for-byte restored |
| SubmitRatingScreen | `lib/features/onboarding/presentation/screens/submit_rating_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ThemeScreen | `lib/features/onboarding/presentation/screens/theme_screen.dart` | Compared directly with PRE_EDIT; byte-for-byte restored |
| AboutScreen | `lib/features/settings/presentation/screens/about_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ChangePasswordScreen | `lib/features/settings/presentation/screens/change_password_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| PrivacyPolicyScreen | `lib/features/settings/presentation/screens/privacy_policy_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ProfileScreen | `lib/features/settings/presentation/screens/profile_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| SettingsScreen | `lib/features/settings/presentation/screens/settings_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| ForumsScreen | `lib/features/shared/presentation/screens/forums_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| NotificationsScreen | `lib/features/shared/presentation/screens/notifications_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| PlaceholderScreen | `lib/features/shared/presentation/screens/placeholder_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| SecurityScreen | `lib/features/shared/presentation/screens/security_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| SessionsScreen | `lib/features/shared/presentation/screens/sessions_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| SupportScreen | `lib/features/shared/presentation/screens/support_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| TransitionScreen | `lib/features/shared/presentation/screens/transition_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| TutorialsScreen | `lib/features/shared/presentation/screens/tutorials_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| SplashScreen | `lib/features/splash/presentation/screens/splash_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| DigitalIDScreen | `lib/features/students/presentation/screens/digital_id_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| DashboardScreen | `lib/features/students/presentation/screens/student_dashboard_screen.dart` | Compared directly with PRE_EDIT; old presentation with documented compatibility changes |
| WelcomeScreen | `lib/features/welcome/presentation/screens/welcome_screen.dart` | Compared directly with PRE_EDIT; byte-for-byte restored |

## Files restored exactly


- `lib/core/app/horus_app.dart`
- `lib/core/router/routes/enrollment_routes.dart`
- `lib/core/router/routes/feed_routes.dart`
- `lib/core/router/routes/settings_routes.dart`
- `lib/core/theme/app_spacing.dart`
- `lib/core/theme/app_text_styles.dart`
- `lib/core/theme/app_theme.dart`
- `lib/core/theme/style_provider.dart`
- `lib/core/theme/style_provider.g.dart`
- `lib/core/theme/theme_provider.dart`
- `lib/core/theme/theme_provider.g.dart`
- `lib/features/academic/presentation/screens/exam_card.dart`
- `lib/features/academic/presentation/screens/exam_countdown.dart`
- `lib/features/academic/presentation/screens/exam_date_scroller.dart`
- `lib/features/academic/presentation/screens/professor_dashboard_announcements.dart`
- `lib/features/academic/presentation/screens/professor_dashboard_header.dart`
- `lib/features/academic/presentation/screens/professor_profile_announcements.dart`
- `lib/features/academic/presentation/screens/professor_profile_groups_files.dart`
- `lib/features/academic/presentation/screens/subject_layout_switcher.dart`
- `lib/features/academic/presentation/screens/subject_minimal_layout.dart`
- `lib/features/academic/presentation/screens/subject_scroller.dart`
- `lib/features/colleges/presentation/screens/college_portal_departments.dart`
- `lib/features/enrollment/presentation/screens/dean_advisor_assignment_screen.dart`
- `lib/features/enrollment/presentation/screens/invoice_actions_widgets.dart`
- `lib/features/enrollment/presentation/screens/invoice_list_widgets.dart`
- `lib/features/enrollment/presentation/screens/invoice_state_widgets.dart`
- `lib/features/enrollment/presentation/screens/registration_course_sections.dart`
- `lib/features/enrollment/presentation/screens/registration_schedule_sections.dart`
- `lib/features/enrollment/presentation/screens/registration_status_sections.dart`
- `lib/features/feed/presentation/screens/create_post_author_widgets.dart`
- `lib/features/feed/presentation/screens/create_post_content_widgets.dart`
- `lib/features/feed/presentation/screens/create_post_toolbar_widgets.dart`
- `lib/features/feed/presentation/screens/feed_comment_widgets.dart`
- `lib/features/feed/presentation/screens/feed_post_card.dart`
- `lib/features/feed/presentation/screens/feed_post_options.dart`
- `lib/features/feed/presentation/screens/feed_screen.dart`
- `lib/features/feed/presentation/widgets/full_screen_gallery.dart`
- `lib/features/feed/presentation/widgets/link_preview_widget.dart`
- `lib/features/feed/presentation/widgets/media_grid.dart`
- `lib/features/feed/presentation/widgets/video_feed_item.dart`
- `lib/features/onboarding/presentation/screens/college_details_painter.dart`
- `lib/features/onboarding/presentation/screens/colleges_screen.dart`
- `lib/features/onboarding/presentation/screens/language_screen.dart`
- `lib/features/onboarding/presentation/screens/style_screen.dart`
- `lib/features/onboarding/presentation/screens/theme_screen.dart`
- `lib/features/settings/presentation/screens/profile_editing_sections.dart`
- `lib/features/settings/presentation/screens/profile_fields.dart`
- `lib/features/settings/presentation/screens/settings_screen_dialogs.dart`
- `lib/features/settings/presentation/screens/settings_screen_items.dart`
- `lib/features/settings/presentation/screens/settings_screen_painter.dart`
- `lib/features/settings/presentation/screens/settings_screen_sections.dart`
- `lib/features/shared/presentation/widgets/animated_mesh_background.dart`
- `lib/features/shared/presentation/widgets/dashboard_action_widgets.dart`
- `lib/features/shared/presentation/widgets/glass_app_bar.dart`
- `lib/features/shared/presentation/widgets/glass_container.dart`
- `lib/features/shared/presentation/widgets/glass_scaffold.dart`
- `lib/features/shared/presentation/widgets/horus_empty_state.dart`
- `lib/features/shared/presentation/widgets/liquid_background.dart`
- `lib/features/shared/presentation/widgets/liquid_toast_overlay.dart`
- `lib/features/shared/presentation/widgets/premium_success_overlay.dart`
- `lib/features/students/presentation/screens/digital_id_card_back.dart`
- `lib/features/students/presentation/screens/digital_id_card_interaction.dart`
- `lib/features/students/presentation/screens/digital_id_card_patterns.dart`
- `lib/features/students/presentation/screens/student_dashboard_academic_sections.dart`
- `lib/features/students/presentation/screens/student_dashboard_action_sections.dart`
- `lib/features/students/presentation/screens/student_dashboard_list_sections.dart`
- `lib/features/welcome/presentation/screens/welcome_screen.dart`
- `lib/shared/widgets/app_badge.dart`
- `lib/shared/widgets/app_progress_bar.dart`
- `lib/shared/widgets/app_section_header.dart`
- `lib/shared/widgets/app_skeleton.dart`
- `lib/shared/widgets/app_text_field.dart`
- `lib/shared/widgets/live_alert_banner.dart`
- `lib/shared/widgets/press_feedback.dart`
- `lib/features/students/data/digital_id_theme_repository.dart`
- `lib/features/students/domain/models/digital_id_theme.dart`

## Files manually adapted / compatibility retained


- `lib/core/router/app_router.dart`
- `lib/core/router/route_guard.dart`
- `lib/core/router/routes/academic_routes.dart`
- `lib/core/router/routes/auth_routes.dart`
- `lib/core/router/routes/home_routes.dart`
- `lib/core/router/routes/onboarding_routes.dart`
- `lib/core/router/routes/shared_routes.dart`
- `lib/core/theme/app_animations.dart`
- `lib/core/theme/app_colors.dart`
- `lib/core/theme/low_performance_provider.dart`
- `lib/core/theme/low_performance_provider.g.dart`
- `lib/features/academic/presentation/screens/academic_progress_screen.dart`
- `lib/features/academic/presentation/screens/action_plan_screen.dart`
- `lib/features/academic/presentation/screens/attendance_screen.dart`
- `lib/features/academic/presentation/screens/courses_screen.dart`
- `lib/features/academic/presentation/screens/daily_schedule_screen.dart`
- `lib/features/academic/presentation/screens/exam_schedule_screen.dart`
- `lib/features/academic/presentation/screens/grades_screen.dart`
- `lib/features/academic/presentation/screens/manage_groups_screen.dart`
- `lib/features/academic/presentation/screens/manage_tas_screen.dart`
- `lib/features/academic/presentation/screens/professor_chat_screen.dart`
- `lib/features/academic/presentation/screens/professor_dashboard_actions.dart`
- `lib/features/academic/presentation/screens/professor_dashboard_groups.dart`
- `lib/features/academic/presentation/screens/professor_dashboard_management.dart`
- `lib/features/academic/presentation/screens/professor_dashboard_screen.dart`
- `lib/features/academic/presentation/screens/professor_profile_header.dart`
- `lib/features/academic/presentation/screens/professor_profile_screen.dart`
- `lib/features/academic/presentation/screens/specialization_projects_screen.dart`
- `lib/features/academic/presentation/screens/subject_analytical_layout.dart`
- `lib/features/academic/presentation/screens/subject_immersive_layout.dart`
- `lib/features/academic/presentation/screens/subject_result_components.dart`
- `lib/features/academic/presentation/screens/subject_results_screen.dart`
- `lib/features/academic/presentation/screens/transcript_screen.dart`
- `lib/features/auth/presentation/screens/forgot_password_screen.dart`
- `lib/features/auth/presentation/screens/login_screen.dart`
- `lib/features/colleges/presentation/screens/college_portal_overview.dart`
- `lib/features/colleges/presentation/screens/college_portal_screen.dart`
- `lib/features/colleges/presentation/screens/college_portal_staff_sections.dart`
- `lib/features/enrollment/presentation/screens/advisor_approval_screen.dart`
- `lib/features/enrollment/presentation/screens/invoice_card_widget.dart`
- `lib/features/enrollment/presentation/screens/invoice_summary_widgets.dart`
- `lib/features/enrollment/presentation/screens/invoices_screen.dart`
- `lib/features/enrollment/presentation/screens/payment_screen.dart`
- `lib/features/enrollment/presentation/screens/registration_confirmation_sections.dart`
- `lib/features/enrollment/presentation/screens/registration_screen.dart`
- `lib/features/feed/presentation/screens/create_post_screen.dart`
- `lib/features/feed/presentation/screens/feed_comments.dart`
- `lib/features/home/presentation/screens/home_screen.dart`
- `lib/features/onboarding/presentation/screens/academic_staff_screen.dart`
- `lib/features/onboarding/presentation/screens/college_departments_screen.dart`
- `lib/features/onboarding/presentation/screens/college_details_screen.dart`
- `lib/features/onboarding/presentation/screens/college_details_sections.dart`
- `lib/features/onboarding/presentation/screens/department_detail_screen.dart`
- `lib/features/onboarding/presentation/screens/staff_rating_detail_screen.dart`
- `lib/features/onboarding/presentation/screens/submit_rating_screen.dart`
- `lib/features/settings/presentation/screens/about_screen.dart`
- `lib/features/settings/presentation/screens/change_password_screen.dart`
- `lib/features/settings/presentation/screens/privacy_policy_screen.dart`
- `lib/features/settings/presentation/screens/profile_display_sections.dart`
- `lib/features/settings/presentation/screens/profile_screen.dart`
- `lib/features/settings/presentation/screens/settings_screen.dart`
- `lib/features/settings/presentation/screens/settings_screen_preferences.dart`
- `lib/features/shared/presentation/screens/forums_screen.dart`
- `lib/features/shared/presentation/screens/notifications_screen.dart`
- `lib/features/shared/presentation/screens/placeholder_screen.dart`
- `lib/features/shared/presentation/screens/security_screen.dart`
- `lib/features/shared/presentation/screens/sessions_screen.dart`
- `lib/features/shared/presentation/screens/support_screen.dart`
- `lib/features/shared/presentation/screens/transition_screen.dart`
- `lib/features/shared/presentation/screens/tutorials_screen.dart`
- `lib/features/splash/presentation/screens/splash_screen.dart`
- `lib/features/students/presentation/screens/digital_id_card_front.dart`
- `lib/features/students/presentation/screens/digital_id_screen.dart`
- `lib/features/students/presentation/screens/digital_id_screen_sections.dart`
- `lib/features/students/presentation/screens/student_dashboard_id_section.dart`
- `lib/features/students/presentation/screens/student_dashboard_screen.dart`
- `lib/shared/widgets/app_button.dart`
- `lib/shared/widgets/app_card.dart`
- `lib/main.dart`
- `lib/features/academic/data/repositories/professor_repository.dart`
- `lib/core/constants/colleges_data.dart`
- `lib/core/constants/college_catalog.dart`
- `lib/core/utils/responsive_helper.dart`
- `lib/core/error/error_handler.dart`

## Current-only features/helpers preserved


- `lib/core/theme/app_layout.dart`
- `lib/features/academic/presentation/widgets/course_file_upload_dialog.dart`
- `lib/features/auth/presentation/screens/access_pending_screen.dart`
- `lib/features/auth/presentation/screens/guest_registration_screen.dart`
- `lib/features/colleges/presentation/widgets/college_staff_panel.dart`
- `lib/features/home/presentation/screens/control_dashboard_screen.dart`
- `lib/features/messaging/presentation/screens/conversation_list_screen.dart`
- `lib/features/messaging/presentation/screens/conversation_thread_screen.dart`
- `lib/features/students/presentation/widgets/horus_identity_card.dart`
- `lib/shared/layout/horus_adaptive_scaffold.dart`
- `lib/shared/layout/horus_destination.dart`
- `lib/shared/layout/horus_page_body.dart`
- `lib/shared/widgets/horus_entrance.dart`
- `lib/shared/widgets/horus_error_state.dart`
- `lib/features/academic/presentation/legacy_academic_view_data.dart`
- `lib/features/colleges/presentation/legacy_college_data.dart`
- `lib/core/router/back_navigation.dart`

## Historical files intentionally not restored

All historical UI Dart files in the inventory are present. Old repositories, database models, auth controllers, SQL, migrations, RLS/RBAC/storage implementation, private API behavior and database tests were not restored because the starting secure contracts are authoritative. Old mock academic/staff/chat/payment data and simulated recovery/upload/review success were not restored. The unreferenced historical HUE video was not restored.

## Git state and commits

No push was performed. Logical restoration commits and final status are recorded below after final validation.

Final branch: `restore-ui-pre-edit-safe`. Final working tree: clean after the documentation/test commit. No push.

Implementation commits:

```text
4039cae restore(ui): restore pre-EDIT UI foundations
e4bac5d restore(ui): restore authentication and mobile navigation
71e21b4 restore(ui): restore feed and academic screens
033eb7a restore(ui): restore profile digital-id and settings
0b87d93 fix(ui): restore offline fonts and secure data compatibility
bfaf5f2 fix(ui): preserve guarded back navigation for direct links
```

Final documentation/test commit: `HEAD`, message `test(ui): align tests and document pre-EDIT restoration` (this report is part of that commit). It includes the updated tests, redacted validation evidence and OFL whitespace normalization.

The restored Web Release remains available at `http://127.0.0.1:8082`, using the local Supabase API. The historical comparison renderer at port 8083 is isolated; it is not the current project.

Browser verification of the final direct Digital ID link confirms Back reaches guarded `/home` without new page errors. See [back verification](ui-restoration/evidence/back-navigation-verification.txt).

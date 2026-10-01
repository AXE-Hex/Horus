# Exact historical reference

commit b6b8a4c373ad04e52496cb963454023435e318a6
Author:     AXE <axe.hex.pr@gmail.com>
AuthorDate: Thu Oct 1 01:26:11 2026 +0300
Commit:     AXE <axe.hex.pr@gmail.com>
CommitDate: Thu Oct 1 01:26:11 2026 +0300

    EDIT UI

Parent: `d67200601ffcd0660a73dfde6934e4a28bd348ad`.

## Files changed by EDIT UI

```text
M	analysis_options.yaml
M	android/gradle.properties
D	assets/Video/HUE.mp4
M	assets/translations/ar.i18n.json
M	assets/translations/de.i18n.json
M	assets/translations/en.i18n.json
M	assets/translations/zh.i18n.json
M	docs/DATABASE_CONTRACT.md
A	docs/DATABASE_INVENTORY.md
A	docs/DATABASE_SECURITY_AUDIT.md
A	docs/DATABASE_VALIDATION.md
A	docs/DESIGN_SYSTEM_IMPLEMENTATION.md
A	docs/DEVELOPMENT_ACCOUNTS.md
A	docs/FULL_REDESIGN_SECURITY_DATA_AUDIT.md
M	docs/RLS_MATRIX.md
M	docs/STORAGE_ACCESS.md
M	lib/core/auth/auth_provider.dart
M	lib/core/auth/auth_provider.g.dart
M	lib/core/auth/role_extensions.dart
D	lib/core/auth/role_registry.dart
M	lib/core/auth/roles.dart
M	lib/core/config/env_config.dart
M	lib/core/constants/college_catalog.dart
M	lib/core/constants/colleges_data.dart
M	lib/core/data/base_repository.dart
M	lib/core/error/error_handler.dart
A	lib/core/i18n/locale_preferences.dart
M	lib/core/i18n/strings.g.dart
M	lib/core/i18n/strings_ar.g.dart
M	lib/core/i18n/strings_de.g.dart
M	lib/core/i18n/strings_en.g.dart
M	lib/core/i18n/strings_zh.g.dart
M	lib/core/router/app_router.dart
M	lib/core/router/route_guard.dart
M	lib/core/router/routes/academic_routes.dart
M	lib/core/router/routes/auth_routes.dart
M	lib/core/router/routes/home_routes.dart
M	lib/core/router/routes/onboarding_routes.dart
M	lib/core/theme/app_animations.dart
M	lib/core/theme/app_colors.dart
A	lib/core/theme/app_layout.dart
A	lib/core/theme/app_shadows.dart
M	lib/core/theme/app_spacing.dart
M	lib/core/theme/app_text_styles.dart
M	lib/core/theme/app_theme.dart
M	lib/core/theme/low_performance_provider.dart
M	lib/core/theme/low_performance_provider.g.dart
D	lib/core/theme/style_provider.dart
D	lib/core/theme/style_provider.g.dart
M	lib/core/utils/responsive_helper.dart
M	lib/features/academic/data/models/academic_records.dart
M	lib/features/academic/data/models/professor_profile_models.dart
M	lib/features/academic/data/repositories/academic_repository.dart
M	lib/features/academic/data/repositories/professor_repository.dart
A	lib/features/academic/presentation/providers/course_catalog_provider.dart
M	lib/features/academic/presentation/providers/semester_provider.dart
A	lib/features/academic/presentation/providers/student_attendance_provider.dart
A	lib/features/academic/presentation/providers/student_grades_provider.dart
M	lib/features/academic/presentation/screens/academic_progress_screen.dart
M	lib/features/academic/presentation/screens/action_plan_screen.dart
M	lib/features/academic/presentation/screens/attendance_screen.dart
M	lib/features/academic/presentation/screens/courses_screen.dart
M	lib/features/academic/presentation/screens/daily_schedule_screen.dart
M	lib/features/academic/presentation/screens/exam_card.dart
M	lib/features/academic/presentation/screens/exam_countdown.dart
M	lib/features/academic/presentation/screens/exam_date_scroller.dart
M	lib/features/academic/presentation/screens/exam_schedule_screen.dart
M	lib/features/academic/presentation/screens/grades_screen.dart
M	lib/features/academic/presentation/screens/manage_groups_screen.dart
M	lib/features/academic/presentation/screens/manage_tas_screen.dart
M	lib/features/academic/presentation/screens/professor_chat_screen.dart
M	lib/features/academic/presentation/screens/professor_dashboard_actions.dart
M	lib/features/academic/presentation/screens/professor_dashboard_announcements.dart
M	lib/features/academic/presentation/screens/professor_dashboard_groups.dart
M	lib/features/academic/presentation/screens/professor_dashboard_header.dart
M	lib/features/academic/presentation/screens/professor_dashboard_management.dart
M	lib/features/academic/presentation/screens/professor_dashboard_screen.dart
M	lib/features/academic/presentation/screens/professor_profile_announcements.dart
M	lib/features/academic/presentation/screens/professor_profile_groups_files.dart
M	lib/features/academic/presentation/screens/professor_profile_header.dart
M	lib/features/academic/presentation/screens/professor_profile_screen.dart
M	lib/features/academic/presentation/screens/specialization_projects_screen.dart
D	lib/features/academic/presentation/screens/subject_analytical_layout.dart
D	lib/features/academic/presentation/screens/subject_immersive_layout.dart
D	lib/features/academic/presentation/screens/subject_layout_switcher.dart
D	lib/features/academic/presentation/screens/subject_minimal_layout.dart
D	lib/features/academic/presentation/screens/subject_result_components.dart
M	lib/features/academic/presentation/screens/subject_results_screen.dart
D	lib/features/academic/presentation/screens/subject_scroller.dart
M	lib/features/academic/presentation/screens/transcript_screen.dart
A	lib/features/academic/presentation/widgets/course_file_upload_dialog.dart
A	lib/features/auth/presentation/screens/access_pending_screen.dart
M	lib/features/auth/presentation/screens/forgot_password_screen.dart
A	lib/features/auth/presentation/screens/guest_registration_screen.dart
M	lib/features/auth/presentation/screens/login_screen.dart
M	lib/features/colleges/presentation/screens/college_portal_departments.dart
M	lib/features/colleges/presentation/screens/college_portal_overview.dart
M	lib/features/colleges/presentation/screens/college_portal_screen.dart
M	lib/features/colleges/presentation/screens/college_portal_staff_sections.dart
A	lib/features/colleges/presentation/widgets/college_staff_panel.dart
M	lib/features/enrollment/data/models/invoice_models.dart
M	lib/features/enrollment/data/repositories/advisor_repository.dart
M	lib/features/enrollment/data/repositories/enrollment_repository.dart
M	lib/features/enrollment/data/repositories/registration_repository.dart
M	lib/features/enrollment/presentation/screens/advisor_approval_screen.dart
M	lib/features/enrollment/presentation/screens/dean_advisor_assignment_screen.dart
M	lib/features/enrollment/presentation/screens/invoice_actions_widgets.dart
M	lib/features/enrollment/presentation/screens/invoice_card_widget.dart
M	lib/features/enrollment/presentation/screens/invoice_state_widgets.dart
M	lib/features/enrollment/presentation/screens/invoice_summary_widgets.dart
M	lib/features/enrollment/presentation/screens/invoices_screen.dart
M	lib/features/enrollment/presentation/screens/payment_screen.dart
M	lib/features/enrollment/presentation/screens/registration_confirmation_sections.dart
M	lib/features/enrollment/presentation/screens/registration_course_sections.dart
M	lib/features/enrollment/presentation/screens/registration_schedule_sections.dart
M	lib/features/enrollment/presentation/screens/registration_screen.dart
M	lib/features/enrollment/presentation/screens/registration_status_sections.dart
M	lib/features/feed/data/repositories/post_repository.dart
M	lib/features/feed/presentation/screens/create_post_author_widgets.dart
M	lib/features/feed/presentation/screens/create_post_content_widgets.dart
M	lib/features/feed/presentation/screens/create_post_screen.dart
M	lib/features/feed/presentation/screens/create_post_toolbar_widgets.dart
M	lib/features/feed/presentation/screens/feed_comment_widgets.dart
M	lib/features/feed/presentation/screens/feed_comments.dart
M	lib/features/feed/presentation/screens/feed_post_card.dart
M	lib/features/feed/presentation/screens/feed_post_options.dart
M	lib/features/feed/presentation/screens/feed_screen.dart
M	lib/features/feed/presentation/widgets/link_preview_widget.dart
A	lib/features/home/presentation/screens/control_dashboard_screen.dart
M	lib/features/home/presentation/screens/home_screen.dart
M	lib/features/institutional/data/repositories/institutional_repository.dart
M	lib/features/onboarding/presentation/screens/academic_staff_screen.dart
M	lib/features/onboarding/presentation/screens/college_departments_screen.dart
D	lib/features/onboarding/presentation/screens/college_details_painter.dart
M	lib/features/onboarding/presentation/screens/college_details_screen.dart
M	lib/features/onboarding/presentation/screens/college_details_sections.dart
M	lib/features/onboarding/presentation/screens/colleges_screen.dart
M	lib/features/onboarding/presentation/screens/department_detail_screen.dart
D	lib/features/onboarding/presentation/screens/language_screen.dart
M	lib/features/onboarding/presentation/screens/staff_rating_detail_screen.dart
D	lib/features/onboarding/presentation/screens/style_screen.dart
M	lib/features/onboarding/presentation/screens/submit_rating_screen.dart
D	lib/features/onboarding/presentation/screens/theme_screen.dart
M	lib/features/profiles/data/repositories/profile_directory_repository.dart
M	lib/features/settings/presentation/screens/about_screen.dart
M	lib/features/settings/presentation/screens/change_password_screen.dart
M	lib/features/settings/presentation/screens/privacy_policy_screen.dart
M	lib/features/settings/presentation/screens/profile_display_sections.dart
M	lib/features/settings/presentation/screens/profile_editing_sections.dart
M	lib/features/settings/presentation/screens/profile_fields.dart
M	lib/features/settings/presentation/screens/profile_screen.dart
M	lib/features/settings/presentation/screens/settings_screen.dart
M	lib/features/settings/presentation/screens/settings_screen_dialogs.dart
M	lib/features/settings/presentation/screens/settings_screen_items.dart
M	lib/features/settings/presentation/screens/settings_screen_preferences.dart
M	lib/features/settings/presentation/screens/settings_screen_sections.dart
M	lib/features/shared/data/notification_provider.dart
M	lib/features/shared/data/repositories/shared_repository.dart
A	lib/features/shared/data/shared_data_providers.dart
M	lib/features/shared/presentation/screens/forums_screen.dart
M	lib/features/shared/presentation/screens/notifications_screen.dart
D	lib/features/shared/presentation/screens/placeholder_screen.dart
M	lib/features/shared/presentation/screens/security_screen.dart
M	lib/features/shared/presentation/screens/sessions_screen.dart
M	lib/features/shared/presentation/screens/support_screen.dart
M	lib/features/shared/presentation/screens/transition_screen.dart
M	lib/features/shared/presentation/screens/tutorials_screen.dart
M	lib/features/shared/presentation/widgets/animated_mesh_background.dart
M	lib/features/shared/presentation/widgets/dashboard_action_widgets.dart
M	lib/features/shared/presentation/widgets/glass_app_bar.dart
M	lib/features/shared/presentation/widgets/glass_container.dart
M	lib/features/shared/presentation/widgets/horus_empty_state.dart
D	lib/features/shared/presentation/widgets/liquid_background.dart
M	lib/features/shared/presentation/widgets/liquid_toast_overlay.dart
M	lib/features/shared/presentation/widgets/premium_success_overlay.dart
M	lib/features/splash/presentation/screens/splash_screen.dart
D	lib/features/students/data/digital_id_theme_repository.dart
D	lib/features/students/domain/models/digital_id_theme.dart
D	lib/features/students/presentation/screens/digital_id_card_back.dart
D	lib/features/students/presentation/screens/digital_id_card_front.dart
D	lib/features/students/presentation/screens/digital_id_card_interaction.dart
D	lib/features/students/presentation/screens/digital_id_card_patterns.dart
M	lib/features/students/presentation/screens/digital_id_screen.dart
D	lib/features/students/presentation/screens/digital_id_screen_sections.dart
M	lib/features/students/presentation/screens/student_dashboard_action_sections.dart
M	lib/features/students/presentation/screens/student_dashboard_id_section.dart
M	lib/features/students/presentation/screens/student_dashboard_list_sections.dart
M	lib/features/students/presentation/screens/student_dashboard_screen.dart
A	lib/features/students/presentation/widgets/horus_identity_card.dart
M	lib/features/welcome/presentation/screens/welcome_screen.dart
M	lib/main.dart
A	lib/shared/layout/horus_adaptive_scaffold.dart
A	lib/shared/layout/horus_app_shell.dart
A	lib/shared/layout/horus_destination.dart
A	lib/shared/layout/horus_page_body.dart
M	lib/shared/widgets/app_badge.dart
M	lib/shared/widgets/app_button.dart
M	lib/shared/widgets/app_card.dart
M	lib/shared/widgets/app_progress_bar.dart
M	lib/shared/widgets/app_skeleton.dart
M	lib/shared/widgets/app_text_field.dart
A	lib/shared/widgets/horus_entrance.dart
A	lib/shared/widgets/horus_error_state.dart
M	lib/shared/widgets/live_alert_banner.dart
M	lib/shared/widgets/press_feedback.dart
M	macos/Runner/DebugProfile.entitlements
M	macos/Runner/Release.entitlements
M	pubspec.lock
M	pubspec.yaml
A	scripts/database/catalog.sql
A	scripts/database/index_audit.sql
A	scripts/database/integrity_audit.sql
A	scripts/database/performance_audit.sql
A	scripts/database/render_inventory.py
A	scripts/database/storage_api_test.py
A	scripts/database/validate_constraints.sql
A	scripts/database/verify_development_accounts.py
M	supabase/README.md
D	supabase/all_migrations.sql
M	supabase/config.toml
A	supabase/migrations/20260929192617_secure_guest_signup_and_permissions.sql
A	supabase/migrations/20260929205234_complete_database_hardening.sql
A	supabase/migrations/20260929205453_require_academic_permissions_for_owned_records.sql
A	supabase/seed.sql
D	supabase/seeds/001_seed.sql
A	supabase/tests/complete_hardening.test.sql
A	supabase/tests/guest_access_regressions.test.sql
M	supabase/tests/phase3_profile_security.test.sql
M	supabase/tests/phase4_rls_authorization.test.sql
A	supabase/tests/storage_hardening.test.sql
M	test/core/auth/authorization_test.dart
A	test/core/config/env_config_test.dart
M	test/core/data/db_row_model_test.dart
M	test/core/i18n/device_locale_test.dart
M	test/core/router/route_guard_test.dart
A	test/core/theme/app_theme_test.dart
A	test/core/utils/responsive_helper_test.dart
M	test/features/academic/academic_summary_test.dart
A	test/features/auth/login_screen_test.dart
A	test/features/auth/startup_identity_test.dart
A	test/features/enrollment/data/models/invoice_model_test.dart
M	test/features/shared/data/models/audit_typed_records_test.dart
A	test/no_runtime_sample_data_test.dart
A	test/shared/widgets/app_button_test.dart
```

## UI files present at the parent

```text
lib/core/app/horus_app.dart
lib/core/router/app_router.dart
lib/core/router/route_guard.dart
lib/core/router/routes/academic_routes.dart
lib/core/router/routes/auth_routes.dart
lib/core/router/routes/enrollment_routes.dart
lib/core/router/routes/feed_routes.dart
lib/core/router/routes/home_routes.dart
lib/core/router/routes/onboarding_routes.dart
lib/core/router/routes/settings_routes.dart
lib/core/router/routes/shared_routes.dart
lib/core/theme/app_animations.dart
lib/core/theme/app_colors.dart
lib/core/theme/app_spacing.dart
lib/core/theme/app_text_styles.dart
lib/core/theme/app_theme.dart
lib/core/theme/low_performance_provider.dart
lib/core/theme/low_performance_provider.g.dart
lib/core/theme/style_provider.dart
lib/core/theme/style_provider.g.dart
lib/core/theme/theme_provider.dart
lib/core/theme/theme_provider.g.dart
lib/features/academic/presentation/screens/academic_progress_screen.dart
lib/features/academic/presentation/screens/action_plan_screen.dart
lib/features/academic/presentation/screens/attendance_screen.dart
lib/features/academic/presentation/screens/courses_screen.dart
lib/features/academic/presentation/screens/daily_schedule_screen.dart
lib/features/academic/presentation/screens/exam_card.dart
lib/features/academic/presentation/screens/exam_countdown.dart
lib/features/academic/presentation/screens/exam_date_scroller.dart
lib/features/academic/presentation/screens/exam_schedule_screen.dart
lib/features/academic/presentation/screens/grades_screen.dart
lib/features/academic/presentation/screens/manage_groups_screen.dart
lib/features/academic/presentation/screens/manage_tas_screen.dart
lib/features/academic/presentation/screens/professor_chat_screen.dart
lib/features/academic/presentation/screens/professor_dashboard_actions.dart
lib/features/academic/presentation/screens/professor_dashboard_announcements.dart
lib/features/academic/presentation/screens/professor_dashboard_groups.dart
lib/features/academic/presentation/screens/professor_dashboard_header.dart
lib/features/academic/presentation/screens/professor_dashboard_management.dart
lib/features/academic/presentation/screens/professor_dashboard_screen.dart
lib/features/academic/presentation/screens/professor_profile_announcements.dart
lib/features/academic/presentation/screens/professor_profile_groups_files.dart
lib/features/academic/presentation/screens/professor_profile_header.dart
lib/features/academic/presentation/screens/professor_profile_screen.dart
lib/features/academic/presentation/screens/specialization_projects_screen.dart
lib/features/academic/presentation/screens/subject_analytical_layout.dart
lib/features/academic/presentation/screens/subject_immersive_layout.dart
lib/features/academic/presentation/screens/subject_layout_switcher.dart
lib/features/academic/presentation/screens/subject_minimal_layout.dart
lib/features/academic/presentation/screens/subject_result_components.dart
lib/features/academic/presentation/screens/subject_results_screen.dart
lib/features/academic/presentation/screens/subject_scroller.dart
lib/features/academic/presentation/screens/transcript_screen.dart
lib/features/auth/presentation/screens/forgot_password_screen.dart
lib/features/auth/presentation/screens/login_screen.dart
lib/features/colleges/presentation/screens/college_portal_departments.dart
lib/features/colleges/presentation/screens/college_portal_overview.dart
lib/features/colleges/presentation/screens/college_portal_screen.dart
lib/features/colleges/presentation/screens/college_portal_staff_sections.dart
lib/features/enrollment/presentation/screens/advisor_approval_screen.dart
lib/features/enrollment/presentation/screens/dean_advisor_assignment_screen.dart
lib/features/enrollment/presentation/screens/invoice_actions_widgets.dart
lib/features/enrollment/presentation/screens/invoice_card_widget.dart
lib/features/enrollment/presentation/screens/invoice_list_widgets.dart
lib/features/enrollment/presentation/screens/invoice_state_widgets.dart
lib/features/enrollment/presentation/screens/invoice_summary_widgets.dart
lib/features/enrollment/presentation/screens/invoices_screen.dart
lib/features/enrollment/presentation/screens/payment_screen.dart
lib/features/enrollment/presentation/screens/registration_confirmation_sections.dart
lib/features/enrollment/presentation/screens/registration_course_sections.dart
lib/features/enrollment/presentation/screens/registration_schedule_sections.dart
lib/features/enrollment/presentation/screens/registration_screen.dart
lib/features/enrollment/presentation/screens/registration_status_sections.dart
lib/features/feed/presentation/screens/create_post_author_widgets.dart
lib/features/feed/presentation/screens/create_post_content_widgets.dart
lib/features/feed/presentation/screens/create_post_screen.dart
lib/features/feed/presentation/screens/create_post_toolbar_widgets.dart
lib/features/feed/presentation/screens/feed_comment_widgets.dart
lib/features/feed/presentation/screens/feed_comments.dart
lib/features/feed/presentation/screens/feed_post_card.dart
lib/features/feed/presentation/screens/feed_post_options.dart
lib/features/feed/presentation/screens/feed_screen.dart
lib/features/feed/presentation/widgets/full_screen_gallery.dart
lib/features/feed/presentation/widgets/link_preview_widget.dart
lib/features/feed/presentation/widgets/media_grid.dart
lib/features/feed/presentation/widgets/video_feed_item.dart
lib/features/home/presentation/screens/home_screen.dart
lib/features/onboarding/presentation/screens/academic_staff_screen.dart
lib/features/onboarding/presentation/screens/college_departments_screen.dart
lib/features/onboarding/presentation/screens/college_details_painter.dart
lib/features/onboarding/presentation/screens/college_details_screen.dart
lib/features/onboarding/presentation/screens/college_details_sections.dart
lib/features/onboarding/presentation/screens/colleges_screen.dart
lib/features/onboarding/presentation/screens/department_detail_screen.dart
lib/features/onboarding/presentation/screens/language_screen.dart
lib/features/onboarding/presentation/screens/staff_rating_detail_screen.dart
lib/features/onboarding/presentation/screens/style_screen.dart
lib/features/onboarding/presentation/screens/submit_rating_screen.dart
lib/features/onboarding/presentation/screens/theme_screen.dart
lib/features/settings/presentation/screens/about_screen.dart
lib/features/settings/presentation/screens/change_password_screen.dart
lib/features/settings/presentation/screens/privacy_policy_screen.dart
lib/features/settings/presentation/screens/profile_display_sections.dart
lib/features/settings/presentation/screens/profile_editing_sections.dart
lib/features/settings/presentation/screens/profile_fields.dart
lib/features/settings/presentation/screens/profile_screen.dart
lib/features/settings/presentation/screens/settings_screen.dart
lib/features/settings/presentation/screens/settings_screen_dialogs.dart
lib/features/settings/presentation/screens/settings_screen_items.dart
lib/features/settings/presentation/screens/settings_screen_painter.dart
lib/features/settings/presentation/screens/settings_screen_preferences.dart
lib/features/settings/presentation/screens/settings_screen_sections.dart
lib/features/shared/presentation/screens/forums_screen.dart
lib/features/shared/presentation/screens/notifications_screen.dart
lib/features/shared/presentation/screens/placeholder_screen.dart
lib/features/shared/presentation/screens/security_screen.dart
lib/features/shared/presentation/screens/sessions_screen.dart
lib/features/shared/presentation/screens/support_screen.dart
lib/features/shared/presentation/screens/transition_screen.dart
lib/features/shared/presentation/screens/tutorials_screen.dart
lib/features/shared/presentation/widgets/animated_mesh_background.dart
lib/features/shared/presentation/widgets/dashboard_action_widgets.dart
lib/features/shared/presentation/widgets/glass_app_bar.dart
lib/features/shared/presentation/widgets/glass_container.dart
lib/features/shared/presentation/widgets/glass_scaffold.dart
lib/features/shared/presentation/widgets/horus_empty_state.dart
lib/features/shared/presentation/widgets/liquid_background.dart
lib/features/shared/presentation/widgets/liquid_toast_overlay.dart
lib/features/shared/presentation/widgets/premium_success_overlay.dart
lib/features/splash/presentation/screens/splash_screen.dart
lib/features/students/presentation/screens/digital_id_card_back.dart
lib/features/students/presentation/screens/digital_id_card_front.dart
lib/features/students/presentation/screens/digital_id_card_interaction.dart
lib/features/students/presentation/screens/digital_id_card_patterns.dart
lib/features/students/presentation/screens/digital_id_screen.dart
lib/features/students/presentation/screens/digital_id_screen_sections.dart
lib/features/students/presentation/screens/student_dashboard_academic_sections.dart
lib/features/students/presentation/screens/student_dashboard_action_sections.dart
lib/features/students/presentation/screens/student_dashboard_id_section.dart
lib/features/students/presentation/screens/student_dashboard_list_sections.dart
lib/features/students/presentation/screens/student_dashboard_screen.dart
lib/features/welcome/presentation/screens/welcome_screen.dart
lib/shared/widgets/app_badge.dart
lib/shared/widgets/app_button.dart
lib/shared/widgets/app_card.dart
lib/shared/widgets/app_progress_bar.dart
lib/shared/widgets/app_section_header.dart
lib/shared/widgets/app_skeleton.dart
lib/shared/widgets/app_text_field.dart
lib/shared/widgets/live_alert_banner.dart
lib/shared/widgets/press_feedback.dart
```

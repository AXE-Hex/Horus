# Pre-EDIT UI restoration inventory

Historical reference: `d67200601ffcd0660a73dfde6934e4a28bd348ad`. Starting commit: `22b783be1470ec2c69afaff3ad9902fab589379b`.

Compared the union of historical and current UI trees: 179 Dart files, including the narrow professor data boundary. Screen parts and presentation methods below enumerate dialogs, bottom sheets, forms, reusable components and states. No historical UI file remains missing.

Final classifications: BACKEND_COMPATIBILITY_REQUIRED: 84, EXACT_OLD: 76, NEW_UI: 17, REMOVED: 2.

`EXACT_OLD`: byte-for-byte equality with Git. `BACKEND_COMPATIBILITY_REQUIRED`: old UI with current secure contracts, truthful data, offline fonts, compatibility API additions, sanitized errors or narrowly required layout adjustments. `NEW_UI`: later secure feature/helper without a historical counterpart. `REMOVED`: unused redesign files removed. `PARTIALLY_RESTORED`/`MISSING` are initial classifications only. Read the restoration report for exact exceptions. The current college catalog removes fabricated dean/statistics records, the existing responsive utility supports later adaptive features, and the current error handler preserves sanitized errors.

| File | Initial | Final | Classes / components | Presentation methods / states |
|---|---|---|---|---|
| `lib/core/app/horus_app.dart` | EXACT_OLD | EXACT_OLD | HorusApp | build |
| `lib/core/router/app_router.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED |  |  |
| `lib/core/router/route_guard.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED |  |  |
| `lib/core/router/routes/academic_routes.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED |  |  |
| `lib/core/router/routes/auth_routes.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED |  |  |
| `lib/core/router/routes/enrollment_routes.dart` | EXACT_OLD | EXACT_OLD |  |  |
| `lib/core/router/routes/feed_routes.dart` | EXACT_OLD | EXACT_OLD |  |  |
| `lib/core/router/routes/home_routes.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED |  |  |
| `lib/core/router/routes/onboarding_routes.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED |  |  |
| `lib/core/router/routes/settings_routes.dart` | EXACT_OLD | EXACT_OLD |  |  |
| `lib/core/router/routes/shared_routes.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED |  |  |
| `lib/core/theme/app_animations.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | AppDurations, AppCurves, AppMotion |  |
| `lib/core/theme/app_colors.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | AppColors |  |
| `lib/core/theme/app_layout.dart` | NEW_UI | NEW_UI | AppLayout |  |
| `lib/core/theme/app_shadows.dart` | NEW_UI | REMOVED |  |  |
| `lib/core/theme/app_spacing.dart` | EXACT_OLD | EXACT_OLD | AppSpacing, AppRadius, AppBorders |  |
| `lib/core/theme/app_text_styles.dart` | EXACT_OLD | EXACT_OLD | AppTextStyles |  |
| `lib/core/theme/app_theme.dart` | EXACT_OLD | EXACT_OLD | AppTheme |  |
| `lib/core/theme/low_performance_provider.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | LowPerformanceController | _loadState, toggle |
| `lib/core/theme/low_performance_provider.g.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | LowPerformanceControllerProvider, _ | runBuild |
| `lib/core/theme/style_provider.dart` | MISSING | EXACT_OLD | AppStyle, StyleController | build, setStyle |
| `lib/core/theme/style_provider.g.dart` | MISSING | EXACT_OLD | StyleControllerProvider, _ | runBuild |
| `lib/core/theme/theme_provider.dart` | EXACT_OLD | EXACT_OLD | ThemeController | build, setTheme, toggleTheme |
| `lib/core/theme/theme_provider.g.dart` | EXACT_OLD | EXACT_OLD | ThemeControllerProvider, _ | runBuild |
| `lib/features/academic/presentation/screens/academic_progress_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | AcademicProgressScreen | build, _buildCompletionSection, _buildStatItem, _buildCategoryCard |
| `lib/features/academic/presentation/screens/action_plan_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ActionPlanScreen, _TimelineItem | build, _buildProgressHeader, build, _buildLine, _buildCard |
| `lib/features/academic/presentation/screens/attendance_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | AttendanceScreen, _AttendanceScreenState, _AttendanceGauge, _AttendanceCourseCard, _SparklinePainter | build, _buildAttendanceHeader, _buildStatDetail, build, build, paint |
| `lib/features/academic/presentation/screens/courses_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | CoursesScreen | build, _buildCourseList, _buildCourseCard |
| `lib/features/academic/presentation/screens/daily_schedule_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | DailyScheduleScreen, _ScheduleItem | build, _buildDayPicker, _buildEmptyState, build, _buildTypeBadge, _buildLiveIndicator, _buildDetailChip |
| `lib/features/academic/presentation/screens/exam_card.dart` | PARTIALLY_RESTORED | EXACT_OLD | _ExamCard | build, _buildSeatBadge, _buildInfoItem, _buildSecondaryButton, _buildIconButton |
| `lib/features/academic/presentation/screens/exam_countdown.dart` | PARTIALLY_RESTORED | EXACT_OLD | _ExamCountdown | build, _buildTimeUnit, _buildDivider |
| `lib/features/academic/presentation/screens/exam_date_scroller.dart` | PARTIALLY_RESTORED | EXACT_OLD | _DateScroller | build, _buildDateItem |
| `lib/features/academic/presentation/screens/exam_schedule_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ExamScheduleScreen | build |
| `lib/features/academic/presentation/screens/grades_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | GradesScreen, _GPAHeader, _SemesterSelector, _GradeCard | build, build, _buildMiniStat, build, build, _buildGradeBadge, _buildDetailItem |
| `lib/features/academic/presentation/screens/manage_groups_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ManageGroupsScreen, _ManageGroupsScreenState | _toggleGroupSelection, _selectAllGroups, build |
| `lib/features/academic/presentation/screens/manage_tas_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ManageTasScreen, _TACard | build, _buildAppBar, _buildEmptyState, _handleDelete, _showAddTaBottomSheet, build |
| `lib/features/academic/presentation/screens/professor_chat_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ProfessorChatScreen, _ChatMessage, _ProfessorChatScreenState | initState, _loadMessages, _sendMessage, dispose, build, _buildChatBody, _buildMessageBubble, _buildInputArea |
| `lib/features/academic/presentation/screens/professor_dashboard_actions.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _QuickActionsPanel, _ActionTile | build, _showUploadDialog, build |
| `lib/features/academic/presentation/screens/professor_dashboard_announcements.dart` | PARTIALLY_RESTORED | EXACT_OLD | _AnnouncementsList | build |
| `lib/features/academic/presentation/screens/professor_dashboard_groups.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _BentoStatsGrid, _BentoCard, _GroupsBentoList | build, build, build |
| `lib/features/academic/presentation/screens/professor_dashboard_header.dart` | PARTIALLY_RESTORED | EXACT_OLD | _ImmersiveHeader | build |
| `lib/features/academic/presentation/screens/professor_dashboard_management.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _ManagementGrid, _ManagementRow, _SectionHeader | build, build, build |
| `lib/features/academic/presentation/screens/professor_dashboard_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ProfessorDashboardScreen | build |
| `lib/features/academic/presentation/screens/professor_profile_announcements.dart` | PARTIALLY_RESTORED | EXACT_OLD | _ProfessorProfileAnnouncements | _buildUrgentAnnouncements, _buildTAsSection |
| `lib/features/academic/presentation/screens/professor_profile_groups_files.dart` | PARTIALLY_RESTORED | EXACT_OLD | _ProfessorProfileGroupsFiles | _buildGroupsSection, _buildSharedFilesSection, _buildOfficeHoursSection, _buildSectionTitle |
| `lib/features/academic/presentation/screens/professor_profile_header.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _ProfessorProfileHeader | _buildGlassSliverAppBar, _buildMiniTag, _buildQuickActions, _buildActionBtn |
| `lib/features/academic/presentation/screens/professor_profile_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ProfessorProfileScreen | build |
| `lib/features/academic/presentation/screens/specialization_projects_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | SpecializationProjectsScreen | build, _buildProjectCard, _buildStatusBadge |
| `lib/features/academic/presentation/screens/subject_analytical_layout.dart` | MISSING | BACKEND_COMPATIBILITY_REQUIRED | _AnalyticalLayout | build, _buildStatsGrid |
| `lib/features/academic/presentation/screens/subject_immersive_layout.dart` | MISSING | BACKEND_COMPATIBILITY_REQUIRED | _ImmersiveLayout | build, _buildGradeBadge, _buildCircularProgress, _buildInsights |
| `lib/features/academic/presentation/screens/subject_layout_switcher.dart` | MISSING | EXACT_OLD | _LayoutSwitcher | build |
| `lib/features/academic/presentation/screens/subject_minimal_layout.dart` | MISSING | EXACT_OLD | _MinimalLayout | build |
| `lib/features/academic/presentation/screens/subject_result_components.dart` | MISSING | BACKEND_COMPATIBILITY_REQUIRED | _ComponentCard, _StatCard | build, build |
| `lib/features/academic/presentation/screens/subject_results_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | SubjectResultsScreen | build, _buildLayout |
| `lib/features/academic/presentation/screens/subject_scroller.dart` | MISSING | EXACT_OLD | _SubjectScroller | build |
| `lib/features/academic/presentation/screens/transcript_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | TranscriptScreen, _AcademicSummary, _SemesterTimelineNode, _TranscriptCourseCard | build, build, _buildLargeStat, build, _buildSmallBadge, build |
| `lib/features/academic/presentation/widgets/course_file_upload_dialog.dart` | NEW_UI | NEW_UI | CourseFileUploadDialog, _CourseFileUploadDialogState | dispose, _pickFile, _upload, build |
| `lib/features/auth/presentation/screens/access_pending_screen.dart` | NEW_UI | NEW_UI | AccessPendingScreen | build |
| `lib/features/auth/presentation/screens/forgot_password_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ForgotPasswordScreen, _ForgotPasswordScreenState, _MethodTab | dispose, _submit, _showUnavailableIdUpload, build, _buildStudentAffairsContent, _buildOnlineContent, build |
| `lib/features/auth/presentation/screens/guest_registration_screen.dart` | NEW_UI | NEW_UI | GuestRegistrationScreen, _GuestRegistrationScreenState | dispose, _register, _show, build |
| `lib/features/auth/presentation/screens/login_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | LoginScreen, _LoginScreenState, _OrbsPainter | initState, dispose, _handleSignIn, _showError, build, _buildLogo, _buildLoginCard, paint, _paintOrb |
| `lib/features/colleges/presentation/screens/college_portal_departments.dart` | PARTIALLY_RESTORED | EXACT_OLD | _CollegePortalDepartments | _buildDepartmentsSection |
| `lib/features/colleges/presentation/screens/college_portal_overview.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _CollegePortalOverview | _buildSliverAppBar, _buildStatsGrid, _buildStatItem, _buildAboutSection, _buildExpandableCard |
| `lib/features/colleges/presentation/screens/college_portal_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | CollegePortalScreen, _CollegePortalScreenState | build |
| `lib/features/colleges/presentation/screens/college_portal_staff_sections.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _CollegePortalStaffSections | _buildDeanSection, _buildStaffSection |
| `lib/features/colleges/presentation/widgets/college_staff_panel.dart` | NEW_UI | NEW_UI | CollegeStaffPanel | build |
| `lib/features/enrollment/presentation/screens/advisor_approval_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | AdvisorApprovalScreen, _AdvisorApprovalScreenState | build, _buildFilterChips, _buildRequestCard, _buildActionButtons, _buildEmptyState |
| `lib/features/enrollment/presentation/screens/dean_advisor_assignment_screen.dart` | PARTIALLY_RESTORED | EXACT_OLD | DeanAdvisorAssignmentScreen, _DeanAdvisorAssignmentScreenState | build, _buildStudentCard |
| `lib/features/enrollment/presentation/screens/invoice_actions_widgets.dart` | PARTIALLY_RESTORED | EXACT_OLD | _QuickActionsRow, _QuickActionBtn, _FilterTabBar | build, _showDownloadSnack, build, build |
| `lib/features/enrollment/presentation/screens/invoice_card_widget.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _InvoiceCard | build, _showPayDialog |
| `lib/features/enrollment/presentation/screens/invoice_list_widgets.dart` | EXACT_OLD | EXACT_OLD | _InvoicesList | build |
| `lib/features/enrollment/presentation/screens/invoice_state_widgets.dart` | PARTIALLY_RESTORED | EXACT_OLD | _MiniStat, _VertDivider, _EmptyState, _ErrorWidget, _SummaryCardShimmer, _SummaryCardError | build, build, build, build, build, build |
| `lib/features/enrollment/presentation/screens/invoice_summary_widgets.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _InvoicesAppBar, _FinancialSummaryCard | build, build |
| `lib/features/enrollment/presentation/screens/invoices_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | InvoicesScreen | build |
| `lib/features/enrollment/presentation/screens/payment_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | PaymentScreen | build, _buildBalanceCard, _buildPaymentMethod |
| `lib/features/enrollment/presentation/screens/registration_confirmation_sections.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _RegistrationConfirmationSections | _buildConfirmationState, _buildSuccessState |
| `lib/features/enrollment/presentation/screens/registration_course_sections.dart` | PARTIALLY_RESTORED | EXACT_OLD | _RegistrationCourseSections | _buildFunnelSteps, _buildCourseSelection, _buildCourseSelectionCard |
| `lib/features/enrollment/presentation/screens/registration_schedule_sections.dart` | PARTIALLY_RESTORED | EXACT_OLD | _RegistrationScheduleSections | _buildScheduleSelection, _buildScheduleItemCard |
| `lib/features/enrollment/presentation/screens/registration_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | RegistrationScreen, _RegistrationScreenState | _updateState, initState, _loadInitialData, _toggleCourse, _proceedToSchedules, _confirmRegistration, build |
| `lib/features/enrollment/presentation/screens/registration_status_sections.dart` | PARTIALLY_RESTORED | EXACT_OLD | _RegistrationStatusSections | _buildStepper, _buildStepIndicator, _buildStepLine, _buildRequestStatusCard |
| `lib/features/feed/presentation/screens/create_post_author_widgets.dart` | PARTIALLY_RESTORED | EXACT_OLD | _AnnouncementBanner, _AuthorHeader, _BadgeChip | build, build, build |
| `lib/features/feed/presentation/screens/create_post_content_widgets.dart` | PARTIALLY_RESTORED | EXACT_OLD | _MentionsRow, _ContentField, _LinkField, _MediaPreview | build, build, build, build |
| `lib/features/feed/presentation/screens/create_post_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | CreatePostScreen, _CreatePostScreenState | initState, _loadInitialData, _loadDepartments, dispose, _pickMedia, _submitPost, build, _buildAppBar |
| `lib/features/feed/presentation/screens/create_post_toolbar_widgets.dart` | PARTIALLY_RESTORED | EXACT_OLD | _Toolbar, _ToolBtn | build, build |
| `lib/features/feed/presentation/screens/feed_comment_widgets.dart` | PARTIALLY_RESTORED | EXACT_OLD | _CommentItem, _AvatarWidget, _EmptyFeedState, _ErrorState, _PostSkeleton, _PostSkeletonState, _Bone | build, build, build, build, initState, dispose, build, build |
| `lib/features/feed/presentation/screens/feed_comments.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _CommentSheet, _CommentSheetState | dispose, build, _sendComment |
| `lib/features/feed/presentation/screens/feed_post_card.dart` | PARTIALLY_RESTORED | EXACT_OLD | _PostCard, _PostCardState, _ActionButton, _RoleChip | initState, dispose, build, _handleLike, _showComments, build, build |
| `lib/features/feed/presentation/screens/feed_post_options.dart` | PARTIALLY_RESTORED | EXACT_OLD | _OptionsMenu | build, _handleEdit, _confirmDelete |
| `lib/features/feed/presentation/screens/feed_screen.dart` | PARTIALLY_RESTORED | EXACT_OLD | FeedScreen, _FeedHeader, _QuickPostBar, _QuickActionBtn, _PostFab | build, build, build, build, build |
| `lib/features/feed/presentation/widgets/full_screen_gallery.dart` | EXACT_OLD | EXACT_OLD | FullScreenGallery, _FullScreenGalleryState | initState, onPageChanged, build |
| `lib/features/feed/presentation/widgets/link_preview_widget.dart` | PARTIALLY_RESTORED | EXACT_OLD | LinkPreviewWidget | _launchUrl, build |
| `lib/features/feed/presentation/widgets/media_grid.dart` | EXACT_OLD | EXACT_OLD | MediaGrid | _openGallery, build, _buildGrid, _buildMediaItem, _buildMoreItem |
| `lib/features/feed/presentation/widgets/video_feed_item.dart` | EXACT_OLD | EXACT_OLD | VideoFeedItem, _VideoFeedItemState | initState, _initializePlayer, dispose, build |
| `lib/features/home/presentation/screens/control_dashboard_screen.dart` | NEW_UI | NEW_UI | ControlDashboardScreen | build |
| `lib/features/home/presentation/screens/home_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | HomeScreen, _HomeScreenState, _TabItem | initState, dispose, build, _showCreatePostMenu, _buildPostOption, _buildAppBar, _buildModernBottomNav |
| `lib/features/messaging/presentation/screens/conversation_list_screen.dart` | NEW_UI | NEW_UI | ConversationListScreen, _ConversationListScreenState, _ConversationListPanel, _ConversationTile, _ConversationPlaceholder, _ConversationError | _loadMore, _showError, build, _refresh, build, build, build, build |
| `lib/features/messaging/presentation/screens/conversation_thread_screen.dart` | NEW_UI | NEW_UI | ConversationThreadScreen, ConversationThreadView, _ConversationThreadViewState, _ConversationTitle, _MessageBubble, _MessageComposer, _MessageLoadError | build, initState, dispose, _markRead, _send, _loadOlder, _showMessage, build, build, build, build, build |
| `lib/features/onboarding/presentation/screens/academic_staff_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | AcademicStaffScreen | build, _buildStaffListItem, _buildRatingMini |
| `lib/features/onboarding/presentation/screens/college_departments_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | CollegeDepartmentsScreen, _DepartmentCard | build, _buildBackButton, build |
| `lib/features/onboarding/presentation/screens/college_details_painter.dart` | MISSING | EXACT_OLD | _MeshPainter | paint |
| `lib/features/onboarding/presentation/screens/college_details_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | CollegeDetailsScreen | build |
| `lib/features/onboarding/presentation/screens/college_details_sections.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _CollegeDetailsSections | _buildSectionHeader, _buildDeanCard, _buildStaffList, _buildDepartmentsButton, _buildStatsGrid, _buildStatCard |
| `lib/features/onboarding/presentation/screens/colleges_screen.dart` | PARTIALLY_RESTORED | EXACT_OLD | CollegesScreen, _CollegesScreenState | build, _onCollegeTap, _buildCollegeCard |
| `lib/features/onboarding/presentation/screens/department_detail_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | DepartmentDetailScreen, _HoDIdentityCard, _HoloLinesPainter | build, _buildHodSection, _buildSectionHeader, _buildBioText, build, _buildProfileSection, _buildChip, _buildLocationStat, _buildRatingStat, paint |
| `lib/features/onboarding/presentation/screens/language_screen.dart` | MISSING | EXACT_OLD | LanguageScreen, _LanguageScreenState, _LanguageCard, _LanguageCardState | _navigateToNext, build, Function, initState, dispose, build |
| `lib/features/onboarding/presentation/screens/staff_rating_detail_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | StaffRatingDetailScreen | build, _buildBody, _buildRatingSection, _buildMetricCard, _buildActionCard, _buildReviewsHeader, _buildReviews |
| `lib/features/onboarding/presentation/screens/style_screen.dart` | MISSING | EXACT_OLD | StyleScreen, _StyleScreenState, _StyleCard, _StyleCardState | _selectStyle, build, Function, initState, dispose, build |
| `lib/features/onboarding/presentation/screens/submit_rating_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | SubmitRatingScreen, _SubmitRatingScreenState | dispose, build, _buildBody, _buildRatingCategory, _buildCommentField, _buildSubmitButton |
| `lib/features/onboarding/presentation/screens/theme_screen.dart` | MISSING | EXACT_OLD | ThemeScreen, _ThemeScreenState, _ThemeCard, _ThemeCardState | _selectTheme, build, Function, initState, dispose, build |
| `lib/features/settings/presentation/screens/about_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | AboutScreen | build, _buildInfoRow |
| `lib/features/settings/presentation/screens/change_password_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ChangePasswordScreen, _ChangePasswordScreenState | dispose, _changePassword, _showError, build |
| `lib/features/settings/presentation/screens/privacy_policy_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | PrivacyPolicyScreen | build |
| `lib/features/settings/presentation/screens/profile_display_sections.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _ProfileDisplaySections | _buildProfileScreen |
| `lib/features/settings/presentation/screens/profile_editing_sections.dart` | PARTIALLY_RESTORED | EXACT_OLD | _ProfileEditingSections | _pickImage, _imagePickerOption, _pickFromSource, _uploadAvatar, _saveProfile |
| `lib/features/settings/presentation/screens/profile_fields.dart` | PARTIALLY_RESTORED | EXACT_OLD | _ProfileFields | _sectionLabel, _buildPremiumField, _buildAccountInfoCard, _infoRow, _buildSaveButton |
| `lib/features/settings/presentation/screens/profile_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ProfileScreen, _ProfileScreenState | _updateState, initState, dispose, _loadProfile, build |
| `lib/features/settings/presentation/screens/settings_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | SettingsScreen, _SettingsScreenState | initState, dispose, _loadNotificationPref, _toggleNotifications, build, _buildBody |
| `lib/features/settings/presentation/screens/settings_screen_dialogs.dart` | PARTIALLY_RESTORED | EXACT_OLD | _SettingsScreenDialogs | _showSupportDialog, _supportOption, _showFeedbackDialog |
| `lib/features/settings/presentation/screens/settings_screen_items.dart` | PARTIALLY_RESTORED | EXACT_OLD | _SettingsScreenItems | _buildAboutSection, _buildLogoutButton, _buildSettingItem, _buildSwitch, _divider |
| `lib/features/settings/presentation/screens/settings_screen_painter.dart` | MISSING | EXACT_OLD | _ParticlesPainter | paint |
| `lib/features/settings/presentation/screens/settings_screen_preferences.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _SettingsScreenPreferences | _handleThemeSwitch, _handleStyleSwitch, _handleLanguageSwitch, _showLanguageSelector, _buildLanguageItem |
| `lib/features/settings/presentation/screens/settings_screen_sections.dart` | PARTIALLY_RESTORED | EXACT_OLD | _SettingsScreenSections | _buildImmersiveHeader, _buildSectionHeader, _buildAccountSection, _buildAppearanceSection, _buildNotificationsSection, _buildLanguageSection, _buildSupportSection |
| `lib/features/shared/presentation/screens/forums_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | ForumsScreen | build, _buildForumTile |
| `lib/features/shared/presentation/screens/notifications_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | NotificationsScreen | build, _buildGravityTile |
| `lib/features/shared/presentation/screens/placeholder_screen.dart` | MISSING | BACKEND_COMPATIBILITY_REQUIRED | PlaceholderScreen | build |
| `lib/features/shared/presentation/screens/security_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | SecurityScreen | build, _buildSecuritySection, _buildSwitchTile, _buildActionTile |
| `lib/features/shared/presentation/screens/sessions_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | SessionsScreen | build, _buildSessionTile |
| `lib/features/shared/presentation/screens/support_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | SupportScreen | build, _buildSupportCard, _buildContactTile |
| `lib/features/shared/presentation/screens/transition_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | TransitionScreen, _TransitionScreenState | initState, dispose, didUpdateWidget, _startTimer, build |
| `lib/features/shared/presentation/screens/tutorials_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | TutorialsScreen | build, _buildTutorialCard |
| `lib/features/shared/presentation/widgets/animated_mesh_background.dart` | EXACT_OLD | EXACT_OLD | AnimatedMeshBackground | build |
| `lib/features/shared/presentation/widgets/dashboard_action_widgets.dart` | EXACT_OLD | EXACT_OLD | DashboardSectionHeader, DashboardGridItem, DashboardHorizontalItem, DashboardSquareItem | build, build, build, build |
| `lib/features/shared/presentation/widgets/glass_app_bar.dart` | PARTIALLY_RESTORED | EXACT_OLD | _GlassConfig, GlassSliverAppBar, _FrostedGlassBackground, _LowPerfBackground | build, build, build |
| `lib/features/shared/presentation/widgets/glass_container.dart` | EXACT_OLD | EXACT_OLD | GlassContainer | build, _buildClassic |
| `lib/features/shared/presentation/widgets/glass_scaffold.dart` | EXACT_OLD | EXACT_OLD | GlassScaffold | build |
| `lib/features/shared/presentation/widgets/horus_empty_state.dart` | EXACT_OLD | EXACT_OLD | HorusEmptyState | build |
| `lib/features/shared/presentation/widgets/liquid_background.dart` | MISSING | EXACT_OLD | LiquidBackground, _LiquidBackgroundState, _LiquidPainter, _LiquidParticles, _LiquidParticlesState, _Particle, _ParticlePainter | initState, dispose, build, paint, _drawBlob, initState, dispose, build, paint |
| `lib/features/shared/presentation/widgets/liquid_toast_overlay.dart` | EXACT_OLD | EXACT_OLD | LiquidToastOverlay, _LiquidToastOverlayState | show, initState, dispose, _show, build, _buildLiquidCard |
| `lib/features/shared/presentation/widgets/premium_success_overlay.dart` | EXACT_OLD | EXACT_OLD | PremiumSuccessOverlay | show, build |
| `lib/features/splash/presentation/screens/splash_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | SplashScreen, _SplashScreenState | _continueWhenReady, initState, build |
| `lib/features/students/presentation/screens/digital_id_card_back.dart` | MISSING | EXACT_OLD | _BackCard, _ShareOption | build, _buildQR, build |
| `lib/features/students/presentation/screens/digital_id_card_front.dart` | MISSING | BACKEND_COMPATIBILITY_REQUIRED | _FrontCard | build, _buildHolographicSweep, _buildGridPattern, _buildContent, _buildUniqueSignature, _buildBrand, _buildSecurityChip, _buildAvatar, _buildDeptBadge, _buildInfoBar, _buildInfoItem |
| `lib/features/students/presentation/screens/digital_id_card_interaction.dart` | MISSING | EXACT_OLD | _Interactive3DCard, _Interactive3DCardState | initState, _toggleFlip, dispose, build |
| `lib/features/students/presentation/screens/digital_id_card_patterns.dart` | MISSING | EXACT_OLD | _CircuitPainter, _OrganicPattern | paint, build |
| `lib/features/students/presentation/screens/digital_id_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | DigitalIDScreen, _DigitalIDScreenState | _updateState, build |
| `lib/features/students/presentation/screens/digital_id_screen_sections.dart` | MISSING | BACKEND_COMPATIBILITY_REQUIRED | _DigitalIDScreenSections | _buildThemeSelector, _buildDepartmentSelector, _buildSecurityStatus, _buildActionGrid, _buildActionCard, _showShareDialog |
| `lib/features/students/presentation/screens/student_dashboard_academic_sections.dart` | EXACT_OLD | EXACT_OLD | _StudentDashboardAcademicSections | _buildAcademicGrid, _buildEnrollmentGrid, _buildUtilitiesRow, _gatedGrid, _gatedHorizontal |
| `lib/features/students/presentation/screens/student_dashboard_action_sections.dart` | PARTIALLY_RESTORED | EXACT_OLD | _StudentDashboardActionSections | _buildSquareItem, _showAccessDenied |
| `lib/features/students/presentation/screens/student_dashboard_id_section.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | _StudentDashboardIdSection | _buildDigitalIDCard, _buildCardStat, _buildSectionHeader |
| `lib/features/students/presentation/screens/student_dashboard_list_sections.dart` | PARTIALLY_RESTORED | EXACT_OLD | _StudentDashboardListSections | _buildGridItem, _buildHorizontalItem |
| `lib/features/students/presentation/screens/student_dashboard_screen.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | DashboardScreen | build |
| `lib/features/students/presentation/widgets/horus_identity_card.dart` | NEW_UI | NEW_UI | HorusIdentityCard | build |
| `lib/features/welcome/presentation/screens/welcome_screen.dart` | PARTIALLY_RESTORED | EXACT_OLD | WelcomeScreen | build, _buildLogoCenterpiece, _buildHeroText, _buildActionButtons |
| `lib/shared/layout/horus_adaptive_scaffold.dart` | NEW_UI | NEW_UI | HorusAdaptiveScaffold, _HorusAdaptiveScaffoldState, _NavigationItem | build, build |
| `lib/shared/layout/horus_app_shell.dart` | NEW_UI | REMOVED |  |  |
| `lib/shared/layout/horus_destination.dart` | NEW_UI | NEW_UI | HorusDestination |  |
| `lib/shared/layout/horus_page_body.dart` | NEW_UI | NEW_UI | HorusPageBody | build |
| `lib/shared/widgets/app_badge.dart` | EXACT_OLD | EXACT_OLD | AppBadge | build |
| `lib/shared/widgets/app_button.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | AppButtonVariant, AppButton, PrimaryButton, GoldButton, SecondaryButton | build, build, build, build |
| `lib/shared/widgets/app_card.dart` | PARTIALLY_RESTORED | BACKEND_COMPATIBILITY_REQUIRED | AppCardVariant, AppCard, UniversityCard | build, build |
| `lib/shared/widgets/app_progress_bar.dart` | EXACT_OLD | EXACT_OLD | AppProgressBar | build |
| `lib/shared/widgets/app_section_header.dart` | EXACT_OLD | EXACT_OLD | SectionHeader | build |
| `lib/shared/widgets/app_skeleton.dart` | EXACT_OLD | EXACT_OLD | Skeleton, _SkeletonState, CardSkeleton, ListSkeleton | initState, dispose, build, build, build |
| `lib/shared/widgets/app_text_field.dart` | EXACT_OLD | EXACT_OLD | AppTextField | build |
| `lib/shared/widgets/horus_entrance.dart` | NEW_UI | NEW_UI | HorusEntrance | build |
| `lib/shared/widgets/horus_error_state.dart` | NEW_UI | NEW_UI | HorusErrorState | build |
| `lib/shared/widgets/live_alert_banner.dart` | EXACT_OLD | EXACT_OLD | PulsingDot, _PulsingDotState, LiveAlertBanner | initState, dispose, build, build |
| `lib/shared/widgets/press_feedback.dart` | EXACT_OLD | EXACT_OLD | HapticFeedbackType, PressFeedback, _PressFeedbackState | _triggerHaptic, build |
| `lib/main.dart` | BACKEND_COMPATIBILITY_REQUIRED | BACKEND_COMPATIBILITY_REQUIRED |  | main |
| `lib/features/students/data/digital_id_theme_repository.dart` | BACKEND_COMPATIBILITY_REQUIRED | EXACT_OLD | DigitalIDThemeRepository |  |
| `lib/features/students/domain/models/digital_id_theme.dart` | BACKEND_COMPATIBILITY_REQUIRED | EXACT_OLD | DigitalIDDesignStyle, DigitalIDTheme |  |
| `lib/features/academic/presentation/legacy_academic_view_data.dart` | BACKEND_COMPATIBILITY_REQUIRED | NEW_UI |  |  |
| `lib/features/colleges/presentation/legacy_college_data.dart` | BACKEND_COMPATIBILITY_REQUIRED | NEW_UI |  |  |
| `lib/features/academic/data/repositories/professor_repository.dart` | BACKEND_COMPATIBILITY_REQUIRED | BACKEND_COMPATIBILITY_REQUIRED | AcademicSummary, ProfessorRepository | getFullProfessorProfile, removeOfficeHour, removeTA, joinGroup, leaveGroup, uploadSharedFile, addMemberToGroup, updateProfessorDetail |
| `lib/core/constants/colleges_data.dart` | BACKEND_COMPATIBILITY_REQUIRED | BACKEND_COMPATIBILITY_REQUIRED | StaticCollegeData, CollegeSection |  |
| `lib/core/constants/college_catalog.dart` | BACKEND_COMPATIBILITY_REQUIRED | BACKEND_COMPATIBILITY_REQUIRED |  |  |
| `lib/core/utils/responsive_helper.dart` | BACKEND_COMPATIBILITY_REQUIRED | BACKEND_COMPATIBILITY_REQUIRED | ResponsiveHelper, ResponsiveLayout | build |
| `lib/core/error/error_handler.dart` | BACKEND_COMPATIBILITY_REQUIRED | BACKEND_COMPATIBILITY_REQUIRED | ErrorHandler | showError |
| `lib/core/router/back_navigation.dart` | BACKEND_COMPATIBILITY_REQUIRED | NEW_UI | HorusBackNavigation | backToHorus |

## Fonts, images and translated UI copy

Generated localization adapters and locale preferences remain at the current contract. All existing translated values match PRE_EDIT; four removed sample teacher-name keys stay removed, and 53 current feature/security keys remain in each locale.

| Resource | Classification | Reason |
|---|---|---|
| `assets/Video/HUE.mp4` | REMOVED | Historical unused video; no screen reference |
| `assets/fonts/Cairo-Black.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cairo-Bold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cairo-ExtraBold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cairo-ExtraLight.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cairo-Light.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cairo-Medium.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cairo-OFL.txt` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cairo-Regular.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cairo-SemiBold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cinzel-Black.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cinzel-Bold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cinzel-ExtraBold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cinzel-Medium.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cinzel-OFL.txt` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cinzel-Regular.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Cinzel-SemiBold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Inter-Black.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Inter-Bold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Inter-ExtraBold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Inter-ExtraLight.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Inter-Light.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Inter-Medium.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Inter-OFL.txt` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Inter-Regular.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Inter-SemiBold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Inter-Thin.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/NotoSansSC-OFL.txt` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/NotoSansSC-Regular.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Outfit-Black.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Outfit-Bold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Outfit-ExtraBold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Outfit-ExtraLight.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Outfit-Light.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Outfit-Medium.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Outfit-OFL.txt` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Outfit-Regular.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Outfit-SemiBold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Outfit-Thin.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/README.md` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/ShareTechMono-OFL.txt` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/ShareTechMono-Regular.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Tajawal-Black.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Tajawal-Bold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Tajawal-ExtraBold.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Tajawal-ExtraLight.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Tajawal-Light.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Tajawal-Medium.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Tajawal-OFL.txt` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/fonts/Tajawal-Regular.ttf` | BACKEND_COMPATIBILITY_REQUIRED | Official OFL fonts for offline historical typography |
| `assets/images/HUE.jpg` | EXACT_OLD | Historical image retained |
| `assets/images/HUE1.jpg` | EXACT_OLD | Historical image retained |
| `assets/images/HUE_2.jpg` | EXACT_OLD | Historical image retained |
| `assets/images/Logo_dark.png` | EXACT_OLD | Historical image retained |
| `assets/images/Logo_light.png` | EXACT_OLD | Historical image retained |
| `assets/images/college_ai.png` | EXACT_OLD | Historical image retained |
| `assets/images/college_applied_health.png` | EXACT_OLD | Historical image retained |
| `assets/images/college_business.png` | EXACT_OLD | Historical image retained |
| `assets/images/college_dentistry.png` | EXACT_OLD | Historical image retained |
| `assets/images/college_engineering.png` | EXACT_OLD | Historical image retained |
| `assets/images/college_fine_arts.png` | EXACT_OLD | Historical image retained |
| `assets/images/college_linguistics.png` | EXACT_OLD | Historical image retained |
| `assets/images/college_medicine.png` | EXACT_OLD | Historical image retained |
| `assets/images/college_pharmacy.png` | EXACT_OLD | Historical image retained |
| `assets/images/college_physical_therapy.png` | EXACT_OLD | Historical image retained |
| `assets/translations/ar.i18n.json` | BACKEND_COMPATIBILITY_REQUIRED | Current secure feature keys retained; historical UI copy unchanged |
| `assets/translations/de.i18n.json` | BACKEND_COMPATIBILITY_REQUIRED | Current secure feature keys retained; historical UI copy unchanged |
| `assets/translations/en.i18n.json` | BACKEND_COMPATIBILITY_REQUIRED | Current secure feature keys retained; historical UI copy unchanged |
| `assets/translations/zh.i18n.json` | BACKEND_COMPATIBILITY_REQUIRED | Current secure feature keys retained; historical UI copy unchanged |
| `lib/core/i18n/locale_preferences.dart` | BACKEND_COMPATIBILITY_REQUIRED | Current locale persistence / generated adapters for unchanged old copy and later secure features |
| `lib/core/i18n/strings.g.dart` | BACKEND_COMPATIBILITY_REQUIRED | Current locale persistence / generated adapters for unchanged old copy and later secure features |
| `lib/core/i18n/strings_ar.g.dart` | BACKEND_COMPATIBILITY_REQUIRED | Current locale persistence / generated adapters for unchanged old copy and later secure features |
| `lib/core/i18n/strings_de.g.dart` | BACKEND_COMPATIBILITY_REQUIRED | Current locale persistence / generated adapters for unchanged old copy and later secure features |
| `lib/core/i18n/strings_en.g.dart` | BACKEND_COMPATIBILITY_REQUIRED | Current locale persistence / generated adapters for unchanged old copy and later secure features |
| `lib/core/i18n/strings_zh.g.dart` | BACKEND_COMPATIBILITY_REQUIRED | Current locale persistence / generated adapters for unchanged old copy and later secure features |

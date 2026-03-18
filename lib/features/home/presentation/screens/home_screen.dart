import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';

import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/feed/presentation/screens/feed_screen.dart';
import 'package:hue/features/feed/domain/models/post_model.dart';
import 'package:hue/features/onboarding/presentation/screens/colleges_screen.dart';
import 'package:hue/features/students/presentation/screens/student_dashboard_screen.dart';
import 'package:hue/features/admin/presentation/screens/administration_screen.dart';
import 'package:hue/features/admin/presentation/screens/staff_dashboard_screen.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late final AnimationController _navAnimController;

  @override
  void initState() {
    super.initState();
    _navAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
  }

  @override
  void dispose() {
    _navAnimController.dispose();
    super.dispose();
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  TAB BUILDER  — builds the list of tabs per role
  // ═══════════════════════════════════════════════════════════════════════════
  List<_TabItem> _buildTabItems(UserRole role) {
    final items = <_TabItem>[];

    // 1. Feed — everyone
    items.add(
      _TabItem(
        icon: LucideIcons.home,
        label: t.home.home,
        screen: const FeedScreen(),
      ),
    );

    // 2. Colleges — everyone
    items.add(
      _TabItem(
        icon: LucideIcons.graduationCap,
        label: t.home.colleges,
        screen: const CollegesScreen(isOnboarding: false),
      ),
    );

    // 3. Student Dashboard
    if (role.isStudent) {
      items.add(
        _TabItem(
          icon: LucideIcons.layoutDashboard,
          label: t.extracted.dashboard,
          screen: const DashboardScreen(),
        ),
      );
    }

    // 4. Staff Dashboard (Teaching, Leadership, Advisors, Librarians, Registrars, Super Admin)
    final hasStaffDashboard =
        role.isTeachingStaff ||
        role.isLeadership ||
        role == UserRole.superAdmin ||
        role == UserRole.registrarOfficer ||
        role == UserRole.academicAdvisor ||
        role == UserRole.librarian;

    if (hasStaffDashboard) {
      items.add(
        _TabItem(
          icon: LucideIcons.presentation,
          label: t.extracted.dashboard,
          screen: const StaffDashboardScreen(),
        ),
      );
    }

    // 4. Admin panel — admin and leadership roles
    if (role.isAdmin || role.isLeadership) {
      items.add(
        _TabItem(
          icon: LucideIcons.shield,
          label: t.home.admin,
          screen: const AdministrationScreen(isStandalone: false),
        ),
      );
    }

    return items;
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  BUILD
  // ═══════════════════════════════════════════════════════════════════════════
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final authState = ref.watch(authControllerProvider);
    final role = authState.role;
    final items = _buildTabItems(role);

    // Clamp index
    if (_currentIndex >= items.length) {
      _currentIndex = items.length - 1;
    }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        extendBody: isGlass,
        backgroundColor: isGlass ? Colors.transparent : null,
        appBar: _buildAppBar(theme, isDark, isGlass, role, items),
        body: IndexedStack(
          index: _currentIndex,
          children: items.map((e) => e.screen).toList(),
        ),
        bottomNavigationBar: _buildModernBottomNav(theme, isDark, items),
        floatingActionButton: null,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  MODERN FAB
  // ═══════════════════════════════════════════════════════════════════════════

  void _showCreatePostMenu(BuildContext context, ThemeData theme, bool isDark) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: (isDark ? const Color(0xFF1E293B) : Colors.white)
                  .withValues(alpha: 0.9),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(28),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  t.$meta.locale.languageCode == 'ar'
                      ? 'إنشاء منشور جديد'
                      : 'Create New Post',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildPostOption(
                      icon: LucideIcons.type,
                      label: t.$meta.locale.languageCode == 'ar'
                          ? 'نص'
                          : 'Text',
                      color: Colors.blue,
                      theme: theme,
                      onTap: () {
                        Navigator.pop(context);
                        context.push(
                          '/create-post',
                          extra: {'type': PostType.text},
                        );
                      },
                    ),
                    _buildPostOption(
                      icon: LucideIcons.image,
                      label: t.$meta.locale.languageCode == 'ar'
                          ? 'صورة'
                          : 'Image',
                      color: Colors.purple,
                      theme: theme,
                      onTap: () {
                        Navigator.pop(context);
                        context.push(
                          '/create-post',
                          extra: {'type': PostType.image},
                        );
                      },
                    ),
                    _buildPostOption(
                      icon: LucideIcons.megaphone,
                      label: t.$meta.locale.languageCode == 'ar'
                          ? 'إعلان'
                          : 'Announcement',
                      color: Colors.orange,
                      theme: theme,
                      onTap: () {
                        Navigator.pop(context);
                        context.push(
                          '/create-post',
                          extra: {'type': PostType.announcement},
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostOption({
    required IconData icon,
    required String label,
    required Color color,
    required ThemeData theme,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: GoogleFonts.inter(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ).animate().fadeIn().scale(),
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  APP BAR
  // ═══════════════════════════════════════════════════════════════════════════
  PreferredSizeWidget _buildAppBar(
    ThemeData theme,
    bool isDark,
    bool isGlass,
    UserRole role,
    List<_TabItem> items,
  ) {
    final portalTitle = items.isNotEmpty && _currentIndex < items.length
        ? items[_currentIndex].label
        : t.home.home;

    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: isGlass
          ? Colors.transparent
          : theme.scaffoldBackgroundColor,
      flexibleSpace: isGlass
          ? ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 30, sigmaY: 30),
                child: Container(
                  color: theme.scaffoldBackgroundColor.withValues(
                    alpha: isDark ? 0.5 : 0.7,
                  ),
                ),
              ),
            )
          : null,
      title: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  theme.primaryColor.withValues(alpha: 0.15),
                  theme.primaryColor.withValues(alpha: 0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              items.isNotEmpty && _currentIndex < items.length
                  ? items[_currentIndex].icon
                  : LucideIcons.home,
              color: theme.primaryColor,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              portalTitle,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: theme.textTheme.bodyLarge?.color,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        if (_currentIndex == 0)
          Container(
            margin: const EdgeInsets.only(right: 8),
            decoration: BoxDecoration(
              color: theme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                LucideIcons.plus,
                size: 20,
                color: theme.primaryColor,
              ),
              onPressed: () => _showCreatePostMenu(context, theme, isDark),
              splashRadius: 22,
            ),
          ),
        Container(
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: Icon(
              LucideIcons.settings,
              size: 20,
              color: theme.iconTheme.color?.withValues(alpha: 0.7),
            ),
            onPressed: () => context.push('/settings'),
            splashRadius: 22,
          ),
        ),
      ],
    );
  }

  // ═══════════════════════════════════════════════════════════════════════════
  //  MODERN BOTTOM NAVIGATION (TASKBAR)
  // ═══════════════════════════════════════════════════════════════════════════
  Widget _buildModernBottomNav(
    ThemeData theme,
    bool isDark,
    List<_TabItem> items,
  ) {
    return Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 20),
          decoration: BoxDecoration(
            color: (isDark ? const Color(0xFF1E293B) : Colors.white).withValues(
              alpha: 0.85,
            ),
            borderRadius: BorderRadius.circular(32),
            border: Border.all(
              color: (isDark ? Colors.white : Colors.black).withValues(
                alpha: 0.1,
              ),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.1),
                blurRadius: 30,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(32),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: SafeArea(
                top: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(items.length, (i) {
                      final isSelected = _currentIndex == i;
                      final item = items[i];

                      // If we have a FAB in the middle and enough items to surround it
                      // we can add a spacer here if we wanted a notched look,
                      // but floating taskbars often just distribute items evenly.

                      return GestureDetector(
                        onTap: () {
                          if (_currentIndex != i) {
                            HapticFeedback.selectionClick();
                            setState(() => _currentIndex = i);
                          }
                        },
                        behavior: HitTestBehavior.opaque,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          padding: EdgeInsets.symmetric(
                            vertical: 10,
                            horizontal: isSelected ? 20 : 16,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? theme.primaryColor.withValues(alpha: 0.15)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              AnimatedScale(
                                scale: isSelected ? 1.1 : 1.0,
                                duration: const Duration(milliseconds: 250),
                                curve: Curves.easeOutBack,
                                child: Icon(
                                  item.icon,
                                  size: 22,
                                  color: isSelected
                                      ? theme.primaryColor
                                      : theme.iconTheme.color?.withValues(
                                          alpha: 0.5,
                                        ),
                                ),
                              ),
                              if (isSelected) ...[
                                const SizedBox(width: 8),
                                AnimatedOpacity(
                                  opacity: isSelected ? 1.0 : 0.0,
                                  duration: const Duration(milliseconds: 200),
                                  child: Text(
                                    item.label,
                                    style: GoogleFonts.outfit(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: theme.primaryColor,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ),
              ),
            ),
          ),
        )
        .animate()
        .slideY(
          begin: 1.0,
          end: 0,
          duration: 800.ms,
          curve: Curves.easeOutQuart,
        )
        .fadeIn(duration: 500.ms);
  }
}

// ═══════════════════════════════════════════════════════════════════════════════
//  TAB ITEM MODEL
// ═══════════════════════════════════════════════════════════════════════════════
class _TabItem {
  final IconData icon;
  final String label;
  final Widget screen;

  const _TabItem({
    required this.icon,
    required this.label,
    required this.screen,
  });
}

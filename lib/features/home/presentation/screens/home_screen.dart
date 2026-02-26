
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/feed/presentation/screens/feed_screen.dart';
import 'package:hue/features/onboarding/presentation/screens/colleges_screen.dart';
import 'package:hue/features/students/presentation/screens/student_dashboard_screen.dart';
import 'package:hue/features/admin/presentation/screens/administration_screen.dart';
import 'package:hue/features/academic/presentation/screens/professor_dashboard_screen.dart';
import 'package:hue/features/academic/data/repositories/professor_repository.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;

  List<Widget> _buildTabs(UserRole role) {
    final tabs = <Widget>[
      const FeedScreen(),
      const CollegesScreen(isOnboarding: false),
    ];

    if (role.isStudent || role == UserRole.superAdmin) {
      tabs.add(const StudentDashboardScreen());
    }

    if (role.isTeachingStaff ||
        role.isLeadership ||
        role == UserRole.superAdmin) {
      tabs.add(
        Consumer(
          builder: (context, ref, child) {
            final profileAsync = ref.watch(professorProfileProvider);
            return profileAsync.when(
              data: (profile) => profile != null
                  ? ProfessorDashboardScreen(profile: profile)
                  : const Center(child: Text('Professor profile not found')),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, st) =>
                  Center(child: Text('Error loading profile: $e')),
            );
          },
        ),
      );
    }

    if (role.isAdmin) {
      tabs.add(const AdministrationScreen());
    }

    return tabs;
  }

  List<NavigationDestination> _buildDestinations(bool isArabic, UserRole role) {
    final destinations = <NavigationDestination>[
      NavigationDestination(
        icon: const Icon(LucideIcons.home),
        label: isArabic ? "الرئيسية" : "Home",
      ),
      NavigationDestination(
        icon: const Icon(LucideIcons.graduationCap),
        label: isArabic ? "الكليات" : "Colleges",
      ),
    ];

    if (role.isStudent || role == UserRole.superAdmin) {
      destinations.add(
        NavigationDestination(
          icon: const Icon(LucideIcons.layoutDashboard),
          label: isArabic ? "الطالب" : "Student",
        ),
      );
    }

    if (role.isTeachingStaff ||
        role.isLeadership ||
        role == UserRole.superAdmin) {
      destinations.add(
        NavigationDestination(
          icon: const Icon(LucideIcons.presentation),
          label: isArabic ? "أستاذ" : "Prof",
        ),
      );
    }

    if (role.isAdmin) {
      destinations.add(
        NavigationDestination(
          icon: const Icon(LucideIcons.shield),
          label: isArabic ? "الإدارة" : "Admin",
        ),
      );
    }

    return destinations;
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final authState = ref.watch(authControllerProvider);
    final role = authState.role;
    final tabs = _buildTabs(role);
    final destinations = _buildDestinations(isArabic, role);

    if (_currentIndex >= tabs.length) {
      _currentIndex = tabs.length - 1;
    }

    final scaffold = GlassScaffold(
      extendBody: isGlass,
      appBar: AppBar(
        title: Text(
          role.isAdmin
              ? (isArabic ? 'بوابة الإدارة' : 'ADMIN PORTAL')
              : (role.isTeachingStaff || role.isLeadership)
              ? (isArabic ? 'بوابة المحاضر' : 'FACULTY PORTAL')
              : (isArabic ? 'بوابة الطالب' : 'STUDENT PORTAL'),
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Theme.of(context).primaryColor,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.settings),
            onPressed: () => context.push('/settings'),
          ),
        ],
        centerTitle: false,
        elevation: 0,
        backgroundColor: isGlass
            ? Colors.transparent
            : Theme.of(context).scaffoldBackgroundColor,
        flexibleSpace: isGlass
            ? GlassContainer(
                borderRadius: BorderRadius.circular(0),
                child: Container(),
              )
            : null,
      ),
      body: IndexedStack(index: _currentIndex, children: tabs),
      bottomNavigationBar: isGlass
          ? null
          : _buildNavigationBar(context, destinations, transparent: false),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: () {},
              child: const Icon(LucideIcons.plus),
            )
          : null,
    );

    if (!isGlass) return scaffold;

    return Stack(
      children: [
        scaffold,
        Positioned(
          bottom: 24,
          left: 24,
          right: 24,
          child: _buildGlassDock(context, destinations),
        ),
      ],
    );
  }

  Widget _buildGlassDock(
    BuildContext context,
    List<NavigationDestination> destinations,
  ) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth / destinations.length;

        return GlassContainer(
          height: 70,
          borderRadius: BorderRadius.circular(35),
          blur: 35,
          border: Border.all(
            color: Colors.white.withValues(alpha: 0.15),
            width: 1.2,
          ),
          padding: EdgeInsets.zero,
          child: Stack(
            children: [

              AnimatedPositioned(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutBack,
                left: _currentIndex * itemWidth + 8,
                top: 8,
                bottom: 8,
                width: itemWidth - 16,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white.withValues(alpha: 0.05),
                        blurRadius: 15,
                        spreadRadius: -2,
                      ),
                    ],
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(destinations.length, (index) {
                  final isSelected = _currentIndex == index;
                  final item = destinations[index];
                  final iconData = (item.icon as Icon).icon;

                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _currentIndex = index),
                      behavior: HitTestBehavior.opaque,
                      child: Center(
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 300),
                          scale: isSelected ? 1.0 : 0.9,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                    iconData,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.white.withValues(alpha: 0.45),
                                    size: isSelected ? 24 : 22,
                                  )
                                  .animate(target: isSelected ? 1 : 0)
                                  .shimmer(
                                    delay: 400.ms,
                                    duration: 1200.ms,
                                    color: Colors.white24,
                                  ),
                              if (isSelected)
                                Text(
                                      item.label,
                                      style: GoogleFonts.outfit(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 10,
                                      ),
                                    )
                                    .animate()
                                    .fadeIn(duration: 200.ms)
                                    .scale(
                                      begin: const Offset(0.8, 0.8),
                                      end: const Offset(1, 1),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ],
          ),
        ).animate().slideY(
          begin: 1.5,
          end: 0,
          duration: 800.ms,
          curve: Curves.easeOutQuart,
        );
      },
    );
  }

  Widget _buildNavigationBar(
    BuildContext context,
    List<NavigationDestination> destinations, {
    required bool transparent,
  }) {
    return NavigationBar(
      backgroundColor: transparent ? Colors.transparent : null,
      indicatorColor: Theme.of(context).primaryColor.withValues(alpha: 0.2),
      elevation: transparent ? 0 : 3,
      selectedIndex: _currentIndex,
      onDestinationSelected: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      destinations: destinations,
    );
  }
}

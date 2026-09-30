import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/utils/responsive_helper.dart';
import 'package:horus/features/feed/domain/models/post_model.dart';
import 'package:horus/features/feed/presentation/screens/feed_screen.dart';
import 'package:horus/features/onboarding/presentation/screens/colleges_screen.dart';
import 'package:horus/features/students/presentation/screens/student_dashboard_screen.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  int _currentIndex = 0;
  final Set<int> _visitedTabs = {0};

  void _selectTab(int index) => setState(() {
    _currentIndex = index;
    _visitedTabs.add(index);
  });

  List<Widget> _tabChildren(List<_TabItem> items) => [
    for (var index = 0; index < items.length; index++)
      _visitedTabs.contains(index)
          ? items[index].screen
          : const SizedBox.shrink(),
  ];

  List<_TabItem> _buildTabItems(UserRole role) => [
    _TabItem(
      icon: LucideIcons.home,
      label: t.home.home,
      screen: const FeedScreen(),
    ),
    _TabItem(
      icon: LucideIcons.graduationCap,
      label: t.home.colleges,
      screen: const CollegesScreen(isOnboarding: false),
    ),
    if (role.isStudent)
      _TabItem(
        icon: LucideIcons.layoutDashboard,
        label: t.extracted.dashboard,
        screen: const DashboardScreen(),
      ),
  ];

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final items = _buildTabItems(authState.role);
    if (_currentIndex >= items.length) _currentIndex = 0;
    final compact = ResponsiveHelper.isCompact(context);
    final selected = items[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(selected.label),
        actions: [
          if (_currentIndex == 0 &&
              authState.hasPermission(RolePermission.createPost))
            IconButton(
              tooltip: t.extracted.create_post,
              onPressed: () => _showCreatePostMenu(context),
              icon: const Icon(LucideIcons.plus),
            ),
          IconButton(
            tooltip: t.settings.title,
            onPressed: () => context.push('/settings'),
            icon: const Icon(LucideIcons.settings),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: compact
          ? IndexedStack(index: _currentIndex, children: _tabChildren(items))
          : Row(
              children: [
                NavigationRail(
                  selectedIndex: _currentIndex,
                  labelType: NavigationRailLabelType.all,
                  onDestinationSelected: _selectTab,
                  destinations: [
                    for (final item in items)
                      NavigationRailDestination(
                        icon: Icon(item.icon),
                        label: Text(item.label),
                      ),
                  ],
                ),
                const VerticalDivider(width: 1),
                Expanded(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: _tabChildren(items),
                  ),
                ),
              ],
            ),
      bottomNavigationBar: compact
          ? NavigationBar(
              selectedIndex: _currentIndex,
              onDestinationSelected: _selectTab,
              destinations: [
                for (final item in items)
                  NavigationDestination(
                    icon: Icon(item.icon),
                    label: item.label,
                  ),
              ],
            )
          : null,
    );
  }

  void _showCreatePostMenu(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                t.extracted.create_post,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 12),
              _postTypeAction(
                context,
                LucideIcons.type,
                t.home.post_text,
                PostType.text,
              ),
              _postTypeAction(
                context,
                LucideIcons.image,
                t.home.post_image,
                PostType.image,
              ),
              _postTypeAction(
                context,
                LucideIcons.megaphone,
                t.home.post_announcement,
                PostType.announcement,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _postTypeAction(
    BuildContext context,
    IconData icon,
    String label,
    PostType type,
  ) => ListTile(
    minTileHeight: 48,
    leading: Icon(icon),
    title: Text(label),
    onTap: () {
      Navigator.pop(context);
      context.push('/create-post', extra: {'type': type});
    },
  );
}

class _TabItem {
  const _TabItem({
    required this.icon,
    required this.label,
    required this.screen,
  });
  final IconData icon;
  final String label;
  final Widget screen;
}

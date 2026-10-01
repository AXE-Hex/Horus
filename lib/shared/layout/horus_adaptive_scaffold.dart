import 'package:flutter/material.dart';
import 'package:horus/core/theme/app_layout.dart';
import 'package:horus/core/theme/app_spacing.dart';
import 'package:horus/core/utils/responsive_helper.dart';
import 'horus_destination.dart';

/// Navigation chrome around an existing feature workspace. Feature app bars,
/// scroll positions, route extras, and back navigation stay owned by the route.
class HorusAdaptiveScaffold extends StatefulWidget {
  const HorusAdaptiveScaffold({
    super.key,
    required this.child,
    required this.destinations,
    required this.location,
    required this.onNavigate,
    required this.navigationLabel,
  });
  final Widget child;
  final List<HorusDestination> destinations;
  final String location;
  final ValueChanged<String> onNavigate;
  final String navigationLabel;

  @override
  State<HorusAdaptiveScaffold> createState() => _HorusAdaptiveScaffoldState();
}

class _HorusAdaptiveScaffoldState extends State<HorusAdaptiveScaffold> {
  bool _collapsed = false;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) {
      final items = widget.destinations;
      if (items.isEmpty) return widget.child;
      final selected = items.indexWhere(
        (item) => item.route == widget.location,
      );
      final compact = constraints.maxWidth < ResponsiveHelper.compactBreakpoint;
      final expanded =
          constraints.maxWidth >= ResponsiveHelper.mediumBreakpoint;
      if (compact) {
        final mobile = items.take(5).toList();
        final mobileIndex = mobile.indexWhere(
          (item) => item.route == widget.location,
        );
        return Scaffold(
          body: widget.child,
          bottomNavigationBar: SafeArea(
            top: false,
            child: SizedBox(
              height: AppLayout.navigationHeight,
              child: Row(
                children: [
                  for (var index = 0; index < mobile.length; index++)
                    Expanded(
                      child: _NavigationItem(
                        destination: mobile[index],
                        selected: mobileIndex == index,
                        onTap: () => widget.onNavigate(mobile[index].route),
                      ),
                    ),
                ],
              ),
            ),
          ),
        );
      }
      return Scaffold(
        body: Row(
          children: [
            if (expanded)
              SizedBox(
                key: const ValueKey('horus-desktop-sidebar'),
                width: _collapsed
                    ? AppLayout.collapsedSidebarWidth
                    : AppLayout.sidebarWidth,
                child: Material(
                  color: Theme.of(context).colorScheme.surface,
                  child: SafeArea(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(AppSpacing.lg),
                          child: Row(
                            children: [
                              if (!_collapsed)
                                Expanded(
                                  child: Image.asset(
                                    Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? 'assets/images/Logo_dark.png'
                                        : 'assets/images/Logo_light.png',
                                    height: 48,
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              IconButton(
                                tooltip: widget.navigationLabel,
                                onPressed: () =>
                                    setState(() => _collapsed = !_collapsed),
                                icon: const Icon(Icons.menu),
                              ),
                            ],
                          ),
                        ),
                        const Divider(),
                        Expanded(
                          child: ListView(
                            padding: const EdgeInsets.all(AppSpacing.sm),
                            children: [
                              for (var index = 0; index < items.length; index++)
                                Padding(
                                  padding: const EdgeInsets.only(
                                    bottom: AppSpacing.xs,
                                  ),
                                  child: ListTile(
                                    selected: index == selected,
                                    selectedTileColor: Theme.of(
                                      context,
                                    ).colorScheme.primaryContainer,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                        AppRadius.md,
                                      ),
                                    ),
                                    leading: Tooltip(
                                      message: items[index].label,
                                      child: Icon(items[index].icon),
                                    ),
                                    title: _collapsed
                                        ? null
                                        : Text(items[index].label),
                                    onTap: () =>
                                        widget.onNavigate(items[index].route),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            else
              NavigationRail(
                minWidth: AppLayout.railWidth,
                selectedIndex: selected < 0 ? null : selected,
                labelType: NavigationRailLabelType.selected,
                scrollable: true,
                onDestinationSelected: (index) =>
                    widget.onNavigate(items[index].route),
                destinations: [
                  for (final item in items)
                    NavigationRailDestination(
                      icon: Icon(item.icon),
                      label: Text(item.label),
                    ),
                ],
              ),
            const VerticalDivider(width: 1),
            Expanded(child: widget.child),
          ],
        ),
      );
    },
  );
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });
  final HorusDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    selected: selected,
    button: true,
    label: destination.label,
    child: Tooltip(
      message: destination.label,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xs),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.lg,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? Theme.of(context).colorScheme.primaryContainer
                      : null,
                  borderRadius: BorderRadius.circular(AppRadius.full),
                ),
                child: Icon(destination.icon),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                destination.label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:horus/features/academic/data/models/professor_profile_models.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ManageGroupsScreen extends ConsumerStatefulWidget {
  final ProfessorProfile profile;

  const ManageGroupsScreen({super.key, required this.profile});

  @override
  ConsumerState<ManageGroupsScreen> createState() => _ManageGroupsScreenState();
}

class _ManageGroupsScreenState extends ConsumerState<ManageGroupsScreen> {
  final Set<String> _selectedGroupIds = {};

  void _toggleGroupSelection(String groupId) {
    HapticFeedback.selectionClick();
    setState(() {
      if (_selectedGroupIds.contains(groupId)) {
        _selectedGroupIds.remove(groupId);
      } else {
        _selectedGroupIds.add(groupId);
      }
    });
  }

  void _selectAllGroups() {
    HapticFeedback.mediumImpact();
    setState(() {
      if (_selectedGroupIds.length == widget.profile.groups.length) {
        _selectedGroupIds.clear();
      } else {
        _selectedGroupIds.addAll(widget.profile.groups.map((g) => g.id));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    const isGlass = false;
    final theme = Theme.of(context);
    final color = Colors.indigo;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    final allSelected =
        _selectedGroupIds.length == widget.profile.groups.length &&
        widget.profile.groups.isNotEmpty;

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 140,
          pinned: true,
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              isArabic ? LucideIcons.chevronRight : LucideIcons.chevronLeft,
              color: Colors.black87,
            ),
            onPressed: () => context.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 16,
            ),
            title: Text(
              t.professor.stats.groups,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${_selectedGroupIds.length} selected',
                  style: TextStyle(fontWeight: FontWeight.bold, color: color),
                ),
                TextButton.icon(
                  onPressed: _selectAllGroups,
                  icon: Icon(
                    allSelected ? LucideIcons.checkSquare : LucideIcons.square,
                    color: color,
                    size: 20,
                  ),
                  label: Text(
                    allSelected
                        ? t.professor.deselect_all
                        : t.professor.select_all,
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ).animate().fadeIn(),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: widget.profile.groups.isEmpty
              ? SliverToBoxAdapter(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 60),
                        Icon(
                          LucideIcons.network,
                          size: 64,
                          color: Colors.grey[300],
                        ),
                        const SizedBox(height: 16),
                        Text(
                          t.professor.no_groups,
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final group = widget.profile.groups[index];
                    final isSelected = _selectedGroupIds.contains(group.id);

                    final block = ListTile(
                      onTap: () => _toggleGroupSelection(group.id),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? color
                              : color.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Icon(
                          LucideIcons.users,
                          color: isSelected ? Colors.white : color,
                        ),
                      ),
                      title: Text(
                        group.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87,
                        ),
                      ),
                      subtitle: Text(
                        group.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                      trailing: Checkbox(
                        value: isSelected,
                        activeColor: color,
                        onChanged: (_) => _toggleGroupSelection(group.id),
                      ),
                    );

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child:
                          AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  border: isSelected
                                      ? Border.all(color: color, width: 2)
                                      : Border.all(
                                          color: Colors.transparent,
                                          width: 2,
                                        ),
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: block,
                                ),
                              )
                              .animate()
                              .fadeIn(delay: Duration(milliseconds: 50 * index))
                              .slideX(begin: isArabic ? -0.1 : 0.1),
                    );
                  }, childCount: widget.profile.groups.length),
                ),
        ),
      ],
    );

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: content,
      floatingActionButton: _buildContextualAction(isGlass, color, isArabic),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget? _buildContextualAction(bool isGlass, Color color, bool isArabic) {
    if (_selectedGroupIds.isEmpty) return null;

    final block = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.megaphone, color: Colors.white),
          const SizedBox(width: 12),
          Text(
            'Announcement',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );

    return InkWell(
      onTap: () {
        HapticFeedback.heavyImpact();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.professor.preparing_announcement)),
        );
      },
      borderRadius: BorderRadius.circular(32),
      child: block,
    ).animate().slideY(begin: 1.0, duration: 300.ms).fadeIn();
  }
}

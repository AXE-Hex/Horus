import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:hue/features/admin/presentation/providers/users_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:hue/core/utils/responsive_helper.dart';
import 'package:flutter_animate/flutter_animate.dart';

class UsersListScreen extends ConsumerStatefulWidget {
  final RoleCategory? category;
  final UserRole? role;
  final String title;

  const UsersListScreen({
    super.key,
    this.category,
    this.role,
    required this.title,
  });

  @override
  ConsumerState<UsersListScreen> createState() => _UsersListScreenState();
}

class _UsersListScreenState extends ConsumerState<UsersListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();
  String _searchQuery = '';
  String _statusFilter = 'all'; // all, active, deactivated, banned
  String _verifiedFilter = 'all'; // all, verified, unverified
  final int _warningFilter = -1; // -1 for all, 0-4 for specific level

  // Selection Mode
  bool _isSelectionMode = false;
  final Set<String> _selectedUserIds = {};

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);
    if (widget.category == RoleCategory.studentRoles) {
      _tabController.index = 0;
    } else if (widget.category == RoleCategory.teachingStaff) {
      _tabController.index = 1;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return GlassScaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_isSelectionMode) ...[
            IconButton(
              icon: const Icon(LucideIcons.checkSquare),
              onPressed: () {
                // Logic to select all visible (would need visible list)
              },
            ),
            IconButton(
              icon: const Icon(LucideIcons.trash2, color: Colors.redAccent),
              onPressed: () => _handleBulkAction('delete'),
            ),
            IconButton(
              icon: const Icon(LucideIcons.x),
              onPressed: () => setState(() {
                _isSelectionMode = false;
                _selectedUserIds.clear();
              }),
            ),
          ] else ...[
            IconButton(
              icon: const Icon(LucideIcons.userPlus),
              onPressed: () => context.push(
                '/admin/users/new',
                extra: {
                  'category': widget.category ?? _getCurrentCategory(),
                  'role': widget.role,
                },
              ),
            ),
          ],
        ],
        bottom: widget.category == null
            ? TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).primaryColor,
                labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: t.admin.students),
                  Tab(text: t.admin.staff),
                ],
              )
            : null,
      ),
      body: Column(
        children: [
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child:
                      Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              color: Colors.white.withValues(alpha: 0.05),
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).primaryColor.withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.1),
                                  blurRadius: 15,
                                  spreadRadius: -5,
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: _searchController,
                              onChanged: (val) => setState(
                                () => _searchQuery = val.toLowerCase(),
                              ),
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                color: Colors.white,
                              ),
                              decoration: InputDecoration(
                                hintText: t.admin.search_by_name_email_phone_id,
                                hintStyle: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: Colors.white.withValues(alpha: 0.3),
                                ),
                                prefixIcon: Icon(
                                  LucideIcons.search,
                                  size: 18,
                                  color: Theme.of(
                                    context,
                                  ).primaryColor.withValues(alpha: 0.5),
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          )
                          .animate()
                          .fadeIn()
                          .scale(
                            begin: const Offset(0.98, 0.98),
                            end: const Offset(1, 1),
                          )
                          .shimmer(
                            color: Theme.of(
                              context,
                            ).primaryColor.withValues(alpha: 0.1),
                            duration: 3.seconds,
                          ),
                ),
                const SizedBox(width: 8),
                GlassContainer(
                  borderRadius: BorderRadius.circular(20),
                  child: IconButton(
                    icon: const Icon(LucideIcons.filter, size: 20),
                    onPressed: () => _showFilterSheet(),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  RoleCategory? _getCurrentCategory() {
    if (widget.category != null) return widget.category;
    return _tabController.index == 0
        ? RoleCategory.studentRoles
        : RoleCategory.teachingStaff;
  }

  Widget _buildMainContent() {
    if (widget.category != null) return _buildUsersList(widget.category);
    return TabBarView(
      controller: _tabController,
      children: [
        _buildUsersList(RoleCategory.studentRoles),
        _buildUsersList(RoleCategory.teachingStaff),
      ],
    );
  }

  Widget _buildUsersList(RoleCategory? category) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final usersAsync = ref.watch(
      usersControllerProvider(category: category, role: widget.role),
    );

    return usersAsync.when(
      data: (users) {
        final filteredUsers = users.where((user) {
          final query = _searchQuery.toLowerCase();
          final matchesSearch =
              user.fullName.toLowerCase().contains(query) ||
              user.email.toLowerCase().contains(query) ||
              (user.studentId?.toLowerCase().contains(query) ?? false) ||
              (user.phone?.toLowerCase().contains(query) ?? false) ||
              user.tags.any((tag) => tag.toLowerCase().contains(query));

          if (!matchesSearch) return false;

          if (_statusFilter == 'active' && (!user.isActive || user.isBanned)) {
            return false;
          }
          if (_statusFilter == 'deactivated' && user.isActive) return false;
          if (_statusFilter == 'banned' && !user.isBanned) return false;

          if (_verifiedFilter == 'verified' && !user.isVerified) return false;
          if (_verifiedFilter == 'unverified' && user.isVerified) return false;

          if (_warningFilter != -1 && user.warningLevel != _warningFilter) {
            return false;
          }

          return true;
        }).toList();

        if (filteredUsers.isEmpty) {
          return _buildEmptyState(isArabic);
        }

        final isDesktop = ResponsiveHelper.isDesktop(context);
        final isTablet = ResponsiveHelper.isTablet(context);

        if (isDesktop || isTablet) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop ? 3 : 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: isDesktop ? 1.05 : 0.95,
            ),
            padding: const EdgeInsets.all(24),
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) {
              final user = filteredUsers[index];
              return _UserTile(
                user: user,
                category: category,
                isSelected: _selectedUserIds.contains(user.id),
                selectionMode: _isSelectionMode,
                onToggleSelection: (id) {
                  setState(() {
                    if (_selectedUserIds.contains(id)) {
                      _selectedUserIds.remove(id);
                      if (_selectedUserIds.isEmpty) _isSelectionMode = false;
                    } else {
                      _selectedUserIds.add(id);
                    }
                  });
                },
                onLongPress: (id) {
                  setState(() {
                    _isSelectionMode = true;
                    _selectedUserIds.add(id);
                  });
                },
              ).animate().fadeIn(delay: (index * 50).ms).slideY(begin: 0.1);
            },
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final user = filteredUsers[index];
            return _UserTile(
                  user: user,
                  category: category,
                  isSelected: _selectedUserIds.contains(user.id),
                  selectionMode: _isSelectionMode,
                  onToggleSelection: (id) {
                    setState(() {
                      if (_selectedUserIds.contains(id)) {
                        _selectedUserIds.remove(id);
                        if (_selectedUserIds.isEmpty) _isSelectionMode = false;
                      } else {
                        _selectedUserIds.add(id);
                      }
                    });
                  },
                  onLongPress: (id) {
                    setState(() {
                      _isSelectionMode = true;
                      _selectedUserIds.add(id);
                    });
                  },
                )
                .animate()
                .fadeIn(delay: (index * 30).ms)
                .slideX(begin: isArabic ? -0.05 : 0.05);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildEmptyState(bool isArabic) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            LucideIcons.users,
            size: 80,
            color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds),
          const SizedBox(height: 24),
          Text(
            t.admin.no_users_found,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ],
      ),
    );
  }

  void _handleBulkAction(String action) {
    if (_selectedUserIds.isEmpty) return;
    // Implement bulk actions here
    setState(() {
      _isSelectionMode = false;
      _selectedUserIds.clear();
    });
  }

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        padding: const EdgeInsets.all(24),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.admin.filter_users,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildFilterSection(t.admin.account_status, [
              _FilterChip(
                label: t.admin.all,
                selected: _statusFilter == 'all',
                onSelected: (val) => setState(() => _statusFilter = 'all'),
              ),
              _FilterChip(
                label: t.admin.active,
                selected: _statusFilter == 'active',
                onSelected: (val) => setState(() => _statusFilter = 'active'),
              ),
              _FilterChip(
                label: t.admin.deactivated,
                selected: _statusFilter == 'deactivated',
                onSelected: (val) =>
                    setState(() => _statusFilter = 'deactivated'),
              ),
              _FilterChip(
                label: t.admin.banned,
                selected: _statusFilter == 'banned',
                onSelected: (val) => setState(() => _statusFilter = 'banned'),
              ),
            ]),
            const SizedBox(height: 16),
            _buildFilterSection(t.admin.verification, [
              _FilterChip(
                label: t.admin.all,
                selected: _verifiedFilter == 'all',
                onSelected: (val) => setState(() => _verifiedFilter = 'all'),
              ),
              _FilterChip(
                label: t.admin.verified,
                selected: _verifiedFilter == 'verified',
                onSelected: (val) =>
                    setState(() => _verifiedFilter = 'verified'),
              ),
              _FilterChip(
                label: t.admin.unverified,
                selected: _verifiedFilter == 'unverified',
                onSelected: (val) =>
                    setState(() => _verifiedFilter = 'unverified'),
              ),
            ]),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.all(16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(t.admin.apply_filters),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 8, children: children),
      ],
    );
  }
}

class _UserTile extends ConsumerWidget {
  final UserProfileModel user;
  final RoleCategory? category;
  final bool isSelected;
  final bool selectionMode;
  final ValueChanged<String>? onToggleSelection;
  final ValueChanged<String>? onLongPress;

  const _UserTile({
    required this.user,
    this.category,
    this.isSelected = false,
    this.selectionMode = false,
    this.onToggleSelection,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isActive = user.isActive && !user.isBanned;
    final statusColor = user.isBanned
        ? Colors.purple
        : (isActive ? Colors.green : Colors.red);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(24),
        onTap: () {
          if (selectionMode) {
            onToggleSelection?.call(user.id);
          } else {
            context.push('/admin/users/details', extra: user);
          }
        },
        onLongPress: () => onLongPress?.call(user.id),
        border: Border.all(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Colors.white.withValues(alpha: 0.08),
          width: isSelected ? 2 : 1,
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: user.avatarUrl != null
                  ? NetworkImage(user.avatarUrl!)
                  : null,
              child: user.avatarUrl == null
                  ? const Icon(LucideIcons.user)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    user.email,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 10,
              height: 10,
              decoration: BoxDecoration(
                color: statusColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool selected;
  final ValueChanged<bool> onSelected;

  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label, style: const TextStyle(fontSize: 12)),
      selected: selected,
      onSelected: onSelected,
      backgroundColor: Colors.transparent,
      selectedColor: Theme.of(context).primaryColor.withValues(alpha: 0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: selected
              ? Theme.of(context).primaryColor
              : Colors.grey.withValues(alpha: 0.3),
        ),
      ),
    );
  }
}

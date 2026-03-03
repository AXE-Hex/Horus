import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/roles.dart';
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
  String _statusFilter = 'all';
  String _verifiedFilter = 'all';
  bool _isSearchFocused = false;

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
    final primaryColor = Theme.of(context).primaryColor;

    return GlassScaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_isSelectionMode) ...[
            _buildActionButton(
              icon: LucideIcons.checkSquare,
              color: primaryColor,
              onTap: () {},
            ),
            _buildActionButton(
              icon: LucideIcons.trash2,
              color: Colors.redAccent,
              onTap: () => _handleBulkAction('delete'),
            ),
            _buildActionButton(
              icon: LucideIcons.x,
              color: Colors.white70,
              onTap: () => setState(() {
                _isSelectionMode = false;
                _selectedUserIds.clear();
              }),
            ),
          ] else ...[
            Container(
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [primaryColor, primaryColor.withValues(alpha: 0.7)],
                ),
                borderRadius: BorderRadius.circular(14),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withValues(alpha: 0.3),
                    blurRadius: 12,
                    spreadRadius: -2,
                  ),
                ],
              ),
              child: IconButton(
                icon: const Icon(LucideIcons.userPlus, size: 18),
                color: Colors.white,
                onPressed: () => context.push(
                  '/admin/users/new',
                  extra: {
                    'category': widget.category ?? _getCurrentCategory(),
                    'role': widget.role,
                  },
                ),
              ),
            ),
          ],
        ],
        bottom: widget.category == null
            ? TabBar(
                controller: _tabController,
                indicatorColor: primaryColor,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.label,
                labelStyle: GoogleFonts.outfit(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                ),
                unselectedLabelStyle: GoogleFonts.outfit(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.graduationCap, size: 16),
                        const SizedBox(width: 8),
                        Text(t.admin.students),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(LucideIcons.briefcase, size: 16),
                        const SizedBox(width: 8),
                        Text(t.admin.staff),
                      ],
                    ),
                  ),
                ],
              )
            : null,
      ),
      body: Column(
        children: [
          const SizedBox(height: 12),
          // ── Search Bar
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Row(
              children: [
                Expanded(child: _buildSearchBar(primaryColor)),
                const SizedBox(width: 10),
                _buildFilterButton(primaryColor),
              ],
            ),
          ),
          // ── Active Filters
          if (_statusFilter != 'all' || _verifiedFilter != 'all')
            _buildActiveFilters(primaryColor),
          const SizedBox(height: 4),
          // ── User List
          Expanded(child: _buildMainContent()),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      child: IconButton(
        icon: Icon(icon, size: 18, color: color),
        onPressed: onTap,
      ),
    );
  }

  Widget _buildSearchBar(Color primaryColor) {
    return AnimatedContainer(
      duration: 300.ms,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(
          color: _isSearchFocused
              ? primaryColor.withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.08),
          width: _isSearchFocused ? 1.5 : 1,
        ),
        boxShadow: _isSearchFocused
            ? [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.15),
                  blurRadius: 20,
                  spreadRadius: -5,
                ),
              ]
            : [],
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
        onTap: () => setState(() => _isSearchFocused = true),
        onEditingComplete: () => setState(() => _isSearchFocused = false),
        style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
        decoration: InputDecoration(
          hintText: t.admin.search_by_name_email_phone_id,
          hintStyle: GoogleFonts.inter(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.25),
          ),
          prefixIcon: Icon(
            LucideIcons.search,
            size: 18,
            color: _isSearchFocused
                ? primaryColor
                : Colors.white.withValues(alpha: 0.35),
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(
                    LucideIcons.x,
                    size: 14,
                    color: Colors.white.withValues(alpha: 0.4),
                  ),
                  onPressed: () {
                    _searchController.clear();
                    setState(() => _searchQuery = '');
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(Color primaryColor) {
    final hasActiveFilters = _statusFilter != 'all' || _verifiedFilter != 'all';
    return GlassContainer(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          IconButton(
            icon: Icon(
              LucideIcons.slidersHorizontal,
              size: 18,
              color: hasActiveFilters ? primaryColor : Colors.white70,
            ),
            onPressed: () => _showFilterSheet(),
          ),
          if (hasActiveFilters)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildActiveFilters(Color primaryColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: Row(
        children: [
          if (_statusFilter != 'all')
            _buildActiveFilterChip(
              _statusFilter,
              primaryColor,
              () => setState(() => _statusFilter = 'all'),
            ),
          if (_verifiedFilter != 'all') ...[
            const SizedBox(width: 8),
            _buildActiveFilterChip(
              _verifiedFilter,
              Colors.tealAccent,
              () => setState(() => _verifiedFilter = 'all'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildActiveFilterChip(
    String label,
    Color color,
    VoidCallback onRemove,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(width: 6),
          GestureDetector(
            onTap: onRemove,
            child: Icon(LucideIcons.x, size: 12, color: color),
          ),
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
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: isDesktop ? 1.1 : 1.0,
            ),
            padding: const EdgeInsets.all(20),
            itemCount: filteredUsers.length,
            itemBuilder: (context, index) =>
                _buildUserTile(filteredUsers[index], category, index, isArabic),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) =>
              _buildUserTile(filteredUsers[index], category, index, isArabic),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildUserTile(
    UserProfileModel user,
    RoleCategory? category,
    int index,
    bool isArabic,
  ) {
    final primaryColor = Theme.of(context).primaryColor;
    final isActive = user.isActive && !user.isBanned;
    final isSelected = _selectedUserIds.contains(user.id);
    final statusColor = user.isBanned
        ? const Color(0xFFEF4444)
        : (isActive ? const Color(0xFF10B981) : const Color(0xFFF59E0B));
    final roleName = user.roles.isNotEmpty
        ? user.roles.first.displayName()
        : '—';

    return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: GlassContainer(
            padding: const EdgeInsets.all(14),
            borderRadius: BorderRadius.circular(22),
            onTap: () {
              if (_isSelectionMode) {
                HapticFeedback.selectionClick();
                setState(() {
                  if (isSelected) {
                    _selectedUserIds.remove(user.id);
                    if (_selectedUserIds.isEmpty) _isSelectionMode = false;
                  } else {
                    _selectedUserIds.add(user.id);
                  }
                });
              } else {
                context.push('/admin/users/details', extra: user);
              }
            },
            onLongPress: () {
              HapticFeedback.mediumImpact();
              setState(() {
                _isSelectionMode = true;
                _selectedUserIds.add(user.id);
              });
            },
            border: Border.all(
              color: isSelected
                  ? primaryColor
                  : Colors.white.withValues(alpha: 0.06),
              width: isSelected ? 2 : 1,
            ),
            child: Row(
              children: [
                // ── Avatar
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            primaryColor.withValues(alpha: 0.3),
                            primaryColor.withValues(alpha: 0.1),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1.5,
                        ),
                      ),
                      child: user.avatarUrl != null
                          ? ClipOval(
                              child: Image.network(
                                user.avatarUrl!,
                                fit: BoxFit.cover,
                                width: 50,
                                height: 50,
                                errorBuilder: (context, error, stackTrace) =>
                                    Icon(
                                      LucideIcons.user,
                                      size: 22,
                                      color: Colors.white.withValues(
                                        alpha: 0.6,
                                      ),
                                    ),
                              ),
                            )
                          : Icon(
                              LucideIcons.user,
                              size: 22,
                              color: Colors.white.withValues(alpha: 0.6),
                            ),
                    ),
                    // Status dot
                    Positioned(
                      bottom: 1,
                      right: 1,
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: const Color(0xFF0A0A1A),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                    // Selection indicator
                    if (_isSelectionMode)
                      Positioned(
                        top: -2,
                        left: -2,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? primaryColor
                                : Colors.white.withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: isSelected
                                  ? primaryColor
                                  : Colors.white.withValues(alpha: 0.3),
                              width: 1.5,
                            ),
                          ),
                          child: isSelected
                              ? const Icon(
                                  LucideIcons.check,
                                  size: 12,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 14),
                // ── User Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              user.fullName,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (user.isVerified) ...[
                            const SizedBox(width: 6),
                            Icon(
                              LucideIcons.badgeCheck,
                              size: 14,
                              color: const Color(0xFF10B981),
                            ),
                          ],
                          if (user.warningLevel > 0) ...[
                            const SizedBox(width: 4),
                            Icon(
                              LucideIcons.alertTriangle,
                              size: 12,
                              color: Colors.orangeAccent,
                            ),
                          ],
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        user.email,
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 6),
                      // ── Role Badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          roleName,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                            letterSpacing: 0.3,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // ── Chevron
                Icon(
                  isArabic ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
                  size: 16,
                  color: Colors.white.withValues(alpha: 0.15),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: (index * 30).ms, duration: 300.ms)
        .slideX(begin: isArabic ? -0.03 : 0.03, end: 0);
  }

  Widget _buildEmptyState(bool isArabic) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.05),
                ),
                child: Icon(
                  LucideIcons.users,
                  size: 40,
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                ),
              )
              .animate(onPlay: (c) => c.repeat(reverse: true))
              .scale(
                begin: const Offset(0.95, 0.95),
                end: const Offset(1.05, 1.05),
                duration: 2.seconds,
              ),
          const SizedBox(height: 20),
          Text(
            t.admin.no_users_found,
            style: GoogleFonts.outfit(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white.withValues(alpha: 0.25),
            ),
          ),
        ],
      ),
    );
  }

  void _handleBulkAction(String action) {
    if (_selectedUserIds.isEmpty) return;
    setState(() {
      _isSelectionMode = false;
      _selectedUserIds.clear();
    });
  }

  void _showFilterSheet() {
    final primaryColor = Theme.of(context).primaryColor;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => GlassContainer(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Handle bar
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(
                    LucideIcons.slidersHorizontal,
                    size: 18,
                    color: primaryColor,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    t.admin.filter_users,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildFilterSection(t.admin.account_status, [
                _buildFilterChipItem(t.admin.all, _statusFilter == 'all', () {
                  setSheetState(() => _statusFilter = 'all');
                  setState(() {});
                }, primaryColor),
                _buildFilterChipItem(
                  t.admin.active,
                  _statusFilter == 'active',
                  () {
                    setSheetState(() => _statusFilter = 'active');
                    setState(() {});
                  },
                  const Color(0xFF10B981),
                ),
                _buildFilterChipItem(
                  t.admin.deactivated,
                  _statusFilter == 'deactivated',
                  () {
                    setSheetState(() => _statusFilter = 'deactivated');
                    setState(() {});
                  },
                  const Color(0xFFF59E0B),
                ),
                _buildFilterChipItem(
                  t.admin.banned,
                  _statusFilter == 'banned',
                  () {
                    setSheetState(() => _statusFilter = 'banned');
                    setState(() {});
                  },
                  const Color(0xFFEF4444),
                ),
              ]),
              const SizedBox(height: 20),
              _buildFilterSection(t.admin.verification, [
                _buildFilterChipItem(t.admin.all, _verifiedFilter == 'all', () {
                  setSheetState(() => _verifiedFilter = 'all');
                  setState(() {});
                }, primaryColor),
                _buildFilterChipItem(
                  t.admin.verified,
                  _verifiedFilter == 'verified',
                  () {
                    setSheetState(() => _verifiedFilter = 'verified');
                    setState(() {});
                  },
                  const Color(0xFF10B981),
                ),
                _buildFilterChipItem(
                  t.admin.unverified,
                  _verifiedFilter == 'unverified',
                  () {
                    setSheetState(() => _verifiedFilter = 'unverified');
                    setState(() {});
                  },
                  const Color(0xFFEF4444),
                ),
              ]),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setSheetState(() {
                          _statusFilter = 'all';
                          _verifiedFilter = 'all';
                        });
                        setState(() {});
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.white60,
                        padding: const EdgeInsets.all(14),
                      ),
                      child: Text(
                        t.admin.all,
                        style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(ctx),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.all(14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        t.admin.apply_filters,
                        style: GoogleFonts.outfit(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
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
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.white.withValues(alpha: 0.5),
            letterSpacing: 0.5,
          ),
        ),
        const SizedBox(height: 10),
        Wrap(spacing: 8, runSpacing: 8, children: children),
      ],
    );
  }

  Widget _buildFilterChipItem(
    String label,
    bool selected,
    VoidCallback onTap,
    Color color,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? color.withValues(alpha: 0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected
                ? color.withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.1),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
            color: selected ? color : Colors.white60,
          ),
        ),
      ),
    );
  }
}

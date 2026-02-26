import 'package:flutter/material.dart';
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
  int _warningFilter = -1; // -1 for all, 0-4 for specific level

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
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.userPlus),
            onPressed: () => context.push(
              '/admin/users/new',
              extra: {'category': _getCurrentCategory(), 'role': widget.role},
            ),
          ),
        ],
        bottom: widget.category == null
            ? TabBar(
                controller: _tabController,
                indicatorColor: Theme.of(context).primaryColor,
                labelStyle: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                tabs: [
                  Tab(text: isArabic ? 'الطلاب' : 'Students'),
                  Tab(text: isArabic ? 'الموظفين' : 'Staff'),
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
                  child: GlassContainer(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    borderRadius: BorderRadius.circular(20),
                    child: TextField(
                      controller: _searchController,
                      onChanged: (val) =>
                          setState(() => _searchQuery = val.toLowerCase()),
                      decoration: InputDecoration(
                        hintText: isArabic
                            ? 'بحث بالاسم، البريد، الهاتف، المعرف...'
                            : 'Search by name, email, phone, ID...',
                        hintStyle: GoogleFonts.inter(fontSize: 14),
                        prefixIcon: const Icon(LucideIcons.search, size: 20),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                GlassContainer(
                  borderRadius: BorderRadius.circular(20),
                  child: IconButton(
                    icon: const Icon(LucideIcons.filter, size: 20),
                    onPressed: () => _showFilterSheet(isArabic),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: widget.category != null
                ? _buildUsersList(widget.category)
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildUsersList(RoleCategory.studentRoles),
                      _buildUsersList(RoleCategory.teachingStaff),
                    ],
                  ),
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
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  LucideIcons.users,
                  size: 64,
                  color: Theme.of(context).hintColor.withValues(alpha: 0.2),
                ),
                const SizedBox(height: 16),
                Text(
                  isArabic ? 'لا يوجد مستخدمين' : 'No users found',
                  style: GoogleFonts.inter(color: Theme.of(context).hintColor),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: filteredUsers.length,
          itemBuilder: (context, index) {
            final user = filteredUsers[index];
            return _UserTile(user: user, category: category)
                .animate()
                .fadeIn(delay: (index * 50).ms, duration: 400.ms)
                .slideX(
                  begin: 0.1,
                  end: 0,
                  delay: (index * 50).ms,
                  duration: 400.ms,
                );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }

  void _showFilterSheet(bool isArabic) {
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
              isArabic ? 'فلترة المستخدمين' : 'Filter Users',
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 24),
            _buildFilterSection(isArabic ? 'حالة الحساب' : 'Account Status', [
              _FilterChip(
                label: isArabic ? 'الكل' : 'All',
                selected: _statusFilter == 'all',
                onSelected: (val) => setState(() => _statusFilter = 'all'),
              ),
              _FilterChip(
                label: isArabic ? 'نشط' : 'Active',
                selected: _statusFilter == 'active',
                onSelected: (val) => setState(() => _statusFilter = 'active'),
              ),
              _FilterChip(
                label: isArabic ? 'معطل' : 'Deactivated',
                selected: _statusFilter == 'deactivated',
                onSelected: (val) =>
                    setState(() => _statusFilter = 'deactivated'),
              ),
              _FilterChip(
                label: isArabic ? 'محظور' : 'Banned',
                selected: _statusFilter == 'banned',
                onSelected: (val) => setState(() => _statusFilter = 'banned'),
              ),
            ]),
            const SizedBox(height: 16),
            _buildFilterSection(isArabic ? 'التوثيق' : 'Verification', [
              _FilterChip(
                label: isArabic ? 'الكل' : 'All',
                selected: _verifiedFilter == 'all',
                onSelected: (val) => setState(() => _verifiedFilter = 'all'),
              ),
              _FilterChip(
                label: isArabic ? 'موثق' : 'Verified',
                selected: _verifiedFilter == 'verified',
                onSelected: (val) =>
                    setState(() => _verifiedFilter = 'verified'),
              ),
              _FilterChip(
                label: isArabic ? 'غير موثق' : 'Unverified',
                selected: _verifiedFilter == 'unverified',
                onSelected: (val) =>
                    setState(() => _verifiedFilter = 'unverified'),
              ),
            ]),
            const SizedBox(height: 16),
            _buildFilterSection(isArabic ? 'مستوى الإنذار' : 'Warning Level', [
              _FilterChip(
                label: isArabic ? 'الكل' : 'All',
                selected: _warningFilter == -1,
                onSelected: (val) => setState(() => _warningFilter = -1),
              ),
              ...List.generate(
                5,
                (i) => _FilterChip(
                  label: '$i',
                  selected: _warningFilter == i,
                  onSelected: (val) => setState(() => _warningFilter = i),
                ),
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
                child: Text(isArabic ? 'تطبيق الفلتر' : 'Apply Filters'),
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

  const _UserTile({required this.user, this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final isActive = user.isActive && !user.isBanned;
    final statusColor = user.isBanned
        ? Colors.purple
        : (isActive ? Colors.green : Colors.red);

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(28),
        onTap: () => context.push('/admin/users/details', extra: user),
        child: Row(
          children: [
            // Avatar with Status Ring
            Stack(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.3),
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Theme.of(
                      context,
                    ).primaryColor.withValues(alpha: 0.1),
                    backgroundImage: user.avatarUrl != null
                        ? NetworkImage(user.avatarUrl!)
                        : null,
                    child: user.avatarUrl == null
                        ? Icon(
                            LucideIcons.user,
                            color: Theme.of(context).primaryColor,
                            size: 28,
                          )
                        : null,
                  ),
                ),
                Positioned(
                  right: 2,
                  bottom: 2,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: statusColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: [
                        BoxShadow(
                          color: statusColor.withValues(alpha: 0.4),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 16),
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
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                            letterSpacing: -0.4,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (user.isVerified) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.verified,
                          size: 18,
                          color: Colors.blueAccent,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.email,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.4),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      _buildBadge(
                        context,
                        user.role.displayName(isArabic: isArabic),
                        Theme.of(context).primaryColor,
                      ),
                      if (user.studentId != null)
                        _buildBadge(
                          context,
                          'ID: ${user.studentId}',
                          Colors.blueGrey,
                        ),
                      ...user.tags
                          .take(2)
                          .map(
                            (tag) => _buildBadge(context, '#$tag', Colors.grey),
                          ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Actions Column
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                PopupMenuButton<String>(
                  padding: EdgeInsets.zero,
                  icon: Icon(
                    LucideIcons.moreHorizontal,
                    size: 20,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  onSelected: (value) => _handleAction(context, ref, value),
                  itemBuilder: (context) => _buildMenuItems(isArabic),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: statusColor.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Text(
                    user.isBanned
                        ? (isArabic ? 'محظور' : 'Banned')
                        : (isActive
                              ? (isArabic ? 'نشط' : 'Active')
                              : (isArabic ? 'معطل' : 'Off')),
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: statusColor,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBadge(BuildContext context, String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color.withValues(alpha: 0.15), width: 1),
      ),
      child: Text(
        text,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: color.withValues(alpha: 0.8),
        ),
      ),
    );
  }

  List<PopupMenuEntry<String>> _buildMenuItems(bool isArabic) {
    return [
      _buildMenuItem(
        'verify',
        user.isVerified ? LucideIcons.userMinus : LucideIcons.userCheck,
        user.isVerified
            ? (isArabic ? 'إزالة التوثيق' : 'Unverify')
            : (isArabic ? 'توثيق الحساب' : 'Verify'),
      ),
      _buildMenuItem(
        'warn',
        LucideIcons.alertTriangle,
        isArabic ? 'إضافة إنذار' : 'Add Warning',
      ),
      _buildMenuItem(
        'tags',
        LucideIcons.tag,
        isArabic ? 'إدارة التاجات' : 'Manage Tags',
      ),
      const PopupMenuDivider(),
      _buildMenuItem(
        'ban',
        LucideIcons.ban,
        user.isBanned
            ? (isArabic ? 'فك الحظر' : 'Unban')
            : (isArabic ? 'حظر نهائي' : 'Permanent Ban'),
        color: user.isBanned ? Colors.green : Colors.red,
      ),
    ];
  }

  PopupMenuItem<String> _buildMenuItem(
    String value,
    IconData icon,
    String text, {
    Color? color,
  }) {
    return PopupMenuItem(
      value: value,
      child: Row(
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(width: 12),
          Text(text, style: TextStyle(color: color, fontSize: 14)),
        ],
      ),
    );
  }

  void _handleAction(BuildContext context, WidgetRef ref, String action) {
    final notifier = ref.read(
      usersControllerProvider(category: user.role.category).notifier,
    );

    switch (action) {
      case 'verify':
        notifier.toggleVerification(user.id, !user.isVerified);
        break;
      case 'warn':
        if (user.warningLevel < 4) {
          notifier.updateWarningLevel(user.id, user.warningLevel + 1);
        }
        break;
      case 'ban':
        notifier.toggleBan(user.id, !user.isBanned);
        break;
      case 'tags':
        _showTagsDialog(context, notifier);
        break;
    }
  }

  void _showTagsDialog(BuildContext context, UsersController notifier) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final controller = TextEditingController(text: user.tags.join(', '));

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(isArabic ? 'إدارة التاجات' : 'Manage Tags'),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            hintText: isArabic ? 'تاج1, تاج2...' : 'tag1, tag2...',
            helperText: isArabic
                ? 'افصل بين التاجات بفاصلة'
                : 'Separate tags with commas',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(isArabic ? 'إلغاء' : 'Cancel'),
          ),
          TextButton(
            onPressed: () {
              final tags = controller.text
                  .split(',')
                  .map((e) => e.trim())
                  .where((e) => e.isNotEmpty)
                  .toList();
              notifier.updateTags(user.id, tags);
              Navigator.pop(context);
            },
            child: Text(isArabic ? 'حفظ' : 'Save'),
          ),
        ],
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
      checkmarkColor: Theme.of(context).primaryColor,
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

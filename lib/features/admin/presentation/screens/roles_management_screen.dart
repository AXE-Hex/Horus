import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/roles.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/admin/data/models/dynamic_role_model.dart';
import 'package:hue/features/admin/presentation/providers/roles_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RolesManagementScreen extends ConsumerStatefulWidget {
  const RolesManagementScreen({super.key});

  @override
  ConsumerState<RolesManagementScreen> createState() =>
      _RolesManagementScreenState();
}

class _RolesManagementScreenState extends ConsumerState<RolesManagementScreen>
    with SingleTickerProviderStateMixin {
  final _searchController = TextEditingController();
  String _searchQuery = '';
  late final TabController _tabController;

  static const _categories = RoleCategory.values;

  @override
  void initState() {
    super.initState();
    // +1 tab for "Custom" roles
    _tabController = TabController(length: _categories.length + 1, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final primaryColor = Theme.of(context).primaryColor;
    final dynamicRolesAsync = ref.watch(rolesProvider);

    return GlassScaffold(
      maxWidth: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          isArabic ? 'إدارة الرتب' : 'Roles Management',
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          // Merge button
          Container(
            margin: const EdgeInsets.only(right: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF6366F1).withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: const Icon(LucideIcons.merge, size: 18),
              color: const Color(0xFF6366F1),
              tooltip: isArabic ? 'دمج رتبتين' : 'Merge Roles',
              onPressed: () => _showMergeDialog(isArabic),
            ),
          ),
          // Create button
          Container(
            margin: const EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [primaryColor, primaryColor.withValues(alpha: 0.7)],
              ),
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withValues(alpha: 0.3),
                  blurRadius: 12,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(LucideIcons.plus, size: 18),
              color: Colors.white,
              tooltip: isArabic ? 'إنشاء رتبة جديدة' : 'Create Role',
              onPressed: () => _showCreateRoleDialog(isArabic),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search Bar
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              borderRadius: BorderRadius.circular(18),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                style: GoogleFonts.inter(color: Colors.white),
                decoration: InputDecoration(
                  hintText: isArabic ? 'بحث عن رتبة...' : 'Search roles...',
                  hintStyle: GoogleFonts.inter(color: Colors.white30),
                  icon: Icon(
                    LucideIcons.search,
                    size: 18,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                  border: InputBorder.none,
                  suffixIcon: _searchQuery.isNotEmpty
                      ? IconButton(
                          icon: const Icon(LucideIcons.x, size: 16),
                          onPressed: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                        )
                      : null,
                ),
              ),
            ),
          ).animate().fadeIn().slideY(begin: -0.03, end: 0),

          // ── Category Tabs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorColor: primaryColor,
              indicatorWeight: 3,
              labelStyle: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
              unselectedLabelStyle: GoogleFonts.inter(fontSize: 12),
              labelColor: Colors.white,
              unselectedLabelColor: Colors.white.withValues(alpha: 0.35),
              tabAlignment: TabAlignment.start,
              tabs: [
                ..._categories.map(
                  (c) => Tab(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_getCategoryIcon(c), size: 14),
                        const SizedBox(width: 6),
                        Text(_getCategoryName(c, isArabic)),
                      ],
                    ),
                  ),
                ),
                Tab(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(LucideIcons.sparkles, size: 14),
                      const SizedBox(width: 6),
                      Text(isArabic ? 'مخصصة' : 'Custom'),
                    ],
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(delay: 50.ms),

          const SizedBox(height: 8),

          // ── Tab Content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                ..._categories.map(
                  (c) => _buildCategoryRoles(c, isArabic, primaryColor),
                ),
                _buildCustomRoles(dynamicRolesAsync, isArabic, primaryColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Built-in Roles by Category ──────────────────────────────────────

  Widget _buildCategoryRoles(
    RoleCategory category,
    bool isArabic,
    Color primaryColor,
  ) {
    final categoryRoles = roleRegistry.entries
        .where((e) => e.value.category == category)
        .toList();

    final filtered = _searchQuery.isEmpty
        ? categoryRoles
        : categoryRoles.where((e) {
            final q = _searchQuery.toLowerCase();
            return e.value.nameEn.toLowerCase().contains(q) ||
                e.value.nameAr.contains(q) ||
                e.key.name.toLowerCase().contains(q);
          }).toList();

    if (filtered.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              _getCategoryIcon(category),
              size: 40,
              color: Colors.white.withValues(alpha: 0.1),
            ),
            const SizedBox(height: 12),
            Text(
              _searchQuery.isNotEmpty
                  ? (isArabic ? 'لا توجد نتائج' : 'No results')
                  : (isArabic ? 'لا توجد رتب' : 'No roles'),
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.25),
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      itemCount: filtered.length + 1, // +1 for header
      itemBuilder: (context, index) {
        if (index == 0) {
          return _buildCategoryHeader(
            category,
            filtered.length,
            isArabic,
          ).animate().fadeIn();
        }
        final entry = filtered[index - 1];
        return _BuiltInRoleTile(
              roleInfo: entry.value,
              isArabic: isArabic,
              categoryColor: _getCategoryColor(category),
            )
            .animate()
            .fadeIn(delay: (index * 40).ms, duration: 350.ms)
            .slideY(begin: 0.04, end: 0);
      },
    );
  }

  Widget _buildCategoryHeader(RoleCategory category, int count, bool isArabic) {
    final color = _getCategoryColor(category);
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        padding: const EdgeInsets.all(18),
        borderRadius: BorderRadius.circular(22),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(_getCategoryIcon(category), size: 22, color: color),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _getCategoryName(category, isArabic),
                    style: GoogleFonts.outfit(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    '$count ${isArabic ? "رتبة" : "roles"}',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                count.toString(),
                style: GoogleFonts.shareTechMono(
                  fontSize: 16,
                  fontWeight: FontWeight.w900,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Custom / Dynamic Roles Tab ──────────────────────────────────────

  Widget _buildCustomRoles(
    AsyncValue<List<DynamicRoleModel>> asyncRoles,
    bool isArabic,
    Color primaryColor,
  ) {
    return asyncRoles.when(
      data: (roles) {
        final filtered = _searchQuery.isEmpty
            ? roles
            : roles.where((r) {
                final q = _searchQuery.toLowerCase();
                return r.nameEn.toLowerCase().contains(q) ||
                    r.nameAr.contains(q) ||
                    r.code.toLowerCase().contains(q);
              }).toList();

        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF6366F1).withValues(alpha: 0.06),
                  ),
                  child: const Icon(
                    LucideIcons.sparkles,
                    size: 40,
                    color: Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  isArabic ? 'لا توجد رتب مخصصة بعد' : 'No custom roles yet',
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isArabic
                      ? 'أنشئ رتبة جديدة أو ادمج رتبتين'
                      : 'Create a new role or merge two roles',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.2),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildSmallButton(
                      icon: LucideIcons.plus,
                      label: isArabic ? 'إنشاء' : 'Create',
                      color: primaryColor,
                      onTap: () => _showCreateRoleDialog(isArabic),
                    ),
                    const SizedBox(width: 12),
                    _buildSmallButton(
                      icon: LucideIcons.merge,
                      label: isArabic ? 'دمج' : 'Merge',
                      color: const Color(0xFF6366F1),
                      onTap: () => _showMergeDialog(isArabic),
                    ),
                  ],
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final role = filtered[index];
            return _DynamicRoleTile(
                  role: role,
                  isArabic: isArabic,
                  onEdit: () => _showEditRoleDialog(role, isArabic),
                  onDelete: () => _confirmDeleteRole(role, isArabic),
                )
                .animate()
                .fadeIn(delay: (index * 50).ms, duration: 350.ms)
                .slideY(begin: 0.04, end: 0);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.alertTriangle,
              size: 32,
              color: Colors.orangeAccent.withValues(alpha: 0.5),
            ),
            const SizedBox(height: 12),
            Text(
              isArabic
                  ? 'لا يمكن تحميل الرتب المخصصة'
                  : 'Could not load custom roles',
              style: GoogleFonts.inter(
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              isArabic
                  ? 'تأكد من وجود جدول "roles" في Supabase'
                  : 'Make sure "roles" table exists in Supabase',
              style: GoogleFonts.inter(
                fontSize: 11,
                color: Colors.white.withValues(alpha: 0.2),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSmallButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Create Role Dialog ──────────────────────────────────────────────

  void _showCreateRoleDialog(bool isArabic) {
    final nameEnCtrl = TextEditingController();
    final nameArCtrl = TextEditingController();
    final descEnCtrl = TextEditingController();
    final descArCtrl = TextEditingController();
    RoleCategory selectedCategory = RoleCategory.studentRoles;
    Set<RolePermission> selectedPerms = {};

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          backgroundColor: const Color(0xFF151528),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(28),
          ),
          title: Row(
            children: [
              Icon(
                LucideIcons.plus,
                size: 20,
                color: Theme.of(context).primaryColor,
              ),
              const SizedBox(width: 10),
              Text(
                isArabic ? 'إنشاء رتبة جديدة' : 'Create New Role',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDialogField(
                    nameEnCtrl,
                    isArabic ? 'الاسم بالإنجليزية' : 'Name (English)',
                    LucideIcons.type,
                  ),
                  const SizedBox(height: 12),
                  _buildDialogField(
                    nameArCtrl,
                    isArabic ? 'الاسم بالعربية' : 'Name (Arabic)',
                    LucideIcons.languages,
                  ),
                  const SizedBox(height: 14),
                  Text(
                    isArabic ? 'القسم' : 'Category',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.04),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                    child: DropdownButtonFormField<RoleCategory>(
                      initialValue: selectedCategory,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                      ),
                      dropdownColor: const Color(0xFF1E1E38),
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                      items: RoleCategory.values
                          .map(
                            (c) => DropdownMenuItem(
                              value: c,
                              child: Row(
                                children: [
                                  Icon(
                                    _getCategoryIcon(c),
                                    size: 16,
                                    color: _getCategoryColor(c),
                                  ),
                                  const SizedBox(width: 10),
                                  Text(_getCategoryName(c, isArabic)),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (v) =>
                          setDialogState(() => selectedCategory = v!),
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildDialogField(
                    descEnCtrl,
                    isArabic ? 'الوصف بالإنجليزية' : 'Description (English)',
                    LucideIcons.fileText,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 12),
                  _buildDialogField(
                    descArCtrl,
                    isArabic ? 'الوصف بالعربية' : 'Description (Arabic)',
                    LucideIcons.fileText,
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isArabic ? 'الصلاحيات' : 'Permissions',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withValues(alpha: 0.5),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildPermissionsGrid(selectedPerms, setDialogState),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: Text(
                isArabic ? 'إلغاء' : 'Cancel',
                style: GoogleFonts.inter(color: Colors.white60),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (nameEnCtrl.text.isEmpty) return;
                final role = DynamicRoleModel(
                  id: '',
                  code: nameEnCtrl.text.toLowerCase().replaceAll(' ', '_'),
                  nameEn: nameEnCtrl.text,
                  nameAr: nameArCtrl.text,
                  descriptionEn: descEnCtrl.text,
                  descriptionAr: descArCtrl.text,
                  category: selectedCategory,
                  permissions: selectedPerms,
                  hierarchyLevel: 10,
                );
                ref.read(rolesControllerProvider.notifier).addRole(role);
                Navigator.pop(ctx);
                _showSuccessSnackBar(
                  isArabic ? 'تم إنشاء الرتبة بنجاح' : 'Role created',
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
              child: Text(
                isArabic ? 'إنشاء' : 'Create',
                style: GoogleFonts.inter(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Merge Roles Dialog ──────────────────────────────────────────────

  void _showMergeDialog(bool isArabic) {
    UserRole? roleA;
    UserRole? roleB;
    final mergedNameCtrl = TextEditingController();
    final mergedNameArCtrl = TextEditingController();

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) {
          final mergedPerms = <RolePermission>{};
          if (roleA != null) {
            mergedPerms.addAll(roleRegistry[roleA]?.permissions ?? {});
          }
          if (roleB != null) {
            mergedPerms.addAll(roleRegistry[roleB]?.permissions ?? {});
          }

          return AlertDialog(
            backgroundColor: const Color(0xFF151528),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(28),
            ),
            title: Row(
              children: [
                const Icon(
                  LucideIcons.merge,
                  size: 20,
                  color: Color(0xFF6366F1),
                ),
                const SizedBox(width: 10),
                Text(
                  isArabic ? 'دمج رتبتين' : 'Merge Two Roles',
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      isArabic
                          ? 'اختر رتبتين لدمجهما وإنشاء رتبة مدمجة جديدة'
                          : 'Select two roles to combine their permissions',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Role A
                    _buildRoleSelector(
                      label: isArabic ? 'الرتبة الأولى' : 'First Role',
                      value: roleA,
                      excludeRole: roleB,
                      isArabic: isArabic,
                      onChanged: (v) => setDialogState(() => roleA = v),
                    ),
                    const SizedBox(height: 8),
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          LucideIcons.plus,
                          size: 16,
                          color: Color(0xFF6366F1),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Role B
                    _buildRoleSelector(
                      label: isArabic ? 'الرتبة الثانية' : 'Second Role',
                      value: roleB,
                      excludeRole: roleA,
                      isArabic: isArabic,
                      onChanged: (v) => setDialogState(() => roleB = v),
                    ),
                    const SizedBox(height: 16),
                    // Merged name
                    _buildDialogField(
                      mergedNameCtrl,
                      isArabic
                          ? 'اسم الرتبة المدمجة (إنجليزي)'
                          : 'Merged Role Name (English)',
                      LucideIcons.tag,
                    ),
                    const SizedBox(height: 10),
                    _buildDialogField(
                      mergedNameArCtrl,
                      isArabic
                          ? 'اسم الرتبة المدمجة (عربي)'
                          : 'Merged Role Name (Arabic)',
                      LucideIcons.languages,
                    ),
                    // Preview
                    if (roleA != null && roleB != null) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFF6366F1,
                          ).withValues(alpha: 0.06),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(
                              0xFF6366F1,
                            ).withValues(alpha: 0.15),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              isArabic
                                  ? 'معاينة الصلاحيات المدمجة'
                                  : 'Merged Permissions Preview',
                              style: GoogleFonts.outfit(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF6366F1),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${mergedPerms.length} ${isArabic ? "صلاحية" : "permissions"}',
                              style: GoogleFonts.shareTechMono(
                                fontSize: 12,
                                color: Colors.white.withValues(alpha: 0.5),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 4,
                              runSpacing: 4,
                              children: mergedPerms.map((p) {
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 6,
                                    vertical: 2,
                                  ),
                                  decoration: BoxDecoration(
                                    color: const Color(
                                      0xFF6366F1,
                                    ).withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    p.name,
                                    style: GoogleFonts.shareTechMono(
                                      fontSize: 9,
                                      color: const Color(0xFF6366F1),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text(
                  isArabic ? 'إلغاء' : 'Cancel',
                  style: GoogleFonts.inter(color: Colors.white60),
                ),
              ),
              ElevatedButton(
                onPressed: roleA != null && roleB != null
                    ? () {
                        final infoA = roleRegistry[roleA]!;
                        final infoB = roleRegistry[roleB]!;
                        final name = mergedNameCtrl.text.isNotEmpty
                            ? mergedNameCtrl.text
                            : '${infoA.nameEn} + ${infoB.nameEn}';
                        final nameAr = mergedNameArCtrl.text.isNotEmpty
                            ? mergedNameArCtrl.text
                            : '${infoA.nameAr} + ${infoB.nameAr}';

                        final merged = DynamicRoleModel(
                          id: '',
                          code: '${roleA!.name}_${roleB!.name}_merged',
                          nameEn: name,
                          nameAr: nameAr,
                          descriptionEn:
                              'Merged role: ${infoA.nameEn} + ${infoB.nameEn}',
                          descriptionAr:
                              'رتبة مدمجة: ${infoA.nameAr} + ${infoB.nameAr}',
                          category: infoA.category,
                          permissions: mergedPerms,
                          hierarchyLevel:
                              (infoA.hierarchyLevel + infoB.hierarchyLevel) ~/
                              2,
                        );

                        ref
                            .read(rolesControllerProvider.notifier)
                            .addRole(merged);
                        Navigator.pop(ctx);
                        _showSuccessSnackBar(
                          isArabic
                              ? 'تم دمج الرتبتين بنجاح'
                              : 'Roles merged successfully',
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  disabledBackgroundColor: Colors.white.withValues(alpha: 0.06),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                ),
                child: Text(
                  isArabic ? 'دمج' : 'Merge',
                  style: GoogleFonts.inter(fontWeight: FontWeight.w700),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildRoleSelector({
    required String label,
    required UserRole? value,
    required UserRole? excludeRole,
    required bool isArabic,
    required ValueChanged<UserRole?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: DropdownButtonFormField<UserRole>(
        initialValue: value,
        isExpanded: true,
        decoration: InputDecoration(
          border: InputBorder.none,
          labelText: label,
          labelStyle: GoogleFonts.inter(
            fontSize: 12,
            color: Colors.white.withValues(alpha: 0.4),
          ),
        ),
        dropdownColor: const Color(0xFF1E1E38),
        style: GoogleFonts.inter(fontSize: 13, color: Colors.white),
        items: UserRole.values
            .where((r) => r != excludeRole && roleRegistry.containsKey(r))
            .map(
              (r) => DropdownMenuItem(
                value: r,
                child: Text(
                  isArabic ? roleRegistry[r]!.nameAr : roleRegistry[r]!.nameEn,
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }

  // ── Edit / Delete Dialogs ──────────────────────────────────────────

  void _showEditRoleDialog(DynamicRoleModel role, bool isArabic) {
    final nameEnCtrl = TextEditingController(text: role.nameEn);
    final nameArCtrl = TextEditingController(text: role.nameAr);
    final descEnCtrl = TextEditingController(text: role.descriptionEn);
    final descArCtrl = TextEditingController(text: role.descriptionAr);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF151528),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
        title: Text(
          isArabic ? 'تعديل الرتبة' : 'Edit Role',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w800),
        ),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDialogField(nameEnCtrl, 'Name (English)', LucideIcons.type),
              const SizedBox(height: 12),
              _buildDialogField(
                nameArCtrl,
                'Name (Arabic)',
                LucideIcons.languages,
              ),
              const SizedBox(height: 12),
              _buildDialogField(
                descEnCtrl,
                'Description (English)',
                LucideIcons.fileText,
                maxLines: 2,
              ),
              const SizedBox(height: 12),
              _buildDialogField(
                descArCtrl,
                'Description (Arabic)',
                LucideIcons.fileText,
                maxLines: 2,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              isArabic ? 'إلغاء' : 'Cancel',
              style: GoogleFonts.inter(color: Colors.white60),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(rolesControllerProvider.notifier).updateRole(role.id, {
                'name_en': nameEnCtrl.text,
                'name_ar': nameArCtrl.text,
                'description_en': descEnCtrl.text,
                'description_ar': descArCtrl.text,
              });
              Navigator.pop(ctx);
              _showSuccessSnackBar(
                isArabic ? 'تم تحديث الرتبة' : 'Role updated',
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              isArabic ? 'حفظ' : 'Save',
              style: GoogleFonts.inter(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDeleteRole(DynamicRoleModel role, bool isArabic) {
    HapticFeedback.mediumImpact();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF151528),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: Text(
          isArabic ? 'حذف الرتبة' : 'Delete Role',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w800),
        ),
        content: Text(
          isArabic
              ? 'هل تريد حذف "${role.nameAr}"؟ لا يمكن التراجع.'
              : 'Delete "${role.nameEn}"? This cannot be undone.',
          style: GoogleFonts.inter(color: Colors.white.withValues(alpha: 0.6)),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: Text(
              isArabic ? 'إلغاء' : 'Cancel',
              style: GoogleFonts.inter(color: Colors.white60),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ref.read(rolesControllerProvider.notifier).removeRole(role.id);
              Navigator.pop(ctx);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFEF4444),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              isArabic ? 'حذف' : 'Delete',
              style: GoogleFonts.inter(fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }

  // ── Helper Widgets ──────────────────────────────────────────────────

  Widget _buildDialogField(
    TextEditingController ctrl,
    String label,
    IconData icon, {
    int maxLines = 1,
  }) {
    return TextField(
      controller: ctrl,
      maxLines: maxLines,
      style: GoogleFonts.inter(color: Colors.white, fontSize: 13),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: GoogleFonts.inter(
          fontSize: 12,
          color: Colors.white.withValues(alpha: 0.4),
        ),
        prefixIcon: Icon(icon, size: 16, color: Colors.white30),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.04),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.08)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor.withValues(alpha: 0.4),
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionsGrid(
    Set<RolePermission> selected,
    StateSetter setDialogState,
  ) {
    return Wrap(
      spacing: 6,
      runSpacing: 6,
      children: RolePermission.values.map((p) {
        final isSelected = selected.contains(p);
        return GestureDetector(
          onTap: () {
            setDialogState(() {
              if (isSelected) {
                selected.remove(p);
              } else {
                selected.add(p);
              }
            });
          },
          child: AnimatedContainer(
            duration: 200.ms,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).primaryColor.withValues(alpha: 0.15)
                  : Colors.white.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).primaryColor.withValues(alpha: 0.4)
                    : Colors.white.withValues(alpha: 0.06),
              ),
            ),
            child: Text(
              p.name,
              style: GoogleFonts.shareTechMono(
                fontSize: 9,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected
                    ? Theme.of(context).primaryColor
                    : Colors.white.withValues(alpha: 0.3),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  void _showSuccessSnackBar(String message) {
    HapticFeedback.heavyImpact();
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(LucideIcons.checkCircle, color: Colors.white, size: 18),
            const SizedBox(width: 10),
            Flexible(
              child: Text(
                message,
                style: GoogleFonts.inter(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF10B981),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  // ── Static Helpers ──────────────────────────────────────────────────

  static IconData _getCategoryIcon(RoleCategory c) {
    switch (c) {
      case RoleCategory.adminIT:
        return LucideIcons.shield;
      case RoleCategory.academicLeadership:
        return LucideIcons.crown;
      case RoleCategory.teachingStaff:
        return LucideIcons.graduationCap;
      case RoleCategory.studentAffairs:
        return LucideIcons.bookOpen;
      case RoleCategory.studentRoles:
        return LucideIcons.users;
      case RoleCategory.facilitiesSecurity:
        return LucideIcons.building;
      case RoleCategory.externalRoles:
        return LucideIcons.globe;
    }
  }

  static Color _getCategoryColor(RoleCategory c) {
    switch (c) {
      case RoleCategory.adminIT:
        return Colors.blueAccent;
      case RoleCategory.academicLeadership:
        return Colors.amber;
      case RoleCategory.teachingStaff:
        return const Color(0xFF10B981);
      case RoleCategory.studentAffairs:
        return Colors.orangeAccent;
      case RoleCategory.studentRoles:
        return const Color(0xFF6366F1);
      case RoleCategory.facilitiesSecurity:
        return Colors.tealAccent;
      case RoleCategory.externalRoles:
        return Colors.pinkAccent;
    }
  }

  static String _getCategoryName(RoleCategory c, bool isArabic) {
    switch (c) {
      case RoleCategory.adminIT:
        return isArabic ? 'الإدارة والتقنية' : 'Admin & IT';
      case RoleCategory.academicLeadership:
        return isArabic ? 'القيادة الأكاديمية' : 'Leadership';
      case RoleCategory.teachingStaff:
        return isArabic ? 'الهيئة التدريسية' : 'Teaching';
      case RoleCategory.studentAffairs:
        return isArabic ? 'شؤون الطلاب' : 'Student Affairs';
      case RoleCategory.studentRoles:
        return isArabic ? 'الطلاب' : 'Students';
      case RoleCategory.facilitiesSecurity:
        return isArabic ? 'المرافق والأمن' : 'Facilities';
      case RoleCategory.externalRoles:
        return isArabic ? 'خارجي' : 'External';
    }
  }
}

// ── Built-in Role Tile ────────────────────────────────────────────────

class _BuiltInRoleTile extends StatefulWidget {
  final RoleInfo roleInfo;
  final bool isArabic;
  final Color categoryColor;

  const _BuiltInRoleTile({
    required this.roleInfo,
    required this.isArabic,
    required this.categoryColor,
  });

  @override
  State<_BuiltInRoleTile> createState() => _BuiltInRoleTileState();
}

class _BuiltInRoleTileState extends State<_BuiltInRoleTile> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        borderRadius: BorderRadius.circular(20),
        onTap: () => setState(() => _expanded = !_expanded),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: widget.categoryColor.withValues(alpha: 0.12),
                    ),
                    child: Center(
                      child: Text(
                        '${widget.roleInfo.hierarchyLevel}',
                        style: GoogleFonts.shareTechMono(
                          fontSize: 16,
                          fontWeight: FontWeight.w900,
                          color: widget.categoryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.roleInfo.nameEn,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          widget.roleInfo.nameAr,
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 3,
                    ),
                    decoration: BoxDecoration(
                      color: widget.categoryColor.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      '${widget.roleInfo.permissions.length}',
                      style: GoogleFonts.shareTechMono(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: widget.categoryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedRotation(
                    duration: 200.ms,
                    turns: _expanded ? 0.5 : 0,
                    child: Icon(
                      LucideIcons.chevronDown,
                      size: 16,
                      color: Colors.white.withValues(alpha: 0.2),
                    ),
                  ),
                ],
              ),
            ),
            if (_expanded)
              Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: Colors.white.withValues(alpha: 0.05)),
                    const SizedBox(height: 8),
                    Text(
                      widget.isArabic
                          ? widget.roleInfo.descriptionAr
                          : widget.roleInfo.descriptionEn,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white.withValues(alpha: 0.4),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      widget.isArabic ? 'الصلاحيات:' : 'Permissions:',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.white.withValues(alpha: 0.35),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 4,
                      runSpacing: 4,
                      children: widget.roleInfo.permissions.map((p) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 3,
                          ),
                          decoration: BoxDecoration(
                            color: widget.categoryColor.withValues(alpha: 0.08),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            p.name,
                            style: GoogleFonts.shareTechMono(
                              fontSize: 9,
                              color: widget.categoryColor,
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Dynamic Role Tile ─────────────────────────────────────────────────

class _DynamicRoleTile extends StatelessWidget {
  final DynamicRoleModel role;
  final bool isArabic;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _DynamicRoleTile({
    required this.role,
    required this.isArabic,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isMerged = role.code.contains('_merged');

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(20),
        border: isMerged
            ? Border.all(color: const Color(0xFF6366F1).withValues(alpha: 0.2))
            : null,
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: isMerged
                    ? LinearGradient(
                        colors: [
                          const Color(0xFF6366F1).withValues(alpha: 0.2),
                          Colors.purpleAccent.withValues(alpha: 0.1),
                        ],
                      )
                    : null,
                color: isMerged
                    ? null
                    : const Color(0xFF10B981).withValues(alpha: 0.12),
              ),
              child: Icon(
                isMerged ? LucideIcons.merge : LucideIcons.sparkles,
                size: 18,
                color: isMerged
                    ? const Color(0xFF6366F1)
                    : const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          role.nameEn,
                          style: GoogleFonts.outfit(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isMerged) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(
                              0xFF6366F1,
                            ).withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            isArabic ? 'مدمجة' : 'MERGED',
                            style: GoogleFonts.inter(
                              fontSize: 8,
                              fontWeight: FontWeight.w800,
                              color: const Color(0xFF6366F1),
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    role.nameAr,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(LucideIcons.pencil, size: 16),
              color: Colors.white30,
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(LucideIcons.trash2, size: 16),
              color: const Color(0xFFEF4444).withValues(alpha: 0.5),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
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

class _RolesManagementScreenState extends ConsumerState<RolesManagementScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final rolesAsync = ref.watch(rolesProvider);

    return GlassScaffold(
      maxWidth: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          t.admin.roles_management,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.plus),
            onPressed: () => _showRoleDialog(context),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GlassContainer(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _searchController,
                onChanged: (v) => setState(() => _searchQuery = v),
                decoration: InputDecoration(
                  hintText: 'Search roles...',
                  icon: const Icon(LucideIcons.search, size: 20),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: rolesAsync.when(
              data: (roles) {
                final filtered = roles.where((r) {
                  final q = _searchQuery.toLowerCase();
                  return r.nameEn.toLowerCase().contains(q) ||
                      r.nameAr.contains(q) ||
                      r.code.toLowerCase().contains(q);
                }).toList();

                if (filtered.isEmpty) {
                  return Center(
                    child: Text('No roles found matching your search.'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final role = filtered[index];
                    return _RoleTile(role: role, index: index);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text('Error: $e')),
            ),
          ),
        ],
      ),
    );
  }

  void _showRoleDialog(BuildContext context, [DynamicRoleModel? role]) {
    // Dialog for adding/editing a role
    showDialog(
      context: context,
      builder: (context) => _RoleEditDialog(role: role),
    );
  }
}

class _RoleTile extends ConsumerWidget {
  final DynamicRoleModel role;
  final int index;

  const _RoleTile({required this.role, required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: GlassContainer(
            padding: const EdgeInsets.all(20),
            onTap: () => _showRoleOptions(context, ref),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: theme.primaryColor.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    _getCategoryIcon(role.category),
                    color: theme.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        role.nameEn,
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        role.nameAr,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    role.category.name.toUpperCase(),
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                      color: Colors.white.withValues(alpha: 0.4),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: (index * 50).ms)
        .slideX(
          begin: Localizations.localeOf(context).languageCode == 'ar'
              ? -0.1
              : 0.1,
          end: 0,
        );
  }

  IconData _getCategoryIcon(RoleCategory category) {
    switch (category) {
      case RoleCategory.adminIT:
        return LucideIcons.shield;
      case RoleCategory.academicLeadership:
        return LucideIcons.crown;
      case RoleCategory.teachingStaff:
        return LucideIcons.graduationCap;
      case RoleCategory.studentRoles:
        return LucideIcons.user;
      default:
        return LucideIcons.users;
    }
  }

  void _showRoleOptions(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(LucideIcons.edit),
              title: const Text('Edit Role'),
              onTap: () {
                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => _RoleEditDialog(role: role),
                );
              },
            ),
            ListTile(
              leading: const Icon(LucideIcons.trash2, color: Colors.redAccent),
              title: const Text(
                'Delete Role',
                style: TextStyle(color: Colors.redAccent),
              ),
              onTap: () {
                Navigator.pop(context);
                _confirmDelete(context, ref);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Role?'),
        content: Text(
          'Are you sure you want to delete "${role.nameEn}"? This cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(rolesControllerProvider.notifier).removeRole(role.id);
              Navigator.pop(context);
            },
            child: const Text(
              'Delete',
              style: TextStyle(color: Colors.redAccent),
            ),
          ),
        ],
      ),
    );
  }
}

class _RoleEditDialog extends ConsumerStatefulWidget {
  final DynamicRoleModel? role;
  const _RoleEditDialog({this.role});

  @override
  ConsumerState<_RoleEditDialog> createState() => _RoleEditDialogState();
}

class _RoleEditDialogState extends ConsumerState<_RoleEditDialog> {
  late TextEditingController _nameEnController;
  late TextEditingController _nameArController;
  late TextEditingController _descEnController;
  late TextEditingController _descArController;
  late RoleCategory _category;

  @override
  void initState() {
    super.initState();
    _nameEnController = TextEditingController(text: widget.role?.nameEn);
    _nameArController = TextEditingController(text: widget.role?.nameAr);
    _descEnController = TextEditingController(text: widget.role?.descriptionEn);
    _descArController = TextEditingController(text: widget.role?.descriptionAr);
    _category = widget.role?.category ?? RoleCategory.studentRoles;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.role == null ? 'Add New Role' : 'Edit Role'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nameEnController,
              decoration: const InputDecoration(labelText: 'Name (English)'),
            ),
            TextField(
              controller: _nameArController,
              decoration: const InputDecoration(labelText: 'Name (Arabic)'),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<RoleCategory>(
              initialValue: _category,
              decoration: const InputDecoration(labelText: 'Category'),
              items: RoleCategory.values
                  .map((c) => DropdownMenuItem(value: c, child: Text(c.name)))
                  .toList(),
              onChanged: (v) => setState(() => _category = v!),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descEnController,
              decoration: const InputDecoration(
                labelText: 'Description (English)',
              ),
            ),
            TextField(
              controller: _descArController,
              decoration: const InputDecoration(
                labelText: 'Description (Arabic)',
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            if (widget.role == null) {
              ref
                  .read(rolesControllerProvider.notifier)
                  .addRole(
                    DynamicRoleModel(
                      id: '',
                      code: _nameEnController.text.toLowerCase().replaceAll(
                        ' ',
                        '_',
                      ),
                      nameEn: _nameEnController.text,
                      nameAr: _nameArController.text,
                      descriptionEn: _descEnController.text,
                      descriptionAr: _descArController.text,
                      category: _category,
                      permissions: {},
                      hierarchyLevel: 10,
                    ),
                  );
            } else {
              ref
                  .read(rolesControllerProvider.notifier)
                  .updateRole(widget.role!.id, {
                    'name_en': _nameEnController.text,
                    'name_ar': _nameArController.text,
                    'description_en': _descEnController.text,
                    'description_ar': _descArController.text,
                    'category': _category.name,
                  });
            }
            Navigator.pop(context);
          },
          child: const Text('Save'),
        ),
      ],
    );
  }
}

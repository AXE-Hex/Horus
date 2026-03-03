import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
// ignore: unnecessary_import
import 'package:hue/core/auth/roles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/admin/presentation/providers/users_provider.dart';
import 'package:hue/features/admin/presentation/providers/admin_stats_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class StudentManagementScreen extends ConsumerStatefulWidget {
  const StudentManagementScreen({super.key});

  @override
  ConsumerState<StudentManagementScreen> createState() =>
      _StudentManagementScreenState();
}

class _StudentManagementScreenState
    extends ConsumerState<StudentManagementScreen> {
  final _searchController = TextEditingController();
  String _levelFilter = 'all'; // all, 1, 2, 3, 4, 5
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final totalStudentsAsync = ref.watch(totalStudentCountProvider);

    return GlassScaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          t.admin.student_management,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.userPlus),
            onPressed: () => context.push(
              '/admin/users/new',
              extra: {'category': RoleCategory.studentRoles},
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // ── Specialized Stats Section
          _buildQuickStats(isArabic, totalStudentsAsync),

          // ── Filter Bar
          _buildFilterBar(isArabic),

          // ── Search Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: _buildSearchBar(isArabic),
          ),

          // ── Students List
          Expanded(child: _buildStudentsList(isArabic)),
        ],
      ),
    );
  }

  Widget _buildQuickStats(bool isArabic, AsyncValue<int> total) {
    return Container(
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        physics: const BouncingScrollPhysics(),
        children: [
          _StatMiniCard(
            label: t.admin.total_students,
            valueAsync: total,
            icon: LucideIcons.graduationCap,
            color: const Color(0xFF10B981),
          ),
          _StatMiniCard(
            label: t.admin.academic_warnings,
            valueAsync: const AsyncValue.data(5), // Mock for now
            icon: LucideIcons.alertTriangle,
            color: Colors.orangeAccent,
          ),
          _StatMiniCard(
            label: t.admin.pending_reg,
            valueAsync: const AsyncValue.data(12), // Mock for now
            icon: LucideIcons.clipboardList,
            color: const Color(0xFF6366F1),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isArabic) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: [
          _FilterChip(
            label: t.admin.all_levels,
            isSelected: _levelFilter == 'all',
            onTap: () => setState(() => _levelFilter = 'all'),
          ),
          ...List.generate(5, (index) {
            final level = (index + 1).toString();
            return _FilterChip(
              label: t.admin.level_level,
              isSelected: _levelFilter == level,
              onTap: () => setState(() => _levelFilter = level),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSearchBar(bool isArabic) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: BorderRadius.circular(24),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
        style: GoogleFonts.inter(fontSize: 14),
        decoration: InputDecoration(
          hintText: t.admin.search_student_or_id,
          prefixIcon: const Icon(
            LucideIcons.search,
            size: 18,
            color: Colors.white38,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildStudentsList(bool isArabic) {
    final studentsAsync = ref.watch(
      usersControllerProvider(category: RoleCategory.studentRoles),
    );

    return studentsAsync.when(
      data: (users) {
        final filtered = users.where((u) {
          final matchesSearch =
              u.fullName.toLowerCase().contains(_searchQuery) ||
              (u.studentId?.toLowerCase().contains(_searchQuery) ?? false);
          return matchesSearch;
        }).toList();

        if (filtered.isEmpty) return _buildEmptyState(isArabic);

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final student = filtered[index];
            return _StudentCard(student: student, isArabic: isArabic)
                .animate()
                .fadeIn(delay: (index * 40).ms)
                .slideX(begin: isArabic ? -0.05 : 0.05);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildEmptyState(bool isArabic) {
    return Center(
      child: Opacity(
        opacity: 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.graduationCap, size: 64),
            const SizedBox(height: 16),
            Text(
              t.admin.no_matching_students_found,
            ),
          ],
        ),
      ),
    );
  }
}

class _StatMiniCard extends StatelessWidget {
  final String label;
  final AsyncValue<int> valueAsync;
  final IconData icon;
  final Color color;

  const _StatMiniCard({
    required this.label,
    required this.valueAsync,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: 150,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                valueAsync.when(
                  data: (val) => Text(
                    val.toString(),
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  loading: () => const SizedBox(
                    height: 18,
                    width: 20,
                    child: LinearProgressIndicator(),
                  ),
                  error: (err, stack) => const Text('?'),
                ),
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 10,
                    color: Colors.white60,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final primary = Theme.of(context).primaryColor;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(right: 10),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? primary.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? primary : Colors.white.withValues(alpha: 0.05),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            color: isSelected ? primary : Colors.white70,
          ),
        ),
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  final dynamic student;
  final bool isArabic;

  const _StudentCard({required this.student, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.push('/admin/users/details', extra: student),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundImage: student.avatarUrl != null
                  ? NetworkImage(student.avatarUrl!)
                  : null,
              child: student.avatarUrl == null
                  ? const Icon(LucideIcons.user)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    student.fullName,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(LucideIcons.hash, size: 10, color: Colors.white38),
                      const SizedBox(width: 4),
                      Text(
                        student.studentId ?? 'N/A',
                        style: GoogleFonts.shareTechMono(
                          fontSize: 11,
                          color: Colors.white38,
                        ),
                      ),
                      const Spacer(),
                      _buildLevelBadge(context, 'Level 2'), // Mock Level
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLevelBadge(BuildContext context, String level) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        level,
        style: GoogleFonts.outfit(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}

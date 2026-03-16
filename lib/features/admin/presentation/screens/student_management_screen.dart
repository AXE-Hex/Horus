import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/core/auth/roles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
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
  String _levelFilter = 'all';
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final primaryColor = Theme.of(context).primaryColor;
    final totalStudentsAsync = ref.watch(totalStudentCountProvider);

    return GlassScaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(
          t.admin.student_management,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.w900,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
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
                extra: {'category': RoleCategory.studentRoles},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildQuickStats(isArabic, totalStudentsAsync, primaryColor),
          _buildFilterBar(isArabic, primaryColor),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: _buildSearchBar(isArabic, primaryColor),
          ),
          Expanded(child: _buildStudentsList(isArabic, primaryColor)),
        ],
      ),
    );
  }

  Widget _buildQuickStats(
    bool isArabic,
    AsyncValue<int> total,
    Color primaryColor,
  ) {
    return Container(
      height: 110,
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
            valueAsync: const AsyncValue.data(5),
            icon: LucideIcons.alertTriangle,
            color: Colors.orangeAccent,
          ),
          _StatMiniCard(
            label: t.admin.pending_reg,
            valueAsync: const AsyncValue.data(12),
            icon: LucideIcons.clipboardList,
            color: const Color(0xFF6366F1),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isArabic, Color primaryColor) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      child: Row(
        children: [
          _buildFilterChip(
            t.admin.all_levels,
            _levelFilter == 'all',
            () => setState(() => _levelFilter = 'all'),
            primaryColor,
          ),
          ...List.generate(5, (index) {
            final level = (index + 1).toString();
            return _buildFilterChip(
              '${t.admin.level_level} $level',
              _levelFilter == level,
              () => setState(() => _levelFilter = level),
              primaryColor,
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(
    String label,
    bool isSelected,
    VoidCallback onTap,
    Color primaryColor,
  ) {
    return GestureDetector(
      onTap: () {
        HapticFeedback.selectionClick();
        onTap();
      },
      child: AnimatedContainer(
        duration: 200.ms,
        margin: const EdgeInsets.only(right: 8),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.15)
              : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: isSelected
                ? primaryColor.withValues(alpha: 0.4)
                : Colors.white.withValues(alpha: 0.06),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            color: isSelected ? primaryColor : Colors.white60,
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(bool isArabic, Color primaryColor) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white.withValues(alpha: 0.05),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
        style: GoogleFonts.inter(fontSize: 14, color: Colors.white),
        decoration: InputDecoration(
          hintText: t.admin.search_student_or_id,
          hintStyle: GoogleFonts.inter(
            fontSize: 13,
            color: Colors.white.withValues(alpha: 0.25),
          ),
          prefixIcon: Icon(
            LucideIcons.search,
            size: 18,
            color: Colors.white.withValues(alpha: 0.35),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildStudentsList(bool isArabic, Color primaryColor) {
    final studentsAsync = ref.watch(
      usersControllerProvider(category: RoleCategory.studentRoles),
    );

    return studentsAsync.when(
      data: (users) {
        final filtered = users.where((u) {
          final matchesSearch =
              u.fullName.toLowerCase().contains(_searchQuery) ||
              (u.studentId?.toLowerCase().contains(_searchQuery) ?? false) ||
              u.email.toLowerCase().contains(_searchQuery);
          return matchesSearch;
        }).toList();

        if (filtered.isEmpty) return _buildEmptyState();

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final student = filtered[index];
            return _StudentCard(
                  student: student,
                  isArabic: isArabic,
                  primaryColor: primaryColor,
                )
                .animate()
                .fadeIn(delay: (index * 35).ms, duration: 300.ms)
                .slideX(begin: isArabic ? -0.03 : 0.03, end: 0);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF10B981).withValues(alpha: 0.06),
            ),
            child: const Icon(
              LucideIcons.graduationCap,
              size: 36,
              color: Color(0xFF10B981),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            t.admin.no_matching_students_found,
            style: GoogleFonts.outfit(
              fontSize: 14,
              color: Colors.white.withValues(alpha: 0.3),
            ),
          ),
        ],
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
      width: 145,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(14),
      borderRadius: BorderRadius.circular(20),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
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
                      fontWeight: FontWeight.w900,
                      fontSize: 20,
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
                    color: Colors.white.withValues(alpha: 0.4),
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

class _StudentCard extends StatelessWidget {
  final UserProfileModel student;
  final bool isArabic;
  final Color primaryColor;

  const _StudentCard({
    required this.student,
    required this.isArabic,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final statusColor = student.isBanned
        ? const Color(0xFFEF4444)
        : (student.isActive
              ? const Color(0xFF10B981)
              : const Color(0xFFF59E0B));

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        padding: const EdgeInsets.all(14),
        borderRadius: BorderRadius.circular(22),
        onTap: () => context.push('/admin/users/details', extra: student),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF10B981).withValues(alpha: 0.3),
                        const Color(0xFF10B981).withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                  child: student.avatarUrl != null
                      ? ClipOval(
                          child: Image.network(
                            student.avatarUrl!,
                            fit: BoxFit.cover,
                            width: 50,
                            height: 50,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  LucideIcons.user,
                                  size: 22,
                                  color: Colors.white70,
                                ),
                          ),
                        )
                      : const Icon(
                          LucideIcons.user,
                          size: 22,
                          color: Colors.white70,
                        ),
                ),
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
              ],
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
                          student.fullName,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w700,
                            fontSize: 15,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (student.isVerified) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          LucideIcons.badgeCheck,
                          size: 14,
                          color: Color(0xFF10B981),
                        ),
                      ],
                      if (student.warningLevel > 0) ...[
                        const SizedBox(width: 4),
                        const Icon(
                          LucideIcons.alertTriangle,
                          size: 12,
                          color: Colors.orangeAccent,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        LucideIcons.hash,
                        size: 10,
                        color: Colors.white.withValues(alpha: 0.3),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        student.studentId ?? 'N/A',
                        style: GoogleFonts.shareTechMono(
                          fontSize: 11,
                          color: Colors.white.withValues(alpha: 0.35),
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: primaryColor.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: primaryColor.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          student.roles.isNotEmpty
                              ? student.roles.first.displayName(
                                  isArabic: isArabic,
                                )
                              : '—',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: primaryColor,
                          ),
                        ),
                      ),
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
}

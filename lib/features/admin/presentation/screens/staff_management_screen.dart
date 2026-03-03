import 'package:flutter/material.dart';
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

class StaffManagementScreen extends ConsumerStatefulWidget {
  const StaffManagementScreen({super.key});

  @override
  ConsumerState<StaffManagementScreen> createState() =>
      _StaffManagementScreenState();
}

class _StaffManagementScreenState extends ConsumerState<StaffManagementScreen> {
  final _searchController = TextEditingController();
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
    final staffCountAsync = ref.watch(totalStaffCountProvider);

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.admin.staff_management,
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
                extra: {'category': RoleCategory.studentAffairs},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildQuickStats(isArabic, staffCountAsync),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: _buildSearchBar(isArabic, primaryColor),
          ),
          Expanded(child: _buildStaffList(isArabic, primaryColor)),
        ],
      ),
    );
  }

  Widget _buildQuickStats(bool isArabic, AsyncValue<int> total) {
    return Container(
      height: 110,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        children: [
          _StatCard(
            label: t.admin.total_staff,
            valueAsync: total,
            icon: LucideIcons.users,
            color: const Color(0xFF6366F1),
          ),
          _StatCard(
            label: t.admin.student_affairs,
            valueAsync: const AsyncValue.data(8),
            icon: LucideIcons.graduationCap,
            color: const Color(0xFF10B981),
          ),
        ],
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
          hintText: t.admin.search_staff_member,
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

  Widget _buildStaffList(bool isArabic, Color primaryColor) {
    final staffAsync = ref.watch(
      usersControllerProvider(category: RoleCategory.studentAffairs),
    );

    return staffAsync.when(
      data: (users) {
        final filtered = users
            .where(
              (u) =>
                  u.fullName.toLowerCase().contains(_searchQuery) ||
                  u.email.toLowerCase().contains(_searchQuery),
            )
            .toList();
        if (filtered.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF6366F1).withValues(alpha: 0.06),
                  ),
                  child: const Icon(
                    LucideIcons.users,
                    size: 36,
                    color: Color(0xFF6366F1),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'No staff found',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Colors.white.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 20),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final member = filtered[index];
            return _StaffTile(
                  member: member,
                  isArabic: isArabic,
                  primaryColor: primaryColor,
                )
                .animate()
                .fadeIn(delay: (index * 35).ms, duration: 300.ms)
                .slideY(begin: 0.04, end: 0);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (err, stack) => Center(child: Text('Error: $err')),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final AsyncValue<int> valueAsync;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.label,
    required this.valueAsync,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      width: 155,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(14),
      borderRadius: BorderRadius.circular(22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 16, color: color),
          ),
          const SizedBox(height: 10),
          valueAsync.when(
            data: (val) => Text(
              val.toString(),
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.w900,
              ),
            ),
            loading: () => const LinearProgressIndicator(),
            error: (err, stack) => const Text('?'),
          ),
          Text(
            label,
            style: GoogleFonts.outfit(
              fontSize: 10,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
        ],
      ),
    );
  }
}

class _StaffTile extends StatelessWidget {
  final UserProfileModel member;
  final bool isArabic;
  final Color primaryColor;

  const _StaffTile({
    required this.member,
    required this.isArabic,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final roleName = member.roles.isNotEmpty
        ? member.roles.first.displayName(isArabic: isArabic)
        : '—';
    final statusColor = member.isBanned
        ? const Color(0xFFEF4444)
        : (member.isActive ? const Color(0xFF10B981) : const Color(0xFFF59E0B));

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        padding: const EdgeInsets.all(14),
        borderRadius: BorderRadius.circular(22),
        onTap: () => context.push('/admin/users/details', extra: member),
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF6366F1).withValues(alpha: 0.3),
                        const Color(0xFF6366F1).withValues(alpha: 0.1),
                      ],
                    ),
                  ),
                  child: member.avatarUrl != null
                      ? ClipOval(
                          child: Image.network(
                            member.avatarUrl!,
                            fit: BoxFit.cover,
                            width: 48,
                            height: 48,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  LucideIcons.user,
                                  size: 20,
                                  color: Colors.white70,
                                ),
                          ),
                        )
                      : const Icon(
                          LucideIcons.user,
                          size: 20,
                          color: Colors.white70,
                        ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
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
                  Text(
                    member.fullName,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    member.email,
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      color: Colors.white.withValues(alpha: 0.3),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF6366F1).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: const Color(0xFF6366F1).withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      roleName,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF6366F1),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              isArabic ? LucideIcons.chevronLeft : LucideIcons.chevronRight,
              size: 16,
              color: Colors.white.withValues(alpha: 0.15),
            ),
          ],
        ),
      ),
    );
  }
}

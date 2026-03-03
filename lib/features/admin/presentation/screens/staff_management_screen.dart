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
    final staffCountAsync = ref.watch(totalStaffCountProvider);

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.admin.staff_management,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.userPlus),
            onPressed: () => context.push(
              '/admin/users/new',
              extra: {'category': RoleCategory.studentAffairs},
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // ── Staff Stats
          _buildQuickStats(isArabic, staffCountAsync),

          // ── Search & Filter
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildSearchBar(isArabic),
          ),

          // ── Staff List
          Expanded(child: _buildStaffList(isArabic)),
        ],
      ),
    );
  }

  Widget _buildQuickStats(bool isArabic, AsyncValue<int> total) {
    return Container(
      height: 120,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        scrollDirection: Axis.horizontal,
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

  Widget _buildSearchBar(bool isArabic) {
    return GlassContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      borderRadius: BorderRadius.circular(24),
      child: TextField(
        controller: _searchController,
        onChanged: (val) => setState(() => _searchQuery = val.toLowerCase()),
        style: GoogleFonts.inter(fontSize: 14),
        decoration: InputDecoration(
          hintText: t.admin.search_staff_member,
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

  Widget _buildStaffList(bool isArabic) {
    // Note: Staff currently under studentAffairs category in roles logic
    final staffAsync = ref.watch(
      usersControllerProvider(category: RoleCategory.studentAffairs),
    );

    return staffAsync.when(
      data: (users) {
        final filtered = users
            .where((u) => u.fullName.toLowerCase().contains(_searchQuery))
            .toList();
        if (filtered.isEmpty) {
          return const Center(child: Text('No staff found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final member = filtered[index];
            return _StaffTile(member: member, isArabic: isArabic)
                .animate()
                .fadeIn(delay: (index * 40).ms)
                .slideY(begin: 0.05, end: 0);
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
      width: 160,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(16),
      borderRadius: BorderRadius.circular(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18, color: color),
          const SizedBox(height: 8),
          valueAsync.when(
            data: (val) => Text(
              val.toString(),
              style: GoogleFonts.outfit(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            loading: () => const LinearProgressIndicator(),
            error: (err, stack) => const Text('?'),
          ),
          Text(
            label,
            style: GoogleFonts.outfit(fontSize: 10, color: Colors.white60),
          ),
        ],
      ),
    );
  }
}

class _StaffTile extends StatelessWidget {
  final dynamic member;
  final bool isArabic;

  const _StaffTile({required this.member, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.push('/admin/users/details', extra: member),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundImage: member.avatarUrl != null
                  ? NetworkImage(member.avatarUrl!)
                  : null,
              child: member.avatarUrl == null
                  ? const Icon(LucideIcons.user)
                  : null,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.fullName,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    member.email,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.white38,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Icon(LucideIcons.chevronRight, size: 16, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}

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

class LeadershipManagementScreen extends ConsumerStatefulWidget {
  const LeadershipManagementScreen({super.key});

  @override
  ConsumerState<LeadershipManagementScreen> createState() =>
      _LeadershipManagementScreenState();
}

class _LeadershipManagementScreenState
    extends ConsumerState<LeadershipManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final statsAsync = ref.watch(adminStatsProvider);

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.admin.academic_leadership,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.userPlus),
            onPressed: () => context.push(
              '/admin/users/new',
              extra: {'category': RoleCategory.academicLeadership},
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // ── Quick Info
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GlassContainer(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(24),
              child: Row(
                children: [
                  const Icon(
                    LucideIcons.shieldCheck,
                    size: 32,
                    color: Colors.amber,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.admin.leadership_stats,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        statsAsync.when(
                          data: (s) => Text(
                            '${s[RoleCategory.academicLeadership] ?? 0} ${t.admin.academic_leaders}',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white60,
                            ),
                          ),
                          loading: () => const Text('...'),
                          error: (err, stack) {
                            return const Text('Error');
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Leadership List
          Expanded(child: _buildLeadershipList(isArabic)),
        ],
      ),
    );
  }

  Widget _buildLeadershipList(bool isArabic) {
    final leadershipAsync = ref.watch(
      usersControllerProvider(category: RoleCategory.academicLeadership),
    );

    return leadershipAsync.when(
      data: (users) {
        if (users.isEmpty) {
          return const Center(child: Text('No leadership found'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final leader = users[index];
            return _LeaderTile(leader: leader, isArabic: isArabic)
                .animate()
                .fadeIn(delay: (index * 60).ms)
                .scale(begin: const Offset(0.98, 0.98));
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _LeaderTile extends StatelessWidget {
  final dynamic leader;
  final bool isArabic;

  const _LeaderTile({required this.leader, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final UserRole role = leader.roles.isNotEmpty
        ? leader.roles.first as UserRole
        : UserRole.dean;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: GlassContainer(
        padding: const EdgeInsets.all(18),
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.push('/admin/users/details', extra: leader),
        child: Row(
          children: [
            Hero(
              tag: 'leader-${leader.id}',
              child: CircleAvatar(
                radius: 28,
                backgroundImage: leader.avatarUrl != null
                    ? NetworkImage(leader.avatarUrl!)
                    : null,
                child: leader.avatarUrl == null
                    ? const Icon(LucideIcons.user)
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leader.fullName,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.amber.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      role.displayName(isArabic: isArabic),
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                        color: Colors.amber,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              LucideIcons.externalLink,
              size: 16,
              color: Colors.white24,
            ),
          ],
        ),
      ),
    );
  }
}

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

class AdminITManagementScreen extends ConsumerStatefulWidget {
  const AdminITManagementScreen({super.key});

  @override
  ConsumerState<AdminITManagementScreen> createState() =>
      _AdminITManagementScreenState();
}

class _AdminITManagementScreenState
    extends ConsumerState<AdminITManagementScreen> {
  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final primaryColor = Theme.of(context).primaryColor;
    final statsAsync = ref.watch(adminStatsProvider);

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.admin.admin_it,
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
                extra: {'category': RoleCategory.adminIT},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── System Status Dashboard
          Padding(
            padding: const EdgeInsets.all(20),
            child: GlassContainer(
              padding: const EdgeInsets.all(22),
              borderRadius: BorderRadius.circular(28),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              t.admin.system_technical_status,
                              style: GoogleFonts.outfit(
                                fontWeight: FontWeight.w800,
                                fontSize: 17,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Container(
                                  width: 8,
                                  height: 8,
                                  decoration: const BoxDecoration(
                                    color: Color(0xFF10B981),
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  t.admin.all_systems_operational,
                                  style: GoogleFonts.inter(
                                    fontSize: 12,
                                    color: const Color(0xFF10B981),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blueAccent.withValues(alpha: 0.2),
                              Colors.purpleAccent.withValues(alpha: 0.1),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: const Icon(
                          LucideIcons.cpu,
                          size: 28,
                          color: Colors.blueAccent,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Divider(color: Colors.white.withValues(alpha: 0.06)),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMiniInfo(
                        t.admin.admins,
                        statsAsync.whenData(
                          (s) => s[RoleCategory.adminIT] ?? 0,
                        ),
                        Colors.blueAccent,
                        LucideIcons.users,
                      ),
                      _buildMiniInfo(
                        t.admin.servers,
                        const AsyncValue.data(3),
                        const Color(0xFF10B981),
                        LucideIcons.server,
                      ),
                      _buildMiniInfo(
                        t.admin.incidents,
                        const AsyncValue.data(0),
                        const Color(0xFFEF4444),
                        LucideIcons.alertOctagon,
                      ),
                    ],
                  ),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.05, end: 0),
          ),

          // ── Admins List
          Expanded(child: _buildAdminsList(isArabic, primaryColor)),
        ],
      ),
    );
  }

  Widget _buildMiniInfo(
    String label,
    AsyncValue<int> value,
    Color color,
    IconData icon,
  ) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Icon(icon, size: 18, color: color),
        ),
        const SizedBox(height: 8),
        value.when(
          data: (val) => Text(
            val.toString(),
            style: GoogleFonts.shareTechMono(
              fontSize: 20,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          loading: () => const Text('...'),
          error: (err, stack) => const Text('?'),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 10,
            color: Colors.white.withValues(alpha: 0.35),
          ),
        ),
      ],
    );
  }

  Widget _buildAdminsList(bool isArabic, Color primaryColor) {
    final adminsAsync = ref.watch(
      usersControllerProvider(category: RoleCategory.adminIT),
    );

    return adminsAsync.when(
      data: (users) {
        if (users.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent.withValues(alpha: 0.06),
                  ),
                  child: const Icon(
                    LucideIcons.terminal,
                    size: 36,
                    color: Colors.blueAccent,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'No admins found',
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
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final admin = users[index];
            return _AdminTile(
                  admin: admin,
                  isArabic: isArabic,
                  primaryColor: primaryColor,
                )
                .animate()
                .fadeIn(delay: (index * 40).ms, duration: 300.ms)
                .slideX(begin: isArabic ? -0.05 : 0.05, end: 0);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _AdminTile extends StatelessWidget {
  final UserProfileModel admin;
  final bool isArabic;
  final Color primaryColor;

  const _AdminTile({
    required this.admin,
    required this.isArabic,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final roleName = admin.roles.isNotEmpty
        ? admin.roles.first.displayName(isArabic: isArabic)
        : '—';

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassContainer(
        padding: const EdgeInsets.all(14),
        borderRadius: BorderRadius.circular(22),
        onTap: () => context.push('/admin/users/details', extra: admin),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: Colors.white.withValues(alpha: 0.15),
                  width: 1.5,
                ),
              ),
              child: admin.avatarUrl != null
                  ? ClipOval(
                      child: Image.network(
                        admin.avatarUrl!,
                        fit: BoxFit.cover,
                        width: 50,
                        height: 50,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(
                              LucideIcons.user,
                              size: 22,
                              color: Colors.white,
                            ),
                      ),
                    )
                  : const Icon(LucideIcons.user, size: 22, color: Colors.white),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    admin.fullName,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 3),
                  Text(
                    admin.email,
                    style: GoogleFonts.shareTechMono(
                      fontSize: 11,
                      color: Colors.blueAccent.withValues(alpha: 0.6),
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
                      color: Colors.blueAccent.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Colors.blueAccent.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Text(
                      roleName,
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w700,
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Icon(LucideIcons.terminal, size: 16, color: Colors.white24),
          ],
        ),
      ),
    );
  }
}

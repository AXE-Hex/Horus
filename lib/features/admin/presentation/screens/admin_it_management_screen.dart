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
    final statsAsync = ref.watch(adminStatsProvider);

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.admin.admin_it,
          style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(LucideIcons.userPlus),
            onPressed: () => context.push(
              '/admin/users/new',
              extra: {'category': RoleCategory.adminIT},
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // ── System Status Card
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: GlassContainer(
              padding: const EdgeInsets.all(24),
              borderRadius: BorderRadius.circular(32),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            t.admin.system_technical_status,
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            t.admin.all_systems_operational,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.greenAccent,
                            ),
                          ),
                        ],
                      ),
                      const Icon(
                        LucideIcons.cpu,
                        size: 32,
                        color: Colors.blueAccent,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(color: Colors.white10),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMiniInfo(
                        t.admin.admins,
                        statsAsync.whenData(
                          (s) => s[RoleCategory.adminIT] ?? 0,
                        ),
                        Colors.blueAccent,
                      ),
                      _buildMiniInfo(
                        t.admin.servers,
                        const AsyncValue.data(3),
                        Colors.green,
                      ),
                      _buildMiniInfo(
                        t.admin.incidents,
                        const AsyncValue.data(0),
                        Colors.red,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── Admins List
          Expanded(child: _buildAdminsList(isArabic)),
        ],
      ),
    );
  }

  Widget _buildMiniInfo(String label, AsyncValue<int> value, Color color) {
    return Column(
      children: [
        value.when(
          data: (val) => Text(
            val.toString(),
            style: GoogleFonts.shareTechMono(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          loading: () => const Text('...'),
          error: (err, stack) => const Text('?'),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(fontSize: 10, color: Colors.white38),
        ),
      ],
    );
  }

  Widget _buildAdminsList(bool isArabic) {
    final adminsAsync = ref.watch(
      usersControllerProvider(category: RoleCategory.adminIT),
    );

    return adminsAsync.when(
      data: (users) {
        if (users.isEmpty) return const Center(child: Text('No admins found'));

        return ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final admin = users[index];
            return _AdminTile(admin: admin, isArabic: isArabic)
                .animate()
                .fadeIn(delay: (index * 50).ms)
                .slideX(begin: isArabic ? -0.1 : 0.1, end: 0);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }
}

class _AdminTile extends StatelessWidget {
  final dynamic admin;
  final bool isArabic;

  const _AdminTile({required this.admin, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.push('/admin/users/details', extra: admin),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Colors.blueAccent, Colors.purpleAccent],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: admin.avatarUrl != null
                  ? ClipOval(
                      child: Image.network(admin.avatarUrl!, fit: BoxFit.cover),
                    )
                  : const Icon(LucideIcons.user, color: Colors.white),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    admin.fullName,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    admin.email,
                    style: GoogleFonts.shareTechMono(
                      fontSize: 11,
                      color: Colors.blueAccent.withValues(alpha: 0.7),
                    ),
                    overflow: TextOverflow.ellipsis,
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

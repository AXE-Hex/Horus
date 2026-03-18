import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/features/admin/data/models/institutional_models.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:hue/features/admin/presentation/providers/users_provider.dart';
import 'package:hue/features/academic/data/repositories/professor_repository.dart';
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DepartmentDetailScreen extends ConsumerWidget {
  final DepartmentModel department;
  final Color color;

  const DepartmentDetailScreen({
    super.key,
    required this.department,
    required this.color,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final name = isArabic ? department.nameAr : department.nameEn;
    final bio =
        (isArabic ? department.descriptionAr : department.descriptionEn) ??
        t.admin.no_about_text_available;

    Widget content = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 180,
          pinned: true,
          backgroundColor: isGlass ? Colors.transparent : color,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.chevronLeft, color: Colors.white),
            ),
            onPressed: () => context.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            title: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.white,
              ),
            ),
            centerTitle: true,
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [color, color.withValues(alpha: 0.7)],
                    ),
                  ),
                ),
                Positioned(
                  right: -20,
                  bottom: -20,
                  child: Icon(
                    LucideIcons.graduationCap,
                    size: 200,
                    color: Colors.white10,
                  ),
                ),
                Center(
                  child:
                      Icon(LucideIcons.binary, size: 60, color: Colors.white30)
                          .animate(onPlay: (c) => c.repeat())
                          .rotate(duration: 10.seconds),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildSectionHeader(
                t.admin.department_details,
                LucideIcons.info,
                isGlass,
              ),
              const SizedBox(height: 10),
              _buildBioText(bio, isGlass),
              const SizedBox(height: 24),
              _buildSectionHeader(
                t.admin.head_of_department,
                LucideIcons.award,
                isGlass,
              ),
              const SizedBox(height: 12),
              _buildHodSection(ref, color, isGlass),
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: content) : Scaffold(body: content);
  }

  Widget _buildHodSection(WidgetRef ref, Color themeColor, bool isGlass) {
    if (department.headId == null) {
      return GlassContainer(
        padding: const EdgeInsets.all(24),
        borderRadius: BorderRadius.circular(24),
        child: Center(
          child: Column(
            children: [
              Icon(LucideIcons.userX, color: Colors.orangeAccent, size: 40),
              SizedBox(height: 12),
              Text(
                t.admin.no_head_assigned,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
      ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.05);
    }

    final usersAsync = ref.watch(usersControllerProvider());

    return usersAsync.when(
      data: (users) {
        final hod = users.firstWhere(
          (u) => u.id == department.headId,
          orElse: () => UserProfileModel(
            id: 'unknown',
            email: 'unknown',
            fullName: 'Unknown',
            isActive: false,
            isBanned: false,
            isVerified: false,
            roles: [],
            createdAt: DateTime.now(),
          ),
        );

        if (hod.id == 'unknown') return const SizedBox();

        return _HoDIdentityCard(
          hod: hod,
          color: themeColor,
          isGlass: isGlass,
          department: department,
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => const SizedBox(),
    );
  }

  Widget _buildSectionHeader(String title, IconData icon, bool isGlass) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.amber),
        const SizedBox(width: 8),
        Text(
          title.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w900,
            letterSpacing: 1.2,
            color: isGlass ? Colors.white70 : Colors.black54,
          ),
        ),
      ],
    );
  }

  Widget _buildBioText(String text, bool isGlass) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 15,
        height: 1.6,
        color: isGlass ? Colors.white70 : Colors.black87,
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }
}

class _HoDIdentityCard extends ConsumerWidget {
  final UserProfileModel hod;
  final DepartmentModel department;
  final Color color;
  final bool isGlass;

  const _HoDIdentityCard({
    required this.hod,
    required this.department,
    required this.color,
    required this.isGlass,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratingAsync = ref.watch(professorAverageRatingProvider(hod.id));

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [color.withValues(alpha: 0.1), color.withValues(alpha: 0.05)],
        ),
        border: Border.all(color: color.withValues(alpha: 0.2), width: 1.2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Positioned.fill(
              child: CustomPaint(painter: _HoloLinesPainter(color: color)),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundImage: hod.avatarUrl != null
                            ? NetworkImage(hod.avatarUrl!)
                            : null,
                        backgroundColor: color.withValues(alpha: 0.2),
                        child: hod.avatarUrl == null
                            ? Icon(LucideIcons.user, color: color, size: 28)
                            : null,
                      ),
                      const SizedBox(width: 16),
                      Expanded(child: _buildProfileSection()),
                      if (department.officeSymbol != null)
                        _buildChip('ID: ${department.officeSymbol}', color),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow(LucideIcons.mail, 'Email', hod.email),
                  const Divider(height: 24, color: Colors.white10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildLocationStat(
                          'Office',
                          department.code ?? '---',
                          LucideIcons.mapPin,
                        ),
                      ),
                      Expanded(
                        child: _buildLocationStat(
                          t.extracted.building,
                          department.building ?? '---',
                          LucideIcons.building,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildLocationStat(
                          'Floor',
                          department.floor?.toString() ?? '---',
                          LucideIcons.layers,
                        ),
                      ),
                      Expanded(
                        child: ratingAsync.when(
                          data: (rating) => _buildRatingStat(rating),
                          loading: () => const Center(
                            child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            ),
                          ),
                          error: (_, __) => _buildRatingStat(0.0),
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
    ).animate().scale(delay: 200.ms, curve: Curves.easeOutBack);
  }

  Widget _buildProfileSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          hod.fullName,
          style: GoogleFonts.outfit(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          t.admin.head_of_department,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildChip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: GoogleFonts.inter(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(fontSize: 10, color: Colors.white38),
              ),
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationStat(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.white38),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(fontSize: 10, color: Colors.white30),
              ),
              Text(
                value,
                style: GoogleFonts.outfit(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRatingStat(double rating) {
    return Row(
      children: [
        const Icon(LucideIcons.star, size: 14, color: Colors.amber),
        const SizedBox(width: 8),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rating',
              style: GoogleFonts.inter(fontSize: 10, color: Colors.white30),
            ),
            Text(
              '$rating / 5.0',
              style: GoogleFonts.outfit(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _HoloLinesPainter extends CustomPainter {
  final Color color;
  _HoloLinesPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withValues(alpha: 0.05)
      ..strokeWidth = 1;

    for (var i = 0; i < size.width; i += 20) {
      canvas.drawLine(
        Offset(i.toDouble(), 0),
        Offset(i.toDouble() - 40, size.height),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

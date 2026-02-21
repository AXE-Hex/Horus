import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DepartmentDetailScreen extends ConsumerWidget {
  final Map<String, dynamic> departmentData;

  const DepartmentDetailScreen({super.key, required this.departmentData});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final color = departmentData['color'] as Color? ?? Colors.blue;
    final name = departmentData['name'] as String;
    final deptKey = departmentData['key'] as String;

    // Mock biological data for departments
    final bio = _getDepartmentBio(deptKey);
    final hod = _getMockHoD(deptKey);

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
              _buildSectionHeader('Overview', LucideIcons.info, isGlass),
              const SizedBox(height: 10),
              _buildBioText(bio, isGlass),
              const SizedBox(height: 24),
              _buildSectionHeader(
                'Head of Department',
                LucideIcons.award,
                isGlass,
              ),
              const SizedBox(height: 12),
              _HoDIdentityCard(hod: hod, color: color, isGlass: isGlass),
              const SizedBox(height: 80),
            ]),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: content) : Scaffold(body: content);
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

  String _getDepartmentBio(String key) {
    if (key.contains('ai')) {
      return 'The AI department leads the digital frontier, focusing on machine learning, robotics, and neural networks. Students engage in deep-tech research to solve global challenges through intelligent automation.';
    } else if (key.contains('medical')) {
      return 'Dedicated to excellence in clinical diagnostics and healthcare innovation. Our laboratories provide state-of-the-art facilities for training the next generation of medical technologists and researchers.';
    } else if (key.contains('engineering')) {
      return 'A hub of technical innovation where theory meets practice. Our programs cover mechanical, electrical, and systems engineering, preparing students to design and build the infrastructure of tomorrow.';
    }
    return 'Ensuring academic excellence through a rigorous curriculum and practical engagement. This department is committed to fostering innovation, critical thinking, and professional development in its specialized field.';
  }

  Map<String, dynamic> _getMockHoD(String key) {
    return {
      'name': 'Prof. Julian Sterling',
      'subject': 'Quantum Computing & Algorithms',
      'office_no': 'H-302',
      'floor': '3rd Floor',
      'direction': 'North-East Wing',
      'symbol': 'θ-4',
      'rating': 4.9,
    };
  }
}

class _HoDIdentityCard extends StatelessWidget {
  final Map<String, dynamic> hod;
  final Color color;
  final bool isGlass;

  const _HoDIdentityCard({
    required this.hod,
    required this.color,
    required this.isGlass,
  });

  @override
  Widget build(BuildContext context) {
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
            // Holographic lines overlay
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
                      _buildProfileSection(),
                      const Spacer(),
                      _buildChip('ID: ${hod['symbol']}', color),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _buildDetailRow(
                    LucideIcons.bookOpen,
                    'Discipline',
                    hod['subject'],
                  ),
                  const Divider(height: 24, color: Colors.white10),
                  Row(
                    children: [
                      Expanded(
                        child: _buildLocationStat(
                          'Office',
                          hod['office_no'],
                          LucideIcons.mapPin,
                        ),
                      ),
                      Expanded(
                        child: _buildLocationStat(
                          'Floor',
                          hod['floor'],
                          LucideIcons.layers,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _buildLocationStat(
                          'Direction',
                          hod['direction'],
                          LucideIcons.compass,
                        ),
                      ),
                      Expanded(child: _buildRatingStat(hod['rating'])),
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
          hod['name'],
          style: GoogleFonts.outfit(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          'Head of Department',
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
        Column(
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
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLocationStat(String label, String value, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 14, color: Colors.white38),
        const SizedBox(width: 8),
        Column(
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
            ),
          ],
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

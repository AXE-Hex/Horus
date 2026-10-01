import 'package:horus/features/academic/data/models/academic_records.dart';
import 'package:horus/features/academic/presentation/providers/student_attendance_provider.dart';
import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/style_provider.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final recordsAsync = ref.watch(studentAttendanceProvider(_page));
    if (recordsAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (recordsAsync.hasError) {
      return Scaffold(body: Center(child: Text(t.academic.error)));
    }
    final records = recordsAsync.value ?? [];
    final attendanceData = [
      for (final courseId in records.map((r) => r.courseId).toSet())
        _attendanceView(
          records.where((r) => r.courseId == courseId).toList(),
          isArabic,
        ),
    ];

    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 100,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft, color: Colors.white),
            onPressed: () => context.pop(),
          ),
          title: Text(
            t.attendance.title,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.w900,
              fontSize: 24,
              color: Colors.white,
              letterSpacing: 1.2,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
              tooltip: MaterialLocalizations.of(context).previousPageTooltip,
              icon: const Icon(LucideIcons.chevronLeft),
              onPressed: _page > 0 ? () => setState(() => _page--) : null,
            ),
            IconButton(
              tooltip: MaterialLocalizations.of(context).nextPageTooltip,
              icon: const Icon(LucideIcons.chevronRight),
              onPressed: records.length == 50
                  ? () => setState(() => _page++)
                  : null,
            ),
          ],
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: _buildAttendanceHeader(context, isGlass, isArabic, records),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child:
                    _AttendanceCourseCard(
                          data: attendanceData[index],
                          isGlass: isGlass,
                          isArabic: isArabic,
                        )
                        .animate(delay: (100 * index).ms)
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.2, end: 0, curve: Curves.easeOutBack),
              );
            }, childCount: attendanceData.length),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Map<String, dynamic> _attendanceView(
    List<AttendanceRecord> records,
    bool isArabic,
  ) {
    final course = records.first.course;
    final present = records
        .where((r) => r.status == AttendanceStatus.present)
        .length;
    final late = records.where((r) => r.status == AttendanceStatus.late).length;
    return {
      'subject':
          (isArabic ? course?.nameAr : course?.nameEn) ??
          course?.code ??
          records.first.courseId,
      'present': present,
      'absent': records
          .where((r) => r.status == AttendanceStatus.absent)
          .length,
      'late': late,
      'ratio': ((present + late) * 100 / records.length).round(),
      'icon': LucideIcons.graduationCap,
      'color': const Color(0xFF6366F1),
      'trend': [
        for (final record in records.reversed)
          record.status == AttendanceStatus.present ||
                  record.status == AttendanceStatus.late
              ? 1.0
              : 0.0,
      ],
    };
  }

  Widget _buildAttendanceHeader(
    BuildContext context,
    bool isGlass,
    bool isArabic,
    List<AttendanceRecord> records,
  ) {
    final present = records
        .where((r) => r.status == AttendanceStatus.present)
        .length;
    final absent = records
        .where((r) => r.status == AttendanceStatus.absent)
        .length;
    final late = records.where((r) => r.status == AttendanceStatus.late).length;
    final ratio = records.isEmpty ? 0.0 : (present + late) / records.length;
    return GlassContainer(
      borderRadius: BorderRadius.circular(32),
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    t.academic.overall_attendance,
                    style:
                        (isArabic
                                ? GoogleFonts.tajawal()
                                : GoogleFonts.outfit())
                            .copyWith(
                              color: Colors.white60,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2,
                            ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    records.isEmpty
                        ? '—'
                        : '${(ratio * 100).toStringAsFixed(1)}%',
                    style: GoogleFonts.outfit(
                      fontSize: 42,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              _AttendanceGauge(
                percentage: ratio,
                color: const Color(0xFF6366F1),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildStatDetail(
                t.attendance.present,
                present.toString(),
                Colors.greenAccent,
              ),
              _buildStatDetail(
                t.attendance.absent,
                absent.toString(),
                Colors.redAccent,
              ),
              _buildStatDetail(
                t.attendance.late,
                late.toString(),
                Colors.orangeAccent,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatDetail(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: color.withValues(alpha: 0.5),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: GoogleFonts.shareTechMono(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Text(
          label.toUpperCase(),
          style: GoogleFonts.outfit(
            fontSize: 9,
            color: Colors.white38,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}

class _AttendanceGauge extends StatelessWidget {
  final double percentage;
  final Color color;

  const _AttendanceGauge({required this.percentage, required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 80,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
                value: percentage,
                strokeWidth: 8,
                backgroundColor: Colors.white10,
                valueColor: AlwaysStoppedAnimation<Color>(color),
                strokeCap: StrokeCap.round,
              )
              .animate(onPlay: (c) => c.forward())
              .shimmer(duration: 2.seconds, color: Colors.white24),
          Icon(LucideIcons.checkCircle, color: color, size: 24),
        ],
      ),
    );
  }
}

class _AttendanceCourseCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool isGlass;
  final bool isArabic;

  const _AttendanceCourseCard({
    required this.data,
    required this.isGlass,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    final Color subjectColor = data['color'] as Color;

    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: subjectColor.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: subjectColor.withValues(alpha: 0.3),
                  ),
                ),
                child: Icon(
                  data['icon'] as IconData,
                  color: subjectColor,
                  size: 24,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data['subject'] as String,
                      style:
                          (isArabic
                                  ? GoogleFonts.tajawal()
                                  : GoogleFonts.outfit())
                              .copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                    ),
                    Text(
                      '${t.attendance.present}: ${data['present']} | ${t.attendance.absent}: ${data['absent']}',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${data['ratio']}%',
                    style: GoogleFonts.shareTechMono(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: subjectColor,
                    ),
                  ),
                  Text(
                    t.academic.ratio,
                    style: GoogleFonts.outfit(
                      fontSize: 8,
                      color: Colors.white24,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 40,
            width: double.infinity,
            child: CustomPaint(
              painter: _SparklinePainter(
                data['trend'] as List<double>,
                subjectColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SparklinePainter extends CustomPainter {
  final List<double> data;
  final Color color;

  _SparklinePainter(this.data, this.color);

  @override
  void paint(Canvas canvas, Size size) {
    if (data.isEmpty) return;

    final paint = Paint()
      ..color = color
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    final double stepX = size.width / (data.length - 1);

    for (var i = 0; i < data.length; i++) {
      final x = i * stepX;
      final y = size.height - (data[i] * size.height);
      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }

    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(
      fillPath,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.2), Colors.transparent],
        ).createShader(Rect.fromLTWH(0, 0, size.width, size.height)),
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

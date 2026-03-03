import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/enrollment/data/models/registration_models.dart';
import 'package:hue/features/enrollment/presentation/providers/advisor_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';

/// Screen for Academic Advisors to review and approve/reject student
/// course registration requests.
class AdvisorApprovalScreen extends ConsumerStatefulWidget {
  const AdvisorApprovalScreen({super.key});

  @override
  ConsumerState<AdvisorApprovalScreen> createState() =>
      _AdvisorApprovalScreenState();
}

class _AdvisorApprovalScreenState extends ConsumerState<AdvisorApprovalScreen> {
  String _filterStatus = 'all'; // all | pending | approved | rejected

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final requestsAsync = ref.watch(advisorRequestsProvider);

    final scaffoldBody = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 120,
          floating: false,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            t.enrollment.registration_requests,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: isGlass
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
          centerTitle: true,
        ),
        // Filter chips
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: _buildFilterChips(isArabic, isGlass),
          ),
        ),
        // Requests list
        requestsAsync.when(
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) =>
              SliverFillRemaining(child: Center(child: Text('Error: $e'))),
          data: (requests) {
            final filtered = _filterStatus == 'all'
                ? requests
                : requests
                      .where((r) => r.status.name == _filterStatus)
                      .toList();

            if (filtered.isEmpty) {
              return SliverFillRemaining(
                child: _buildEmptyState(isArabic, isGlass),
              );
            }

            return SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildRequestCard(
                    filtered[index],
                    isArabic,
                    isGlass,
                    index,
                  ),
                  childCount: filtered.length,
                ),
              ),
            );
          },
        ),
      ],
    );

    return isGlass
        ? GlassScaffold(resizeToAvoidBottomInset: true, body: scaffoldBody)
        : Scaffold(resizeToAvoidBottomInset: true, body: scaffoldBody);
  }

  Widget _buildFilterChips(bool isArabic, bool isGlass) {
    final filters = [
      ('all', t.enrollment.all, LucideIcons.layoutList),
      ('pending', t.enrollment.pending, LucideIcons.clock),
      ('approved', t.enrollment.approved_1, LucideIcons.checkCircle),
      ('rejected', t.enrollment.rejected, LucideIcons.xCircle),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: filters.map((f) {
          final isSelected = _filterStatus == f.$1;
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _filterStatus = f.$1),
              child: AnimatedContainer(
                duration: 250.ms,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  gradient: isSelected
                      ? LinearGradient(
                          colors: [
                            Colors.indigoAccent.withValues(alpha: 0.8),
                            Colors.purpleAccent.withValues(alpha: 0.6),
                          ],
                        )
                      : null,
                  color: isSelected
                      ? null
                      : Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? Colors.indigoAccent.withValues(alpha: 0.5)
                        : Colors.white12,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      f.$3,
                      size: 14,
                      color: isSelected ? Colors.white : Colors.white54,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      f.$2,
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: isSelected ? Colors.white : Colors.white60,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildRequestCard(
    RegistrationRequest request,
    bool isArabic,
    bool isGlass,
    int index,
  ) {
    final statusColor = _statusColor(request.status);
    final studentName = request.studentProfile?['full_name'] as String? ?? '—';
    final studentIdNum = request.studentProfile?['student_id'] as String? ?? '';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child:
          GlassContainer(
            borderRadius: BorderRadius.circular(20),
            child: ExpansionTile(
              tilePadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              childrenPadding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              leading: CircleAvatar(
                backgroundColor: statusColor.withValues(alpha: 0.15),
                child: Icon(
                  _statusIcon(request.status),
                  color: statusColor,
                  size: 20,
                ),
              ),
              title: Text(
                studentName,
                style: GoogleFonts.outfit(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (studentIdNum.isNotEmpty)
                    Text(
                      'ID: $studentIdNum',
                      style: GoogleFonts.outfit(
                        fontSize: 12,
                        color: Colors.white54,
                      ),
                    ),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          request.status.label(isArabic: isArabic),
                          style: GoogleFonts.outfit(
                            fontSize: 11,
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        request.semester,
                        style: GoogleFonts.outfit(
                          fontSize: 11,
                          color: Colors.white38,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              children: [
                // Courses
                ...request.courses.map((rc) {
                  final course = rc.course;
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(
                          LucideIcons.bookOpen,
                          size: 14,
                          color: Colors.white54,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            course != null
                                ? (isArabic
                                      ? (course.nameAr ?? course.name)
                                      : course.name)
                                : rc.courseId,
                            style: GoogleFonts.outfit(
                              fontSize: 13,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                        if (rc.sectionName != null)
                          Text(
                            rc.sectionName!,
                            style: GoogleFonts.outfit(
                              fontSize: 12,
                              color: Colors.white38,
                            ),
                          ),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 12),
                // If already reviewed show notes
                if (request.advisorNotes != null &&
                    request.advisorNotes!.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: statusColor.withValues(alpha: 0.3),
                      ),
                    ),
                    child: Text(
                      '"${request.advisorNotes}"',
                      style: GoogleFonts.outfit(
                        fontSize: 13,
                        color: Colors.white70,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                // Action buttons (only for pending)
                if (request.isPending)
                  _buildActionButtons(request, isArabic, isGlass),
              ],
            ),
          ).animate().fadeIn(
            duration: 300.ms,
            delay: Duration(milliseconds: index * 60),
          ),
    );
  }

  Widget _buildActionButtons(
    RegistrationRequest request,
    bool isArabic,
    bool isGlass,
  ) {
    final notesController = TextEditingController();

    return Column(
      children: [
        TextField(
          controller: notesController,
          style: GoogleFonts.outfit(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: t.enrollment.notes_optional,
            hintStyle: GoogleFonts.outfit(color: Colors.white38, fontSize: 13),
            filled: true,
            fillColor: Colors.white.withValues(alpha: 0.05),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white12),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.white12),
            ),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 10,
            ),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await ref
                      .read(advisorRequestsProvider.notifier)
                      .reject(request.id, notes: notesController.text.trim());
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.red.shade800,
                        content: Text(
                          t.enrollment.request_rejected,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(LucideIcons.x, size: 16),
                label: Text(t.enrollment.reject),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red.shade800,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ElevatedButton.icon(
                onPressed: () async {
                  await ref
                      .read(advisorRequestsProvider.notifier)
                      .approve(request.id, notes: notesController.text.trim());
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: Colors.green.shade800,
                        content: Text(
                          t.enrollment.approved_courses_registered,
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    );
                  }
                },
                icon: const Icon(LucideIcons.check, size: 16),
                label: Text(t.enrollment.approve),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade700,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState(bool isArabic, bool isGlass) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(LucideIcons.inbox, size: 64, color: Colors.white24),
          const SizedBox(height: 16),
          Text(
            t.enrollment.no_requests_found,
            style: GoogleFonts.outfit(fontSize: 18, color: Colors.white54),
          ),
        ],
      ),
    );
  }

  Color _statusColor(RegistrationStatus status) {
    switch (status) {
      case RegistrationStatus.pending:
        return Colors.amber;
      case RegistrationStatus.approved:
        return Colors.greenAccent;
      case RegistrationStatus.rejected:
        return Colors.redAccent;
      default:
        return Colors.blueGrey;
    }
  }

  IconData _statusIcon(RegistrationStatus status) {
    switch (status) {
      case RegistrationStatus.pending:
        return LucideIcons.clock;
      case RegistrationStatus.approved:
        return LucideIcons.checkCircle;
      case RegistrationStatus.rejected:
        return LucideIcons.xCircle;
      default:
        return LucideIcons.info;
    }
  }
}

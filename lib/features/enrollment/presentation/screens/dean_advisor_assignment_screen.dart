import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/enrollment/data/models/registration_models.dart';
import 'package:hue/features/enrollment/data/repositories/advisor_repository.dart';
import 'package:hue/features/enrollment/presentation/providers/advisor_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:lucide_icons/lucide_icons.dart';

class DeanAdvisorAssignmentScreen extends ConsumerStatefulWidget {
  const DeanAdvisorAssignmentScreen({super.key});

  @override
  ConsumerState<DeanAdvisorAssignmentScreen> createState() =>
      _DeanAdvisorAssignmentScreenState();
}

class _DeanAdvisorAssignmentScreenState
    extends ConsumerState<DeanAdvisorAssignmentScreen> {
  String _searchQuery = '';
  bool _onlyUnassigned = false;

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final auth = ref.watch(authControllerProvider);
    final collegeId = auth.user?.userMetadata?['college_id'] as String? ?? '';

    final studentsAsync = ref.watch(collegeStudentsProvider(collegeId));
    final advisorsAsync = ref.watch(collegeAdvisorsProvider(collegeId));

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
            t.enrollment.advisor_assignment,
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: isGlass
                  ? Colors.white
                  : Theme.of(context).colorScheme.primary,
            ),
          ),
          centerTitle: true,
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: TextField(
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    decoration: InputDecoration(
                      hintText: t.enrollment.search_students,
                      hintStyle: GoogleFonts.outfit(
                        color: Colors.white38,
                        fontSize: 14,
                      ),
                      prefixIcon: const Icon(
                        LucideIcons.search,
                        color: Colors.white38,
                        size: 18,
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                    onChanged: (v) =>
                        setState(() => _searchQuery = v.toLowerCase()),
                  ),
                ),
                const SizedBox(height: 8),

                GestureDetector(
                  onTap: () =>
                      setState(() => _onlyUnassigned = !_onlyUnassigned),
                  child: AnimatedContainer(
                    duration: 200.ms,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: _onlyUnassigned
                          ? Colors.orangeAccent.withValues(alpha: 0.15)
                          : Colors.white.withValues(alpha: 0.06),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _onlyUnassigned
                            ? Colors.orangeAccent.withValues(alpha: 0.4)
                            : Colors.white12,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          LucideIcons.userX,
                          size: 14,
                          color: _onlyUnassigned
                              ? Colors.orangeAccent
                              : Colors.white38,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          t.enrollment.unassigned_only,
                          style: GoogleFonts.outfit(
                            fontSize: 13,
                            color: _onlyUnassigned
                                ? Colors.orangeAccent
                                : Colors.white54,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),

        advisorsAsync.when(
          loading: () => const SliverFillRemaining(
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => SliverFillRemaining(
            child: Center(child: Text('Error loading advisors: $e')),
          ),
          data: (advisors) {
            return studentsAsync.when(
              loading: () => const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              ),
              error: (e, _) => SliverFillRemaining(
                child: Center(child: Text('Error loading students: $e')),
              ),
              data: (students) {
                var filtered = students.where((s) {
                  final name = (s['full_name'] as String? ?? '').toLowerCase();
                  final idNum = (s['student_id'] as String? ?? '')
                      .toLowerCase();
                  final matchesSearch =
                      _searchQuery.isEmpty ||
                      name.contains(_searchQuery) ||
                      idNum.contains(_searchQuery);
                  final matchesFilter =
                      !_onlyUnassigned || s['advisor_id'] == null;
                  return matchesSearch && matchesFilter;
                }).toList();

                if (filtered.isEmpty) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            LucideIcons.users,
                            size: 56,
                            color: Colors.white24,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            t.enrollment.no_students_found,
                            style: GoogleFonts.outfit(
                              fontSize: 16,
                              color: Colors.white38,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildStudentCard(
                        filtered[index],
                        advisors,
                        isArabic,
                        isGlass,
                        index,
                      ),
                      childCount: filtered.length,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ],
    );

    return isGlass
        ? GlassScaffold(resizeToAvoidBottomInset: true, body: scaffoldBody)
        : Scaffold(resizeToAvoidBottomInset: true, body: scaffoldBody);
  }

  Widget _buildStudentCard(
    Map<String, dynamic> student,
    List<AdvisorInfo> advisors,
    bool isArabic,
    bool isGlass,
    int index,
  ) {
    final studentId = student['id'] as String;
    final studentName = student['full_name'] as String? ?? '—';
    final studentIdNum = student['student_id'] as String? ?? '';
    final currentAdvisorId = student['advisor_id'] as String?;

    final currentAdvisor = advisors
        .where((a) => a.id == currentAdvisorId)
        .firstOrNull;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child:
          GlassContainer(
                borderRadius: BorderRadius.circular(18),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundColor: Colors.indigoAccent.withValues(
                              alpha: 0.2,
                            ),
                            child: Text(
                              studentName.isNotEmpty
                                  ? studentName[0].toUpperCase()
                                  : '?',
                              style: GoogleFonts.outfit(
                                color: Colors.indigoAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  studentName,
                                  style: GoogleFonts.outfit(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                                if (studentIdNum.isNotEmpty)
                                  Text(
                                    'ID: $studentIdNum',
                                    style: GoogleFonts.outfit(
                                      fontSize: 12,
                                      color: Colors.white54,
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: currentAdvisor != null
                                  ? Colors.greenAccent.withValues(alpha: 0.12)
                                  : Colors.orangeAccent.withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              currentAdvisor != null
                                  ? (t.enrollment.assigned)
                                  : (t.enrollment.unassigned),
                              style: GoogleFonts.outfit(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: currentAdvisor != null
                                    ? Colors.greenAccent
                                    : Colors.orangeAccent,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Colors.white10, height: 1),
                      const SizedBox(height: 12),

                      DropdownButtonFormField<String?>(
                        initialValue: currentAdvisorId,
                        decoration: InputDecoration(
                          labelText: t.enrollment.academic_advisor,
                          labelStyle: GoogleFonts.outfit(
                            color: Colors.white54,
                            fontSize: 13,
                          ),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.05),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Colors.white12),
                          ),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                        ),
                        dropdownColor: const Color(0xFF1C1C2E),
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                        items: [
                          DropdownMenuItem<String?>(
                            value: null,
                            child: Text(
                              t.enrollment.no_advisor,
                              style: GoogleFonts.outfit(
                                color: Colors.white38,
                                fontSize: 13,
                              ),
                            ),
                          ),
                          ...advisors.map(
                            (a) => DropdownMenuItem<String?>(
                              value: a.id,
                              child: Text(
                                a.fullName,
                                style: GoogleFonts.outfit(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),
                        ],
                        onChanged: (newAdvisorId) async {
                          final repo = ref.read(advisorRepositoryProvider);
                          if (newAdvisorId == null) {
                            await repo.removeAdvisorFromStudent(studentId);
                          } else {
                            await repo.assignAdvisorToStudent(
                              studentId: studentId,
                              advisorId: newAdvisorId,
                            );
                          }

                          ref.invalidate(collegeStudentsProvider);
                          if (mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.green.shade800,
                                content: Text(
                                  t.enrollment.advisor_updated_successfully,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              )
              .animate()
              .fadeIn(
                duration: 300.ms,
                delay: Duration(milliseconds: index * 50),
              )
              .slideY(begin: 0.05),
    );
  }
}

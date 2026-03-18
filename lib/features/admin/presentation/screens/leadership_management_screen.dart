import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:hue/core/auth/roles.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/admin/data/models/user_management_models.dart';
import 'package:hue/features/admin/data/models/institutional_models.dart';
import 'package:hue/features/admin/data/repositories/institutional_repository.dart';
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
  String _collegeFilter = 'all';
  List<CollegeModel> _colleges = [];
  bool _isLoadingColleges = true;

  @override
  void initState() {
    super.initState();
    _loadColleges();
  }

  Future<void> _loadColleges() async {
    try {
      final repo = ref.read(institutionalRepositoryProvider);
      final colleges = await repo.getColleges();
      if (mounted) {
        setState(() {
          _colleges = colleges;
          _isLoadingColleges = false;
        });
      }
    } catch (_) {
      if (mounted) setState(() => _isLoadingColleges = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final primaryColor = Theme.of(context).primaryColor;
    final statsAsync = ref.watch(adminStatsProvider);

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.admin.academic_leadership,
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
              icon: Icon(LucideIcons.userPlus, size: 18),
              color: Theme.of(context).colorScheme.onSurface,
              onPressed: () => context.push(
                '/admin/users/new',
                extra: {'category': RoleCategory.academicLeadership},
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: GlassContainer(
              padding: const EdgeInsets.all(20),
              borderRadius: BorderRadius.circular(24),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      LucideIcons.crown,
                      size: 24,
                      color: Colors.amber,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          t.admin.leadership_stats,
                          style: GoogleFonts.outfit(
                            fontWeight: FontWeight.w800,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        statsAsync.when(
                          data: (s) => Text(
                            '${s[RoleCategory.academicLeadership] ?? 0} ${t.admin.academic_leaders}',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).colorScheme.onSurface.withValues(alpha: 0.45),
                            ),
                          ),
                          loading: () => Text(
                            '...',
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              color: Colors.white30,
                            ),
                          ),
                          error: (err, stack) => Text('Error'),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color:
                          (Theme.of(context).cardTheme.color ??
                                  Theme.of(context).cardColor)
                              .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      LucideIcons.shieldCheck,
                      size: 18,
                      color: Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
            ).animate().fadeIn().slideY(begin: 0.05, end: 0),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [_buildCollegeFilterButton(primaryColor, isArabic)],
            ),
          ),
          Expanded(child: _buildLeadershipList(isArabic, primaryColor)),
        ],
      ),
    );
  }

  Widget _buildLeadershipList(bool isArabic, Color primaryColor) {
    final leadershipAsync = ref.watch(
      usersControllerProvider(category: RoleCategory.academicLeadership),
    );

    return leadershipAsync.when(
      data: (users) {
        final filtered = users.where((u) {
          if (_collegeFilter != 'all' && u.collegeId != _collegeFilter) {
            return false;
          }
          return true;
        }).toList();

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
                    color: Colors.amber.withValues(alpha: 0.06),
                  ),
                  child: Icon(LucideIcons.crown, size: 36, color: Colors.amber),
                ),
                SizedBox(height: 16),
                Text(
                  'No leadership found',
                  style: GoogleFonts.outfit(
                    fontSize: 14,
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.3),
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          itemCount: filtered.length,
          itemBuilder: (context, index) {
            final leader = filtered[index];
            return _LeaderTile(
                  leader: leader,
                  isArabic: isArabic,
                  primaryColor: primaryColor,
                )
                .animate()
                .fadeIn(delay: (index * 50).ms, duration: 350.ms)
                .scale(
                  begin: const Offset(0.98, 0.98),
                  end: const Offset(1, 1),
                );
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Error: $e')),
    );
  }

  Widget _buildCollegeFilterButton(Color primaryColor, bool isArabic) {
    final hasActiveFilter = _collegeFilter != 'all';
    return GlassContainer(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        children: [
          IconButton(
            icon: Icon(
              LucideIcons.building,
              size: 18,
              color: hasActiveFilter ? primaryColor : Colors.white70,
            ),
            onPressed: () => _showCollegeFilterSheet(primaryColor, isArabic),
          ),
          if (hasActiveFilter)
            Positioned(
              top: 8,
              right: 8,
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: primaryColor,
                  shape: BoxShape.circle,
                ),
              ),
            ),
        ],
      ),
    );
  }

  void _showCollegeFilterSheet(Color primaryColor, bool isArabic) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setSheetState) => GlassContainer(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.onSurface.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              Row(
                children: [
                  Icon(LucideIcons.building, size: 18, color: primaryColor),
                  const SizedBox(width: 10),
                  Text(
                    t.admin.colleges,
                    style: GoogleFonts.outfit(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (_isLoadingColleges)
                const Center(child: CircularProgressIndicator())
              else if (_colleges.isEmpty)
                Text(t.admin.no_colleges_found)
              else
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildFilterSheetChip(
                      t.admin.all,
                      _collegeFilter == 'all',
                      () {
                        setSheetState(() => _collegeFilter = 'all');
                        setState(() => _collegeFilter = 'all');
                      },
                      primaryColor,
                    ),
                    ..._colleges.map((college) {
                      final name = isArabic ? college.nameAr : college.nameEn;
                      return _buildFilterSheetChip(
                        name,
                        _collegeFilter == college.id,
                        () {
                          setSheetState(() => _collegeFilter = college.id);
                          setState(() => _collegeFilter = college.id);
                        },
                        primaryColor,
                      );
                    }),
                  ],
                ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSheetChip(
    String label,
    bool isSelected,
    VoidCallback onTap,
    Color primaryColor,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: 200.ms,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? primaryColor.withValues(alpha: 0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? primaryColor
                : Theme.of(
                    context,
                  ).colorScheme.onSurface.withValues(alpha: 0.2),
          ),
        ),
        child: Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            color: isSelected
                ? primaryColor
                : Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}

class _LeaderTile extends StatelessWidget {
  final UserProfileModel leader;
  final bool isArabic;
  final Color primaryColor;

  const _LeaderTile({
    required this.leader,
    required this.isArabic,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    final UserRole role = leader.roles.isNotEmpty
        ? leader.roles.first
        : UserRole.dean;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassContainer(
        padding: const EdgeInsets.all(16),
        borderRadius: BorderRadius.circular(24),
        onTap: () => context.push('/admin/users/details', extra: leader),
        child: Row(
          children: [
            Hero(
              tag: 'leader-${leader.id}',
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.amber.withValues(alpha: 0.4),
                      Colors.orangeAccent.withValues(alpha: 0.15),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  border: Border.all(
                    color: Colors.amber.withValues(alpha: 0.3),
                    width: 2,
                  ),
                ),
                child: leader.avatarUrl != null
                    ? ClipOval(
                        child: Image.network(
                          leader.avatarUrl!,
                          fit: BoxFit.cover,
                          width: 56,
                          height: 56,
                          errorBuilder: (context, error, stackTrace) => Icon(
                            LucideIcons.user,
                            size: 24,
                            color: Colors.white70,
                          ),
                        ),
                      )
                    : Icon(LucideIcons.user, size: 24, color: Colors.white70),
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    leader.fullName,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.w800,
                      fontSize: 16,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.amber.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: Colors.amber.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Text(
                      role.displayName(isArabic: isArabic),
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                        color: Colors.amber,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              LucideIcons.externalLink,
              size: 16,
              color: Theme.of(
                context,
              ).colorScheme.onSurface.withValues(alpha: 0.15),
            ),
          ],
        ),
      ),
    );
  }
}

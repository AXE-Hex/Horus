part of 'digital_id_screen.dart';

extension _DigitalIDScreenSections on _DigitalIDScreenState {
  Widget _buildThemeSelector(bool isArabic) {
    final selectedCollegeId = _overrideCollegeId ?? _identityData['college'];
    final selectedCollege = _collegesData.firstWhere(
      (c) => c['id'] == selectedCollegeId,
      orElse: () => _collegesData.last,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 55,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _collegesData.length,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final college = _collegesData[index];
              final isSelected = selectedCollegeId == college['id'];

              return GestureDetector(
                onTap: () => _updateState(() {
                  _overrideCollegeId = college['id'] as String;
                  _overrideSpecId = null;
                }),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutQuint,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Colors.blueAccent.withValues(alpha: 0.2)
                        : Colors.white.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSelected
                          ? Colors.blueAccent
                          : Colors.white.withValues(alpha: 0.1),
                      width: 1.5,
                    ),
                    boxShadow: isSelected
                        ? [
                            BoxShadow(
                              color: Colors.blueAccent.withValues(alpha: 0.3),
                              blurRadius: 15,
                              spreadRadius: -5,
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    children: [
                      Icon(
                        college['icon'] as IconData,
                        color: isSelected ? Colors.white : Colors.white38,
                        size: 18,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        isArabic
                            ? college['nameAr'] as String
                            : college['nameEn'] as String,
                        style:
                            (isArabic
                                    ? GoogleFonts.tajawal()
                                    : GoogleFonts.outfit())
                                .copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.white38,
                                  fontWeight: isSelected
                                      ? FontWeight.w900
                                      : FontWeight.w600,
                                  fontSize: 13,
                                ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        _buildDepartmentSelector(isArabic, selectedCollege, selectedCollegeId),
      ],
    );
  }

  Widget _buildDepartmentSelector(
    bool isArabic,
    Map<String, dynamic> selectedCollege,
    dynamic selectedCollegeId,
  ) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child: SizedBox(
        key: ValueKey(selectedCollegeId),
        height: 45,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: (selectedCollege['departments'] as List).length,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) => const SizedBox(width: 8),
          itemBuilder: (context, index) {
            final dept = (selectedCollege['departments'] as List)[index];
            final isSelected =
                (_overrideSpecId ?? _identityData['specialization']) ==
                dept['id'];

            return GestureDetector(
              onTap: () =>
                  _updateState(() => _overrideSpecId = dept['id'] as String),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeOutQuint,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? Colors.white.withValues(alpha: 0.1)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: isSelected
                        ? Colors.white.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.05),
                  ),
                ),
                child: Center(
                  child: Text(
                    isArabic
                        ? dept['nameAr'] as String
                        : dept['nameEn'] as String,
                    style:
                        (isArabic
                                ? GoogleFonts.tajawal()
                                : GoogleFonts.outfit())
                            .copyWith(
                              color: isSelected ? Colors.white : Colors.white24,
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildSecurityStatus(bool isArabic) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(50),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
        boxShadow: [
          BoxShadow(
            color: Colors.greenAccent.withValues(alpha: 0.1),
            blurRadius: 30,
            spreadRadius: -10,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: Colors.greenAccent,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.greenAccent,
                      blurRadius: 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
              )
              .animate(onPlay: (c) => c.repeat())
              .scale(
                duration: 1.seconds,
                begin: const Offset(1, 1),
                end: const Offset(1.5, 1.5),
              )
              .fadeOut(),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              t.students.identity_active_secure,
              style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                  .copyWith(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 2.0,
                  ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(
            LucideIcons.shieldCheck,
            color: Colors.greenAccent,
            size: 18,
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).slideY(begin: 0.5, end: 0);
  }

  Widget _buildActionGrid(BuildContext context, bool isArabic) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: MediaQuery.textScalerOf(context).scale(13) > 13
          ? 0.8
          : 1.6,
      children: [
        _buildActionCard(
          LucideIcons.nfc,
          t.students.nfc_pass,
          Colors.blueAccent,
          isArabic,
        ),
        _buildActionCard(
          LucideIcons.download,
          t.students.offline_copy,
          Colors.purpleAccent,
          isArabic,
        ),
        _buildActionCard(
          LucideIcons.history,
          t.students.access_logs,
          Colors.orangeAccent,
          isArabic,
        ),
        _buildActionCard(
          LucideIcons.settings,
          t.students.settings,
          Colors.tealAccent,
          isArabic,
        ),
      ],
    ).animate().fadeIn(delay: 400.ms).slideY(begin: 0.2, end: 0);
  }

  Widget _buildActionCard(
    IconData icon,
    String label,
    Color color,
    bool isArabic,
  ) {
    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(16),
      border: Border.all(color: color.withValues(alpha: 0.2)),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [color.withValues(alpha: 0.1), Colors.transparent],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 12),
          Text(
            label,
            style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                .copyWith(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
    ).animate().shimmer(
      delay: 2.seconds,
      duration: 1.5.seconds,
      color: color.withValues(alpha: 0.1),
    );
  }

  void _showShareDialog(BuildContext context) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => GlassContainer(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              t.students.share_identity,
              style: (isArabic ? GoogleFonts.tajawal() : GoogleFonts.outfit())
                  .copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _ShareOption(
                  icon: LucideIcons.download,
                  label: t.students.download,
                  color: Colors.blueAccent,
                ),
                _ShareOption(
                  icon: LucideIcons.copy,
                  label: t.students.copy,
                  color: Colors.orangeAccent,
                ),
                _ShareOption(
                  icon: LucideIcons.send,
                  label: t.students.send,
                  color: Colors.greenAccent,
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

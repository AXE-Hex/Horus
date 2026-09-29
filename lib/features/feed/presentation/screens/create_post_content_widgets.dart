part of 'create_post_screen.dart';

class _MentionsRow extends StatelessWidget {
  final List<CollegeModel> colleges;
  final List<DepartmentModel> departments;
  final String? selectedCollegeId;
  final String? selectedDepartmentId;
  final bool isDark;
  final bool isArabic;
  final ValueChanged<String?> onCollegeChanged;
  final ValueChanged<String?> onDeptChanged;

  const _MentionsRow({
    required this.colleges,
    required this.departments,
    required this.selectedCollegeId,
    required this.selectedDepartmentId,
    required this.isDark,
    required this.isArabic,
    required this.onCollegeChanged,
    required this.onDeptChanged,
  });

  Widget _dropdown<T>({
    required List<T> items,
    required String Function(T) idOf,
    required String? Function(T) nameArOf,
    required String Function(T) nameEnOf,
    required String? value,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.10)
            : Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(50),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          iconSize: 14,
          isDense: true,
          dropdownColor: isDark ? _kSurface : Colors.white,
          hint: Text(
            hint,
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.38)
                  : Colors.black.withValues(alpha: 0.38),
            ),
          ),
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isDark ? Colors.white : _kBg,
          ),
          items: items
              .map(
                (item) => DropdownMenuItem(
                  value: idOf(item),
                  child: Text(
                    isArabic
                        ? (nameArOf(item) ?? nameEnOf(item))
                        : nameEnOf(item),
                  ),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Wrap(
        spacing: 8,
        runSpacing: 8,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            isArabic ? 'ذكر:' : 'Mention:',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.38)
                  : Colors.black.withValues(alpha: 0.38),
            ),
          ),
          _dropdown(
            items: colleges,
            idOf: (college) => college.id,
            nameArOf: (college) => college.nameAr,
            nameEnOf: (college) => college.nameEn,
            value: selectedCollegeId,
            hint: isArabic ? 'اختر كلية' : 'College',
            onChanged: onCollegeChanged,
          ),
          if (departments.isNotEmpty)
            _dropdown(
              items: departments,
              idOf: (department) => department.id,
              nameArOf: (department) => department.nameAr,
              nameEnOf: (department) => department.nameEn,
              value: selectedDepartmentId,
              hint: isArabic ? 'القسم' : 'Dept.',
              onChanged: onDeptChanged,
            ),
        ],
      ),
    );
  }
}

// ─── Content Field ────────────────────────────────────────────────────────────
class _ContentField extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final bool isDark;
  final bool isArabic;
  final ValueChanged<String> onChanged;

  const _ContentField({
    required this.controller,
    required this.focusNode,
    required this.isDark,
    required this.isArabic,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      focusNode: focusNode,
      maxLines: null,
      minLines: 5,
      autofocus: true,
      onChanged: onChanged,
      style: GoogleFonts.inter(
        fontSize: 17,
        height: 1.6,
        color: isDark
            ? Colors.white.withValues(alpha: 0.87)
            : const Color(0xFF1E293B),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: isArabic
            ? 'شاركنا ما يدور في ذهنك...'
            : "What's on your mind?",
        hintStyle: GoogleFonts.inter(
          fontSize: 17,
          color: isDark
              ? Colors.white.withValues(alpha: 0.24)
              : Colors.black.withValues(alpha: 0.26),
        ),
      ),
    );
  }
}

// ─── Link Field ───────────────────────────────────────────────────────────────
class _LinkField extends StatelessWidget {
  final TextEditingController controller;
  final bool isDark;
  final bool isArabic;

  const _LinkField({
    required this.controller,
    required this.isDark,
    required this.isArabic,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: _kPrimary.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: _kPrimary.withValues(alpha: 0.2)),
      ),
      child: TextField(
        controller: controller,
        style: GoogleFonts.inter(fontSize: 14, color: _kPrimary),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(LucideIcons.link, color: _kPrimary, size: 18),
          hintText: isArabic ? 'الصق الرابط هنا...' : 'Paste a link...',
          hintStyle: GoogleFonts.inter(color: _kPrimary.withValues(alpha: 0.4)),
        ),
      ),
    );
  }
}

// ─── Media Preview ────────────────────────────────────────────────────────────
class _MediaPreview extends StatelessWidget {
  final List<File> media;
  final ValueChanged<int> onRemove;

  const _MediaPreview({required this.media, required this.onRemove});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        physics: const BouncingScrollPhysics(),
        itemCount: media.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final isVideo = [
            '.mp4',
            '.mov',
            '.avi',
          ].any((ext) => media[i].path.toLowerCase().endsWith(ext));
          return SizedBox(
            width: 170,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: isVideo
                      ? Container(
                          color: Colors.black.withValues(alpha: 0.45),
                          child: const Center(
                            child: Icon(
                              LucideIcons.playCircle,
                              size: 44,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Image.file(
                          media[i],
                          fit: BoxFit.cover,
                          width: 170,
                          height: double.infinity,
                        ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => onRemove(i),
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.54),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ).animate().scale(
            delay: Duration(milliseconds: i * 50),
            duration: 200.ms,
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}

// ─── Toolbar ──────────────────────────────────────────────────────────────────

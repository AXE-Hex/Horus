import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/features/academic/data/repositories/academic_repository.dart';
import 'package:horus/features/feed/data/repositories/post_repository.dart';
import 'package:horus/features/feed/domain/models/post_model.dart';
import 'package:horus/features/feed/presentation/providers/feed_provider.dart';
import 'package:horus/features/feed/presentation/widgets/link_preview_widget.dart';
import 'package:horus/features/shared/presentation/widgets/premium_success_overlay.dart';

// ─── Tokens ───────────────────────────────────────────────────────────────────
const _kPrimary = Color(0xFF6366F1);
const _kSurface = Color(0xFF1E293B);
const _kBg = Color(0xFF0F172A);
const _kBorderLight = Color(0xFFE2E8F0);

class CreatePostScreen extends ConsumerStatefulWidget {
  final PostType initialType;
  const CreatePostScreen({super.key, this.initialType = PostType.text});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen>
    with SingleTickerProviderStateMixin {
  final _contentController = TextEditingController();
  final _linkController = TextEditingController();
  final _focusNode = FocusNode();

  String? _selectedCollegeId;
  String? _selectedDepartmentId;
  List<Map<String, dynamic>> _colleges = [];
  List<Map<String, dynamic>> _departments = [];

  String? _detectedLink;
  late PostType _currentType;
  bool _postAsCollege = false;
  bool _isLoading = false;
  final List<File> _selectedMedia = [];
  final ImagePicker _picker = ImagePicker();

  late AnimationController _fabAnim;

  @override
  void initState() {
    super.initState();
    _currentType = widget.initialType;
    _fabAnim = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _contentController.addListener(() {
      if (_contentController.text.trim().isNotEmpty) {
        _fabAnim.forward();
      } else {
        _fabAnim.reverse();
      }
      setState(() {});
    });
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final academicRepo = ref.read(academicRepositoryProvider);
    final colleges = await academicRepo.getColleges();
    if (mounted) setState(() => _colleges = colleges);
  }

  Future<void> _loadDepartments(String collegeId) async {
    final depts = await ref
        .read(academicRepositoryProvider)
        .getDepartments(collegeId: collegeId);
    if (mounted) {
      setState(() {
        _departments = depts;
        _selectedDepartmentId = null;
      });
    }
  }

  @override
  void dispose() {
    _contentController.dispose();
    _linkController.dispose();
    _focusNode.dispose();
    _fabAnim.dispose();
    super.dispose();
  }

  Future<void> _pickMedia(bool isVideo) async {
    try {
      if (isVideo) {
        final XFile? video = await _picker.pickVideo(
          source: ImageSource.gallery,
          maxDuration: const Duration(minutes: 5),
        );
        if (video != null) setState(() => _selectedMedia.add(File(video.path)));
      } else {
        final List<XFile> images = await _picker.pickMultiImage(limit: 10);
        if (images.isNotEmpty) {
          setState(() => _selectedMedia.addAll(images.map((x) => File(x.path))));
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }

  Future<void> _submitPost() async {
    final content = _contentController.text.trim();
    if (content.isEmpty) return;
    HapticFeedback.mediumImpact();
    setState(() => _isLoading = true);

    try {
      final repository = ref.read(postRepositoryProvider);
      final userId = ref.read(authControllerProvider).user!.id;

      List<String> uploadedUrls = [];
      for (var file in _selectedMedia) {
        final url = await repository.uploadMedia(file, userId);
        if (url != null) uploadedUrls.add(url);
      }

      String? collegeId;
      if (_postAsCollege) {
        final res = await repository.supabase
            .from('colleges')
            .select('id')
            .eq('dean_id', userId)
            .maybeSingle();
        if (res != null) collegeId = res['id'] as String;
      } else {
        collegeId = _selectedCollegeId;
      }

      final post = await repository.createPost(
        content: content,
        type: _currentType,
        mediaUrls: uploadedUrls,
        linkUrl: _detectedLink ??
            (_currentType == PostType.link
                ? _linkController.text.trim()
                : null),
        collegeId: collegeId,
        departmentId: _selectedDepartmentId,
      );

      ref.read(feedProvider.notifier).addPost(post);

      if (mounted) {
        PremiumSuccessOverlay.show(
          context,
          title: t.extracted.posted_successfully,
          message: t.extracted.your_post_is_now_live_on_the_feed,
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: const Color(0xFFEF4444),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authState = ref.watch(authControllerProvider);
    final canPostAsCollege =
        authState.role == UserRole.dean || authState.role == UserRole.rector;
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final isEmpty = _contentController.text.trim().isEmpty;

    return Scaffold(
      backgroundColor: isDark ? _kBg : Colors.white,
      appBar: _buildAppBar(isDark, isArabic, isEmpty),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ── Type selector banner ─────────────────────────────────
                  if (_currentType == PostType.announcement)
                    _AnnouncementBanner(isArabic: isArabic),

                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // ── Author Header ──────────────────────────────────
                        _AuthorHeader(
                          authState: authState,
                          canPostAsCollege: canPostAsCollege,
                          postAsCollege: _postAsCollege,
                          isDark: isDark,
                          isArabic: isArabic,
                          onToggleCollege: () =>
                              setState(() => _postAsCollege = !_postAsCollege),
                        ),

                        const SizedBox(height: 16),

                        // ── Mentions ────────────────────────────────────────
                        if (!_postAsCollege && _colleges.isNotEmpty)
                          _MentionsRow(
                            colleges: _colleges,
                            departments: _departments,
                            selectedCollegeId: _selectedCollegeId,
                            selectedDepartmentId: _selectedDepartmentId,
                            isDark: isDark,
                            isArabic: isArabic,
                            onCollegeChanged: (val) {
                              if (val != null) {
                                setState(() {
                                  _selectedCollegeId = val;
                                  _selectedDepartmentId = null;
                                  _departments = [];
                                });
                                _loadDepartments(val);
                              }
                            },
                            onDeptChanged: (val) =>
                                setState(() => _selectedDepartmentId = val),
                          ),

                        const SizedBox(height: 12),

                        // ── Content Field ───────────────────────────────────
                        _ContentField(
                          controller: _contentController,
                          focusNode: _focusNode,
                          isDark: isDark,
                          isArabic: isArabic,
                          onChanged: (text) {
                            final urlRegExp = RegExp(
                                r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,})');
                            final match = urlRegExp.firstMatch(text);
                            if (match != null) {
                              var link = text.substring(match.start, match.end);
                              if (!link.startsWith('http')) link = 'https://$link';
                              if (_detectedLink != link) {
                                setState(() => _detectedLink = link);
                              }
                            } else if (_detectedLink != null) {
                              setState(() => _detectedLink = null);
                            }
                          },
                        ),

                        const SizedBox(height: 12),

                        // ── Link Preview ────────────────────────────────────
                        if (_detectedLink != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: LinkPreviewWidget(url: _detectedLink!),
                          ).animate().fadeIn().slideY(begin: 0.1, end: 0),

                        // ── Manual Link Field ───────────────────────────────
                        if (_currentType == PostType.link &&
                            _detectedLink == null)
                          _LinkField(
                            controller: _linkController,
                            isDark: isDark,
                            isArabic: isArabic,
                          ).animate().fadeIn().slideY(begin: 0.08, end: 0),
                      ],
                    ),
                  ),

                  // ── Media Preview ──────────────────────────────────────────
                  if (_selectedMedia.isNotEmpty)
                    _MediaPreview(
                      media: _selectedMedia,
                      onRemove: (i) => setState(() => _selectedMedia.removeAt(i)),
                    )
                        .animate()
                        .fadeIn()
                        .slideY(begin: 0.06, end: 0),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),

          // ── Bottom Toolbar ─────────────────────────────────────────────────
          _Toolbar(
            isDark: isDark,
            isArabic: isArabic,
            currentType: _currentType,
            selectedCount: _selectedMedia.length,
            onPickImage: () => _pickMedia(false),
            onPickVideo: () => _pickMedia(true),
            onToggleLink: () => setState(() => _currentType =
                _currentType == PostType.link ? PostType.text : PostType.link),
            onToggleAnnouncement: () => setState(() =>
                _currentType = _currentType == PostType.announcement
                    ? PostType.text
                    : PostType.announcement),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(
    bool isDark,
    bool isArabic,
    bool isEmpty,
  ) {
    return AppBar(
      backgroundColor: isDark ? _kBg : Colors.white,
      elevation: 0,
      scrolledUnderElevation: 0.5,
      shadowColor: Colors.black.withValues(alpha: 0.12),
      leading: IconButton(
        onPressed: () => context.pop(),
        icon: Icon(
          LucideIcons.x,
          size: 22,
          color: isDark ? Colors.white.withValues(alpha: 0.70) : Colors.black.withValues(alpha: 0.54),
        ),
      ),
      title: Text(
        isArabic ? 'منشور جديد' : 'Create Post',
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.w700,
          fontSize: 18,
          color: isDark ? Colors.white : _kBg,
        ),
      ),
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: AnimatedOpacity(
            opacity: isEmpty ? 0.4 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: (_isLoading || isEmpty) ? null : _submitPost,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                decoration: BoxDecoration(
                  gradient: isEmpty || _isLoading
                      ? null
                      : const LinearGradient(
                          colors: [_kPrimary, Color(0xFF8B5CF6)],
                        ),
                  color: isEmpty ? Colors.grey.withValues(alpha: 0.3) : null,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: _isLoading
                    ? const SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(
                        isArabic ? 'نشر' : 'Post',
                        style: GoogleFonts.outfit(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 14,
                        ),
                      ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Announcement Banner ──────────────────────────────────────────────────────
class _AnnouncementBanner extends StatelessWidget {
  final bool isArabic;
  const _AnnouncementBanner({required this.isArabic});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFFF59E0B).withValues(alpha: 0.15),
            const Color(0xFFF97316).withValues(alpha: 0.05),
          ],
        ),
        border: const Border(
          bottom: BorderSide(
            color: Color(0xFFF59E0B),
            width: 0.5,
          ),
        ),
      ),
      child: Row(
        children: [
          const Icon(LucideIcons.megaphone,
              color: Color(0xFFF59E0B), size: 16),
          const SizedBox(width: 8),
          Text(
            isArabic ? 'أنت تنشر إعلاناً رسمياً' : 'Posting as Announcement',
            style: GoogleFonts.outfit(
              color: const Color(0xFFF59E0B),
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),
          ),
        ],
      ),
    ).animate().fadeIn().slideY(begin: -0.1, end: 0);
  }
}

// ─── Author Header ────────────────────────────────────────────────────────────
class _AuthorHeader extends StatelessWidget {
  final AuthState authState;
  final bool canPostAsCollege;
  final bool postAsCollege;
  final bool isDark;
  final bool isArabic;
  final VoidCallback onToggleCollege;

  const _AuthorHeader({
    required this.authState,
    required this.canPostAsCollege,
    required this.postAsCollege,
    required this.isDark,
    required this.isArabic,
    required this.onToggleCollege,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundImage: authState.profile?.avatarUrl != null
              ? NetworkImage(authState.profile!.avatarUrl!)
              : null,
          backgroundColor: _kPrimary.withValues(alpha: 0.1),
          child: authState.profile?.avatarUrl == null
              ? Icon(LucideIcons.user, color: _kPrimary, size: 22)
              : null,
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                authState.profile?.fullName ?? 'User',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: isDark ? Colors.white : _kBg,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 6,
                children: [
                  _BadgeChip(
                    icon: LucideIcons.globe,
                    label: isArabic ? 'عام' : 'Public',
                    isDark: isDark,
                    color: _kPrimary,
                  ),
                  if (canPostAsCollege)
                    GestureDetector(
                      onTap: onToggleCollege,
                      child: _BadgeChip(
                        icon: LucideIcons.building,
                        label: isArabic ? 'باسم الكلية' : 'As College',
                        isDark: isDark,
                        color: postAsCollege
                            ? _kPrimary
                            : (isDark ? Colors.white.withValues(alpha: 0.54) : Colors.black.withValues(alpha: 0.45)),
                        isActive: postAsCollege,
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _BadgeChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isDark;
  final Color color;
  final bool isActive;

  const _BadgeChip({
    required this.icon,
    required this.label,
    required this.isDark,
    required this.color,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isActive
            ? _kPrimary.withValues(alpha: 0.12)
            : (isDark ? Colors.white.withValues(alpha: 0.10) : Colors.black.withValues(alpha: 0.05)),
        borderRadius: BorderRadius.circular(8),
        border: isActive
            ? Border.all(color: _kPrimary.withValues(alpha: 0.3))
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Mentions Row ─────────────────────────────────────────────────────────────
class _MentionsRow extends StatelessWidget {
  final List<Map<String, dynamic>> colleges;
  final List<Map<String, dynamic>> departments;
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

  Widget _dropdown({
    required List<Map<String, dynamic>> items,
    required String? value,
    required String hint,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withValues(alpha: 0.10) : Colors.black.withValues(alpha: 0.05),
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
              color: isDark ? Colors.white.withValues(alpha: 0.38) : Colors.black.withValues(alpha: 0.38),
            ),
          ),
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isDark ? Colors.white : _kBg,
          ),
          items: items
              .map((i) => DropdownMenuItem(
                    value: i['id'] as String,
                    child: Text(isArabic
                        ? (i['name_ar'] ?? i['name_en'])
                        : i['name_en']),
                  ))
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
              color: isDark ? Colors.white.withValues(alpha: 0.38) : Colors.black.withValues(alpha: 0.38),
            ),
          ),
          _dropdown(
            items: colleges,
            value: selectedCollegeId,
            hint: isArabic ? 'اختر كلية' : 'College',
            onChanged: onCollegeChanged,
          ),
          if (departments.isNotEmpty)
            _dropdown(
              items: departments,
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
        color: isDark ? Colors.white.withValues(alpha: 0.87) : const Color(0xFF1E293B),
      ),
      decoration: InputDecoration(
        border: InputBorder.none,
        hintText: isArabic ? 'شاركنا ما يدور في ذهنك...' : "What's on your mind?",
        hintStyle: GoogleFonts.inter(
          fontSize: 17,
          color: isDark ? Colors.white.withValues(alpha: 0.24) : Colors.black.withValues(alpha: 0.26),
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
          hintStyle: GoogleFonts.inter(
            color: _kPrimary.withValues(alpha: 0.4),
          ),
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
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) {
          final isVideo = ['.mp4', '.mov', '.avi']
              .any((ext) => media[i].path.toLowerCase().endsWith(ext));
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
class _Toolbar extends StatelessWidget {
  final bool isDark;
  final bool isArabic;
  final PostType currentType;
  final int selectedCount;
  final VoidCallback onPickImage;
  final VoidCallback onPickVideo;
  final VoidCallback onToggleLink;
  final VoidCallback onToggleAnnouncement;

  const _Toolbar({
    required this.isDark,
    required this.isArabic,
    required this.currentType,
    required this.selectedCount,
    required this.onPickImage,
    required this.onPickVideo,
    required this.onToggleLink,
    required this.onToggleAnnouncement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom > 0
            ? MediaQuery.of(context).viewInsets.bottom
            : MediaQuery.of(context).padding.bottom,
        left: 12,
        right: 12,
        top: 10,
      ),
      decoration: BoxDecoration(
        color: isDark ? _kSurface : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? Colors.white.withValues(alpha: 0.10) : _kBorderLight,
          ),
        ),
      ),
      child: Row(
        children: [
          Text(
            isArabic ? 'أضف للمنشور:' : 'Add to post:',
            style: GoogleFonts.inter(
              fontSize: 12,
              color: isDark ? Colors.white.withValues(alpha: 0.38) : Colors.black.withValues(alpha: 0.38),
            ),
          ),
          const SizedBox(width: 4),
          _ToolBtn(
            icon: LucideIcons.image,
            color: const Color(0xFF10B981),
            onTap: onPickImage,
            badge: selectedCount > 0 ? '$selectedCount' : null,
          ),
          _ToolBtn(
            icon: LucideIcons.video,
            color: const Color(0xFFEF4444),
            onTap: onPickVideo,
          ),
          _ToolBtn(
            icon: LucideIcons.link,
            color: const Color(0xFF3B82F6),
            onTap: onToggleLink,
            isActive: currentType == PostType.link,
          ),
          _ToolBtn(
            icon: LucideIcons.megaphone,
            color: const Color(0xFFF59E0B),
            onTap: onToggleAnnouncement,
            isActive: currentType == PostType.announcement,
          ),
          const Spacer(),
          Text(
            '${t.extracted.whats_on_your_mind}'.length > 0
                ? ''
                : '',
            style: const TextStyle(fontSize: 0),
          ),
        ],
      ),
    );
  }
}

class _ToolBtn extends StatelessWidget {
  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? badge;
  final bool isActive;

  const _ToolBtn({
    required this.icon,
    required this.color,
    required this.onTap,
    this.badge,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          IconButton(
            onPressed: onTap,
            icon: Icon(
              icon,
              size: 22,
              color: isActive ? color : color.withValues(alpha: 0.6),
            ),
            style: isActive
                ? IconButton.styleFrom(
                    backgroundColor: color.withValues(alpha: 0.12),
                  )
                : null,
          ),
          if (badge != null)
            Positioned(
              top: 4,
              right: 4,
              child: Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    badge!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

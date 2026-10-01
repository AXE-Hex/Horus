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
import 'package:horus/features/feed/data/repositories/post_repository.dart';
import 'package:horus/features/feed/domain/models/post_model.dart';
import 'package:horus/features/institutional/data/models/institutional_models.dart';
import 'package:horus/features/institutional/data/repositories/institutional_repository.dart';
import 'package:horus/features/feed/presentation/providers/feed_provider.dart';
import 'package:horus/features/feed/presentation/widgets/link_preview_widget.dart';
import 'package:horus/features/shared/presentation/widgets/premium_success_overlay.dart';

part 'create_post_author_widgets.dart';
part 'create_post_content_widgets.dart';
part 'create_post_toolbar_widgets.dart';

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
  List<CollegeModel> _colleges = [];
  List<DepartmentModel> _departments = [];

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
    final colleges = await ref
        .read(institutionalRepositoryProvider)
        .getColleges();
    if (mounted) setState(() => _colleges = colleges);
  }

  Future<void> _loadDepartments(String collegeId) async {
    final depts = await ref
        .read(institutionalRepositoryProvider)
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
          setState(
            () => _selectedMedia.addAll(images.map((x) => File(x.path))),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(t.academic.error)));
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
        final url = await repository.uploadMedia(file);
        if (url != null) uploadedUrls.add(url);
      }

      String? collegeId;
      if (_postAsCollege) {
        final college = await ref
            .read(institutionalRepositoryProvider)
            .getCollegeForDean(userId);
        collegeId = college?.id;
      } else {
        collegeId = _selectedCollegeId;
      }

      final post = await repository.createPost(
        content: content,
        type: _currentType,
        mediaUrls: uploadedUrls,
        linkUrl:
            _detectedLink ??
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
            content: Text(t.academic.error),
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
    final canPostAsCollege = authState.hasPermission(
      RolePermission.createAnnouncements,
    );
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
                              r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,})',
                            );
                            final match = urlRegExp.firstMatch(text);
                            if (match != null) {
                              var link = text.substring(match.start, match.end);
                              if (!link.startsWith('http')) {
                                link = 'https://$link';
                              }
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
                      onRemove: (i) =>
                          setState(() => _selectedMedia.removeAt(i)),
                    ).animate().fadeIn().slideY(begin: 0.06, end: 0),

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
            onToggleLink: () => setState(
              () => _currentType = _currentType == PostType.link
                  ? PostType.text
                  : PostType.link,
            ),
            onToggleAnnouncement: () => setState(
              () => _currentType = _currentType == PostType.announcement
                  ? PostType.text
                  : PostType.announcement,
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(bool isDark, bool isArabic, bool isEmpty) {
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
          color: isDark
              ? Colors.white.withValues(alpha: 0.70)
              : Colors.black.withValues(alpha: 0.54),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
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

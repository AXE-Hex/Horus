import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:horus/core/i18n/strings.g.dart';
import 'package:horus/core/auth/auth_provider.dart';
import 'package:horus/features/feed/domain/models/post_model.dart';
import 'package:horus/features/feed/presentation/providers/feed_provider.dart';
import 'package:horus/features/feed/data/repositories/post_repository.dart';
import 'package:horus/features/academic/data/repositories/academic_repository.dart';
import 'package:horus/features/shared/presentation/widgets/premium_success_overlay.dart';
import 'package:horus/features/feed/presentation/widgets/link_preview_widget.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  final PostType initialType;

  const CreatePostScreen({super.key, this.initialType = PostType.text});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

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

  @override
  void initState() {
    super.initState();
    _currentType = widget.initialType;
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    final academicRepo = ref.read(academicRepositoryProvider);
    final colleges = await academicRepo.getColleges();
    if (mounted) {
      setState(() {
        _colleges = colleges;
      });
    }
  }

  Future<void> _loadDepartments(String collegeId) async {
    final academicRepo = ref.read(academicRepositoryProvider);
    final depts = await academicRepo.getDepartments(collegeId: collegeId);
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
    super.dispose();
  }

  Future<void> _pickMedia(bool isVideo) async {
    try {
      if (isVideo) {
        final XFile? video = await _picker.pickVideo(
          source: ImageSource.gallery,
        );
        if (video != null) {
          setState(() => _selectedMedia.add(File(video.path)));
        }
      } else {
        final List<XFile> images = await _picker.pickMultiImage();
        if (images.isNotEmpty) {
          setState(() {
            _selectedMedia.addAll(images.map((x) => File(x.path)));
          });
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking media: ${e.toString()}')),
        );
      }
    }
  }

  Future<void> _submitPost() async {
    final content = _contentController.text.trim();
    if (content.isEmpty) return;

    setState(() => _isLoading = true);

    try {
      final feedNotifier = ref.read(feedProvider.notifier);
      final repository = ref.read(postRepositoryProvider);

      List<String> uploadedUrls = [];
      String userId = ref.read(authControllerProvider).user!.id;

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
        if (res != null) {
          collegeId = res['id'] as String;
        }
      } else {
        collegeId = _selectedCollegeId;
      }

      final post = await repository.createPost(
        content: content,
        type: _currentType,
        mediaUrls: uploadedUrls,
        linkUrl: _detectedLink ?? (_currentType == PostType.link
            ? _linkController.text.trim()
            : null),
        collegeId: collegeId,
        departmentId: _selectedDepartmentId,
      );

      feedNotifier.addPost(post);

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
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final authState = ref.watch(authControllerProvider);
    final canPostAsCollege =
        authState.role == UserRole.dean || authState.role == UserRole.rector;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF1E293B) : Colors.white,
      appBar: AppBar(
        title: Text(
          t.extracted.create_post,
          style: GoogleFonts.outfit(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: FilledButton(
              onPressed: _isLoading || _contentController.text.trim().isEmpty
                  ? null
                  : _submitPost,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
                      t.extracted.post,
                      style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
                    ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildAuthorHeader(
                    authState,
                    isArabic,
                    canPostAsCollege,
                    theme,
                  ),
                  const SizedBox(height: 16),

                  if (!_postAsCollege) _buildMentionsSection(isArabic, theme),

                  _buildContentInput(isArabic),
                  const SizedBox(height: 16),

                  if (_detectedLink != null)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: LinkPreviewWidget(url: _detectedLink!),
                    ),

                  if (_selectedMedia.isNotEmpty) _buildPremiumMediaPreview(),

                  if (_currentType == PostType.link && _detectedLink == null)
                    _buildLinkField(isArabic, theme),
                ],
              ),
            ),
          ),

          _buildToolBar(isArabic, theme),
        ],
      ),
    );
  }

  Widget _buildAuthorHeader(
    AuthState authState,
    bool isArabic,
    bool canPostAsCollege,
    ThemeData theme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: 22,
          backgroundImage: authState.profile?.avatarUrl != null
              ? NetworkImage(authState.profile!.avatarUrl!)
              : null,
          backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
          child: authState.profile?.avatarUrl == null
              ? Icon(LucideIcons.user, color: theme.primaryColor)
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
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 4),
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  _buildVisibilityBadge(isArabic, theme),
                  if (canPostAsCollege) _buildPostAsSwitch(isArabic, theme),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostAsSwitch(bool isArabic, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => setState(() => _postAsCollege = !_postAsCollege),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: _postAsCollege
              ? theme.primaryColor.withValues(alpha: 0.1)
              : (isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05)),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              LucideIcons.building,
              size: 14,
              color: _postAsCollege ? theme.primaryColor : (isDark ? Colors.white70 : Colors.black87),
            ),
            const SizedBox(width: 4),
            Text(
              t.extracted.as_college,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: _postAsCollege ? theme.primaryColor : (isDark ? Colors.white70 : Colors.black87),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisibilityBadge(bool isArabic, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(LucideIcons.users, size: 14, color: isDark ? Colors.white70 : Colors.black87),
          const SizedBox(width: 4),
          Text(
            t.extracted.public,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: isDark ? Colors.white70 : Colors.black87,
            ),
          ),
          const SizedBox(width: 4),
          Icon(LucideIcons.chevronDown, size: 14, color: isDark ? Colors.white70 : Colors.black87),
        ],
      ),
    );
  }

  Widget _buildMentionsSection(bool isArabic, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Text(
            t.extracted.mention_collegedept,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Wrap(
              spacing: 8,
              children: [
                _buildMentionsDropdown(
                  value: _selectedCollegeId,
                  items: _colleges,
                  hint: t.extracted.select_college,
                  onChanged: (val) {
                    if (val != null) {
                      setState(() {
                        _selectedCollegeId = val;
                        _selectedDepartmentId = null;
                        _departments = [];
                      });
                      _loadDepartments(val);
                    }
                  },
                  theme: theme,
                ),
                if (_departments.isNotEmpty)
                  _buildMentionsDropdown(
                    value: _selectedDepartmentId,
                    items: _departments,
                    hint: t.extracted.dept,
                    onChanged: (val) =>
                        setState(() => _selectedDepartmentId = val),
                    theme: theme,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentionsDropdown({
    required String? value,
    required List<Map<String, dynamic>> items,
    required String hint,
    required ValueChanged<String?> onChanged,
    required ThemeData theme,
  }) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final isDark = theme.brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      decoration: BoxDecoration(
        color: isDark ? Colors.white10 : Colors.black.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(20),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          iconSize: 16,
          isDense: true,
          dropdownColor: isDark ? const Color(0xFF1E293B) : Colors.white,
          hint: Text(
            hint,
            style: GoogleFonts.inter(fontSize: 12, color: isDark ? Colors.white54 : Colors.black54),
          ),
          style: GoogleFonts.inter(fontSize: 12, color: isDark ? Colors.white : Colors.black87),
          items: items
              .map(
                (i) => DropdownMenuItem(
                  value: i['id'] as String,
                  child: Text(isArabic ? i['name_ar'] : i['name_en']),
                ),
              )
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildContentInput(bool isArabic) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return TextField(
      controller: _contentController,
      maxLines: null,
      minLines: 4,
      onChanged: (text) {
        final RegExp urlRegExp = RegExp(
            r'(https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|www\.[a-zA-Z0-9][a-zA-Z0-9-]+[a-zA-Z0-9]\.[^\s]{2,}|https?:\/\/(?:www\.|(?!www))[a-zA-Z0-9]+\.[^\s]{2,}|www\.[a-zA-Z0-9]+\.[^\s]{2,})');
        final match = urlRegExp.firstMatch(text);
        if (match != null) {
          var link = text.substring(match.start, match.end);
          if (!link.startsWith('http')) link = 'https://$link';
          if (_detectedLink != link) setState(() => _detectedLink = link);
        } else {
          if (_detectedLink != null) setState(() => _detectedLink = null);
        }
        setState(() {});
      },
      style: GoogleFonts.inter(
        fontSize: 20, 
        height: 1.5,
        color: isDark ? Colors.white : Colors.black87,
      ),
      decoration: InputDecoration(
        hintText: t.extracted.whats_on_your_mind,
        hintStyle: GoogleFonts.inter(
          fontSize: 20,
          color: isDark ? Colors.white30 : Colors.black38,
        ),
        border: InputBorder.none,
      ),
    );
  }

  Widget _buildPremiumMediaPreview() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 260,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: _selectedMedia.length,
        separatorBuilder: (_, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return Container(
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: (_selectedMedia[index].path.toLowerCase().endsWith('.mp4') ||
                          _selectedMedia[index].path.toLowerCase().endsWith('.mov') ||
                          _selectedMedia[index].path.toLowerCase().endsWith('.avi'))
                      ? Container(
                          color: Colors.black26,
                          child: const Center(
                            child: Icon(
                              LucideIcons.playCircle,
                              size: 50,
                              color: Colors.white,
                            ),
                          ),
                        )
                      : Image.file(_selectedMedia[index], fit: BoxFit.cover),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: GestureDetector(
                    onTap: () => setState(() => _selectedMedia.removeAt(index)),
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ).animate().scale(delay: (index * 50).ms, duration: 200.ms);
        },
      ),
    );
  }

  Widget _buildLinkField(bool isArabic, ThemeData theme) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: theme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.primaryColor.withValues(alpha: 0.2)),
      ),
      child: TextField(
        controller: _linkController,
        style: GoogleFonts.inter(fontSize: 14, color: theme.primaryColor),
        decoration: InputDecoration(
          border: InputBorder.none,
          icon: Icon(LucideIcons.link, color: theme.primaryColor, size: 18),
          hintText: t.extracted.paste_link_here,
          hintStyle: GoogleFonts.inter(
            color: theme.primaryColor.withValues(alpha: 0.4),
          ),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildToolBar(bool isArabic, ThemeData theme) {
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            offset: const Offset(0, -2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              t.extracted.add_to_your_post,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
          Row(
            children: [
              _buildToolItem(LucideIcons.image, Colors.green, () {
                _pickMedia(false);
              }),
              _buildToolItem(LucideIcons.video, Colors.red, () {
                _pickMedia(true);
              }),
              _buildToolItem(
                LucideIcons.link,
                Colors.blue,
                () => setState(() {
                  _currentType = PostType.link;
                }),
              ),
              _buildToolItem(
                LucideIcons.megaphone,
                Colors.orange,
                () => setState(() {
                  _currentType = PostType.announcement;
                }),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolItem(IconData icon, Color color, VoidCallback onTap) {
    return IconButton(
      onPressed: onTap,
      icon: Icon(icon, color: color, size: 24),
      splashRadius: 24,
    );
  }
}

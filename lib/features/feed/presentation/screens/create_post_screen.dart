import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:hue/core/i18n/strings.g.dart';
import 'package:hue/core/auth/auth_provider.dart';
import 'package:hue/features/feed/domain/models/post_model.dart';
import 'package:hue/features/feed/presentation/providers/feed_provider.dart';
import 'package:hue/features/feed/data/repositories/post_repository.dart';
import 'package:hue/features/academic/data/repositories/professor_repository.dart';
import 'package:hue/features/shared/presentation/widgets/premium_success_overlay.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';

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

      // Upload media
      for (var file in _selectedMedia) {
        final url = await repository.uploadMedia(file, userId);
        if (url != null) uploadedUrls.add(url);
      }

      // Determine collegeId for this post.
      // - When posting as a college: derive the college from the current dean/rector account only.
      // - Otherwise: use the explicitly mentioned college (if any).
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
        linkUrl: _currentType == PostType.link
            ? _linkController.text.trim()
            : null,
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
    final authState = ref.watch(authControllerProvider);
    final canPostAsCollege =
        authState.role == UserRole.dean || authState.role == UserRole.rector;
    final isArabic = t.$meta.locale.languageCode == 'ar';

    return GlassScaffold(
      appBar: AppBar(
        title: Text(
          t.extracted.create_post,
          style: GoogleFonts.outfit(fontWeight: FontWeight.w900, letterSpacing: -0.5),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: ElevatedButton(
              onPressed: _isLoading || _contentController.text.trim().isEmpty ? null : _submitPost,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                padding: const EdgeInsets.symmetric(horizontal: 24),
              ),
              child: _isLoading
                  ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text(t.extracted.post, style: GoogleFonts.outfit(fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Author Header (WhatsApp/FB Style)
                  _buildAuthorHeader(authState.user, isArabic, canPostAsCollege, theme),
                  const SizedBox(height: 20),

                  // Mentions Area (If needed)
                  if (!_postAsCollege) _buildMentionsSection(isArabic, theme),
                  
                  // Content Input Area (Premium Glass)
                  _buildContentInput(isArabic),
                  const SizedBox(height: 20),

                  // Media Preview (Premium WhatsApp Style Grid)
                  if (_selectedMedia.isNotEmpty) _buildPremiumMediaPreview(),

                  // Link Field
                  if (_currentType == PostType.link) _buildLinkField(isArabic, theme),
                ],
              ),
            ),
          ),
          
          // Tool Bar (Fixed at bottom)
          _buildToolBar(isArabic, theme),
        ],
      ),
    );
  }

  Widget _buildAuthorHeader(dynamic user, bool isArabic, bool canPostAsCollege, ThemeData theme) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: theme.primaryColor.withValues(alpha: 0.3), width: 2),
          ),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: user?.avatarUrl != null ? NetworkImage(user!.avatarUrl!) : null,
            backgroundColor: theme.primaryColor.withValues(alpha: 0.1),
            child: user?.avatarUrl == null ? Icon(LucideIcons.user, color: theme.primaryColor) : null,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user?.name ?? 'User',
                style: GoogleFonts.outfit(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  if (canPostAsCollege) _buildPostAsSwitch(isArabic, theme),
                  const SizedBox(width: 8),
                  _buildVisibilityBadge(isArabic, theme),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPostAsSwitch(bool isArabic, ThemeData theme) {
    return GestureDetector(
      onTap: () => setState(() => _postAsCollege = !_postAsCollege),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
        decoration: BoxDecoration(
          color: _postAsCollege ? theme.primaryColor.withValues(alpha: 0.1) : Colors.white10,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _postAsCollege ? theme.primaryColor.withValues(alpha: 0.3) : Colors.white24),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.building, size: 12, color: _postAsCollege ? theme.primaryColor : Colors.white70),
            const SizedBox(width: 6),
            Text(
              t.extracted.as_college,
              style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: _postAsCollege ? theme.primaryColor : Colors.white70),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVisibilityBadge(bool isArabic, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white10,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.white24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(LucideIcons.users, size: 12, color: Colors.white70),
          const SizedBox(width: 6),
          Text(
            t.extracted.public,
            style: GoogleFonts.inter(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.white70),
          ),
          const SizedBox(width: 4),
          const Icon(LucideIcons.chevronDown, size: 12, color: Colors.white30),
        ],
      ),
    );
  }

  Widget _buildMentionsSection(bool isArabic, ThemeData theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.extracted.mention_collegedept,
          style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.white30),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: _buildMentionsDropdown(
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
              ),
            ),
            if (_departments.isNotEmpty) ...[
              const SizedBox(width: 8),
              Expanded(
                child: _buildMentionsDropdown(
                  value: _selectedDepartmentId,
                  items: _departments,
                  hint: t.extracted.dept,
                  onChanged: (val) => setState(() => _selectedDepartmentId = val),
                ),
              ),
            ],
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildMentionsDropdown({required String? value, required List<Map<String, dynamic>> items, required String hint, required ValueChanged<String?> onChanged}) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: value,
          isExpanded: true,
          dropdownColor: const Color(0xFF1E293B),
          hint: Text(hint, style: GoogleFonts.inter(fontSize: 13, color: Colors.white30)),
          style: GoogleFonts.inter(fontSize: 13, color: Colors.white),
          items: items.map((i) => DropdownMenuItem(value: i['id'] as String, child: Text(isArabic ? i['name_ar'] : i['name_en']))).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }

  Widget _buildContentInput(bool isArabic) {
    return TextField(
      controller: _contentController,
      maxLines: null,
      minLines: 5,
      onChanged: (_) => setState(() {}),
      style: GoogleFonts.inter(fontSize: 18, height: 1.5),
      decoration: InputDecoration(
        hintText: t.extracted.whats_on_your_mind,
        hintStyle: GoogleFonts.outfit(fontSize: 22, color: Colors.white24, fontWeight: FontWeight.bold),
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
              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: _currentType == PostType.video
                    ? Container(
                      color: Colors.black26,
                      child: const Center(child: Icon(LucideIcons.playCircle, size: 50, color: Colors.white)),
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
                      decoration: const BoxDecoration(color: Colors.black54, shape: BoxShape.circle),
                      child: const Icon(Icons.close, color: Colors.white, size: 16),
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
          hintStyle: GoogleFonts.inter(color: theme.primaryColor.withValues(alpha: 0.4)),
        ),
      ),
    ).animate().fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildToolBar(bool isArabic, ThemeData theme) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E293B).withValues(alpha: 0.9),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        border: Border(top: BorderSide(color: Colors.white.withValues(alpha: 0.05))),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 12, top: 4),
            child: Text(
              t.extracted.add_to_your_post,
              style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white30),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildToolItem(LucideIcons.image, Colors.green, () {
                if (_currentType != PostType.image) setState(() { _selectedMedia.clear(); _currentType = PostType.image; });
                _pickMedia(false);
              }),
              _buildToolItem(LucideIcons.video, Colors.red, () {
                if (_currentType != PostType.video) setState(() { _selectedMedia.clear(); _currentType = PostType.video; });
                _pickMedia(true);
              }),
              _buildToolItem(LucideIcons.link, Colors.blue, () => setState(() { _selectedMedia.clear(); _currentType = PostType.link; })),
              _buildToolItem(LucideIcons.megaphone, Colors.orange, () => setState(() { _selectedMedia.clear(); _currentType = PostType.announcement; })),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToolItem(IconData icon, Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 60,
        height: 50,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}

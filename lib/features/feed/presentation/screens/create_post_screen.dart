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
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/feed/domain/models/post_model.dart';
import 'package:hue/features/feed/presentation/providers/feed_provider.dart';
import 'package:hue/features/feed/data/repositories/post_repository.dart';

class CreatePostScreen extends ConsumerStatefulWidget {
  final PostType initialType;

  const CreatePostScreen({super.key, this.initialType = PostType.text});

  @override
  ConsumerState<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends ConsumerState<CreatePostScreen> {
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _linkController = TextEditingController();

  late PostType _currentType;
  bool _postAsCollege = false;
  bool _isLoading = false;

  final List<File> _selectedMedia = [];
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    _currentType = widget.initialType;
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
          SnackBar(content: Text('Error picking media: \${e.toString()}')),
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

      // We resolve collegeId if they elected to post as college
      String? collegeId;
      if (_postAsCollege) {
        // Query the colleges table for one where dean_id = userId
        final res = await repository.supabase
            .from('colleges')
            .select('id')
            .eq('dean_id', userId)
            .maybeSingle();
        if (res != null) {
          collegeId = res['id'] as String;
        }
      }

      final post = await repository.createPost(
        content: content,
        type: _currentType,
        mediaUrls: uploadedUrls,
        linkUrl: _currentType == PostType.link
            ? _linkController.text.trim()
            : null,
        collegeId: collegeId,
      );

      feedNotifier.addPost(post);

      if (mounted) {
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

    return Scaffold(
      appBar: AppBar(
        title: Text(
          isArabic ? 'إنشاء منشور' : 'Create Post',
          style: GoogleFonts.outfit(fontWeight: FontWeight.w600),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FilledButton(
              onPressed: _isLoading || _contentController.text.trim().isEmpty
                  ? null
                  : _submitPost,
              style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: _isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(isArabic ? 'نشر' : 'Post'),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Author Context Switcher
              if (canPostAsCollege)
                GlassContainer(
                  borderRadius: BorderRadius.circular(16),
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Row(
                    children: [
                      Icon(Icons.business_center, color: theme.primaryColor),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          isArabic ? 'النشر بصفتك الكلية' : 'Post as College',
                          style: GoogleFonts.inter(fontWeight: FontWeight.w600),
                        ),
                      ),
                      Switch(
                        value: _postAsCollege,
                        onChanged: (val) =>
                            setState(() => _postAsCollege = val),
                        activeThumbColor: theme.primaryColor,
                      ),
                    ],
                  ),
                ).animate().fadeIn(),

              // Text Input Area
              GlassContainer(
                borderRadius: BorderRadius.circular(20),
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _contentController,
                  maxLines: 8,
                  minLines: 4,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: isArabic ? 'بم تفكر؟' : 'What\'s on your mind?',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  style: GoogleFonts.inter(fontSize: 16),
                ),
              ),
              const SizedBox(height: 16),

              // Link Input
              if (_currentType == PostType.link)
                GlassContainer(
                  borderRadius: BorderRadius.circular(16),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 4,
                  ),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: TextField(
                    controller: _linkController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      icon: Icon(LucideIcons.link, color: theme.primaryColor),
                      hintText: isArabic
                          ? 'ألصق رابط (يوتيوب، مقال، إلخ)'
                          : 'Paste link (YouTube, Article, etc)',
                    ),
                  ),
                ).animate().slideY(begin: 0.1).fadeIn(),

              // Media Preview
              if (_selectedMedia.isNotEmpty)
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _selectedMedia.length,
                    separatorBuilder: (c, i) => const SizedBox(width: 8),
                    itemBuilder: (c, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: _currentType == PostType.video
                                ? Container(
                                    width: 120,
                                    height: 120,
                                    color: Colors.black12,
                                    child: const Icon(
                                      LucideIcons.video,
                                      size: 40,
                                      color: Colors.white,
                                    ),
                                  )
                                : Image.file(
                                    _selectedMedia[index],
                                    width: 120,
                                    height: 120,
                                    fit: BoxFit.cover,
                                  ),
                          ),
                          Positioned(
                            top: 4,
                            right: 4,
                            child: GestureDetector(
                              onTap: () => setState(
                                () => _selectedMedia.removeAt(index),
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(4),
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
                      );
                    },
                  ),
                ),
              const SizedBox(height: 24),

              // Attachment Tools
              Text(
                isArabic ? 'إضافة للمنشور' : 'Add to your post',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTool(
                    title: isArabic ? 'صورة' : 'Image',
                    icon: LucideIcons.image,
                    color: Colors.green,
                    onTap: () {
                      setState(() {
                        if (_currentType != PostType.image) {
                          _selectedMedia.clear();
                        }
                        _currentType = PostType.image;
                      });
                      _pickMedia(false);
                    },
                  ),
                  _buildTool(
                    title: isArabic ? 'فيديو' : 'Video',
                    icon: LucideIcons.video,
                    color: Colors.red,
                    onTap: () {
                      setState(() {
                        if (_currentType != PostType.video) {
                          _selectedMedia.clear();
                        }
                        _currentType = PostType.video;
                      });
                      _pickMedia(true);
                    },
                  ),
                  _buildTool(
                    title: isArabic ? 'رابط' : 'Link',
                    icon: LucideIcons.link,
                    color: Colors.blue,
                    onTap: () => setState(() {
                      _selectedMedia.clear();
                      _currentType = PostType.link;
                    }),
                  ),
                  _buildTool(
                    title: isArabic ? 'إعلان' : 'Alert',
                    icon: LucideIcons.megaphone,
                    color: Colors.orange,
                    onTap: () => setState(() {
                      _selectedMedia.clear();
                      _currentType = PostType.announcement;
                    }),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTool({
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 4),
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

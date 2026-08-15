import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:horus/features/feed/presentation/widgets/video_feed_item.dart';
import 'package:horus/core/utils/lucide_icon_mapping.dart';
import 'package:google_fonts/google_fonts.dart';

class MediaViewerScreen extends StatefulWidget {
  final List<String> mediaUrls;
  final int initialIndex;

  const MediaViewerScreen({
    super.key,
    required this.mediaUrls,
    this.initialIndex = 0,
  });

  @override
  State<MediaViewerScreen> createState() => _MediaViewerScreenState();
}

class _MediaViewerScreenState extends State<MediaViewerScreen> {
  late PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _isVideo(String url) {
    final lower = url.toLowerCase();
    return lower.endsWith('.mp4') ||
        lower.endsWith('.mov') ||
        lower.endsWith('.avi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Swipe down to dismiss using Dismissible (Instagram style)
          Dismissible(
            key: const Key('media_viewer_dismiss'),
            direction: DismissDirection.down,
            onDismissed: (_) => Navigator.of(context).pop(),
            child: PageView.builder(
              controller: _pageController,
              itemCount: widget.mediaUrls.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (context, index) {
                final url = widget.mediaUrls[index];
                if (_isVideo(url)) {
                  // Video player
                  return Center(child: VideoFeedItem(videoUrl: url));
                } else {
                  // Image with pinch-to-zoom
                  return InteractiveViewer(
                    minScale: 0.5,
                    maxScale: 4.0,
                    child: CachedNetworkImage(
                      imageUrl: url,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      ),
                      errorWidget: (context, url, error) => const Center(
                        child: Icon(Icons.error_outline, color: Colors.white),
                      ),
                    ),
                  );
                }
              },
            ),
          ),

          // Top Bar
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 10,
            right: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(LucideIcons.x, color: Colors.white, size: 28),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                if (widget.mediaUrls.length > 1)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black45,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${_currentIndex + 1}/${widget.mediaUrls.length}',
                      style: GoogleFonts.outfit(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

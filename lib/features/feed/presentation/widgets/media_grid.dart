import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:horus/features/feed/presentation/widgets/video_feed_item.dart';
import 'package:horus/features/feed/presentation/screens/media_viewer_screen.dart';
class MediaGrid extends StatelessWidget {
  final List<String> mediaUrls;
  final double borderRadius;

  const MediaGrid({
    super.key,
    required this.mediaUrls,
    this.borderRadius = 20.0,
  });

  bool _isVideo(String url) {
    final lower = url.toLowerCase();
    return lower.endsWith('.mp4') ||
        lower.endsWith('.mov') ||
        lower.endsWith('.avi');
  }

  @override
  Widget build(BuildContext context) {
    if (mediaUrls.isEmpty) return const SizedBox.shrink();

    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: AspectRatio(
        aspectRatio: _getAspectRatio(),
        child: _buildGrid(context),
      ),
    );
  }

  double _getAspectRatio() {
    final count = mediaUrls.length;
    if (count == 1) return 16 / 9;
    if (count == 2) return 1.5;
    return 1.2;
  }

  Widget _buildGrid(BuildContext context) {
    final count = mediaUrls.length;

    if (count == 1) {
      return _buildMediaItem(context, mediaUrls[0], 0, isLarge: true);
    } else if (count == 2) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildMediaItem(context, mediaUrls[0], 0)),
          const SizedBox(width: 2),
          Expanded(child: _buildMediaItem(context, mediaUrls[1], 1)),
        ],
      );
    } else if (count == 3) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 2, child: _buildMediaItem(context, mediaUrls[0], 0)),
          const SizedBox(width: 2),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: _buildMediaItem(context, mediaUrls[1], 1)),
                const SizedBox(height: 2),
                Expanded(child: _buildMediaItem(context, mediaUrls[2], 2)),
              ],
            ),
          ),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildMediaItem(context, mediaUrls[0], 0)),
                const SizedBox(width: 2),
                Expanded(child: _buildMediaItem(context, mediaUrls[1], 1)),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildMediaItem(context, mediaUrls[2], 2)),
                const SizedBox(width: 2),
                Expanded(child: _buildMoreItem(context, mediaUrls[3], 3, count - 4)),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _buildMediaItem(BuildContext context, String url, int index, {bool isLarge = false}) {
    Widget child;
    if (_isVideo(url)) {
      child = VideoFeedItem(videoUrl: url);
    } else {
      child = CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        width: double.infinity,
        height: isLarge ? null : double.infinity,
        placeholder: (context, url) => Container(
          color: Colors.grey.withValues(alpha: 0.1),
          child: const Center(child: CircularProgressIndicator(strokeWidth: 2)),
        ),
        errorWidget: (context, url, error) => Container(
          color: Colors.grey.withValues(alpha: 0.1),
          child: const Icon(Icons.error_outline),
        ),
      );
    }

    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => MediaViewerScreen(
              mediaUrls: mediaUrls,
              initialIndex: index,
            ),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: child,
    );
  }

  Widget _buildMoreItem(BuildContext context, String url, int index, int remaining) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            pageBuilder: (_, __, ___) => MediaViewerScreen(
              mediaUrls: mediaUrls,
              initialIndex: index,
            ),
            transitionsBuilder: (_, animation, __, child) {
              return FadeTransition(opacity: animation, child: child);
            },
          ),
        );
      },
      child: Stack(
        fit: StackFit.expand,
        children: [
          CachedNetworkImage(
            imageUrl: url,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
          if (remaining > 0)
            Container(
              color: Colors.black54,
              child: Center(
                child: Text(
                  '+$remaining',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

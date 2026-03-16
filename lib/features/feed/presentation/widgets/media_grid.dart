import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hue/features/feed/presentation/widgets/video_feed_item.dart';

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
    return lower.endsWith('.mp4') || lower.endsWith('.mov') || lower.endsWith('.avi');
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
      return _buildMediaItem(mediaUrls[0], isLarge: true);
    } else if (count == 2) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: _buildMediaItem(mediaUrls[0])),
          const SizedBox(width: 2),
          Expanded(child: _buildMediaItem(mediaUrls[1])),
        ],
      );
    } else if (count == 3) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 2, child: _buildMediaItem(mediaUrls[0])),
          const SizedBox(width: 2),
          Expanded(
            flex: 1,
            child: Column(
              children: [
                Expanded(child: _buildMediaItem(mediaUrls[1])),
                const SizedBox(height: 2),
                Expanded(child: _buildMediaItem(mediaUrls[2])),
              ],
            ),
          ),
        ],
      );
    } else {
      // 4 or more
      return Column(
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildMediaItem(mediaUrls[0])),
                const SizedBox(width: 2),
                Expanded(child: _buildMediaItem(mediaUrls[1])),
              ],
            ),
          ),
          const SizedBox(height: 2),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(child: _buildMediaItem(mediaUrls[2])),
                const SizedBox(width: 2),
                Expanded(child: _buildMoreItem(mediaUrls[3], count - 4)),
              ],
            ),
          ),
        ],
      );
    }
  }

  Widget _buildMediaItem(String url, {bool isLarge = false}) {
    if (_isVideo(url)) {
      return VideoFeedItem(videoUrl: url);
    }

    return CachedNetworkImage(
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

  Widget _buildMoreItem(String url, int remaining) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildMediaItem(url),
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
    );
  }
}

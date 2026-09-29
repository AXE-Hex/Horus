import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:horus/features/feed/presentation/widgets/video_feed_item.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FullScreenGallery extends StatefulWidget {
  final List<String> mediaUrls;
  final int initialIndex;

  const FullScreenGallery({
    super.key,
    required this.mediaUrls,
    this.initialIndex = 0,
  });

  @override
  State<FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery> {
  late int currentIndex;
  late PageController pageController;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    pageController = PageController(initialPage: widget.initialIndex);
  }

  bool _isVideo(String url) {
    final lower = url.toLowerCase();
    return lower.endsWith('.mp4') ||
        lower.endsWith('.mov') ||
        lower.endsWith('.avi');
  }

  void onPageChanged(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          '${currentIndex + 1} / ${widget.mediaUrls.length}',
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
      extendBodyBehindAppBar: true,
      body: PhotoViewGallery.builder(
        scrollPhysics: const BouncingScrollPhysics(),
        builder: (BuildContext context, int index) {
          final url = widget.mediaUrls[index];
          if (_isVideo(url)) {
            return PhotoViewGalleryPageOptions.customChild(
              child: Center(
                child: VideoFeedItem(videoUrl: url, autoPlay: true),
              ),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.contained,
              heroAttributes: PhotoViewHeroAttributes(tag: url),
            );
          } else {
            return PhotoViewGalleryPageOptions(
              imageProvider: CachedNetworkImageProvider(url),
              initialScale: PhotoViewComputedScale.contained,
              minScale: PhotoViewComputedScale.contained,
              maxScale: PhotoViewComputedScale.covered * 2,
              heroAttributes: PhotoViewHeroAttributes(tag: url),
            );
          }
        },
        itemCount: widget.mediaUrls.length,
        loadingBuilder: (context, event) =>
            const Center(child: CircularProgressIndicator(color: Colors.white)),
        backgroundDecoration: const BoxDecoration(color: Colors.black),
        pageController: pageController,
        onPageChanged: onPageChanged,
      ),
    );
  }
}

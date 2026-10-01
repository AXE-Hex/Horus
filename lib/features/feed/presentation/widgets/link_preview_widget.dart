import 'package:flutter/material.dart';
import 'package:any_link_preview/any_link_preview.dart';
import 'package:url_launcher/url_launcher.dart';

class LinkPreviewWidget extends StatelessWidget {
  final String url;

  const LinkPreviewWidget({super.key, required this.url});

  Future<void> _launchUrl() async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnyLinkPreview(
      link: url,
      displayDirection: UIDirection.uiDirectionHorizontal,
      cache: const Duration(days: 7),
      backgroundColor: Theme.of(context).cardColor,
      errorWidget: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
        ),
        child: Row(
          children: [
            const Icon(Icons.link, color: Colors.blue),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                url,
                style: const TextStyle(color: Colors.blue),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
      errorImage: 'https://via.placeholder.com/150',
      boxShadow: const [BoxShadow(blurRadius: 3, color: Colors.black12)],
      borderRadius: 12,
      removeElevation: true,
      onTap: _launchUrl,
      bodyTextOverflow: TextOverflow.ellipsis,
      titleStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      bodyStyle: const TextStyle(fontSize: 12, color: Colors.grey),
    );
  }
}

// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ForumsScreen extends ConsumerWidget {
  const ForumsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final body = CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 120,
          floating: true,
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () => context.pop(),
          ),
          title: Text(
            isArabic ? 'المنتديات' : 'Forums',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),

        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          sliver: SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              final forums = isArabic
                  ? [
                      {
                        'name': 'نقاش عام',
                        'threads': '124',
                        'members': '1,200',
                        'icon': LucideIcons.messageSquare,
                      },
                      {
                        'name': 'كلية الذكاء الاصطناعي',
                        'threads': '89',
                        'members': '450',
                        'icon': LucideIcons.cpu,
                      },
                      {
                        'name': 'تقييمات المقررات',
                        'threads': '210',
                        'members': '800',
                        'icon': LucideIcons.messageCircle,
                      },
                    ]
                  : [
                      {
                        'name': 'General Discussion',
                        'threads': '124',
                        'members': '1,200',
                        'icon': LucideIcons.messageSquare,
                      },
                      {
                        'name': 'Faculty of AI',
                        'threads': '89',
                        'members': '450',
                        'icon': LucideIcons.cpu,
                      },
                      {
                        'name': 'Course Feedbacks',
                        'threads': '210',
                        'members': '800',
                        'icon': LucideIcons.messageCircle,
                      },
                    ];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildForumTile(
                  context,
                  forums[index],
                  isGlass,
                  isArabic,
                ),
              );
            }, childCount: 3),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildForumTile(
    BuildContext context,
    Map<String, dynamic> forum,
    bool isGlass,
    bool isArabic,
  ) {
    final content = ListTile(
      onTap: () {},
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(
          forum['icon'] as IconData,
          color: Theme.of(context).primaryColor,
          size: 18,
        ),
      ),
      title: Text(
        forum['name'] as String,
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          color: isGlass
              ? Colors.white
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
      subtitle: Text(
        '${forum['threads']} ${isArabic ? "مواضيع" : "threads"} • ${forum['members']} ${isArabic ? "أعضاء" : "members"}',
        style: GoogleFonts.inter(
          fontSize: 12,
          color: Theme.of(context).hintColor,
        ),
      ),
      trailing: Icon(
        LucideIcons.chevronRight,
        size: 18,
        color: Theme.of(context).hintColor,
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(20),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black12),
            ),
            child: content,
          );
  }
}

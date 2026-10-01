import 'package:horus/core/router/back_navigation.dart';
import 'package:horus/features/shared/data/shared_data_providers.dart';
import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:horus/core/theme/style_provider.dart';
import 'package:horus/features/shared/presentation/widgets/glass_container.dart';
import 'package:horus/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ForumsScreen extends ConsumerWidget {
  const ForumsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final valuesAsync = ref.watch(forumsProvider);
    if (valuesAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (valuesAsync.hasError) {
      return Scaffold(body: Center(child: Text(t.shared.error)));
    }
    final forums = [
      for (final item in valuesAsync.value ?? [])
        {
          'name': isArabic ? (item.nameAr ?? item.name) : item.name,
          'threads': '—',
          'members': '—',
          'icon': LucideIcons.messageSquare,
        },
    ];
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
            onPressed: () => context.backToHorus(),
          ),
          title: Text(
            t.shared.forums,
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
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildForumTile(
                  context,
                  forums[index],
                  isGlass,
                  isArabic,
                ),
              );
            }, childCount: forums.length),
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
        '${forum['threads']} ${t.shared.threads} • ${forum['members']} ${t.shared.members}',
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

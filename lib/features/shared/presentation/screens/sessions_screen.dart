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

class SessionsScreen extends ConsumerWidget {
  const SessionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final valuesAsync = ref.watch(userSessionsProvider);
    if (valuesAsync.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (valuesAsync.hasError) {
      return Scaffold(body: Center(child: Text(t.shared.error)));
    }
    final sessions = [
      for (final item in valuesAsync.value ?? [])
        {
          'device': item.deviceName ?? t.shared.device,
          'location': item.location ?? '—',
          'time': MaterialLocalizations.of(
            context,
          ).formatMediumDate(item.lastActive),
          'isCurrent': item.isActive,
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
            t.shared.active_sessions,
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
                child: _buildSessionTile(
                  context,
                  sessions[index],
                  isGlass,
                  isArabic,
                ),
              );
            }, childCount: sessions.length),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildSessionTile(
    BuildContext context,
    Map<String, dynamic> session,
    bool isGlass,
    bool isArabic,
  ) {
    final isCurrent = session['isCurrent'] as bool;

    final content = Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(
            isCurrent ? LucideIcons.smartphone : LucideIcons.monitor,
            color: isCurrent
                ? Theme.of(context).primaryColor
                : Theme.of(context).hintColor,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  session['device'] as String,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: isGlass
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                Text(
                  '${session['location']} • ${session['time']}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: isGlass
                        ? Colors.white60
                        : Theme.of(context).hintColor,
                  ),
                ),
              ],
            ),
          ),
          if (!isCurrent)
            TextButton(
              onPressed: null,
              child: Text(
                t.shared.logout,
                style: GoogleFonts.inter(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
        ],
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

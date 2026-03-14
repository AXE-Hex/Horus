import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class TutorialsScreen extends ConsumerWidget {
  const TutorialsScreen({super.key});

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
            t.shared.tutorials,
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
              final tutorials = isArabic
                  ? [
                      {
                        'title': 'تصفح النظام',
                        'desc':
                            'تعلم كيفية العثور على كل شيء في البوابة الجديدة.',
                        'icon': LucideIcons.compass,
                      },
                      {
                        'title': 'تخطيط الدرجة العلمية',
                        'desc': 'كيفية استخدام خطة العمل لتتبع درجاتك.',
                        'icon': LucideIcons.map,
                      },
                      {
                        'title': 'دليل الدفع الإلكتروني',
                        'desc':
                            'إرشادات خطوة بخطوة لدفع المصروفات عبر الإنترنت.',
                        'icon': LucideIcons.dollarSign,
                      },
                    ]
                  : [
                      {
                        'title': 'Navigating HUE',
                        'desc':
                            'Learn how to find everything in the new portal.',
                        'icon': LucideIcons.compass,
                      },
                      {
                        'title': 'Degree Planning',
                        'desc':
                            'How to use the action plan to track your degree.',
                        'icon': LucideIcons.map,
                      },
                      {
                        'title': 'E-Payment Guide',
                        'desc':
                            'Step-by-step instructions for paying tuition online.',
                        'icon': LucideIcons.dollarSign,
                      },
                    ];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: _buildTutorialCard(context, tutorials[index], isGlass),
              );
            }, childCount: 3),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildTutorialCard(
    BuildContext context,
    Map<String, dynamic> tutorial,
    bool isGlass,
  ) {
    final content = Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                tutorial['icon'] as IconData,
                color: Theme.of(context).primaryColor,
                size: 28,
              ),
              const Spacer(),
              const Icon(LucideIcons.playCircle, color: Colors.blue, size: 24),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            tutorial['title'] as String,
            style: GoogleFonts.outfit(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: isGlass
                  ? Colors.white
                  : Theme.of(context).colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            tutorial['desc'] as String,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: isGlass ? Colors.white70 : Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(24),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.black12),
            ),
            child: content,
          );
  }
}

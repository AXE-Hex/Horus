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

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

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
            isArabic ? 'الدعم والمساعدة' : 'Support',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),

        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 1.2,
            ),
            delegate: SliverChildListDelegate([
              _buildSupportCard(
                context,
                isArabic ? 'الدعم الفني' : 'IT Support',
                LucideIcons.monitor,
                isGlass,
              ),
              _buildSupportCard(
                context,
                isArabic ? 'شؤون الطلاب' : 'Student Affairs',
                LucideIcons.users,
                isGlass,
              ),
              _buildSupportCard(
                context,
                isArabic ? 'المساعدات المالية' : 'Financial Aid',
                LucideIcons.helpCircle,
                isGlass,
              ),
              _buildSupportCard(
                context,
                isArabic ? 'المكتبة' : 'Library',
                LucideIcons.book,
                isGlass,
              ),
            ]),
          ),
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Text(
                  isArabic ? 'تواصل معنا' : 'Contact Us',
                  style: GoogleFonts.outfit(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isGlass
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                _buildContactTile(
                  context,
                  isArabic ? 'دعم البريد الإلكتروني' : 'Email Support',
                  'support@hue.edu.eg',
                  LucideIcons.mail,
                  isGlass,
                ),
                const SizedBox(height: 12),
                _buildContactTile(
                  context,
                  isArabic ? 'الخط الساخن' : 'Call Hotline',
                  '19XXX',
                  LucideIcons.phone,
                  isGlass,
                ),
              ],
            ),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildSupportCard(
    BuildContext context,
    String title,
    IconData icon,
    bool isGlass,
  ) {
    final content = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: Theme.of(context).primaryColor, size: 32),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.outfit(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: isGlass ? Colors.white : null,
          ),
        ),
      ],
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

  Widget _buildContactTile(
    BuildContext context,
    String title,
    String value,
    IconData icon,
    bool isGlass,
  ) {
    final content = Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor, size: 20),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: Theme.of(context).hintColor,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(16),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.black12),
            ),
            child: content,
          );
  }
}

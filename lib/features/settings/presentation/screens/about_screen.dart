import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/i18n/strings.g.dart';
import 'package:lucide_icons/lucide_icons.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

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
          pinned: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(LucideIcons.arrowLeft),
            onPressed: () => context.pop(),
          ),
          title: Text(
            isArabic ? 'حول التطبيق' : 'About App',
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              // App Logo
              Center(
                child: Image.asset(
                  Theme.of(context).brightness == Brightness.dark
                      ? 'assets/images/Logo_dark.png'
                      : 'assets/images/Logo_light.png',
                  width: 120,
                  height: 120,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Text(
                  'HUE Portal',
                  style: GoogleFonts.outfit(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Center(
                child: Text(
                  'v1.0.0',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              const SizedBox(height: 32),

              // About info
              GlassContainer(
                borderRadius: BorderRadius.circular(20),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInfoRow(
                      context,
                      LucideIcons.building2,
                      isArabic ? 'الجامعة' : 'University',
                      isArabic ? 'جامعة حورس' : 'Horus University',
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                      context,
                      LucideIcons.code2,
                      isArabic ? 'المطور' : 'Developer',
                      isArabic ? 'فريق تطوير HUE' : 'HUE Development Team',
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                      context,
                      LucideIcons.smartphone,
                      isArabic ? 'المنصة' : 'Platform',
                      'Flutter / Dart',
                    ),
                    const Divider(height: 24),
                    _buildInfoRow(
                      context,
                      LucideIcons.database,
                      isArabic ? 'قاعدة البيانات' : 'Backend',
                      'Supabase',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Description
              GlassContainer(
                borderRadius: BorderRadius.circular(20),
                padding: const EdgeInsets.all(20),
                child: Text(
                  isArabic
                      ? 'بوابة HUE هي تطبيق جامعي شامل يتيح للطلاب وأعضاء هيئة التدريس والإداريين إدارة جميع الخدمات الأكاديمية والمالية والإدارية من مكان واحد. يتميز التطبيق بتصميم عصري وتجربة مستخدم سلسة مع دعم اللغة العربية والإنجليزية.'
                      : 'HUE Portal is a comprehensive university application that enables students, faculty, and administrators to manage all academic, financial, and administrative services from one place. The app features a modern design and smooth user experience with Arabic and English language support.',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    height: 1.6,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.8),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Copyright
              Center(
                child: Text(
                  '© 2026 Horus University. All rights reserved.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(context).hintColor,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 40),
            ]),
          ),
        ),
      ],
    );

    return isGlass ? GlassScaffold(body: body) : Scaffold(body: body);
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Theme.of(context).primaryColor),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 12,
                color: Theme.of(context).hintColor,
              ),
            ),
            Text(
              value,
              style: GoogleFonts.outfit(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

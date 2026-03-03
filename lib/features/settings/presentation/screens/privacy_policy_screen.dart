
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:hue/core/i18n/strings.g.dart';
import 'package:lucide_icons/lucide_icons.dart';

class PrivacyPolicyScreen extends ConsumerWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isArabic = t.$meta.locale.languageCode == 'ar';
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;

    final sections = isArabic ? _arabicSections : _englishSections;

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
            t.settings.privacy_policy,
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

              Center(
                child: Text(
                  t.settings.last_updated_february_2026,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(context).hintColor,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              ...sections.map(
                (section) => Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: GlassContainer(
                    borderRadius: BorderRadius.circular(20),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          section['title']!,
                          style: GoogleFonts.outfit(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          section['content']!,
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            height: 1.7,
                            color: Theme.of(context).textTheme.bodyMedium?.color
                                ?.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              Center(
                child: Text(
                  '© 2026 Horus University',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: Theme.of(context).hintColor,
                  ),
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
}

const _englishSections = [
  {
    'title': 'Information We Collect',
    'content':
        'We collect personal information including your name, email address, student/staff ID, phone number, and academic records. This data is necessary to provide university services through the HUE Portal application.',
  },
  {
    'title': 'How We Use Your Data',
    'content':
        'Your information is used to: manage your academic records, facilitate course registration and enrollment, process financial transactions, send notifications about academic events, and provide access to university resources.',
  },
  {
    'title': 'Data Security',
    'content':
        'We implement industry-standard security measures including encryption, secure authentication via Supabase, and row-level security on all database tables. Your data is stored securely and access is restricted based on your role.',
  },
  {
    'title': 'Data Sharing',
    'content':
        'We do not sell or share your personal information with third parties. Your data may be shared with authorized university personnel (faculty, administration) only as necessary to provide academic services.',
  },
  {
    'title': 'Your Rights',
    'content':
        'You have the right to: view your personal data, request corrections, export your data, and request deletion of your account. Contact the university administration for any data-related requests.',
  },
  {
    'title': 'Contact Us',
    'content':
        'For privacy-related inquiries, contact us at: privacy@hue.edu.eg\nHorus University\nEl-Horreya, Cairo, Egypt',
  },
];

const _arabicSections = [
  {
    'title': 'المعلومات التي نجمعها',
    'content':
        'نجمع معلومات شخصية تشمل الاسم والبريد الإلكتروني ورقم الطالب/الموظف ورقم الهاتف والسجلات الأكاديمية. هذه البيانات ضرورية لتقديم خدمات الجامعة من خلال تطبيق بوابة HUE.',
  },
  {
    'title': 'كيف نستخدم بياناتك',
    'content':
        'تُستخدم معلوماتك لـ: إدارة سجلاتك الأكاديمية، تسهيل تسجيل المقررات والقبول، معالجة المعاملات المالية، إرسال إشعارات حول الأحداث الأكاديمية، وتوفير الوصول إلى موارد الجامعة.',
  },
  {
    'title': 'أمان البيانات',
    'content':
        'نطبق معايير أمان عالية تشمل التشفير والمصادقة الآمنة عبر Supabase وأمان مستوى الصفوف على جميع جداول قاعدة البيانات. يتم تخزين بياناتك بشكل آمن ويُقيّد الوصول بناءً على دورك.',
  },
  {
    'title': 'مشاركة البيانات',
    'content':
        'لا نبيع أو نشارك معلوماتك الشخصية مع أطراف خارجية. قد تتم مشاركة بياناتك مع موظفي الجامعة المخولين (الأساتذة، الإدارة) فقط حسب الضرورة لتقديم الخدمات الأكاديمية.',
  },
  {
    'title': 'حقوقك',
    'content':
        'لديك الحق في: عرض بياناتك الشخصية، طلب التصحيحات، تصدير بياناتك، وطلب حذف حسابك. تواصل مع إدارة الجامعة لأي طلبات متعلقة بالبيانات.',
  },
  {
    'title': 'تواصل معنا',
    'content':
        'للاستفسارات المتعلقة بالخصوصية، تواصل معنا على: privacy@hue.edu.eg\nجامعة حورس\nالحرية، القاهرة، مصر',
  },
];

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

class PaymentScreen extends ConsumerWidget {
  const PaymentScreen({super.key});

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
            isArabic ? "الدفع الإلكتروني" : "E-Payment",
            style: GoogleFonts.outfit(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          centerTitle: true,
        ),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: _buildBalanceCard(context, isGlass, isArabic),
          ),
        ),

        const SliverToBoxAdapter(child: SizedBox(height: 32)),

        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isArabic ? "طرق الدفع بضمان الجامعة" : "Payment Methods",
                  style: GoogleFonts.outfit(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: isGlass
                        ? Colors.white
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                _buildPaymentMethod(
                  context,
                  isArabic ? 'بطاقة ائتمان / خصم مباشر' : 'Credit / Debit Card',
                  LucideIcons.creditCard,
                  isGlass,
                ),
                const SizedBox(height: 12),
                _buildPaymentMethod(
                  context,
                  isArabic ? 'فوري / دفع إلكتروني' : 'Fawry / E-Payment',
                  LucideIcons.zap,
                  isGlass,
                ),
                const SizedBox(height: 12),
                _buildPaymentMethod(
                  context,
                  isArabic ? 'تحويل بنكي' : 'Bank Transfer',
                  LucideIcons.landmark,
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

  Widget _buildBalanceCard(BuildContext context, bool isGlass, bool isArabic) {
    final content = Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Text(
            isArabic ? '12,450 ج.م' : '12,450 EGP',
            style: GoogleFonts.shareTechMono(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: isGlass ? Colors.white : Theme.of(context).primaryColor,
            ),
          ),
          Text(
            isArabic ? "الرصيد المستحق" : "Outstanding Balance",
            style: GoogleFonts.inter(
              fontSize: 14,
              color: isGlass ? Colors.white60 : Theme.of(context).hintColor,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 0,
            ),
            child: Text(
              isArabic ? "سداد الآن" : "Pay Now",
              style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );

    return isGlass
        ? GlassContainer(
            borderRadius: BorderRadius.circular(32),
            padding: EdgeInsets.zero,
            child: content,
          )
        : Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(32),
              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
            ),
            child: content,
          );
  }

  Widget _buildPaymentMethod(
    BuildContext context,
    String name,
    IconData icon,
    bool isGlass,
  ) {
    final content = Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              name,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w500,
                color: isGlass ? Colors.white : null,
              ),
            ),
          ),
          Icon(
            LucideIcons.chevronRight,
            size: 18,
            color: Theme.of(context).hintColor,
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

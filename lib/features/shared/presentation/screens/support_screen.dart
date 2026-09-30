import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const isGlass = false;

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
            t.shared.support,
            style: TextStyle(
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
                t.shared.email_support,
                LucideIcons.monitor,
                isGlass,
              ),
              _buildSupportCard(
                context,
                t.shared.student_affairs,
                LucideIcons.users,
                isGlass,
              ),
              _buildSupportCard(
                context,
                t.shared.financial_aid,
                LucideIcons.helpCircle,
                isGlass,
              ),
              _buildSupportCard(
                context,
                t.shared.library,
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
                  t.shared.contact_us,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 16),
                _buildContactTile(
                  context,
                  t.shared.email_support,
                  'support@hue.edu.eg',
                  LucideIcons.mail,
                  isGlass,
                ),
                const SizedBox(height: 12),
                _buildContactTile(
                  context,
                  t.shared.call_hotline,
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

    return Scaffold(body: body);
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
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: null,
          ),
        ),
      ],
    );

    return Container(
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
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).hintColor,
                ),
              ),
              Text(
                value,
                style: TextStyle(fontWeight: FontWeight.bold, color: null),
              ),
            ],
          ),
        ],
      ),
    );

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: content,
    );
  }
}

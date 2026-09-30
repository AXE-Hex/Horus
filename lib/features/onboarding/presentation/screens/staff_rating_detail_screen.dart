import 'package:horus/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:horus/core/i18n/strings.g.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class StaffRatingDetailScreen extends ConsumerWidget {
  final Map<String, dynamic> staffMember;

  const StaffRatingDetailScreen({super.key, required this.staffMember});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const isGlass = false;
    final color = Colors.blue;

    return Scaffold(body: _buildBody(context, isGlass, color));
  }

  Widget _buildBody(BuildContext context, bool isGlass, Color color) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: color,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(LucideIcons.chevronLeft, color: Colors.white),
            ),
            onPressed: () => context.pop(),
          ),
          flexibleSpace: FlexibleSpaceBar(
            background: Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [color, color.withValues(alpha: 0.5)],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'staff_${staffMember['name']}',
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.white24,
                          child: const Icon(
                            LucideIcons.user,
                            size: 40,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        staffMember['name']!,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        staffMember['role']!,
                        style: TextStyle(fontSize: 14, color: Colors.white70),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.all(20),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _buildRatingSection(context, isGlass, color),
              const SizedBox(height: 24),
              Text(
                t.academic.no_reviews_yet,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 100),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingSection(BuildContext context, bool isGlass, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: _buildMetricCard(
                context,
                'General Performance',
                staffMember['generalRating'] as double,
                LucideIcons.user,
                color,
                isGlass,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildMetricCard(
                context,
                'Curriculum Quality',
                staffMember['curriculumRating'] as double,
                LucideIcons.bookOpen,
                Colors.orange,
                isGlass,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildActionCard(context, isGlass, color),
      ],
    );
  }

  Widget _buildMetricCard(
    BuildContext context,
    String title,
    double rating,
    IconData icon,
    Color color,
    bool isGlass,
  ) {
    final content = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            rating.toString(),
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: null,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              5,
              (i) => Icon(
                LucideIcons.star,
                size: 14,
                color: i < rating.floor() ? Colors.amber : Colors.white10,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 10, color: Colors.grey),
          ),
        ],
      ),
    );

    return Card(child: content);
  }

  Widget _buildActionCard(BuildContext context, bool isGlass, Color color) {
    final content = ListTile(
      onTap: () {
        HapticFeedback.heavyImpact();
        context.push('/submit-rating', extra: staffMember);
      },
      leading: CircleAvatar(
        backgroundColor: color.withValues(alpha: 0.1),
        child: Icon(LucideIcons.pencil, color: color, size: 20),
      ),
      title: Text(
        'Rate this Professional',
        style: TextStyle(fontWeight: FontWeight.bold, color: null),
      ),
      subtitle: Text(
        'Help others by sharing your experience',
        style: TextStyle(fontSize: 12, color: Colors.grey),
      ),
      trailing: const Icon(
        LucideIcons.chevronRight,
        size: 20,
        color: Colors.white30,
      ),
    );

    return Card(child: content);
  }
}

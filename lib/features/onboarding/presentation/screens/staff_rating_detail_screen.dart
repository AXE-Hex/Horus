import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class StaffRatingDetailScreen extends ConsumerWidget {
  final Map<String, dynamic> staffMember;

  const StaffRatingDetailScreen({super.key, required this.staffMember});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final color = Colors.blue;

    return isGlass
        ? GlassScaffold(body: _buildBody(context, isGlass, color))
        : Scaffold(body: _buildBody(context, isGlass, color));
  }

  Widget _buildBody(BuildContext context, bool isGlass, Color color) {
    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        GlassSliverAppBar(
          expandedHeight: 200,
          pinned: true,
          backgroundColor: isGlass ? Colors.transparent : color,
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
                        style: GoogleFonts.outfit(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        staffMember['role']!,
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
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
              _buildReviewsHeader(context, isGlass),
              const SizedBox(height: 16),
              ..._buildMockReviews(context, isGlass),
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
            style: GoogleFonts.outfit(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: isGlass ? Colors.white : null,
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
            style: GoogleFonts.inter(
              fontSize: 10,
              color: isGlass ? Colors.white60 : Colors.grey,
            ),
          ),
        ],
      ),
    );

    return isGlass ? GlassContainer(child: content) : Card(child: content);
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
        style: GoogleFonts.outfit(
          fontWeight: FontWeight.bold,
          color: isGlass ? Colors.white : null,
        ),
      ),
      subtitle: Text(
        'Help others by sharing your experience',
        style: GoogleFonts.inter(
          fontSize: 12,
          color: isGlass ? Colors.white60 : Colors.grey,
        ),
      ),
      trailing: const Icon(
        LucideIcons.chevronRight,
        size: 20,
        color: Colors.white30,
      ),
    );

    return isGlass
        ? GlassContainer(padding: EdgeInsets.zero, child: content)
        : Card(child: content);
  }

  Widget _buildReviewsHeader(BuildContext context, bool isGlass) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Student Reviews',
          style: GoogleFonts.outfit(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: isGlass ? Colors.white : null,
          ),
        ),
        Text(
          '24 Reviews',
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isGlass ? Colors.white30 : Colors.grey,
          ),
        ),
      ],
    );
  }

  List<Widget> _buildMockReviews(BuildContext context, bool isGlass) {
    return [
      _buildReviewCard(
        context,
        'Ahmed Hassan',
        5,
        'Best doctor I have ever met. The material is very updated.',
        isGlass,
      ),
      _buildReviewCard(
        context,
        'Sarah Smith',
        4,
        'Very helpful, but the curriculum is a bit challenging.',
        isGlass,
      ),
      _buildReviewCard(
        context,
        'John Doe',
        3,
        'Good performance but could be better in communication.',
        isGlass,
      ),
    ].animate(interval: 100.ms).fadeIn().slideY(begin: 0.1, end: 0);
  }

  Widget _buildReviewCard(
    BuildContext context,
    String name,
    int rating,
    String text,
    bool isGlass,
  ) {
    final content = Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : null,
                ),
              ),
              Row(
                children: List.generate(
                  5,
                  (i) => Icon(
                    LucideIcons.star,
                    size: 12,
                    color: i < rating ? Colors.amber : Colors.white10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 13,
              color: isGlass ? Colors.white70 : Colors.black87,
            ),
          ),
        ],
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: isGlass
          ? GlassContainer(padding: EdgeInsets.zero, child: content)
          : Card(child: content),
    );
  }
}

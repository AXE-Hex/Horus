import 'package:hue/features/shared/presentation/widgets/glass_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/core/theme/style_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_scaffold.dart';
import 'package:lucide_icons/lucide_icons.dart';

class SubmitRatingScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> staffMember;

  const SubmitRatingScreen({super.key, required this.staffMember});

  @override
  ConsumerState<SubmitRatingScreen> createState() => _SubmitRatingScreenState();
}

class _SubmitRatingScreenState extends ConsumerState<SubmitRatingScreen> {
  double _generalRating = 0;
  double _curriculumRating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appStyle = ref.watch(styleControllerProvider);
    final isGlass = appStyle.value == AppStyle.glass;
    final color = Colors.blue;

    return isGlass
        ? GlassScaffold(body: _buildBody(context, isGlass, color))
        : Scaffold(body: _buildBody(context, isGlass, color));
  }

  Widget _buildBody(BuildContext context, bool isGlass, Color color) {
    return CustomScrollView(
      slivers: [
        GlassSliverAppBar(
          title: Text(
            'Submit Rating',
            style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
          ),
          pinned: true,
          backgroundColor: isGlass ? Colors.transparent : color,
        ),
        SliverPadding(
          padding: const EdgeInsets.all(24),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              Text(
                'How was your experience with ${widget.staffMember['name']}?',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : null,
                ),
              ),
              const SizedBox(height: 32),
              _buildRatingCategory(
                'General Performance',
                'Teaching style, communication, and availability.',
                LucideIcons.user,
                _generalRating,
                (val) => setState(() => _generalRating = val),
                isGlass,
                color,
              ),
              const SizedBox(height: 32),
              _buildRatingCategory(
                'Curriculum Excellence',
                'Material updates, relevance, and structure.',
                LucideIcons.bookOpen,
                _curriculumRating,
                (val) => setState(() => _curriculumRating = val),
                isGlass,
                Colors.orange,
              ),
              const SizedBox(height: 32),
              Text(
                'Optional Comments',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: isGlass ? Colors.white : null,
                ),
              ),
              const SizedBox(height: 12),
              _buildCommentField(isGlass),
              const SizedBox(height: 48),
              _buildSubmitButton(context, isGlass, color),
            ]),
          ),
        ),
      ],
    );
  }

  Widget _buildRatingCategory(
    String title,
    String subtitle,
    IconData icon,
    double currentRating,
    Function(double) onRatingUpdate,
    bool isGlass,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color, size: 20),
            const SizedBox(width: 8),
            Text(
              title,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                color: isGlass ? Colors.white : null,
              ),
            ),
          ],
        ),
        Text(
          subtitle,
          style: GoogleFonts.inter(
            fontSize: 12,
            color: isGlass ? Colors.white60 : Colors.grey,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            final ratingVal = index + 1.0;
            final isSelected = currentRating >= ratingVal;
            return IconButton(
              onPressed: () {
                HapticFeedback.lightImpact();
                onRatingUpdate(ratingVal);
              },
              icon: Icon(
                LucideIcons.star,
                size: 32,
                color: isSelected ? Colors.amber : Colors.white10,
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildCommentField(bool isGlass) {
    final decoration = InputDecoration(
      hintText: 'Share more details...',
      hintStyle: GoogleFonts.inter(color: Colors.white30),
      fillColor: isGlass
          ? Colors.white.withValues(alpha: 0.05)
          : Colors.grey.withValues(alpha: 0.1),
      filled: true,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    );

    return TextField(
      controller: _commentController,
      maxLines: 4,
      style: GoogleFonts.inter(color: isGlass ? Colors.white : null),
      decoration: decoration,
    );
  }

  Widget _buildSubmitButton(BuildContext context, bool isGlass, Color color) {
    return ElevatedButton(
      onPressed: (_generalRating > 0 && _curriculumRating > 0)
          ? () {
              HapticFeedback.heavyImpact();
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Rating submitted successfully!')),
              );
            }
          : null,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Text(
        'Submit Review',
        style: GoogleFonts.outfit(fontWeight: FontWeight.bold),
      ),
    );
  }
}

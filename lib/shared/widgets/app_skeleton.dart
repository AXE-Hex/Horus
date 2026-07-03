import 'package:flutter/material.dart';
import '../../core/theme/app_spacing.dart';

class Skeleton extends StatefulWidget {
  final double? width;
  final double? height;
  final double borderRadius;

  const Skeleton({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 8.0,
  });

  @override
  State<Skeleton> createState() => _SkeletonState();
}

class _SkeletonState extends State<Skeleton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _opacityAnimation = Tween<double>(begin: 0.4, end: 0.8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(widget.borderRadius),
            ),
          ),
        );
      },
    );
  }
}

class CardSkeleton extends StatelessWidget {
  final double height;

  const CardSkeleton({
    super.key,
    this.height = 120.0,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E293B) : Colors.white,
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: isDark ? const Color(0xFF334155) : const Color(0xFFE5E7EB),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Skeleton(width: 40, height: 40, borderRadius: 20),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Skeleton(width: MediaQuery.of(context).size.width * 0.4, height: 16),
                    const SizedBox(height: AppSpacing.sm),
                    Skeleton(width: MediaQuery.of(context).size.width * 0.2, height: 12),
                  ],
                ),
              ),
            ],
          ),
          const Spacer(),
          Skeleton(width: double.infinity, height: 14),
          const SizedBox(height: AppSpacing.sm),
          Skeleton(width: MediaQuery.of(context).size.width * 0.6, height: 12),
        ],
      ),
    );
  }
}

class ListSkeleton extends StatelessWidget {
  final int count;

  const ListSkeleton({
    super.key,
    this.count = 3,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: count,
      separatorBuilder: (context, index) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) => const CardSkeleton(height: 100),
    );
  }
}

// ---------------------------------------------------------------------------
// 🚀 Developed by the GT-AXE Team
// 👤 Signature: Axe
// ---------------------------------------------------------------------------

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hue/features/shared/data/notification_provider.dart';
import 'package:hue/features/shared/presentation/widgets/glass_container.dart';
import 'package:lucide_icons/lucide_icons.dart';

class LiquidToastOverlay extends ConsumerStatefulWidget {
  final Widget child;

  const LiquidToastOverlay({super.key, required this.child});

  @override
  ConsumerState<LiquidToastOverlay> createState() => _LiquidToastOverlayState();

  static void show(BuildContext context, AppNotification notification) {
    final state = context.findAncestorStateOfType<_LiquidToastOverlayState>();
    state?._show(notification);
  }
}

class _LiquidToastOverlayState extends ConsumerState<LiquidToastOverlay>
    with SingleTickerProviderStateMixin {
  AppNotification? _current;
  late AnimationController _controller;
  late Animation<double> _dropAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _dropAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _show(AppNotification notification) {
    setState(() {
      _current = notification;
    });
    HapticFeedback.lightImpact();
    _controller.forward(from: 0).then((_) {
      Future.delayed(const Duration(seconds: 4), () {
        if (mounted && _current == notification) {
          _controller.reverse().then((_) {
            setState(() {
              _current = null;
            });
          });
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (_current != null)
          Positioned(
            top: MediaQuery.of(context).padding.top + 10,
            left: 20,
            right: 20,
            child: AnimatedBuilder(
              animation: _dropAnimation,
              builder: (context, child) {
                final yOffset = -100 * (1 - _dropAnimation.value);
                final scale = 0.5 + (0.5 * _dropAnimation.value);
                final opacity = _dropAnimation.value.clamp(0.0, 1.0);

                return Transform.translate(
                  offset: Offset(0, yOffset),
                  child: Transform.scale(
                    scale: scale,
                    child: Opacity(
                      opacity: opacity,
                      child: GestureDetector(
                        onVerticalDragEnd: (details) {
                          if (details.primaryVelocity! < -100) {
                            _controller.reverse();
                          }
                        },
                        child: _buildLiquidCard(_current!),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildLiquidCard(AppNotification note) {
    Color color;
    IconData icon;
    switch (note.category) {
      case NotificationCategory.academic:
        color = Colors.blue;
        icon = LucideIcons.bookOpen;
        break;
      case NotificationCategory.finance:
        color = Colors.green;
        icon = LucideIcons.dollarSign;
        break;
      case NotificationCategory.security:
        color = Colors.red;
        icon = LucideIcons.shieldAlert;
        break;
      default:
        color = Colors.orange;
        icon = LucideIcons.bell;
    }

    return GlassContainer(
      borderRadius: BorderRadius.circular(24),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.2),
                  blurRadius: 10,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Icon(icon, color: color, size: 20),
          ).animate(onPlay: (c) => c.repeat()).shimmer(duration: 2.seconds),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  note.title,
                  style: GoogleFonts.outfit(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
                Text(
                  note.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

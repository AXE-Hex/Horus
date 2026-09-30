import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_animations.dart';

enum HapticFeedbackType { none, light, medium }

class PressFeedback extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;
  final double scale;
  final HapticFeedbackType hapticType;

  const PressFeedback({
    super.key,
    required this.child,
    this.onTap,
    this.scale = 0.97,
    this.hapticType = HapticFeedbackType.light,
  });

  @override
  State<PressFeedback> createState() => _PressFeedbackState();
}

class _PressFeedbackState extends State<PressFeedback> {
  bool _isPressed = false;

  void _triggerHaptic() {
    switch (widget.hapticType) {
      case HapticFeedbackType.light:
        HapticFeedback.lightImpact();
        break;
      case HapticFeedbackType.medium:
        HapticFeedback.mediumImpact();
        break;
      case HapticFeedbackType.none:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.onTap == null) return widget.child;
    return InkWell(
      onHighlightChanged: (value) => setState(() => _isPressed = value),
      onTap: () {
        _triggerHaptic();
        widget.onTap?.call();
      },
      child: AnimatedScale(
        scale: _isPressed ? widget.scale : 1.0,
        duration: AppMotion.duration(context, AppDurations.micro),
        curve: AppCurves.smooth,
        child: widget.child,
      ),
    );
  }
}

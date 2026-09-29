part of 'settings_screen.dart';

class _ParticlesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withValues(alpha: 0.04)
      ..style = PaintingStyle.fill;

    canvas.drawCircle(Offset(size.width * 0.1, size.height * 0.2), 60, paint);
    canvas.drawCircle(Offset(size.width * 0.8, size.height * 0.6), 100, paint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.9), 40, paint);
    canvas.drawCircle(Offset(size.width * 0.9, size.height * 0.1), 30, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

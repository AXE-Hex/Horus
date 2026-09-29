part of 'digital_id_screen.dart';

class _CircuitPainter extends CustomPainter {
  final Color color;
  final int seed;
  _CircuitPainter(this.color, {required this.seed});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final random = math.Random(seed);
    final path = Path();
    for (var i = 0; i < 8; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      path.moveTo(x, 0);
      path.lineTo(x, y);
      path.lineTo(x + (random.nextBool() ? 20 : -20), y + 20);
      path.lineTo(x + (random.nextBool() ? 20 : -20), size.height);

      if (random.nextBool()) {
        canvas.drawCircle(Offset(x, y), 2, paint..style = PaintingStyle.fill);
        paint.style = PaintingStyle.stroke;
      }
    }
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CircuitPainter oldDelegate) =>
      oldDelegate.seed != seed;
}

class _OrganicPattern extends StatelessWidget {
  final int seed;
  const _OrganicPattern({required this.seed});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(12, (index) {
        final r = math.Random(seed + index);
        return Positioned(
          left: r.nextDouble() * 300 - 50,
          top: r.nextDouble() * 300 - 50,
          child: Container(
            width: r.nextDouble() * 150 + 50,
            height: r.nextDouble() * 150 + 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.1),
                width: 0.5,
              ),
            ),
          ),
        );
      }),
    );
  }
}

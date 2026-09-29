part of 'digital_id_screen.dart';

class _Interactive3DCard extends StatefulWidget {
  final Map<String, dynamic> studentData;

  const _Interactive3DCard({required this.studentData});

  @override
  State<_Interactive3DCard> createState() => _Interactive3DCardState();
}

class _Interactive3DCardState extends State<_Interactive3DCard>
    with TickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;

  Offset _tilt = Offset.zero;
  bool _isFlipped = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _flipAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _flipController, curve: Curves.easeInOutBack),
    );
  }

  void _toggleFlip() {
    if (_isFlipped) {
      _flipController.reverse();
    } else {
      _flipController.forward();
    }
    setState(() => _isFlipped = !_isFlipped);
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleFlip,
      onPanUpdate: (details) {
        setState(() {
          _tilt += Offset(details.delta.dx / 1000, details.delta.dy / 1000);
          _tilt = Offset(_tilt.dx.clamp(-0.2, 0.2), _tilt.dy.clamp(-0.2, 0.2));
        });
      },
      onPanEnd: (_) => setState(() => _tilt = Offset.zero),
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final angle = _flipAnimation.value * math.pi;
          return Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateX(_tilt.dy)
              ..rotateY(_tilt.dx + angle),
            alignment: Alignment.center,
            child: angle < math.pi / 2
                ? _FrontCard(studentData: widget.studentData, tilt: _tilt)
                : Transform(
                    transform: Matrix4.identity()..rotateY(math.pi),
                    alignment: Alignment.center,
                    child: _BackCard(
                      studentData: widget.studentData,
                      tilt: _tilt,
                    ),
                  ),
          );
        },
      ).animate().scale(duration: 1.seconds, curve: Curves.elasticOut),
    );
  }
}

part of 'exam_schedule_screen.dart';

class _ExamCountdown extends HookWidget {
  final DateTime nextExam;
  final bool isArabic;

  const _ExamCountdown({required this.nextExam, required this.isArabic});

  @override
  Widget build(BuildContext context) {
    final timeLeft = useState(nextExam.difference(DateTime.now()));

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        timeLeft.value = nextExam.difference(DateTime.now());
      });
      return timer.cancel;
    }, [nextExam]);

    final days = timeLeft.value.inDays;
    final hours = timeLeft.value.inHours % 24;
    final minutes = timeLeft.value.inMinutes % 60;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFF6366F1).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: const Color(0xFF6366F1).withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6366F1).withValues(alpha: 0.05),
            blurRadius: 20,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            t.academic.next_exam_in,
            style: GoogleFonts.outfit(
              color: const Color(0xFF6366F1),
              fontWeight: FontWeight.w900,
              fontSize: 12,
              letterSpacing: 2,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTimeUnit(days.toString().padLeft(2, '0'), t.academic.days),
              _buildDivider(),
              _buildTimeUnit(
                hours.toString().padLeft(2, '0'),
                t.academic.hours,
              ),
              _buildDivider(),
              _buildTimeUnit(
                minutes.toString().padLeft(2, '0'),
                t.academic.mins,
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.9, 0.9));
  }

  Widget _buildTimeUnit(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.shareTechMono(
            fontSize: 36,
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.outfit(
            fontSize: 10,
            color: Colors.white38,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        ':',
        style: GoogleFonts.shareTechMono(
          fontSize: 36,
          color: const Color(0xFF6366F1).withValues(alpha: 0.3),
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

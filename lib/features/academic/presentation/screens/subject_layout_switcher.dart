part of 'subject_results_screen.dart';

class _LayoutSwitcher extends StatelessWidget {
  final int current;
  final Function(int) onChanged;

  const _LayoutSwitcher({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(3, (index) {
          final isSelected = current == index;
          IconData icon;
          switch (index) {
            case 1:
              icon = LucideIcons.barChart2;
              break;
            case 2:
              icon = LucideIcons.layoutGrid;
              break;
            default:
              icon = LucideIcons.circle;
              break;
          }
          return GestureDetector(
            onTap: () => onChanged(index),
            child: AnimatedContainer(
              duration: 200.ms,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.1)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: isSelected ? Colors.white : Colors.white38,
                size: 18,
              ),
            ),
          );
        }),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:tickme/common/utils/time.dart';

class TimerDisplay extends StatefulWidget {
  final DateTime startTime;
  final String categoryName;

  const TimerDisplay({
    super.key,
    required this.startTime,
    required this.categoryName,
  });

  @override
  State<TimerDisplay> createState() => _TimerDisplayState();
}

class _TimerDisplayState extends State<TimerDisplay>
    with TickerProviderStateMixin {
  late AnimationController _blinkController;
  late Animation<double> _blinkAnimation;

  @override
  void initState() {
    super.initState();
    _blinkController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _blinkAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _blinkController,
      curve: Curves.easeInOut,
    ));
    _blinkController.repeat(reverse: true);
  }

  @override
  void dispose() {
    _blinkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DateTime>(
      stream:
          Stream.periodic(const Duration(seconds: 1), (_) => DateTime.now()),
      builder: (context, snapshot) {
        final now = snapshot.data ?? DateTime.now();
        final duration = now.difference(widget.startTime);

        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Timer display
            AnimatedBuilder(
              animation: _blinkAnimation,
              builder: (context, child) {
                return Text(
                  formatDuration(duration).join(':'),
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontFamily: 'monospace',
                        fontWeight: FontWeight.bold,
                        color: _blinkAnimation.value > 0.5
                            ? Theme.of(context).textTheme.headlineMedium?.color
                            : Colors.transparent,
                      ),
                );
              },
            ),
            const SizedBox(height: 4),
            // Category name
            Text(
              widget.categoryName,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.color
                        ?.withValues(alpha: 0.7),
                  ),
            ),
          ],
        );
      },
    );
  }
}

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
      duration: const Duration(milliseconds: 1000),
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
        final timeParts = formatDuration(duration);

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Timer display with fixed width to prevent shifting
            Container(
              width: 140,
              height: 40,
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _blinkAnimation,
                builder: (context, child) {
                  return Text(
                    '${timeParts[0]}:${timeParts[1]}:${timeParts[2]}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontFamily: 'Courier New',
                          fontWeight: FontWeight.bold,
                          color: _blinkAnimation.value > 0.5
                              ? Theme.of(context).primaryColor
                              : Theme.of(context)
                                  .primaryColor
                                  .withValues(alpha: 0.3),
                          letterSpacing: 0,
                        ),
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            // Category name with fixed width to prevent shifting
            SizedBox(
              width: 80,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  widget.categoryName,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

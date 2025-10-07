import 'package:flutter/material.dart';
import 'package:tickme/common/tickme_light_theme.dart';
import 'package:tickme/common/utils/time.dart';

class _TimeBlockAtom extends StatelessWidget {
  final String value;
  final double width;
  final double? opacity;

  const _TimeBlockAtom({
    required this.value,
    required this.width,
    this.opacity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      margin: const EdgeInsets.only(right: 4.0),
      height: 40,
      alignment: Alignment.center,
      child: Text(
        value,
        style: EstimatedTimerTextTheme.style.copyWith(
          color: opacity != null
              ? EstimatedTimerTextTheme.style.color!.withValues(alpha: opacity)
              : EstimatedTimerTextTheme.style.color!,
        ),
      ),
    );
  }
}

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
  int _lastSecond = -1;

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
        final timeString = formatDuration(duration).join(':');

        // Synchronize blinking animation with timer updates
        final currentSecond = duration.inSeconds;
        if (currentSecond != _lastSecond) {
          _lastSecond = currentSecond;
          _blinkController.reset();
          _blinkController.forward();
        }

        return Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              alignment: Alignment.center,
              child: AnimatedBuilder(
                animation: _blinkAnimation,
                builder: (context, child) {
                  return Row(
                    children: timeString
                        .split('')
                        .asMap()
                        .entries
                        .map((e) => _TimeBlockAtom(
                              value: e.value,
                              width: (e.key + 1) % 3 == 0 ? 5 : 15,
                              opacity: (e.key + 1) % 3 != 0
                                  ? null
                                  : _blinkAnimation.value > 0.5
                                      ? 1.0
                                      : 0.3,
                            ))
                        .toList(),
                  );
                },
              ),
            ),
            const SizedBox(width: 12),
            Container(
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
          ],
        );
      },
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class TimerCountDown extends HookWidget {
  final DateTime? initialStart;
  final DateTime end;
  final TextStyle? style;
  final String? elapsedText;

  const TimerCountDown({
    super.key,
    this.initialStart,
    required this.end,
    this.elapsedText,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    final start = useState<DateTime>(initialStart ?? DateTime.now());

    ///
    /// generate a timeElapsed between the start and end date
    /// follow the format for 04:30:00
    ///

    final timeElapsed = end.difference(start.value);

    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        start.value = DateTime.now();
      });
      return () => timer.cancel();
    }, []);

    if (timeElapsed <= const Duration(seconds: 0)) {
      return elapsedText != null ? Text(elapsedText!) : const Text('00:00:00');
    }

    return Text(
      timeElapsed.toString().split('.').first,
      style: style ?? Theme.of(context).textTheme.titleLarge,
    );
  }
}

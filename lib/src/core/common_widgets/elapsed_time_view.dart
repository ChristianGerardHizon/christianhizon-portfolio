import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class ElapsedTimeView extends HookWidget {
  final DateTime startTime;
  final DateTime endTime;
  final DateTime currentTime;
  final TextStyle? style;

  const ElapsedTimeView({
    super.key,
    required this.startTime,
    required this.endTime,
    required this.currentTime,
    this.style,
  });

  ///
  ///
  ///

  String _getTimeRemainingMessage(DateTime now) {
    final isBefore = now.isBefore(startTime);
    final isOnGoing = now.isAfter(startTime) && now.isBefore(endTime);
    if (isBefore) {
      final duration = startTime.difference(now);
      return "Will start in ${_formatDuration(duration)}";
    } else if (isOnGoing) {
      final duration = endTime.difference(now);
      return "${_formatDuration(duration)} left";
    } else {
      return "Bidding has ended";
    }
  }

  ///
  /// Will build the string of the remaining time
  ///
  String _formatDuration(Duration duration) {
    final days = duration.inDays;
    final hours = duration.inHours % 24;
    final minutes = duration.inMinutes % 60;

    String value;
    if (days > 0) {
      value = '$days days';
    } else if (hours > 0) {
      value = '$hours hrs';
    } else if (minutes > 0) {
      value = '$minutes mins';
    } else {
      value = 'Less than a minute';
    }

    return value;
  }

  @override
  Widget build(BuildContext context) {
    final now = useState(DateTime.now());

    ///
    /// the Timer.peridoic will update the now value every second so that
    /// the UI can be updated.
    ///
    useEffect(() {
      final timer = Timer.periodic(const Duration(seconds: 1), (_) {
        now.value = DateTime.now();
      });
      return timer.cancel;
    }, []);

    return Text(
      _getTimeRemainingMessage(now.value),
      style: style,
      textAlign: TextAlign.start,
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

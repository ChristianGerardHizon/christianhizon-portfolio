import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/failures/failure.dart';
import 'package:sannjosevet/src/core/routing/router.dart';

class AppSnackBar extends StatelessWidget {
  const AppSnackBar({super.key, required this.message, this.style});

  final String message;
  final TextStyle? style;

  static show(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    if (!context.mounted) return;

    final snackItem = SnackBar(
      duration: duration ?? const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      content: AppSnackBar(message: message),
    );

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackItem);
  }

  static error(
    BuildContext context, {
    required String message,
    Duration? duration,
  }) {
    final color = Theme.of(context).colorScheme;
    String failureMsg = message;
    if (failureMsg.length > 100) {
      failureMsg = '${failureMsg.substring(0, 97)}...';
    }

    final snackItem = SnackBar(
      backgroundColor: color.errorContainer,
      duration: duration ?? const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      closeIconColor: color.error,
      content: AppSnackBar(
        message: failureMsg,
        style: TextStyle(color: color.error),
      ),
    );
    if (!context.mounted) return;

    ScaffoldMessenger.of(context)
      ..clearSnackBars()
      ..showSnackBar(snackItem);
  }

  static rootError({
    required String message,
    Duration? duration,
  }) {
    final rootContext = rootKey.currentContext;
    if (rootContext == null) return;
    if (!rootContext.mounted) return;

    error(rootContext, message: message, duration: duration);
  }

  static rootFailure(
    Failure failure, {
    Duration? duration,
  }) {
    final rootContext = rootKey.currentContext;
    if (rootContext == null) return;
    if (!rootContext.mounted) return;

    error(rootContext, message: failure.messageString, duration: duration);
  }

  static root({
    required String message,
    Duration? duration,
  }) {
    final snackItem = SnackBar(
      duration: duration ?? const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      showCloseIcon: true,
      content: AppSnackBar(message: message),
    );
    final rootContext = rootKey.currentContext;
    if (rootContext == null) return;
    if (!rootContext.mounted) return;

    ScaffoldMessenger.of(rootContext)
      ..clearSnackBars()
      ..showSnackBar(snackItem);
  }

  @override
  Widget build(BuildContext context) {
    return Text(message, style: style);
  }
}

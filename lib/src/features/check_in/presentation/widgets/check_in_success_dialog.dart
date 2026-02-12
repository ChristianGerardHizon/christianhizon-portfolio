import 'package:flutter/material.dart';

/// Shows a success dialog after a check-in.
Future<void> showCheckInSuccessDialog(
  BuildContext context, {
  required String memberName,
  required bool hasActiveMembership,
}) {
  return showDialog(
    context: context,
    builder: (context) => _CheckInSuccessDialog(
      memberName: memberName,
      hasActiveMembership: hasActiveMembership,
    ),
  );
}

class _CheckInSuccessDialog extends StatelessWidget {
  const _CheckInSuccessDialog({
    required this.memberName,
    required this.hasActiveMembership,
  });

  final String memberName;
  final bool hasActiveMembership;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AlertDialog(
      icon: Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 48,
      ),
      title: const Text('Check-In Successful'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            memberName,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          if (!hasActiveMembership)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.orange.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.warning_amber_rounded,
                    color: Colors.orange,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    'No active membership',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
      actions: [
        FilledButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

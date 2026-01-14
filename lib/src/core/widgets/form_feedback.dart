import 'package:flutter/material.dart';

/// Shows an error dialog with a list of validation errors.
///
/// Used for displaying form validation errors in a user-friendly popup.
///
/// Example:
/// ```dart
/// showFormErrorDialog(
///   context,
///   errors: ['Name is required', 'Email is invalid'],
///   title: 'Validation Errors', // optional
/// );
/// ```
void showFormErrorDialog(
  BuildContext context, {
  required List<String> errors,
  String title = 'Validation Errors',
}) {
  final theme = Theme.of(context);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Row(
        children: [
          Icon(Icons.error_outline, color: theme.colorScheme.error),
          const SizedBox(width: 8),
          Expanded(child: Text(title)),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: errors
            .map((error) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '\u2022 ',
                        style: TextStyle(color: theme.colorScheme.error),
                      ),
                      Expanded(child: Text(error)),
                    ],
                  ),
                ))
            .toList(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}

/// Shows a floating success snackbar with a check icon.
///
/// Used for displaying success messages after form submissions.
///
/// Example:
/// ```dart
/// showSuccessSnackBar(context, message: 'Patient created successfully');
/// ```
void showSuccessSnackBar(
  BuildContext context, {
  required String message,
  Duration duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.green,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(16),
      duration: duration,
    ),
  );
}

/// Shows a floating error snackbar with an error icon.
///
/// Used for displaying quick error messages (use [showFormErrorDialog] for
/// detailed validation errors).
///
/// Example:
/// ```dart
/// showErrorSnackBar(context, message: 'Failed to save');
/// ```
void showErrorSnackBar(
  BuildContext context, {
  required String message,
  Duration duration = const Duration(seconds: 4),
}) {
  final theme = Theme.of(context);

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.white),
          const SizedBox(width: 8),
          Expanded(child: Text(message)),
        ],
      ),
      behavior: SnackBarBehavior.floating,
      backgroundColor: theme.colorScheme.error,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: const EdgeInsets.all(16),
      duration: duration,
    ),
  );
}

/// Helper to convert form field errors to user-friendly messages.
///
/// Pass a map of field name to label mappings.
///
/// Example:
/// ```dart
/// final labels = {'name': 'Pet Name', 'email': 'Email Address'};
/// final messages = formatFormErrors(formKey.currentState?.errors ?? {}, labels);
/// if (messages.isNotEmpty) {
///   showFormErrorDialog(context, errors: messages);
/// }
/// ```
List<String> formatFormErrors(
  Map<String, String> errors,
  Map<String, String> fieldLabels,
) {
  return errors.entries
      .where((e) => e.value.isNotEmpty)
      .map((e) => '${fieldLabels[e.key] ?? e.key}: ${e.value}')
      .toList();
}

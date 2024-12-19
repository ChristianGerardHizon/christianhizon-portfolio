import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ConfirmModal extends HookConsumerWidget {
  const ConfirmModal({
    super.key,
    required this.title,
    required this.message,
    required this.confirm,
    required this.cancel,
    required this.showCancelFirst,
  });

  final String title;
  final String message;
  final String confirm;
  final String cancel;
  final bool showCancelFirst;

  static Future<bool?> show(
    BuildContext context, {
    String? title,
    String? message,
    String? confirm,
    String? cancel,
    bool showCancelFirst = false,
  }) async {
    return showDialog<bool>(
      useSafeArea: true,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return ConfirmModal(
          title: title ?? 'Are you sure?',
          message: message ?? 'Do you want to proceed with this action?',
          cancel: cancel ?? 'Cancel',
          confirm: confirm ?? 'Confirm',
          showCancelFirst: showCancelFirst,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ///
    return Center(
      child: Dialog(
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Text(title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w500)),
              const SizedBox(height: 10),
              Text(message),
              const SizedBox(height: 22),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: showCancelFirst
                    ? [
                        FilledButton(
                          onPressed: () {
                            context.pop(true);
                          },
                          child: Text(confirm),
                        ),
                        const SizedBox(width: 10),
                        TextButton(
                          onPressed: () {
                            context.pop(false);
                          },
                          child: Text(cancel),
                        ),
                      ]
                    : [
                        TextButton(
                          onPressed: () {
                            context.pop(false);
                          },
                          child: Text(cancel),
                        ),
                        const SizedBox(width: 10),
                        FilledButton(
                          onPressed: () {
                            context.pop(true);
                          },
                          child: Text(confirm),
                        ),
                      ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}

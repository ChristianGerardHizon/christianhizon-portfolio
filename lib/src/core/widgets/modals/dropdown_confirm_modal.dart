import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:sannjosevet/src/core/failures/failure.dart';
import 'package:sannjosevet/src/core/models/type_defs.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DropdownConfirmOption<T> {
  final String label;
  final T value;

  const DropdownConfirmOption({required this.label, required this.value});
}

class DropdownConfirmModal<T> extends HookConsumerWidget {
  const DropdownConfirmModal({
    super.key,
    required this.title,
    required this.confirm,
    required this.cancel,
    required this.options,
    required this.showCancelFirst,
    this.initialValue,
  });

  final String title;
  final String confirm;
  final String cancel;
  final bool showCancelFirst;
  final T? initialValue;
  final List<DropdownConfirmOption<T>> options;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<DropdownConfirmOption<T>> options,
    String confirm = 'Confirm',
    String cancel = 'Cancel',
    bool showCancelFirst = false,
    T? initialValue,
  }) async {
    return showDialog<T>(
      useSafeArea: true,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return DropdownConfirmModal<T>(
          title: title,
          confirm: confirm,
          cancel: cancel,
          initialValue: initialValue,
          options: options,
          showCancelFirst: showCancelFirst,
        );
      },
    );
  }

  static TaskResult<T> showTaskResult<T>(
    BuildContext context, {
    required String title,
    required List<DropdownConfirmOption<T>> options,
    String confirm = 'Confirm',
    String cancel = 'Cancel',
    bool showCancelFirst = false,
    T? initialValue,
  }) {
    return TaskResult.tryCatch(() async {
      final result = await show<T>(
        context,
        title: title,
        options: options,
        confirm: confirm,
        cancel: cancel,
        initialValue: initialValue,
        showCancelFirst: showCancelFirst,
      );
      if (result == null) throw CancelledFailure();
      return result;
    }, Failure.handle);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = useState<T?>(initialValue);

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 400),
        child: Dialog(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 16),
            child: StatefulBuilder(
              builder: (context, setState) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(title,
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500)),
                    const SizedBox(height: 15),
                    DropdownButtonFormField<T>(
                      value: selected.value,
                      isExpanded: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Please select an option',
                      ),
                      items: options
                          .map((opt) => DropdownMenuItem<T>(
                                value: opt.value,
                                child: Text(opt.label),
                              ))
                          .toList(),
                      onChanged: (value) =>
                          setState(() => selected.value = value),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: showCancelFirst
                          ? [
                              FilledButton(
                                onPressed: selected.value != null
                                    ? () => context.pop(selected.value)
                                    : null,
                                child: Text(confirm),
                              ),
                              const SizedBox(width: 10),
                              TextButton(
                                onPressed: () => context.pop(null),
                                child: Text(cancel),
                              ),
                            ]
                          : [
                              TextButton(
                                onPressed: () => context.pop(null),
                                child: Text(cancel),
                              ),
                              const SizedBox(width: 10),
                              FilledButton(
                                onPressed: selected.value != null
                                    ? () => context.pop(selected.value)
                                    : null,
                                child: Text(confirm),
                              ),
                            ],
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

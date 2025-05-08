import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  });

  final String title;
  final String confirm;
  final String cancel;
  final bool showCancelFirst;
  final List<DropdownConfirmOption<T>> options;

  static Future<T?> show<T>(
    BuildContext context, {
    required String title,
    required List<DropdownConfirmOption<T>> options,
    String confirm = 'Confirm',
    String cancel = 'Cancel',
    bool showCancelFirst = false,
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
          options: options,
          showCancelFirst: showCancelFirst,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    T? selected;

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
                      value: selected,
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
                      onChanged: (value) => setState(() => selected = value),
                    ),
                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: showCancelFirst
                          ? [
                              FilledButton(
                                onPressed: selected != null
                                    ? () => context.pop(selected)
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
                                onPressed: selected != null
                                    ? () => context.pop(selected)
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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:sannjosevet/src/core/widgets/app_snackbar.dart';

class PageSelector extends HookWidget {
  const PageSelector({
    super.key,
    required this.page,
    this.onPageChange,
    this.hasNext = false,
    this.enabled = true,
    required this.totalPages,
  });

  final int page;
  final int totalPages;
  final bool hasNext;
  final bool enabled;
  final Function(int)? onPageChange;

  @override
  Widget build(BuildContext context) {
    if (totalPages == 0) return SizedBox();

    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///
          /// previous
          ///
          TextButton.icon(
            onPressed:
                enabled && page > 1 ? () => onPageChange?.call(page - 1) : null,
            iconAlignment: IconAlignment.end,
            label: const Text('Prev'),
            icon: const Icon(Icons.chevron_left),
          ),

          ///
          /// text field
          ///
          const SizedBox(width: 16),
          SizedBox(
            width: 80,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    enabled: enabled,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: TextEditingController(text: page.toString()),
                    decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      border: InputBorder.none,
                      isDense: true,
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    onSubmitted: (value) {
                      final tryParse = int.tryParse(value);
                      if (tryParse == null) return;
                      if (tryParse > totalPages) {
                        AppSnackBar.root(message: 'Invalid page number');
                        return;
                      }
                      onPageChange?.call(tryParse);
                    },
                  ),
                ),
                Text(
                  '/',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(width: 20),
                Text(
                  totalPages.toString(),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),

          ///
          /// Next
          ///
          TextButton.icon(
            onPressed:
                enabled && hasNext ? () => onPageChange?.call(page + 1) : null,
            iconAlignment: IconAlignment.start,
            label: const Text('Next'),
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}

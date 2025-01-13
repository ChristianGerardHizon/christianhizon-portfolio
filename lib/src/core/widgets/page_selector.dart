import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PageSelector extends HookWidget {
  const PageSelector(
      {super.key, required this.page, this.onPageChange, this.hasNext = false});

  final int page;
  final bool hasNext;
  final Function(int)? onPageChange;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///
          /// previous
          ///
          TextButton.icon(
            onPressed: page > 1 ? () => onPageChange?.call(page - 1) : null,
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
            child: TextField(
              enabled: hasNext,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: TextEditingController(text: page.toString()),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                border: OutlineInputBorder(),
                isDense: true,
              ),
              textAlign: TextAlign.center,
              keyboardType: TextInputType.number,
              onSubmitted: (value) {
                final tryParse = int.tryParse(value);
                if (tryParse != null) onPageChange?.call(tryParse);
              },
            ),
          ),
          const SizedBox(width: 16),

          ///
          /// Next
          ///
          TextButton.icon(
            onPressed: hasNext ? () => onPageChange?.call(page + 1) : null,
            iconAlignment: IconAlignment.start,
            label: const Text('Next'),
            icon: const Icon(Icons.chevron_right),
          ),
        ],
      ),
    );
  }
}

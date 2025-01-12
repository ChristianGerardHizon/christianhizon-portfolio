import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PageSelector extends HookWidget {
  const PageSelector({super.key, required this.page, this.onPageChange});

  final int page;
  final Function(int)? onPageChange;

  @override
  Widget build(BuildContext context) {
    return Row(
        children: [
          ///
          /// previous
          ///
          Expanded(
            child: ElevatedButton.icon(
              onPressed: page > 1 ? () => onPageChange?.call(page - 1) : null,
              iconAlignment: IconAlignment.end,
              label: const Text('Previous'),
              icon: const Icon(Icons.chevron_left),
            ),
          ),
      
          ///
          /// text field
          ///
          const SizedBox(width: 16),
          SizedBox(
            width: 80,
            child: TextField(
              controller: TextEditingController(text: page.toString()),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
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
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () => onPageChange?.call(page + 1),
              iconAlignment: IconAlignment.start,
              label: const Text('Next'),
              icon: const Icon(Icons.chevron_right),
            ),
          ),
        ],
      );
  }
}

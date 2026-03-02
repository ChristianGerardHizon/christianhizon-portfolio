import 'package:flutter/material.dart';

/// A visual editor for managing a list of strings.
///
/// Displays items as [InputChip]s in a [Wrap] with a text field and
/// "Add" button to append new entries.
class StringListEditor extends StatefulWidget {
  const StringListEditor({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.hintText,
  });

  final String label;
  final List<String> items;
  final ValueChanged<List<String>> onChanged;
  final String? hintText;

  @override
  State<StringListEditor> createState() => _StringListEditorState();
}

class _StringListEditorState extends State<StringListEditor> {
  final _controller = TextEditingController();

  void _addItem() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onChanged([...widget.items, text]);
    _controller.clear();
  }

  void _removeItem(int index) {
    final updated = [...widget.items]..removeAt(index);
    widget.onChanged(updated);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  hintText: widget.hintText ?? 'Type to add...',
                  isDense: true,
                ),
                onSubmitted: (_) => _addItem(),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton.tonalIcon(
              onPressed: _addItem,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
            ),
          ],
        ),
        if (widget.items.isNotEmpty) ...[
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 4,
            children: [
              for (var i = 0; i < widget.items.length; i++)
                InputChip(
                  label: Text(widget.items[i]),
                  onDeleted: () => _removeItem(i),
                ),
            ],
          ),
        ],
      ],
    );
  }
}

import 'package:flutter/material.dart';

/// A visual editor for managing a list of key-value pairs.
///
/// Each row has two text fields side by side and a delete icon.
/// An "Add" button at the bottom appends new entries.
class KeyValueListEditor extends StatelessWidget {
  const KeyValueListEditor({
    super.key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.keyLabel = 'Key',
    this.valueLabel = 'Value',
    this.addButtonLabel = 'Add',
  });

  final String label;
  final List<Map<String, String>> items;
  final ValueChanged<List<Map<String, String>>> onChanged;
  final String keyLabel;
  final String valueLabel;
  final String addButtonLabel;

  void _addItem() {
    onChanged([...items, {keyLabel.toLowerCase(): '', valueLabel.toLowerCase(): ''}]);
  }

  void _removeItem(int index) {
    final updated = [...items]..removeAt(index);
    onChanged(updated);
  }

  void _updateItem(int index, String field, String value) {
    final updated = [
      for (var i = 0; i < items.length; i++)
        if (i == index) {...items[i], field: value} else items[i],
    ];
    onChanged(updated);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        for (var i = 0; i < items.length; i++) ...[
          _KeyValueRow(
            item: items[i],
            keyLabel: keyLabel,
            valueLabel: valueLabel,
            onKeyChanged: (v) => _updateItem(i, keyLabel.toLowerCase(), v),
            onValueChanged: (v) => _updateItem(i, valueLabel.toLowerCase(), v),
            onDelete: () => _removeItem(i),
          ),
          const SizedBox(height: 8),
        ],
        TextButton.icon(
          onPressed: _addItem,
          icon: const Icon(Icons.add, size: 18),
          label: Text('+ $addButtonLabel'),
        ),
      ],
    );
  }
}

class _KeyValueRow extends StatefulWidget {
  const _KeyValueRow({
    required this.item,
    required this.keyLabel,
    required this.valueLabel,
    required this.onKeyChanged,
    required this.onValueChanged,
    required this.onDelete,
  });

  final Map<String, String> item;
  final String keyLabel;
  final String valueLabel;
  final ValueChanged<String> onKeyChanged;
  final ValueChanged<String> onValueChanged;
  final VoidCallback onDelete;

  @override
  State<_KeyValueRow> createState() => _KeyValueRowState();
}

class _KeyValueRowState extends State<_KeyValueRow> {
  late final TextEditingController _keyController;
  late final TextEditingController _valueController;

  @override
  void initState() {
    super.initState();
    _keyController = TextEditingController(
      text: widget.item[widget.keyLabel.toLowerCase()] ?? '',
    );
    _valueController = TextEditingController(
      text: widget.item[widget.valueLabel.toLowerCase()] ?? '',
    );
  }

  @override
  void didUpdateWidget(covariant _KeyValueRow oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newKey = widget.item[widget.keyLabel.toLowerCase()] ?? '';
    final newValue = widget.item[widget.valueLabel.toLowerCase()] ?? '';
    if (_keyController.text != newKey) _keyController.text = newKey;
    if (_valueController.text != newValue) _valueController.text = newValue;
  }

  @override
  void dispose() {
    _keyController.dispose();
    _valueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _keyController,
            decoration: InputDecoration(
              labelText: widget.keyLabel,
              isDense: true,
            ),
            onChanged: widget.onKeyChanged,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: TextField(
            controller: _valueController,
            decoration: InputDecoration(
              labelText: widget.valueLabel,
              isDense: true,
            ),
            onChanged: widget.onValueChanged,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.delete_outline, size: 20),
          onPressed: widget.onDelete,
          tooltip: 'Remove',
        ),
      ],
    );
  }
}

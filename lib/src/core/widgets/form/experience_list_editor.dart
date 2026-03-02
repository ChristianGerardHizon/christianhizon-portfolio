import 'package:flutter/material.dart';

/// A visual editor for managing a list of experience entries.
///
/// Each entry is an expandable card with company, role, dates, and description.
/// Entries can be deleted individually and new ones added at the bottom.
class ExperienceListEditor extends StatelessWidget {
  const ExperienceListEditor({
    super.key,
    required this.items,
    required this.onChanged,
  });

  final List<Map<String, String>> items;
  final ValueChanged<List<Map<String, String>>> onChanged;

  void _addItem() {
    onChanged([
      ...items,
      {
        'company': '',
        'role': '',
        'startDate': '',
        'endDate': '',
        'description': '',
      },
    ]);
  }

  void _removeItem(int index) {
    final updated = [...items]..removeAt(index);
    onChanged(updated);
  }

  void _updateField(int index, String field, String value) {
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
        Text('Experience', style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        for (var i = 0; i < items.length; i++)
          _ExperienceCard(
            key: ValueKey('exp_$i'),
            item: items[i],
            index: i,
            onFieldChanged: (field, value) => _updateField(i, field, value),
            onDelete: () => _removeItem(i),
          ),
        TextButton.icon(
          onPressed: _addItem,
          icon: const Icon(Icons.add, size: 18),
          label: const Text('+ Add Experience'),
        ),
      ],
    );
  }
}

class _ExperienceCard extends StatefulWidget {
  const _ExperienceCard({
    super.key,
    required this.item,
    required this.index,
    required this.onFieldChanged,
    required this.onDelete,
  });

  final Map<String, String> item;
  final int index;
  final void Function(String field, String value) onFieldChanged;
  final VoidCallback onDelete;

  @override
  State<_ExperienceCard> createState() => _ExperienceCardState();
}

class _ExperienceCardState extends State<_ExperienceCard> {
  bool _expanded = true;

  late final TextEditingController _companyCtrl;
  late final TextEditingController _roleCtrl;
  late final TextEditingController _startCtrl;
  late final TextEditingController _endCtrl;
  late final TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    _companyCtrl = TextEditingController(text: widget.item['company'] ?? '');
    _roleCtrl = TextEditingController(text: widget.item['role'] ?? '');
    _startCtrl = TextEditingController(text: widget.item['startDate'] ?? '');
    _endCtrl = TextEditingController(text: widget.item['endDate'] ?? '');
    _descCtrl = TextEditingController(text: widget.item['description'] ?? '');
  }

  @override
  void didUpdateWidget(covariant _ExperienceCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    _syncController(_companyCtrl, widget.item['company'] ?? '');
    _syncController(_roleCtrl, widget.item['role'] ?? '');
    _syncController(_startCtrl, widget.item['startDate'] ?? '');
    _syncController(_endCtrl, widget.item['endDate'] ?? '');
    _syncController(_descCtrl, widget.item['description'] ?? '');
  }

  void _syncController(TextEditingController ctrl, String value) {
    if (ctrl.text != value) ctrl.text = value;
  }

  @override
  void dispose() {
    _companyCtrl.dispose();
    _roleCtrl.dispose();
    _startCtrl.dispose();
    _endCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  String get _title {
    final company = widget.item['company'] ?? '';
    final role = widget.item['role'] ?? '';
    if (company.isEmpty && role.isEmpty) return 'New Experience';
    if (company.isEmpty) return role;
    if (role.isEmpty) return company;
    return '$company — $role';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          InkWell(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(8)),
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  Icon(
                    _expanded ? Icons.expand_more : Icons.chevron_right,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _title,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete_outline, size: 20),
                    onPressed: widget.onDelete,
                    tooltip: 'Remove',
                  ),
                ],
              ),
            ),
          ),
          if (_expanded)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                children: [
                  TextField(
                    controller: _companyCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Company',
                      isDense: true,
                    ),
                    onChanged: (v) =>
                        widget.onFieldChanged('company', v),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _roleCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Role',
                      isDense: true,
                    ),
                    onChanged: (v) => widget.onFieldChanged('role', v),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _startCtrl,
                          decoration: const InputDecoration(
                            labelText: 'Start Date',
                            hintText: 'e.g. 2022',
                            isDense: true,
                          ),
                          onChanged: (v) =>
                              widget.onFieldChanged('startDate', v),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: _endCtrl,
                          decoration: const InputDecoration(
                            labelText: 'End Date',
                            hintText: 'e.g. Present',
                            isDense: true,
                          ),
                          onChanged: (v) =>
                              widget.onFieldChanged('endDate', v),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _descCtrl,
                    decoration: const InputDecoration(
                      labelText: 'Description',
                      isDense: true,
                    ),
                    maxLines: 3,
                    onChanged: (v) =>
                        widget.onFieldChanged('description', v),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

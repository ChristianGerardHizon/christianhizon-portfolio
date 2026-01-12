import 'package:flutter/material.dart';

import '../../../data/dummy_patients_data.dart';
import '../../../domain/prescription.dart';
import '../cards/prescription_card.dart';
import '../sheets/add_prescription_sheet.dart';

/// Section displaying prescriptions for a record.
class PrescriptionsSection extends StatefulWidget {
  const PrescriptionsSection({
    super.key,
    required this.recordId,
  });

  final String recordId;

  @override
  State<PrescriptionsSection> createState() => _PrescriptionsSectionState();
}

class _PrescriptionsSectionState extends State<PrescriptionsSection> {
  List<Prescription> get _prescriptions =>
      dummyPrescriptions.where((p) => p.recordId == widget.recordId).toList();

  void _handleAddPrescription() {
    showPrescriptionSheet(
      context,
      recordId: widget.recordId,
      onSave: (prescription) {
        setState(() {
          dummyPrescriptions.add(prescription);
        });
      },
    );
  }

  void _handleEditPrescription(Prescription prescription) {
    showPrescriptionSheet(
      context,
      recordId: widget.recordId,
      existingPrescription: prescription,
      onSave: (updated) {
        setState(() {
          final index = dummyPrescriptions.indexWhere((p) => p.id == updated.id);
          if (index != -1) {
            dummyPrescriptions[index] = updated;
          }
        });
      },
    );
  }

  Future<void> _handleDeletePrescription(Prescription prescription) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Prescription'),
        content: Text('Are you sure you want to delete ${prescription.medication}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() {
        dummyPrescriptions.removeWhere((p) => p.id == prescription.id);
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Prescription deleted')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final prescriptions = _prescriptions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Icon(Icons.medication, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text('Prescriptions', style: theme.textTheme.titleMedium),
            const Spacer(),
            FilledButton.icon(
              onPressed: _handleAddPrescription,
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Content
        if (prescriptions.isEmpty)
          _EmptyState(onAdd: _handleAddPrescription)
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: prescriptions.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final prescription = prescriptions[index];
              return PrescriptionCard(
                prescription: prescription,
                onEdit: () => _handleEditPrescription(prescription),
                onDelete: () => _handleDeletePrescription(prescription),
              );
            },
          ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.medication_outlined,
              size: 48,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No prescriptions',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add a prescription for this record',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('Add Prescription'),
            ),
          ],
        ),
      ),
    );
  }
}

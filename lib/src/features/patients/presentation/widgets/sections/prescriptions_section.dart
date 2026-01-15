import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../domain/prescription.dart';
import '../../controllers/prescription_controller.dart';
import '../cards/prescription_card.dart';
import '../sheets/add_prescription_group_sheet.dart';
import '../sheets/add_prescription_sheet.dart';

/// Section displaying prescriptions for a record, grouped by date.
class PrescriptionsSection extends ConsumerWidget {
  const PrescriptionsSection({
    super.key,
    required this.recordId,
  });

  final String recordId;

  /// Groups prescriptions by date and returns a sorted map (newest first).
  Map<DateTime, List<Prescription>> _groupByDate(List<Prescription> prescriptions) {
    final grouped = groupBy<Prescription, DateTime>(
      prescriptions,
      (p) {
        final date = p.date ?? p.created ?? DateTime.now();
        // Normalize to date only (no time component)
        return DateTime(date.year, date.month, date.day);
      },
    );

    // Sort by date descending (newest first)
    final sortedKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));
    return {for (final key in sortedKeys) key: grouped[key]!};
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return 'Today';
    } else if (date == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMMM d, yyyy').format(date);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionsAsync = ref.watch(prescriptionControllerProvider(recordId));
    final theme = Theme.of(context);

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
            OutlinedButton.icon(
              onPressed: () => _handleAddPrescriptionGroup(context, ref),
              icon: const Icon(Icons.playlist_add, size: 18),
              label: const Text('Add Group'),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: () => _handleAddPrescription(context, ref),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Content
        prescriptionsAsync.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stack) => Card(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load prescriptions',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => ref
                        .read(prescriptionControllerProvider(recordId).notifier)
                        .refresh(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          data: (prescriptions) {
            if (prescriptions.isEmpty) {
              return _EmptyState(
                onAdd: () => _handleAddPrescription(context, ref),
              );
            }

            final groupedPrescriptions = _groupByDate(prescriptions);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: groupedPrescriptions.entries.map((entry) {
                final date = entry.key;
                final datePrescriptions = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header
                    _DateHeader(date: _formatDateHeader(date)),
                    const SizedBox(height: 8),
                    // Prescriptions for this date
                    ...datePrescriptions.map(
                      (prescription) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: PrescriptionCard(
                          prescription: prescription,
                          onEdit: () => _handleEditPrescription(context, ref, prescription),
                          onDelete: () => _handleDeletePrescription(context, ref, prescription),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                );
              }).toList(),
            );
          },
        ),
      ],
    );
  }

  void _handleAddPrescription(BuildContext context, WidgetRef ref) {
    showPrescriptionSheet(
      context,
      recordId: recordId,
      onSave: (prescription) async {
        return await ref
            .read(prescriptionControllerProvider(recordId).notifier)
            .createPrescription(prescription);
      },
    );
  }

  void _handleAddPrescriptionGroup(BuildContext context, WidgetRef ref) {
    showPrescriptionGroupSheet(
      context,
      recordId: recordId,
      onSave: (prescription) async {
        return await ref
            .read(prescriptionControllerProvider(recordId).notifier)
            .createPrescription(prescription);
      },
    );
  }

  void _handleEditPrescription(
    BuildContext context,
    WidgetRef ref,
    Prescription prescription,
  ) {
    showPrescriptionSheet(
      context,
      recordId: recordId,
      existingPrescription: prescription,
      onSave: (updated) async {
        return await ref
            .read(prescriptionControllerProvider(recordId).notifier)
            .updatePrescription(updated);
      },
    );
  }

  Future<void> _handleDeletePrescription(
    BuildContext context,
    WidgetRef ref,
    Prescription prescription,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Prescription'),
        content: Text('Are you sure you want to delete ${prescription.medication}?'),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref
          .read(prescriptionControllerProvider(recordId).notifier)
          .deletePrescription(prescription.id);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Prescription deleted' : 'Failed to delete prescription',
            ),
          ),
        );
      }
    }
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

/// Date header for grouping prescriptions.
class _DateHeader extends StatelessWidget {
  const _DateHeader({required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(
          Icons.calendar_today,
          size: 16,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 8),
        Text(
          date,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Divider(
            color: theme.colorScheme.outlineVariant,
          ),
        ),
      ],
    );
  }
}

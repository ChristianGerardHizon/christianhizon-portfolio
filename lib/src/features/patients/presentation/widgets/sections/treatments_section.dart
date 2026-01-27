import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/routing/routes/appointments.routes.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/patient_treatment_record.dart';
import '../../controllers/patient_treatment_records_controller.dart';
import '../cards/treatment_record_card.dart';
import '../dialogs/add_treatment_record_dialog.dart';

/// Section displaying treatment records for a patient, grouped by date.
class TreatmentsSection extends ConsumerWidget {
  const TreatmentsSection({
    super.key,
    required this.patientId,
  });

  final String patientId;

  /// Groups treatment records by date and returns a sorted map (newest first).
  Map<DateTime, List<PatientTreatmentRecord>> _groupByDate(
    List<PatientTreatmentRecord> records,
  ) {
    final grouped = groupBy<PatientTreatmentRecord, DateTime>(
      records,
      (r) {
        final date = r.date ?? r.created ?? DateTime.now();
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
    final recordsAsync =
        ref.watch(patientTreatmentRecordsControllerProvider(patientId));
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Icon(Icons.healing, color: theme.colorScheme.tertiary),
            const SizedBox(width: 8),
            Text('Treatments', style: theme.textTheme.titleMedium),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => _handleAddTreatment(context, ref),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Content
        recordsAsync.when(
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
                    'Failed to load treatments',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => ref
                        .read(patientTreatmentRecordsControllerProvider(
                                patientId)
                            .notifier)
                        .refresh(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          data: (records) {
            if (records.isEmpty) {
              return _EmptyState(
                onAdd: () => _handleAddTreatment(context, ref),
              );
            }

            final groupedRecords = _groupByDate(records);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: groupedRecords.entries.map((entry) {
                final date = entry.key;
                final dateRecords = entry.value;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Date header
                    _DateHeader(date: _formatDateHeader(date)),
                    const SizedBox(height: 8),
                    // Records for this date
                    ...dateRecords.map(
                      (record) => Padding(
                        padding: const EdgeInsets.only(bottom: 8),
                        child: TreatmentRecordCard(
                          treatmentRecord: record,
                          onEdit: () =>
                              _handleEditTreatment(context, ref, record),
                          onDelete: () =>
                              _handleDeleteTreatment(context, ref, record),
                          onViewAppointment: record.appointment != null &&
                                  record.appointment!.isNotEmpty
                              ? () => AppointmentDetailRoute(
                                      id: record.appointment!)
                                  .go(context)
                              : null,
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

  void _handleAddTreatment(BuildContext context, WidgetRef ref) {
    showTreatmentRecordDialog(
      context,
      patientId: patientId,
      onSave: (record) async {
        return await ref
            .read(
                patientTreatmentRecordsControllerProvider(patientId).notifier)
            .createTreatmentRecordAndReturn(record);
      },
    );
  }

  void _handleEditTreatment(
    BuildContext context,
    WidgetRef ref,
    PatientTreatmentRecord record,
  ) {
    showTreatmentRecordDialog(
      context,
      patientId: patientId,
      existingRecord: record,
      onSave: (updated) async {
        return await ref
            .read(
                patientTreatmentRecordsControllerProvider(patientId).notifier)
            .updateTreatmentRecordAndReturn(updated);
      },
    );
  }

  Future<void> _handleDeleteTreatment(
    BuildContext context,
    WidgetRef ref,
    PatientTreatmentRecord record,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Treatment Record'),
        content: Text(
          'Are you sure you want to delete this ${record.treatmentName} record?',
        ),
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
          .read(patientTreatmentRecordsControllerProvider(patientId).notifier)
          .deleteTreatmentRecord(record.id);

      if (context.mounted) {
        if (success) {
          showSuccessSnackBar(context, message: 'Treatment record deleted');
        } else {
          showErrorSnackBar(context,
              message: 'Failed to delete treatment record');
        }
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
              Icons.healing_outlined,
              size: 48,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No treatments',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Add a treatment record for this patient',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('Add Treatment'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Date header for grouping treatment records.
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
          color: theme.colorScheme.tertiary,
        ),
        const SizedBox(width: 8),
        Text(
          date,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.tertiary,
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

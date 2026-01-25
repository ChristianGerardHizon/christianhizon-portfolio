import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../../core/routing/routes/patients.routes.dart';
import '../../../domain/patient.dart';
import '../../controllers/patient_records_controller.dart';
import '../cards/record_card.dart';

/// Records tab showing patient medical records/visits.
class PatientRecordsTab extends HookConsumerWidget {
  const PatientRecordsTab({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordsAsync =
        ref.watch(patientRecordsControllerProvider(patient.id));
    final theme = Theme.of(context);

    return recordsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 64, color: theme.colorScheme.error),
            const SizedBox(height: 16),
            Text(
              'Failed to load records',
              style: theme.textTheme.titleLarge?.copyWith(
                color: theme.colorScheme.error,
              ),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () => ref
                  .read(patientRecordsControllerProvider(patient.id).notifier)
                  .refresh(),
              icon: const Icon(Icons.refresh),
              label: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (patientRecords) {
        if (patientRecords.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.medical_services_outlined,
                  size: 64,
                  color: theme.colorScheme.outline,
                ),
                const SizedBox(height: 16),
                Text(
                  'No records yet',
                  style: theme.textTheme.titleLarge?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton.icon(
                  onPressed: () => _navigateToNewRecord(context),
                  icon: const Icon(Icons.add),
                  label: const Text('Add Record'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Add button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FilledButton.icon(
                    onPressed: () => _navigateToNewRecord(context),
                    icon: const Icon(Icons.add),
                    label: const Text('Add Record'),
                  ),
                ],
              ),
            ),
            // Records list
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => ref
                    .read(patientRecordsControllerProvider(patient.id).notifier)
                    .refresh(),
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: patientRecords.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    final record = patientRecords[index];
                    return RecordCard(
                      record: record,
                      patient: patient,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  /// Navigate to the new record creation page.
  void _navigateToNewRecord(BuildContext context) {
    RecordDetailRoute(id: patient.id, recordId: 'new').go(context);
  }
}

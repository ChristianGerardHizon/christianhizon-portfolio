import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/patient.dart';
import '../../controllers/patient_records_controller.dart';
import '../cards/new_record_card.dart';
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
    final showNewRecordCard = useState(false);
    // Track which record should be expanded (after creation)
    final expandedRecordId = useState<String?>(null);

    void handleRecordSaved(String recordId) {
      showNewRecordCard.value = false;
      expandedRecordId.value = recordId;
    }

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
        // Empty state with inline add option
        if (patientRecords.isEmpty && !showNewRecordCard.value) {
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
                  onPressed: () => showNewRecordCard.value = true,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Record'),
                ),
              ],
            ),
          );
        }

        // Empty state but showing new record card
        if (patientRecords.isEmpty && showNewRecordCard.value) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: NewRecordCard(
              patient: patient,
              onSaved: handleRecordSaved,
              onCancel: () => showNewRecordCard.value = false,
            ),
          );
        }

        // Records list with optional new record card
        return Column(
          children: [
            // Add button (hide when new record card is showing)
            if (!showNewRecordCard.value)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton.icon(
                      onPressed: () => showNewRecordCard.value = true,
                      icon: const Icon(Icons.add),
                      label: const Text('Add Record'),
                    ),
                  ],
                ),
              ),

            // New record card (shown at top when adding)
            if (showNewRecordCard.value)
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: NewRecordCard(
                  patient: patient,
                  onSaved: handleRecordSaved,
                  onCancel: () => showNewRecordCard.value = false,
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
                    final shouldExpand = expandedRecordId.value == record.id;

                    // Clear the expanded state after it's been used
                    if (shouldExpand) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        expandedRecordId.value = null;
                      });
                    }

                    return RecordCard(
                      key: ValueKey(record.id),
                      record: record,
                      patient: patient,
                      initiallyExpanded: shouldExpand,
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
}

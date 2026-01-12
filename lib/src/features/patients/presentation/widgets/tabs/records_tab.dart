import 'package:flutter/material.dart';

import '../../../data/dummy_patients_data.dart';
import '../../../domain/patient.dart';
import '../cards/record_card.dart';
import '../sheets/add_record_sheet.dart';

/// Records tab showing patient medical records/visits.
class RecordsTab extends StatelessWidget {
  const RecordsTab({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final patientRecords = dummyRecords.where((r) => r.patientId == patient.id).toList();
    final theme = Theme.of(context);

    if (patientRecords.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.medical_services_outlined, size: 64, color: theme.colorScheme.outline),
            const SizedBox(height: 16),
            Text(
              'No records yet',
              style: theme.textTheme.titleLarge?.copyWith(color: theme.colorScheme.outline),
            ),
            const SizedBox(height: 8),
            FilledButton.icon(
              onPressed: () => _showAddRecordSheet(context),
              icon: const Icon(Icons.add),
              label: const Text('Add First Record'),
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
                onPressed: () => _showAddRecordSheet(context),
                icon: const Icon(Icons.add),
                label: const Text('Add Record'),
              ),
            ],
          ),
        ),
        // Records list
        Expanded(
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
      ],
    );
  }

  void _showAddRecordSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => const AddRecordSheet(),
    );
  }
}

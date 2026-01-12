import 'package:flutter/material.dart';

import '../../data/dummy_patients_data.dart';
import '../../domain/patient.dart';
import '../../domain/patient_record.dart';
import '../widgets/sections/prescriptions_section.dart';

/// Full-screen page showing record details.
class RecordDetailPage extends StatelessWidget {
  const RecordDetailPage({
    super.key,
    required this.patientId,
    required this.recordId,
  });

  final String patientId;
  final String recordId;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Find patient and record
    final patient = dummyPatients.firstWhere(
      (p) => p.id == patientId,
      orElse: () => dummyPatients.first,
    );
    final record = dummyRecords.firstWhere(
      (r) => r.id == recordId,
      orElse: () => dummyRecords.first,
    );

    final dateStr = _formatDate(record.date);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Record Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Edit record coming soon')),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Patient info
            _buildPatientCard(theme, patient),
            const SizedBox(height: 24),

            // Visit date
            Text('Visit Date', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 20),
                    const SizedBox(width: 12),
                    Text(dateStr),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Vitals
            Text('Vitals', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            _buildVitalsRow(theme, record),
            const SizedBox(height: 24),

            // Diagnosis
            Text('Diagnosis', style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(record.diagnosis),
              ),
            ),

            if (record.notes != null) ...[
              const SizedBox(height: 24),
              Text('Notes', style: theme.textTheme.titleMedium),
              const SizedBox(height: 8),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(record.notes!),
                ),
              ),
            ],

            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            // Prescriptions
            PrescriptionsSection(recordId: recordId),

            const SizedBox(height: 32),

            // Actions
            Row(
              children: [
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Print functionality coming soon')),
                    );
                  },
                  icon: const Icon(Icons.print),
                  label: const Text('Print'),
                ),
                const SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Share functionality coming soon')),
                    );
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPatientCard(ThemeData theme, Patient patient) {
    return Card(
      color: theme.colorScheme.primaryContainer,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: patient.species == 'Dog'
                  ? Colors.brown.shade100
                  : Colors.orange.shade100,
              child: Icon(
                patient.species == 'Dog' ? Icons.pets : Icons.catching_pokemon,
                color: patient.species == 'Dog' ? Colors.brown : Colors.orange,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  Text('${patient.species} - ${patient.breed}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalsRow(ThemeData theme, PatientRecord record) {
    return Row(
      children: [
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.monitor_weight, size: 32),
                  const SizedBox(height: 8),
                  Text(record.weight, style: theme.textTheme.headlineSmall),
                  Text('Weight', style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  const Icon(Icons.thermostat, size: 32),
                  const SizedBox(height: 8),
                  Text(record.temperature, style: theme.textTheme.headlineSmall),
                  Text('Temperature', style: theme.textTheme.bodySmall),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    final month = months[date.month - 1];
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final hour = date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final minute = date.minute.toString().padLeft(2, '0');
    return '$month ${date.day}, ${date.year} $hour:$minute $amPm';
  }
}

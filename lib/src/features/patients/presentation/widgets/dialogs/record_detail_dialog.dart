import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/widgets/dialog_close_handler.dart';
import '../../../../../core/widgets/form_feedback.dart';
import '../../../domain/patient.dart';
import '../../../domain/patient_record.dart';
import 'edit_record_dialog.dart';

/// Dialog showing record details.
class RecordDetailDialog extends StatelessWidget {
  const RecordDetailDialog({
    super.key,
    required this.record,
    required this.patient,
  });

  final PatientRecord record;
  final Patient patient;

  void _showEditDialog(BuildContext context) {
    context.pop();
    showEditRecordDialog(context, record: record);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.sizeOf(context);
    final dateStr = _formatDate(record.date);

    return DialogCloseHandler(
      child: SizedBox(
        width: size.width,
        height: size.height,
        child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => context.pop(),
                ),
                Expanded(
                  child: Text(
                    'Record Details',
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () => _showEditDialog(context),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),

          const SizedBox(height: 8),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Patient info
                  Card(
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
                              patient.species == 'Dog'
                                  ? Icons.pets
                                  : Icons.catching_pokemon,
                              color: patient.species == 'Dog'
                                  ? Colors.brown
                                  : Colors.orange,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  patient.name,
                                  style: theme.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text('${patient.species} - ${patient.breed}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
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
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              children: [
                                const Icon(Icons.monitor_weight, size: 32),
                                const SizedBox(height: 8),
                                Text(record.weight,
                                    style: theme.textTheme.headlineSmall),
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
                                Text(record.temperature,
                                    style: theme.textTheme.headlineSmall),
                                Text('Temperature',
                                    style: theme.textTheme.bodySmall),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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

                  // Actions
                  Row(
                    children: [
                      OutlinedButton.icon(
                        onPressed: () {
                          showWarningSnackBar(context,
                              message: 'Print functionality coming soon');
                        },
                        icon: const Icon(Icons.print),
                        label: const Text('Print'),
                      ),
                      const SizedBox(width: 8),
                      OutlinedButton.icon(
                        onPressed: () {
                          showWarningSnackBar(context,
                              message: 'Share functionality coming soon');
                        },
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
      ),
    );
  }

  String _formatDate(DateTime date) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final month = months[date.month - 1];
    final amPm = date.hour >= 12 ? 'PM' : 'AM';
    final hour =
        date.hour > 12 ? date.hour - 12 : (date.hour == 0 ? 12 : date.hour);
    final minute = date.minute.toString().padLeft(2, '0');
    return '$month ${date.day}, ${date.year} $hour:$minute $amPm';
  }
}

/// Shows the record detail dialog.
void showRecordDetailDialog(
  BuildContext context, {
  required PatientRecord record,
  required Patient patient,
}) {
  showDialog(
    context: context,
    useRootNavigator: true,
    barrierDismissible: false,
    builder: (context) => Dialog(
      insetPadding: const EdgeInsets.all(8),
      clipBehavior: Clip.antiAlias,
      child: RecordDetailDialog(record: record, patient: patient),
    ),
  );
}

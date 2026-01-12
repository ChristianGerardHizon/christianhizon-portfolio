import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/patient.dart';
import '../../../domain/patient_record.dart';

/// Card displaying a patient medical record.
class RecordCard extends StatelessWidget {
  const RecordCard({
    super.key,
    required this.record,
    required this.patient,
  });

  final PatientRecord record;
  final Patient patient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateStr = _formatDate(record.date);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _navigateToRecordDetail(context),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.medical_services, color: theme.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text(
                    dateStr,
                    style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  const Icon(Icons.chevron_right),
                ],
              ),
              const SizedBox(height: 8),
              Text(record.diagnosis),
              const SizedBox(height: 8),
              Row(
                children: [
                  Chip(
                    avatar: const Icon(Icons.monitor_weight, size: 16),
                    label: Text(record.weight),
                  ),
                  const SizedBox(width: 8),
                  Chip(
                    avatar: const Icon(Icons.thermostat, size: 16),
                    label: Text(record.temperature),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToRecordDetail(BuildContext context) {
    context.push('/patients/${patient.id}/records/${record.id}');
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

import 'package:flutter/material.dart';

import '../../../domain/patient_treatment_record.dart';

/// Card displaying a treatment record.
class TreatmentRecordCard extends StatelessWidget {
  const TreatmentRecordCard({
    super.key,
    required this.treatmentRecord,
    required this.onEdit,
    required this.onDelete,
  });

  final PatientTreatmentRecord treatmentRecord;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  IconData _getTreatmentIcon() {
    final iconName = treatmentRecord.treatment?.icon?.toLowerCase() ?? '';

    // Map common icon names to Material icons
    switch (iconName) {
      case 'vaccine':
      case 'vaccination':
      case 'syringe':
        return Icons.vaccines;
      case 'deworm':
      case 'deworming':
      case 'pill':
        return Icons.medication;
      case 'surgery':
      case 'operation':
        return Icons.local_hospital;
      case 'checkup':
      case 'examination':
        return Icons.health_and_safety;
      case 'dental':
      case 'teeth':
        return Icons.emoji_emotions;
      case 'grooming':
      case 'bath':
        return Icons.bathtub;
      case 'xray':
      case 'scan':
        return Icons.biotech;
      case 'lab':
      case 'test':
        return Icons.science;
      default:
        return Icons.healing;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Treatment icon
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: theme.colorScheme.tertiaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                _getTreatmentIcon(),
                color: theme.colorScheme.tertiary,
              ),
            ),
            const SizedBox(width: 16),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          treatmentRecord.treatmentName.isNotEmpty
                              ? treatmentRecord.treatmentName
                              : 'Unknown Treatment',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (treatmentRecord.appointment != null &&
                          treatmentRecord.appointment!.isNotEmpty) ...[
                        const SizedBox(width: 8),
                        Tooltip(
                          message: 'Linked to appointment',
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.primaryContainer,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.event,
                                  size: 14,
                                  color: theme.colorScheme.onPrimaryContainer,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'Appt',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: theme.colorScheme.onPrimaryContainer,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (treatmentRecord.notes != null &&
                      treatmentRecord.notes!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      treatmentRecord.notes!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ],
              ),
            ),

            // Menu
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit();
                } else if (value == 'delete') {
                  onDelete();
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      Icon(Icons.edit, size: 20),
                      SizedBox(width: 8),
                      Text('Edit'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(Icons.delete, size: 20),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

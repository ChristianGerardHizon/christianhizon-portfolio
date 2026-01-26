import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../domain/patient_treatment_record.dart';

/// Card displaying a treatment record with linked appointment.
class TreatmentRecordCard extends ConsumerWidget {
  const TreatmentRecordCard({
    super.key,
    required this.treatmentRecord,
    required this.onEdit,
    required this.onDelete,
    this.onViewAppointment,
  });

  final PatientTreatmentRecord treatmentRecord;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onViewAppointment;

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
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final hasAppointment = treatmentRecord.appointment != null &&
        treatmentRecord.appointment!.isNotEmpty;

    // Watch appointment if linked
    final appointmentAsync = hasAppointment
        ? ref.watch(appointmentProvider(treatmentRecord.appointment!))
        : null;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Main row with icon, content, and menu
            Row(
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
                      Text(
                        treatmentRecord.treatmentName.isNotEmpty
                            ? treatmentRecord.treatmentName
                            : 'Unknown Treatment',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
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
                          SizedBox(width: 12),
                          Text('Edit'),
                        ],
                      ),
                    ),
                    PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(
                            Icons.delete,
                            size: 20,
                            color: theme.colorScheme.error,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            'Delete',
                            style: TextStyle(color: theme.colorScheme.error),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),

            // Linked appointment section
            if (hasAppointment) ...[
              const SizedBox(height: 12),
              const Divider(height: 1),
              const SizedBox(height: 12),
              _LinkedAppointmentSection(
                appointmentAsync: appointmentAsync,
                onView: onViewAppointment,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Section showing linked appointment info.
class _LinkedAppointmentSection extends StatelessWidget {
  const _LinkedAppointmentSection({
    required this.appointmentAsync,
    required this.onView,
  });

  final AsyncValue? appointmentAsync;
  final VoidCallback? onView;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (appointmentAsync == null) {
      return const SizedBox.shrink();
    }

    return appointmentAsync!.when(
      loading: () => Row(
        children: [
          Icon(
            Icons.calendar_today,
            size: 16,
            color: theme.colorScheme.primary,
          ),
          const SizedBox(width: 8),
          const SizedBox(
            width: 16,
            height: 16,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ],
      ),
      error: (_, __) => const SizedBox.shrink(),
      data: (appointment) {
        if (appointment == null) return const SizedBox.shrink();

        final dateFormat = DateFormat('MMM d, yyyy');
        final timeFormat = DateFormat('h:mm a');

        return InkWell(
          onTap: onView,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${dateFormat.format(appointment.date)} at ${timeFormat.format(appointment.date)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ),
                if (onView != null)
                  Icon(
                    Icons.chevron_right,
                    size: 16,
                    color: theme.colorScheme.primary,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}

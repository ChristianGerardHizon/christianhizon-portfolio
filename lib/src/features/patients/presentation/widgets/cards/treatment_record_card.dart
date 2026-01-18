import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../../messages/presentation/controllers/messages_controller.dart';
import '../../../domain/patient_treatment_record.dart';

/// Card displaying a treatment record with linked appointment and messages.
class TreatmentRecordCard extends ConsumerWidget {
  const TreatmentRecordCard({
    super.key,
    required this.treatmentRecord,
    required this.onEdit,
    required this.onDelete,
    this.onViewAppointment,
    this.onViewMessages,
  });

  final PatientTreatmentRecord treatmentRecord;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onViewAppointment;
  final VoidCallback? onViewMessages;

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

    // Watch messages for this patient (we'll filter by treatment context)
    final messagesAsync = treatmentRecord.patientId.isNotEmpty
        ? ref.watch(messagesByPatientProvider(treatmentRecord.patientId))
        : null;

    // Filter messages that might be related to this treatment
    // (linked via appointment or created around the same time)
    final relatedMessages = messagesAsync?.value?.where((m) {
      // If message is linked to the same appointment
      if (hasAppointment && m.appointment == treatmentRecord.appointment) {
        return true;
      }
      return false;
    }).toList();

    final messageCount = relatedMessages?.length ?? 0;

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

            // Linked items section (appointment and messages)
            if (hasAppointment || messageCount > 0) ...[
              const SizedBox(height: 12),
              Divider(color: theme.colorScheme.outlineVariant, height: 1),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  // Linked Appointment Badge
                  if (hasAppointment)
                    appointmentAsync?.when(
                          loading: () => _LinkedItemChip(
                            icon: Icons.event,
                            label: 'Loading...',
                            color: theme.colorScheme.primaryContainer,
                            textColor: theme.colorScheme.onPrimaryContainer,
                          ),
                          error: (_, __) => _LinkedItemChip(
                            icon: Icons.event,
                            label: 'Appointment',
                            color: theme.colorScheme.primaryContainer,
                            textColor: theme.colorScheme.onPrimaryContainer,
                            onTap: onViewAppointment,
                          ),
                          data: (appointment) {
                            if (appointment == null) {
                              return _LinkedItemChip(
                                icon: Icons.event,
                                label: 'Appointment',
                                color: theme.colorScheme.primaryContainer,
                                textColor: theme.colorScheme.onPrimaryContainer,
                                onTap: onViewAppointment,
                              );
                            }
                            final dateStr =
                                DateFormat('MMM d').format(appointment.date);
                            return _LinkedItemChip(
                              icon: Icons.event,
                              label: dateStr,
                              subtitle: appointment.purpose,
                              color: theme.colorScheme.primaryContainer,
                              textColor: theme.colorScheme.onPrimaryContainer,
                              onTap: onViewAppointment,
                            );
                          },
                        ) ??
                        _LinkedItemChip(
                          icon: Icons.event,
                          label: 'Appointment',
                          color: theme.colorScheme.primaryContainer,
                          textColor: theme.colorScheme.onPrimaryContainer,
                          onTap: onViewAppointment,
                        ),

                  // Linked Messages Badge
                  if (messageCount > 0)
                    _LinkedItemChip(
                      icon: Icons.message,
                      label: '$messageCount message${messageCount > 1 ? 's' : ''}',
                      color: theme.colorScheme.secondaryContainer,
                      textColor: theme.colorScheme.onSecondaryContainer,
                      onTap: onViewMessages,
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// A chip displaying a linked item (appointment or message).
class _LinkedItemChip extends StatelessWidget {
  const _LinkedItemChip({
    required this.icon,
    required this.label,
    this.subtitle,
    required this.color,
    required this.textColor,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? subtitle;
  final Color color;
  final Color textColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: color,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: textColor),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: textColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null && subtitle!.isNotEmpty)
                    Text(
                      subtitle!,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: textColor.withValues(alpha: 0.7),
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                ],
              ),
              if (onTap != null) ...[
                const SizedBox(width: 4),
                Icon(Icons.chevron_right, size: 16, color: textColor),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

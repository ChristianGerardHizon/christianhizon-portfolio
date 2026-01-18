import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../../core/foundation/paginated_state.dart';
import '../../../../../core/routing/routes/messages.routes.dart';
import '../../../../appointments/domain/appointment_schedule.dart';
import '../../../../appointments/presentation/controllers/patient_appointments_controller.dart';
import '../../../../messages/domain/message.dart';
import '../../../../messages/presentation/controllers/messages_controller.dart';
import '../../../domain/patient.dart';
import '../../../domain/patient_record.dart';
import '../../controllers/patient_records_controller.dart';

/// Overview tab showing key patient information at a glance.
///
/// Displays:
/// - Upcoming appointments count and next appointment
/// - Last visit date
/// - Last recorded weight and temperature
class PatientOverviewTab extends HookConsumerWidget {
  const PatientOverviewTab({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appointmentsAsync =
        ref.watch(patientAppointmentsControllerProvider(patient.id));
    final recordsAsync =
        ref.watch(patientRecordsControllerProvider(patient.id));
    final messagesAsync =
        ref.watch(messagesByPatientProvider(patient.id));

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Upcoming Appointments Card
          _buildUpcomingAppointmentsCard(context, appointmentsAsync),
          const SizedBox(height: 16),

          // Upcoming Messages Card
          _buildUpcomingMessagesCard(context, messagesAsync),
          const SizedBox(height: 16),

          // Last Visit and Vitals Row
          _buildLastVisitAndVitalsRow(context, recordsAsync),
        ],
      ),
    );
  }

  Widget _buildUpcomingAppointmentsCard(
    BuildContext context,
    AsyncValue<PaginatedState<AppointmentSchedule>> appointmentsAsync,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.calendar_today,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Upcoming Appointments',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            appointmentsAsync.when(
              loading: () => const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              error: (error, _) => Text(
                'Error loading appointments',
                style: TextStyle(color: theme.colorScheme.error),
              ),
              data: (paginatedState) {
                final upcoming = paginatedState.items
                    .where((a) =>
                        a.date.isAfter(DateTime.now()) &&
                        a.status == AppointmentScheduleStatus.scheduled)
                    .toList()
                  ..sort((a, b) => a.date.compareTo(b.date));

                if (upcoming.isEmpty) {
                  return Row(
                    children: [
                      Icon(
                        Icons.event_available,
                        size: 18,
                        color: theme.colorScheme.outline,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'No upcoming appointments',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  );
                }

                final nextAppointment = upcoming.first;
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '${upcoming.length} upcoming',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onPrimaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        Icon(
                          Icons.schedule,
                          size: 16,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Next: ${nextAppointment.displayDate}',
                            style: theme.textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    if (nextAppointment.purpose != null &&
                        nextAppointment.purpose!.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.description,
                            size: 16,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              nextAppointment.purpose!,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingMessagesCard(
    BuildContext context,
    AsyncValue<List<Message>> messagesAsync,
  ) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.message,
                  size: 20,
                  color: theme.colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Upcoming Messages',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () => const MessagesRoute().go(context),
                  icon: const Icon(Icons.open_in_new, size: 16),
                  label: const Text('View All'),
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    visualDensity: VisualDensity.compact,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            messagesAsync.when(
              loading: () => const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
              error: (error, _) => Text(
                'Error loading messages',
                style: TextStyle(color: theme.colorScheme.error),
              ),
              data: (messages) {
                // Filter for pending messages scheduled in the future
                final upcoming = messages
                    .where((m) =>
                        m.status == MessageStatus.pending &&
                        m.sendDateTime.isAfter(DateTime.now()))
                    .toList()
                  ..sort((a, b) => a.sendDateTime.compareTo(b.sendDateTime));

                if (upcoming.isEmpty) {
                  return Row(
                    children: [
                      Icon(
                        Icons.mark_chat_read,
                        size: 18,
                        color: theme.colorScheme.outline,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'No upcoming messages',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  );
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            '${upcoming.length} pending',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Show up to 3 upcoming messages
                    ...upcoming.take(3).map((message) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _buildMessageItem(context, message),
                        )),
                    if (upcoming.length > 3)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          '+ ${upcoming.length - 3} more',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageItem(BuildContext context, Message message) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.schedule,
                size: 14,
                color: theme.colorScheme.secondary,
              ),
              const SizedBox(width: 6),
              Text(
                DateFormat('MMM d, yyyy - h:mm a').format(message.sendDateTime),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            message.content,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                Icons.phone,
                size: 12,
                color: theme.colorScheme.outline,
              ),
              const SizedBox(width: 4),
              Text(
                message.phone,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLastVisitAndVitalsRow(
    BuildContext context,
    AsyncValue<List<PatientRecord>> recordsAsync,
  ) {
    return recordsAsync.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      ),
      error: (error, _) => Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            'Error loading records',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ),
      ),
      data: (records) {
        // Get the most recent record
        PatientRecord? latestRecord;
        if (records.isNotEmpty) {
          final sortedRecords = [...records]
            ..sort((a, b) => b.date.compareTo(a.date));
          latestRecord = sortedRecords.first;
        }

        return Column(
          children: [
            // Last Visit Card
            _buildLastVisitCard(context, latestRecord),
            const SizedBox(height: 16),

            // Vitals Card
            _buildVitalsCard(context, latestRecord),
          ],
        );
      },
    );
  }

  Widget _buildLastVisitCard(BuildContext context, PatientRecord? latestRecord) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.history,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Last Visit',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (latestRecord == null)
              Row(
                children: [
                  Icon(
                    Icons.event_busy,
                    size: 18,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'No records yet',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_month,
                        size: 16,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        DateFormat('MMMM d, yyyy').format(latestRecord.date),
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  if (latestRecord.diagnosis.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.medical_information,
                          size: 16,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            latestRecord.diagnosis,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalsCard(BuildContext context, PatientRecord? latestRecord) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.monitor_heart,
                  size: 20,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Last Vitals',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (latestRecord == null)
              Row(
                children: [
                  Icon(
                    Icons.monitor_heart_outlined,
                    size: 18,
                    color: theme.colorScheme.outline,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'No vitals recorded',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ],
              )
            else
              Row(
                children: [
                  // Weight
                  Expanded(
                    child: _buildVitalItem(
                      context,
                      icon: Icons.scale,
                      label: 'Weight',
                      value: latestRecord.weight,
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Temperature
                  Expanded(
                    child: _buildVitalItem(
                      context,
                      icon: Icons.thermostat,
                      label: 'Temperature',
                      value: latestRecord.temperature,
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildVitalItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            value.isNotEmpty ? value : '-',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

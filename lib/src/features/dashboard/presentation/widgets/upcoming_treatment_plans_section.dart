import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../core/routing/routes/appointments.routes.dart';
import '../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../appointments/presentation/widgets/sheets/create_appointment_sheet.dart';
import '../../../patients/presentation/controllers/patient_provider.dart';
import '../../../treatment_plans/data/repositories/treatment_plan_item_repository.dart';
import '../../../treatment_plans/domain/treatment_plan_item.dart';
import '../../../treatment_plans/domain/treatment_plan_item_status.dart';
import '../../../treatment_plans/presentation/controllers/treatment_plan_items_controller.dart';
import '../../../treatment_plans/presentation/widgets/sheets/reschedule_item_sheet.dart';

/// Section displaying upcoming treatment plan items on the dashboard.
///
/// Shows treatment sessions scheduled for the next 7 days with action options.
class UpcomingTreatmentPlansSection extends ConsumerWidget {
  const UpcomingTreatmentPlansSection({super.key});

  static const _daysAhead = 7;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final itemsAsync = ref.watch(upcomingTreatmentPlanItemsProvider(_daysAhead));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Section header
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Icon(
                Icons.medical_services,
                color: theme.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Upcoming Treatments',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              itemsAsync.whenOrNull(
                data: (items) => Text(
                  'Next $_daysAhead days',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.outline,
                  ),
                ),
              ) ?? const SizedBox.shrink(),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // Items list
        itemsAsync.when(
          data: (items) {
            if (items.isEmpty) {
              return _buildEmptyState(context);
            }
            return Column(
              children: items.map((item) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                child: _DashboardTreatmentCard(
                  item: item,
                  onMarkCompleted: () => _handleMarkCompleted(context, ref, item),
                  onMarkSkipped: () => _handleMarkSkipped(context, ref, item),
                  onReschedule: () => _handleReschedule(context, ref, item),
                  onBookAppointment: () => _handleBookAppointment(context, ref, item),
                  onViewAppointment: item.appointmentId != null && item.appointmentId!.isNotEmpty
                      ? () => _handleViewAppointment(context, item)
                      : null,
                ),
              )).toList(),
            );
          },
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stack) => _buildErrorState(context, ref),
        ),
      ],
    );
  }

  Future<void> _handleMarkCompleted(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlanItem item,
  ) async {
    final repository = ref.read(treatmentPlanItemRepositoryProvider);
    final result = await repository.updateStatus(
      item.id,
      TreatmentPlanItemStatus.completed,
      completedDate: DateTime.now(),
    );

    if (context.mounted) {
      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update session')),
          );
        },
        (updatedItem) {
          ref.invalidate(upcomingTreatmentPlanItemsProvider(_daysAhead));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Session marked as completed')),
          );
        },
      );
    }
  }

  Future<void> _handleMarkSkipped(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlanItem item,
  ) async {
    final repository = ref.read(treatmentPlanItemRepositoryProvider);
    final result = await repository.updateStatus(
      item.id,
      TreatmentPlanItemStatus.skipped,
    );

    if (context.mounted) {
      result.fold(
        (failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update session')),
          );
        },
        (updatedItem) {
          ref.invalidate(upcomingTreatmentPlanItemsProvider(_daysAhead));
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Session skipped')),
          );
        },
      );
    }
  }

  void _handleReschedule(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlanItem item,
  ) {
    showRescheduleItemSheet(
      context,
      item: item,
      onSave: (newDate) async {
        final repository = ref.read(treatmentPlanItemRepositoryProvider);
        final result = await repository.reschedule(item.id, newDate);

        return result.fold(
          (failure) => false,
          (updatedItem) {
            if (context.mounted) {
              ref.invalidate(upcomingTreatmentPlanItemsProvider(_daysAhead));
            }
            return true;
          },
        );
      },
    );
  }

  Future<void> _handleBookAppointment(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlanItem item,
  ) async {
    // Treatment plan items have patientId from expanded plan data
    if (item.patientId == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load patient information')),
        );
      }
      return;
    }

    final patient = await ref.read(patientProvider(item.patientId!).future);

    if (patient == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load patient information')),
        );
      }
      return;
    }

    if (!context.mounted) return;

    // Construct purpose with treatment name and session info
    final treatmentName = item.treatmentName ?? 'Treatment';
    final purpose = '$treatmentName - Session ${item.sequence}';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (sheetContext) => CreateAppointmentSheet(
        initialPatient: patient,
        treatmentPlanItem: item,
        initialPurpose: purpose,
        onSave: (appointment) async {
          final created = await ref
              .read(appointmentsControllerProvider.notifier)
              .createAppointmentAndReturn(appointment);

          if (created != null && context.mounted) {
            final repository = ref.read(treatmentPlanItemRepositoryProvider);
            final result = await repository.linkAppointment(item.id, created.id);

            result.fold(
              (failure) {
                // Log failure but don't block appointment creation
              },
              (updatedItem) {
                ref.invalidate(upcomingTreatmentPlanItemsProvider(_daysAhead));
              },
            );
          }

          return created;
        },
      ),
    );
  }

  void _handleViewAppointment(BuildContext context, TreatmentPlanItem item) {
    if (item.appointmentId != null && item.appointmentId!.isNotEmpty) {
      AppointmentDetailRoute(id: item.appointmentId!).go(context);
    }
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.event_available,
              size: 48,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 12),
            Text(
              'No upcoming treatments',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'No sessions scheduled for the next $_daysAhead days',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.outline,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              size: 48,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              'Failed to load treatments',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            FilledButton.tonal(
              onPressed: () => ref.invalidate(upcomingTreatmentPlanItemsProvider(_daysAhead)),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Card widget for displaying a treatment session on the dashboard.
class _DashboardTreatmentCard extends StatelessWidget {
  const _DashboardTreatmentCard({
    required this.item,
    this.onMarkCompleted,
    this.onMarkSkipped,
    this.onReschedule,
    this.onBookAppointment,
    this.onViewAppointment,
  });

  final TreatmentPlanItem item;
  final VoidCallback? onMarkCompleted;
  final VoidCallback? onMarkSkipped;
  final VoidCallback? onReschedule;
  final VoidCallback? onBookAppointment;
  final VoidCallback? onViewAppointment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('EEE, MMM d');
    final isBooked = item.status == TreatmentPlanItemStatus.booked;
    final isOverdue = item.isOverdue;

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: isOverdue
              ? theme.colorScheme.error.withValues(alpha: 0.5)
              : theme.colorScheme.outlineVariant,
        ),
      ),
      color: isOverdue
          ? theme.colorScheme.errorContainer.withValues(alpha: 0.3)
          : theme.colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Session badge
            _buildSessionBadge(context),
            const SizedBox(width: 12),

            // Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Patient name and treatment
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.patientName ?? 'Unknown Patient',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // Booked badge
                      if (isBooked) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondaryContainer,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.event,
                                size: 14,
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                'Booked',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.onSecondaryContainer,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 4),

                  // Treatment name
                  Text(
                    item.treatmentName ?? 'Treatment',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),

                  // Date and status row
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        size: 14,
                        color: isOverdue
                            ? theme.colorScheme.error
                            : theme.colorScheme.outline,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        dateFormat.format(item.expectedDate),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: isOverdue
                              ? theme.colorScheme.error
                              : theme.colorScheme.outline,
                          fontWeight: isOverdue ? FontWeight.w500 : null,
                        ),
                      ),
                      if (isOverdue) ...[
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 6,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.errorContainer,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            'OVERDUE',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onErrorContainer,
                              fontWeight: FontWeight.bold,
                              fontSize: 10,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),

            // Actions menu
            _buildActionsMenu(context),
          ],
        ),
      ),
    );
  }

  Widget _buildSessionBadge(BuildContext context) {
    final theme = Theme.of(context);
    final isBooked = item.status == TreatmentPlanItemStatus.booked;
    final isOverdue = item.isOverdue;

    Color backgroundColor;
    Color foregroundColor;

    if (isOverdue) {
      backgroundColor = theme.colorScheme.errorContainer;
      foregroundColor = theme.colorScheme.onErrorContainer;
    } else if (isBooked) {
      backgroundColor = theme.colorScheme.secondaryContainer;
      foregroundColor = theme.colorScheme.onSecondaryContainer;
    } else {
      backgroundColor = theme.colorScheme.primaryContainer;
      foregroundColor = theme.colorScheme.onPrimaryContainer;
    }

    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '${item.sequence}',
          style: theme.textTheme.titleMedium?.copyWith(
            color: foregroundColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildActionsMenu(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      onSelected: (value) {
        switch (value) {
          case 'complete':
            onMarkCompleted?.call();
          case 'skip':
            onMarkSkipped?.call();
          case 'reschedule':
            onReschedule?.call();
          case 'book':
            onBookAppointment?.call();
          case 'view_appointment':
            onViewAppointment?.call();
        }
      },
      itemBuilder: (context) => [
        if (item.status == TreatmentPlanItemStatus.scheduled) ...[
          const PopupMenuItem(
            value: 'complete',
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 20),
                SizedBox(width: 8),
                Text('Mark Completed'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'book',
            child: Row(
              children: [
                Icon(Icons.event, size: 20),
                SizedBox(width: 8),
                Text('Book Appointment'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'reschedule',
            child: Row(
              children: [
                Icon(Icons.schedule, size: 20),
                SizedBox(width: 8),
                Text('Reschedule'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'skip',
            child: Row(
              children: [
                Icon(Icons.skip_next, size: 20),
                SizedBox(width: 8),
                Text('Skip'),
              ],
            ),
          ),
        ],
        if (item.status == TreatmentPlanItemStatus.booked) ...[
          const PopupMenuItem(
            value: 'complete',
            child: Row(
              children: [
                Icon(Icons.check_circle, size: 20),
                SizedBox(width: 8),
                Text('Mark Completed'),
              ],
            ),
          ),
          if (item.appointmentId != null && item.appointmentId!.isNotEmpty)
            const PopupMenuItem(
              value: 'view_appointment',
              child: Row(
                children: [
                  Icon(Icons.event, size: 20),
                  SizedBox(width: 8),
                  Text('View Appointment'),
                ],
              ),
            ),
          const PopupMenuItem(
            value: 'reschedule',
            child: Row(
              children: [
                Icon(Icons.schedule, size: 20),
                SizedBox(width: 8),
                Text('Reschedule'),
              ],
            ),
          ),
          const PopupMenuItem(
            value: 'skip',
            child: Row(
              children: [
                Icon(Icons.skip_next, size: 20),
                SizedBox(width: 8),
                Text('Skip'),
              ],
            ),
          ),
        ],
      ],
    );
  }
}

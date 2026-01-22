import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../treatment_plans/domain/treatment_plan_item.dart';
import '../../../treatment_plans/domain/treatment_plan_item_status.dart';
import '../../../treatment_plans/presentation/controllers/treatment_plan_items_controller.dart';

/// Section displaying upcoming treatment plan items on the dashboard.
///
/// Shows treatment sessions scheduled for the next 7 days.
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
              children: items.map((item) => _UpcomingTreatmentTile(item: item)).toList(),
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

/// A compact tile for displaying an upcoming treatment plan item.
class _UpcomingTreatmentTile extends StatelessWidget {
  const _UpcomingTreatmentTile({required this.item});

  final TreatmentPlanItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('EEE, MMM d');

    // Determine if this is today
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final itemDate = DateTime(
      item.expectedDate.year,
      item.expectedDate.month,
      item.expectedDate.day,
    );
    final isToday = itemDate == today;
    final isTomorrow = itemDate == today.add(const Duration(days: 1));
    final isOverdue = item.isOverdue;
    final isBooked = item.status == TreatmentPlanItemStatus.booked;

    String dateDisplay;
    if (isToday) {
      dateDisplay = 'Today';
    } else if (isTomorrow) {
      dateDisplay = 'Tomorrow';
    } else {
      dateDisplay = dateFormat.format(item.expectedDate);
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: isOverdue
            ? BorderSide(color: theme.colorScheme.error, width: 1.5)
            : BorderSide.none,
      ),
      child: InkWell(
        onTap: () {
          // TODO: Navigate to treatment plan detail
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Date column
              Container(
                width: 80,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isOverdue
                      ? theme.colorScheme.errorContainer
                      : isToday
                          ? theme.colorScheme.primaryContainer
                          : theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      isOverdue ? 'Overdue' : dateDisplay,
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: isOverdue
                            ? theme.colorScheme.onErrorContainer
                            : isToday
                                ? theme.colorScheme.onPrimaryContainer
                                : theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (isOverdue) ...[
                      const SizedBox(height: 2),
                      Text(
                        dateDisplay,
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.onErrorContainer
                              .withValues(alpha: 0.7),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ],
                ),
              ),
              const SizedBox(width: 12),

              // Patient and treatment info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (item.patientName != null) ...[
                      Row(
                        children: [
                          Icon(
                            Icons.pets,
                            size: 14,
                            color: theme.colorScheme.outline,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              item.patientName!,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                    if (item.treatmentName != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        item.treatmentName!,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.outline,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (item.patientName == null && item.treatmentName == null)
                      Text(
                        'Session ${item.sequence}',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    // Booking status indicator
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          isBooked ? Icons.event_available : Icons.event_busy,
                          size: 12,
                          color: isBooked ? Colors.green : theme.colorScheme.outline,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          isBooked ? 'Booked' : 'Not booked',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: isBooked ? Colors.green : theme.colorScheme.outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Session badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondaryContainer,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '#${item.sequence}',
                  style: theme.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSecondaryContainer,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

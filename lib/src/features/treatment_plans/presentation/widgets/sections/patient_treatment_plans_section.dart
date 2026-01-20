import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../../appointments/presentation/widgets/sheets/create_appointment_sheet.dart';
import '../../../../patients/presentation/controllers/patient_provider.dart';
import '../../../domain/treatment_plan.dart';
import '../../../domain/treatment_plan_item.dart';
import '../../../domain/treatment_plan_status.dart';
import '../../controllers/patient_treatment_plans_controller.dart';
import '../../controllers/treatment_plan_items_controller.dart';
import '../cards/treatment_plan_card.dart';
import '../sheets/create_treatment_plan_sheet.dart';
import '../sheets/edit_treatment_plan_sheet.dart';
import '../sheets/reschedule_item_sheet.dart';

/// Section displaying treatment plans for a patient.
class PatientTreatmentPlansSection extends HookConsumerWidget {
  const PatientTreatmentPlansSection({
    super.key,
    required this.patientId,
  });

  final String patientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final plansAsync =
        ref.watch(patientTreatmentPlansControllerProvider(patientId));
    final theme = Theme.of(context);

    // Track expanded cards
    final expandedPlanIds = useState<Set<String>>({});

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        Row(
          children: [
            Icon(Icons.medical_services, color: theme.colorScheme.primary),
            const SizedBox(width: 8),
            Text('Treatment Plans', style: theme.textTheme.titleMedium),
            const Spacer(),
            FilledButton.icon(
              onPressed: () => _handleAddPlan(context, ref),
              icon: const Icon(Icons.add, size: 18),
              label: const Text('New Plan'),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Content
        plansAsync.when(
          loading: () => const Center(
            child: Padding(
              padding: EdgeInsets.all(32),
              child: CircularProgressIndicator(),
            ),
          ),
          error: (error, stack) => Card(
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                children: [
                  Icon(
                    Icons.error_outline,
                    size: 48,
                    color: theme.colorScheme.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Failed to load treatment plans',
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.error,
                    ),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => ref
                        .read(patientTreatmentPlansControllerProvider(patientId)
                            .notifier)
                        .refresh(),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Retry'),
                  ),
                ],
              ),
            ),
          ),
          data: (plans) {
            if (plans.isEmpty) {
              return _EmptyState(
                onAdd: () => _handleAddPlan(context, ref),
              );
            }

            // Separate active and inactive plans
            final activePlans =
                plans.where((p) => p.status == TreatmentPlanStatus.active).toList();
            final inactivePlans =
                plans.where((p) => p.status != TreatmentPlanStatus.active).toList();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Active plans
                if (activePlans.isNotEmpty) ...[
                  _SectionHeader(
                    title: 'Active Plans',
                    count: activePlans.length,
                  ),
                  const SizedBox(height: 8),
                  ...activePlans.map(
                    (plan) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: _buildPlanCard(
                        context,
                        ref,
                        plan,
                        expandedPlanIds.value.contains(plan.id),
                        () {
                          final newSet = Set<String>.from(expandedPlanIds.value);
                          if (newSet.contains(plan.id)) {
                            newSet.remove(plan.id);
                          } else {
                            newSet.add(plan.id);
                          }
                          expandedPlanIds.value = newSet;
                        },
                      ),
                    ),
                  ),
                ],

                // Inactive plans (collapsed by default)
                if (inactivePlans.isNotEmpty) ...[
                  if (activePlans.isNotEmpty) const SizedBox(height: 16),
                  _InactivePlansSection(
                    plans: inactivePlans,
                    buildPlanCard: (plan, isExpanded, toggleExpand) =>
                        _buildPlanCard(context, ref, plan, isExpanded, toggleExpand),
                  ),
                ],
              ],
            );
          },
        ),
      ],
    );
  }

  Widget _buildPlanCard(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
    bool isExpanded,
    VoidCallback toggleExpand,
  ) {
    return GestureDetector(
      onTap: toggleExpand,
      child: TreatmentPlanCard(
        plan: plan,
        expanded: isExpanded,
        onEdit: () => _handleEditPlan(context, ref, plan),
        onCancel: () => _handleCancelPlan(context, ref, plan),
        onComplete: () => _handleCompletePlan(context, ref, plan),
        onPutOnHold: () => _handlePutOnHold(context, ref, plan),
        onReactivate: () => _handleReactivate(context, ref, plan),
        onMarkItemCompleted: (item) =>
            _handleMarkItemCompleted(context, ref, plan, item),
        onMarkItemSkipped: (item) =>
            _handleMarkItemSkipped(context, ref, plan, item),
        onRescheduleItem: (item) =>
            _handleRescheduleItem(context, ref, plan, item),
        onBookAppointment: (item) =>
            _handleBookAppointment(context, ref, plan, item),
        onViewAppointment: (item) =>
            _handleViewAppointment(context, ref, plan, item),
      ),
    );
  }

  void _handleAddPlan(BuildContext context, WidgetRef ref) {
    showCreateTreatmentPlanSheet(
      context,
      patientId: patientId,
      onSave: (plan, scheduledDates) async {
        final created = await ref
            .read(patientTreatmentPlansControllerProvider(patientId).notifier)
            .createPlanWithItems(plan, scheduledDates);
        return created;
      },
    );
  }

  void _handleEditPlan(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
  ) {
    showEditTreatmentPlanSheet(
      context,
      plan: plan,
      onSave: (updatedPlan) async {
        final success = await ref
            .read(patientTreatmentPlansControllerProvider(patientId).notifier)
            .updatePlan(updatedPlan);
        return success;
      },
    );
  }

  Future<void> _handleCancelPlan(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancel Treatment Plan'),
        content: Text(
          'Are you sure you want to cancel this ${plan.treatmentName} plan?',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: const Text('Yes, Cancel'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref
          .read(patientTreatmentPlansControllerProvider(patientId).notifier)
          .updatePlanStatus(plan.id, TreatmentPlanStatus.cancelled);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Plan cancelled' : 'Failed to cancel plan',
            ),
          ),
        );
      }
    }
  }

  Future<void> _handleCompletePlan(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Complete Treatment Plan'),
        content: Text(
          'Mark this ${plan.treatmentName} plan as completed?\n\n'
          'Progress: ${plan.progressDisplay}',
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => context.pop(true),
            child: const Text('Complete'),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      final success = await ref
          .read(patientTreatmentPlansControllerProvider(patientId).notifier)
          .updatePlanStatus(plan.id, TreatmentPlanStatus.completed);

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              success ? 'Plan completed' : 'Failed to complete plan',
            ),
          ),
        );
      }
    }
  }

  Future<void> _handlePutOnHold(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
  ) async {
    final success = await ref
        .read(patientTreatmentPlansControllerProvider(patientId).notifier)
        .updatePlanStatus(plan.id, TreatmentPlanStatus.onHold);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? 'Plan put on hold' : 'Failed to put plan on hold',
          ),
        ),
      );
    }
  }

  Future<void> _handleReactivate(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
  ) async {
    final success = await ref
        .read(patientTreatmentPlansControllerProvider(patientId).notifier)
        .updatePlanStatus(plan.id, TreatmentPlanStatus.active);

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? 'Plan reactivated' : 'Failed to reactivate plan',
          ),
        ),
      );
    }
  }

  Future<void> _handleMarkItemCompleted(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
    TreatmentPlanItem item,
  ) async {
    final success = await ref
        .read(treatmentPlanItemsControllerProvider(plan.id).notifier)
        .markCompleted(item.id);

    if (context.mounted) {
      if (success) {
        // Refresh the plans list to get updated progress
        ref
            .read(patientTreatmentPlansControllerProvider(patientId).notifier)
            .refresh();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? 'Session marked as completed' : 'Failed to update session',
          ),
        ),
      );
    }
  }

  Future<void> _handleMarkItemSkipped(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
    TreatmentPlanItem item,
  ) async {
    final success = await ref
        .read(treatmentPlanItemsControllerProvider(plan.id).notifier)
        .markSkipped(item.id);

    if (context.mounted) {
      if (success) {
        // Refresh the plans list to get updated progress
        ref
            .read(patientTreatmentPlansControllerProvider(patientId).notifier)
            .refresh();
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            success ? 'Session skipped' : 'Failed to update session',
          ),
        ),
      );
    }
  }

  void _handleRescheduleItem(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
    TreatmentPlanItem item,
  ) {
    showRescheduleItemSheet(
      context,
      item: item,
      onSave: (newDate) async {
        final success = await ref
            .read(treatmentPlanItemsControllerProvider(plan.id).notifier)
            .reschedule(item.id, newDate);

        if (context.mounted && success) {
          // Refresh the plans list
          ref
              .read(patientTreatmentPlansControllerProvider(patientId).notifier)
              .refresh();
        }

        return success;
      },
    );
  }

  Future<void> _handleBookAppointment(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
    TreatmentPlanItem item,
  ) async {
    // Fetch the patient for the appointment form
    final patient = await ref.read(patientProvider(patientId).future);

    if (patient == null) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to load patient information')),
        );
      }
      return;
    }

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CreateAppointmentSheet(
        initialPatient: patient,
        treatmentPlanItem: item,
        onSave: (appointment) async {
          // Create the appointment and return it
          final created = await ref
              .read(appointmentsControllerProvider.notifier)
              .createAppointmentAndReturn(appointment);

          if (created != null && context.mounted) {
            // Link the appointment to the plan item
            final linkSuccess = await ref
                .read(treatmentPlanItemsControllerProvider(plan.id).notifier)
                .linkAppointment(item.id, created.id);

            if (linkSuccess) {
              // Refresh plans to show updated status
              ref
                  .read(patientTreatmentPlansControllerProvider(patientId)
                      .notifier)
                  .refresh();
            }
          }

          return created;
        },
      ),
    );
  }

  void _handleViewAppointment(
    BuildContext context,
    WidgetRef ref,
    TreatmentPlan plan,
    TreatmentPlanItem item,
  ) {
    if (item.appointmentId != null && item.appointmentId!.isNotEmpty) {
      // Navigate to appointment detail
      // AppointmentDetailRoute(id: item.appointmentId!).go(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('View appointment coming soon')),
      );
    }
  }
}

/// Empty state when no treatment plans exist.
class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onAdd});

  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          children: [
            Icon(
              Icons.medical_services_outlined,
              size: 48,
              color: theme.colorScheme.outline,
            ),
            const SizedBox(height: 16),
            Text(
              'No treatment plans',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Create a treatment plan to schedule recurring sessions',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.outline,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onAdd,
              icon: const Icon(Icons.add),
              label: const Text('Create Plan'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Section header with title and count.
class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.count,
  });

  final String title;
  final int count;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          title,
          style: theme.textTheme.titleSmall?.copyWith(
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          decoration: BoxDecoration(
            color: theme.colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            '$count',
            style: theme.textTheme.labelSmall?.copyWith(
              color: theme.colorScheme.onPrimaryContainer,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Divider(color: theme.colorScheme.outlineVariant),
        ),
      ],
    );
  }
}

/// Collapsible section for inactive plans.
class _InactivePlansSection extends HookWidget {
  const _InactivePlansSection({
    required this.plans,
    required this.buildPlanCard,
  });

  final List<TreatmentPlan> plans;
  final Widget Function(TreatmentPlan, bool, VoidCallback) buildPlanCard;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isExpanded = useState(false);
    final expandedPlanIds = useState<Set<String>>({});

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () => isExpanded.value = !isExpanded.value,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Icon(
                  isExpanded.value
                      ? Icons.expand_less
                      : Icons.expand_more,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Text(
                  'Past Plans',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${plans.length}',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Divider(color: theme.colorScheme.outlineVariant),
                ),
              ],
            ),
          ),
        ),
        if (isExpanded.value) ...[
          const SizedBox(height: 8),
          ...plans.map(
            (plan) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: buildPlanCard(
                plan,
                expandedPlanIds.value.contains(plan.id),
                () {
                  final newSet = Set<String>.from(expandedPlanIds.value);
                  if (newSet.contains(plan.id)) {
                    newSet.remove(plan.id);
                  } else {
                    newSet.add(plan.id);
                  }
                  expandedPlanIds.value = newSet;
                },
              ),
            ),
          ),
        ],
      ],
    );
  }
}

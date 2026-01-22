import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/routing/routes/appointments.routes.dart';
import '../../../../core/routing/routes/patients.routes.dart';
import '../../../../core/routing/routes/sales.routes.dart';
import '../../../appointments/presentation/controllers/appointments_controller.dart';
import '../../../appointments/presentation/widgets/sheets/create_appointment_sheet.dart';
import '../../../patients/presentation/widgets/sheets/create_patient_sheet.dart';

/// Section displaying quick action buttons on the dashboard.
///
/// Provides fast access to common tasks:
/// - Create new appointment
/// - Create new patient
/// - Open POS/Cashier
/// - Show dashboard overview (tablet only)
class QuickActionsSection extends ConsumerWidget {
  const QuickActionsSection({
    super.key,
    this.onShowOverview,
  });

  /// Optional callback to show the dashboard overview (clears appointment selection).
  /// Only shown when this callback is provided (tablet layout).
  final VoidCallback? onShowOverview;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Quick Actions',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Show Dashboard Overview button only on tablet
                if (onShowOverview != null) ...[
                  _QuickActionButton(
                    icon: Icons.dashboard,
                    label: 'Overview',
                    color: Theme.of(context).colorScheme.primary,
                    onTap: onShowOverview!,
                  ),
                  const SizedBox(width: 12),
                ],
                _QuickActionButton(
                  icon: Icons.calendar_month,
                  label: 'New Appointment',
                  color: Colors.blue,
                  onTap: () => _showCreateAppointmentSheet(context, ref),
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  icon: Icons.pets,
                  label: 'New Patient',
                  color: Colors.teal,
                  onTap: () => showCreatePatientSheet(context),
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  icon: Icons.point_of_sale,
                  label: 'New Sale',
                  color: Colors.green,
                  onTap: () => const SalesRoute().go(context),
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  icon: Icons.list_alt,
                  label: 'Appointments',
                  color: Colors.purple,
                  onTap: () => const AppointmentsRoute().go(context),
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  icon: Icons.person_search,
                  label: 'Find Patient',
                  color: Colors.orange,
                  onTap: () => const PatientsRoute().go(context),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showCreateAppointmentSheet(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => CreateAppointmentSheet(
        onSave: (appointment) async {
          return await ref
              .read(appointmentsControllerProvider.notifier)
              .createAppointmentAndReturn(appointment);
        },
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: color,
                size: 20,
              ),
              const SizedBox(width: 8),
              Text(
                label,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

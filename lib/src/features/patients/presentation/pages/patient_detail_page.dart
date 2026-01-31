import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/widgets/form_feedback.dart';
import '../../../../core/routing/routes/patients.routes.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../../appointments/presentation/controllers/patient_appointments_controller.dart';
import '../../../appointments/presentation/widgets/dialogs/create_appointment_dialog.dart';
import '../../../appointments/presentation/widgets/tabs/patient_appointments_tab.dart';
import '../../domain/patient.dart';
import '../../domain/patient_tab.dart';
import '../controllers/patient_provider.dart';
import '../controllers/patients_controller.dart';
import '../widgets/dialogs/edit_patient_dialog.dart';
import '../widgets/tabs/patient_details_tab.dart';
import '../widgets/tabs/patient_files_tab.dart';
import '../widgets/tabs/patient_overview_tab.dart';
import '../widgets/tabs/patient_records_tab.dart';
import '../widgets/tabs/patient_treatments_tab.dart';

/// Patient detail page with tabbed content.
///
/// Shows patient info across 6 tabs:
/// - Overview: Brief customizable summary
/// - Details: Patient and owner information
/// - Records: Medical records/visits
/// - Treatments: Prescribed treatments (placeholder)
/// - Appointments: Scheduled appointments (placeholder)
/// - Files: Attached documents (images, videos, PDFs)
class PatientDetailPage extends HookConsumerWidget {
  const PatientDetailPage({
    super.key,
    required this.patientId,
    this.initialTab = PatientTab.overview,
  });

  final String patientId;
  final PatientTab initialTab;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final patientAsync = ref.watch(patientProvider(patientId));

    final tabController = useTabController(
      initialLength: 6,
      initialIndex: initialTab.index,
    );
    final isTablet = Breakpoints.isTabletOrLarger(context);
    final t = Translations.of(context);

    return patientAsync.when(
      loading: () => const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
      error: (error, stack) => Scaffold(
        appBar: AppBar(
          leading: isTablet
              ? null
              : IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => const PatientsRoute().go(context),
                ),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 48),
              const SizedBox(height: 16),
              Text('Error loading patient: ${error.toString()}'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => ref.invalidate(patientProvider(patientId)),
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      ),
      data: (patient) {
        if (patient == null) {
          return Scaffold(
            appBar: AppBar(
              leading: isTablet
                  ? null
                  : IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () => const PatientsRoute().go(context),
                    ),
            ),
            body: const Center(
              child: Text('Patient not found'),
            ),
          );
        }

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: !isTablet,
            leading: isTablet
                ? null
                : IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => const PatientsRoute().go(context),
                  ),
            title: Text('${patient.name} - ${patient.breed ?? "Unknown breed"}'),
            actions: [
              IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  ref.invalidate(patientProvider(patientId));
                  showInfoSnackBar(
                    context,
                    message: 'Refreshing...',
                    duration: const Duration(seconds: 1),
                  );
                },
                tooltip: 'Refresh',
              ),
              IconButton(
                icon: const Icon(Icons.calendar_month),
                onPressed: () => _showBookAppointmentDialog(
                    context, ref, patient),
                tooltip: 'Book Appointment',
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => _showEditPatientDialog(context, patient),
                tooltip: t.common.edit,
              ),
              IconButton(
                icon: const Icon(Icons.more_vert),
                onPressed: () => _showMoreOptions(context, ref, patient),
              ),
            ],
            bottom: TabBar(
              controller: tabController,
              isScrollable: true,
              tabs: const [
                Tab(text: 'Overview'),
                Tab(text: 'Details'),
                Tab(text: 'Records'),
                Tab(text: 'Treatments'),
                Tab(text: 'Appointments'),
                Tab(text: 'Files'),
              ],
            ),
          ),
          body: TabBarView(
            controller: tabController,
            children: [
              PatientOverviewTab(patient: patient),
              PatientDetailsTab(patient: patient),
              PatientRecordsTab(patient: patient),
              PatientTreatmentsTab(patient: patient),
              PatientAppointmentsTab(patient: patient),
              PatientFilesTab(patient: patient),
            ],
          ),
        );
      },
    );
  }

  void _showBookAppointmentDialog(
      BuildContext context, WidgetRef ref, Patient patient) {
    showCreateAppointmentDialog(
      context,
      initialPatient: patient,
      onSave: (appointment) async {
        return await ref
            .read(patientAppointmentsControllerProvider(patient.id).notifier)
            .createAppointmentAndReturn(appointment);
      },
    );
  }

  void _showEditPatientDialog(BuildContext context, Patient patient) {
    showEditPatientDialog(context, patient: patient);
  }

  void _showMoreOptions(BuildContext context, WidgetRef ref, Patient patient) {
    final t = Translations.of(context);

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.print),
              title: const Text('Print Record'),
              onTap: () {
                Navigator.pop(context);
                showWarningSnackBar(context, message: 'Print functionality coming soon');
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                showWarningSnackBar(context, message: 'Share functionality coming soon');
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
              title: Text(t.common.delete,
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context, ref, patient);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
      BuildContext context, WidgetRef ref, Patient patient) {
    final t = Translations.of(context);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(t.common.delete),
        content: const Text('Are you sure you want to delete this patient?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(t.common.cancel),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.pop(context);
              final success = await ref
                  .read(patientsControllerProvider.notifier)
                  .deletePatient(patient.id);
              if (context.mounted) {
                if (success) {
                  const PatientsRoute().go(context);
                  showSuccessSnackBar(context, message: 'Patient deleted');
                } else {
                  showErrorSnackBar(context, message: 'Failed to delete patient');
                }
              }
            },
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.error,
            ),
            child: Text(t.common.delete),
          ),
        ],
      ),
    );
  }
}

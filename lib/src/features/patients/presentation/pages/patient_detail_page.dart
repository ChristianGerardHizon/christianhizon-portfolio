import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/i18n/strings.g.dart';
import '../../../../core/utils/breakpoints.dart';
import '../../data/dummy_patients_data.dart';
import '../../domain/patient.dart';
import '../../domain/patient_tab.dart';
import '../widgets/sheets/edit_patient_sheet.dart';
import '../widgets/tabs/details_tab.dart';
import '../widgets/tabs/placeholder_tab.dart';
import '../widgets/tabs/records_tab.dart';

/// Patient detail page with tabbed content.
///
/// Shows patient info across 5 tabs:
/// - Details: Patient and owner information
/// - Records: Medical records/visits
/// - Treatments: Prescribed treatments (placeholder)
/// - Appointments: Scheduled appointments (placeholder)
/// - Files: Attached documents (placeholder)
class PatientDetailPage extends HookWidget {
  const PatientDetailPage({
    super.key,
    required this.patientId,
    this.initialTab = PatientTab.details,
  });

  final String patientId;
  final PatientTab initialTab;

  @override
  Widget build(BuildContext context) {
    final patient = dummyPatients.firstWhere(
      (p) => p.id == patientId,
      orElse: () => dummyPatients.first,
    );

    final tabController = useTabController(
      initialLength: 5,
      initialIndex: initialTab.index,
    );
    final isTablet = Breakpoints.isTabletOrLarger(context);
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: !isTablet,
        leading: isTablet
            ? null
            : IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => context.go('/patients'),
              ),
        title: Text('${patient.name} - ${patient.breed}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditPatientDialog(context, patient),
            tooltip: t.common.edit,
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () => _showMoreOptions(context),
          ),
        ],
        bottom: TabBar(
          controller: tabController,
          isScrollable: true,
          tabs: const [
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
          DetailsTab(patient: patient),
          RecordsTab(patient: patient),
          const PlaceholderTab(title: 'Treatments', icon: Icons.healing),
          const PlaceholderTab(title: 'Appointments', icon: Icons.calendar_today),
          const PlaceholderTab(title: 'Files', icon: Icons.folder),
        ],
      ),
    );
  }

  void _showEditPatientDialog(BuildContext context, Patient patient) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      useRootNavigator: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => EditPatientSheet(patient: patient),
    );
  }

  void _showMoreOptions(BuildContext context) {
    final t = Translations.of(context);

    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.print),
              title: const Text('Print Record'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Print functionality coming soon')),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.share),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Share functionality coming soon')),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
              title: Text(t.common.delete, style: TextStyle(color: Theme.of(context).colorScheme.error)),
              onTap: () {
                Navigator.pop(context);
                _showDeleteConfirmation(context);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
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
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Patient deleted (demo)')),
              );
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

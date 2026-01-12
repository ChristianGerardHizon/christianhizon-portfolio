import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../controllers/patients_controller.dart';
import '../pages/patient_detail_page.dart';
import 'empty_detail_state.dart';
import 'patient_list_panel.dart';

/// Two-pane tablet layout for patients.
///
/// Left pane: Patient list with search
/// Right pane: Patient detail or empty state
class TabletPatientsLayout extends ConsumerStatefulWidget {
  const TabletPatientsLayout({super.key});

  @override
  ConsumerState<TabletPatientsLayout> createState() => _TabletPatientsLayoutState();
}

class _TabletPatientsLayoutState extends ConsumerState<TabletPatientsLayout> {
  String? _selectedPatientId;

  @override
  Widget build(BuildContext context) {
    final patientsAsync = ref.watch(patientsControllerProvider);

    return patientsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 48),
            const SizedBox(height: 16),
            Text('Error: ${error.toString()}'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(patientsControllerProvider.notifier).refresh(),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
      data: (patients) => Row(
        children: [
          // List panel
          SizedBox(
            width: 320,
            child: PatientListPanel(
              patients: patients,
              selectedId: _selectedPatientId,
              onPatientTap: (patient) {
                setState(() {
                  _selectedPatientId = patient.id;
                });
              },
              onRefresh: () =>
                  ref.read(patientsControllerProvider.notifier).refresh(),
            ),
          ),
          const VerticalDivider(width: 1),
          // Detail panel
          Expanded(
            child: _selectedPatientId != null
                ? PatientDetailPage(patientId: _selectedPatientId!)
                : const EmptyDetailState(),
          ),
        ],
      ),
    );
  }
}

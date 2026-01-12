import 'package:flutter/material.dart';

import '../../data/dummy_patients_data.dart';
import '../pages/patient_detail_page.dart';
import 'empty_detail_state.dart';
import 'patient_list_panel.dart';

/// Two-pane tablet layout for patients.
///
/// Left pane: Patient list with search
/// Right pane: Patient detail or empty state
class TabletPatientsLayout extends StatefulWidget {
  const TabletPatientsLayout({super.key});

  @override
  State<TabletPatientsLayout> createState() => _TabletPatientsLayoutState();
}

class _TabletPatientsLayoutState extends State<TabletPatientsLayout> {
  String? _selectedPatientId;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // List panel
        SizedBox(
          width: 320,
          child: PatientListPanel(
            patients: dummyPatients,
            selectedId: _selectedPatientId,
            onPatientTap: (patient) {
              setState(() {
                _selectedPatientId = patient.id;
              });
            },
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/dummy_patients_data.dart';
import '../widgets/patient_list_panel.dart';

/// Patients list page for mobile view.
///
/// Shows the patient list panel and navigates to detail on tap.
class PatientsListPage extends StatelessWidget {
  const PatientsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return PatientListPanel(
      patients: dummyPatients,
      selectedId: null,
      onPatientTap: (patient) {
        context.push('/patients/${patient.id}');
      },
    );
  }
}

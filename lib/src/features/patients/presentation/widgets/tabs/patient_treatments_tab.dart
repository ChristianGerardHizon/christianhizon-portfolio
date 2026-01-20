import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../treatment_plans/presentation/widgets/sections/patient_treatment_plans_section.dart';
import '../../../domain/patient.dart';
import '../sections/treatments_section.dart';

/// Treatments tab showing patient treatment records and treatment plans.
class PatientTreatmentsTab extends HookConsumerWidget {
  const PatientTreatmentsTab({super.key, required this.patient});

  final Patient patient;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Treatment Plans Section
          PatientTreatmentPlansSection(patientId: patient.id),
          const SizedBox(height: 24),
          // Treatment Records Section
          TreatmentsSection(patientId: patient.id),
        ],
      ),
    );
  }
}

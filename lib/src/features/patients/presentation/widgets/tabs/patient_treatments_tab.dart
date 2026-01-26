import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../domain/patient.dart';
import '../sections/treatments_section.dart';

/// Treatments tab showing patient treatment records.
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
          // Treatment Records Section
          TreatmentsSection(patientId: patient.id),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/features/patient_treatments/domain/patient_treatment.dart';

class PatientTreatmentCard extends StatelessWidget {
  final PatientTreatment treatment;
  final VoidCallback? onTap;

  const PatientTreatmentCard({
    Key? key,
    required this.treatment,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        title: Text(treatment.name.optional()),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}

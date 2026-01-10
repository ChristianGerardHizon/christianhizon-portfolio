import 'package:flutter/material.dart';
import 'package:sannjosevet/src/features/patients/species/domain/patient_species.dart';

class PatientSpeciesTile extends StatelessWidget {
  const PatientSpeciesTile({super.key, required this.patientSpecies});
  final PatientSpecies patientSpecies;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: Text(patientSpecies.name.substring(0, 1)),
      ),
      title: Text(patientSpecies.name),
    );
  }
}

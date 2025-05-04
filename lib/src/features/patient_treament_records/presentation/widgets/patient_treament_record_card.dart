import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/selectable_card.dart';
import 'package:gym_system/src/features/patient_treament_records/domain/patient_treatment_record.dart';

class PatientTreatmentRecordCard extends StatelessWidget {
  const PatientTreatmentRecordCard({
    super.key,
    required this.patientTreatmentRecord,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final PatientTreatmentRecord patientTreatmentRecord;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
          leading: Icon(Icons.abc),
          title: Text(patientTreatmentRecord.id),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(patientTreatmentRecord.id),
            ],
          )),
    );
  }
}

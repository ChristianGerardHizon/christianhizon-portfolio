import 'package:flutter/material.dart';
import 'package:gym_system/src/core/widgets/selectable_card.dart';
import 'package:gym_system/src/features/patient_records/domain/patient_record.dart';

class PatientRecordCard extends StatelessWidget {
  const PatientRecordCard({
    super.key,
    required this.patientRecord,
    required this.onLongPress,
    required this.onTap,
    this.selected = false,
  });

  final Function() onLongPress;
  final Function() onTap;
  final bool selected;
  final PatientRecord patientRecord;

  @override
  Widget build(BuildContext context) {
    return SelectableCard(
      margin: EdgeInsets.all(8),
      onLongPress: onLongPress,
      onTap: onTap,
      selected: selected,
      child: ListTile(
          leading: Icon(Icons.abc),
          title: Text(patientRecord.id),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(patientRecord.id),
            ],
          )),
    );
  }
}

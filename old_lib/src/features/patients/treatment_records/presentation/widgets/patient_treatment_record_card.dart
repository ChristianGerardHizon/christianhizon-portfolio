import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/core/widgets/selectable_card.dart';
import 'package:sannjosevet/src/features/patients/treatment_records/domain/patient_treatment_record.dart';

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
          title: Text(
            (patientTreatmentRecord.date?.fullDateTime).optional(),
            style: Theme.of(context).textTheme.titleMedium,
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(patientTreatmentRecord.expand.treatment.name),
            ],
          )),
    );
  }
}

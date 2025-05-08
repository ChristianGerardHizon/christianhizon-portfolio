import 'package:flutter/material.dart';
import 'package:gym_system/src/core/extensions/date_time_extension.dart';
import 'package:gym_system/src/core/extensions/string.dart';
import 'package:gym_system/src/features/patient_records/domain/patient_record.dart';

class PatientRecordTile extends StatelessWidget {
  const PatientRecordTile({super.key, required this.patientRecord});
  final PatientRecord patientRecord;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(patientRecord.visitDate.fullDateTime.optional()),
      subtitle: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // RichText(
          //   text: TextSpan(
          //     style: Theme.of(context).textTheme.bodySmall,
          //     children: [
          //       TextSpan(
          //         text: patient.expand.breed?.name.optional(),
          //       ),
          //       TextSpan(text: ' - '),
          //       TextSpan(
          //         text: patient.expand.species?.name.optional(),
          //       ),
          //     ],
          //   ),
          // ),
          // Text(
          //   'Owner: ${patient.owner?.optional()}',
          //   style: Theme.of(context).textTheme.bodySmall,
          // ),
        ],
      ),
    );
  }
}

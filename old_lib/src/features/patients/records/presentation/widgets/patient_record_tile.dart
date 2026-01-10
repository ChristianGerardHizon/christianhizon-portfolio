import 'package:flutter/material.dart';
import 'package:sannjosevet/src/core/extensions/date_time_extension.dart';
import 'package:sannjosevet/src/core/extensions/string.dart';
import 'package:sannjosevet/src/features/patients/records/domain/patient_record.dart';

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
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodySmall,
              children: [
                TextSpan(
                  text: 'Diagnosis',
                ),
                TextSpan(text: ': '),
                TextSpan(
                  text: patientRecord.diagnosis.optional(),
                ),
              ],
            ),
          ),

          ///
          RichText(
            text: TextSpan(
              style: Theme.of(context).textTheme.bodySmall,
              children: [
                TextSpan(
                  text: 'Treatment',
                ),
                TextSpan(text: ': '),
                TextSpan(
                  text: patientRecord.treatment.optional(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

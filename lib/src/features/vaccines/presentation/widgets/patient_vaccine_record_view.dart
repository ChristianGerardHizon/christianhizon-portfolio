import 'package:flutter/material.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/features/vaccines/domain/vaccine.dart';
import 'package:gym_system/src/features/vaccines/presentation/controllers/vaccine_record/patient_vaccine_record_controller.dart';
import 'package:gym_system/src/features/vaccines/presentation/sheets/vaccine_record_create_sheet.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientVaccineRecordView extends HookConsumerWidget {
  final Vaccine type;
  final Patient patient;

  const PatientVaccineRecordView(
      {super.key, required this.type, required this.patient});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showCreateSheet(Patient patient, Vaccine type) {
      VaccineRecordCreateSheet.show(context, type: type, formData: {
        VaccineRecordField.patient: patient,
        VaccineRecordField.type: type,
      });
    }

    final state = ref.watch(patientVaccineRecordControllerProvider(
      historyTypeId: type.id,
      patientId: patient.id,
    ));

    return state.when(
      data: (historyList) {
        return Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(historyList.items.length.toString()),
              TextButton(
                onPressed: () => showCreateSheet(patient, type),
                child: Text('Create New ${type.name}'),
              )
            ],
          ),
        );
      },
      error: (error, stackTrace) => Text(error.toString()),
      loading: () => CenteredProgressIndicator(),
    );
  }
}

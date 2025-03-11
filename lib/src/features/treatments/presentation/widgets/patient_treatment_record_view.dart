import 'package:flutter/material.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/features/treatments/domain/treatment.dart';
import 'package:gym_system/src/features/treatments/presentation/controllers/treatment_record/patient_treatment_record_controller.dart';
import 'package:gym_system/src/features/treatments/presentation/sheets/treatment_record_create_sheet.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientTreatmentRecordView extends HookConsumerWidget {
  final Treatment type;
  final Patient patient;

  const PatientTreatmentRecordView(
      {super.key, required this.type, required this.patient});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showCreateSheet(Patient patient, Treatment type) {
      TreatmentRecordCreateSheet.show(context, type: type, formData: {
        TreatmentRecordField.patient: patient,
        TreatmentRecordField.type: type,
      });
    }

    final state = ref.watch(patientTreatmentRecordControllerProvider(
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

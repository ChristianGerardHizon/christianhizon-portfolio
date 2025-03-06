import 'package:flutter/material.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/widgets/center_progress_indicator.dart';
import 'package:gym_system/src/features/history/domain/history_type.dart';
import 'package:gym_system/src/features/history/presentation/controllers/history/patient_history_controller.dart';
import 'package:gym_system/src/features/history/presentation/sheets/history_create_sheet.dart';
import 'package:gym_system/src/features/patients/domain/patient.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PatientHistoryView extends HookConsumerWidget {
  final HistoryType type;
  final Patient patient;

  const PatientHistoryView(
      {super.key, required this.type, required this.patient});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    void showCreateSheet(Patient patient, HistoryType type) {
      HistoryCreateSheet.show(context, type: type, formData: {
        HistoryField.patient: patient,
        HistoryField.type: type,
      });
    }

    final state = ref.watch(patientHistoryControllerProvider(
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

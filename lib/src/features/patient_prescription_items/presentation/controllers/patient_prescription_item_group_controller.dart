import 'package:gym_system/src/core/failures/failure.dart';
import 'package:gym_system/src/core/strings/fields.dart';
import 'package:gym_system/src/core/type_defs/type_defs.dart';
import 'package:gym_system/src/features/patient_prescription_items/data/patient_prescription_item_repository.dart';
import 'package:gym_system/src/features/patient_prescription_items/domain/patient_prescription_item.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_prescription_item_group_controller.g.dart';

class PatientPrescriptionItemGroupState {
  final DateTime date;
  final List<PatientPrescriptionItem> items;

  PatientPrescriptionItemGroupState({required this.date, required this.items});
}

@riverpod
class PatientPrescriptionItemGroupController
    extends _$PatientPrescriptionItemGroupController {
  @override
  Future<List<PatientPrescriptionItemGroupState>> build(String id) async {
    final result = await TaskResult.Do(($) async {
      final list = await $(_getPatientTreatmentRecord(id));
      final result = _buildList(list);

      return result;
    }).run();
    return result.fold(Future.error, (x) => Future.value(x));
  }

  ///
  /// Fetch patients
  ///
  TaskResult<List<PatientPrescriptionItem>> _getPatientTreatmentRecord(
      String id) {
    return TaskResult.tryCatch(() async {
      final repo = ref.read(patientPrescriptionItemRepositoryProvider);
      final result = await repo
          .listAll(
            filter:
                "${PbField.isDeleted} = false && ${PatientPrescriptionItemField.patientRecord} = '$id' ",
          )
          .run();
      return result.fold(Future.error, (x) => Future.value(x));
    }, Failure.handle);
  }

  ///
  /// build list
  ///
  List<PatientPrescriptionItemGroupState> _buildList(
    List<PatientPrescriptionItem> items,
  ) {
    // 1. Group by the date (ignoring time)
    final Map<DateTime, List<PatientPrescriptionItem>> grouped = {};
    for (final item in items) {
      final d = item.date;
      // Normalize to year-month-day
      final dateOnly = DateTime(d.year, d.month, d.day);
      grouped.putIfAbsent(dateOnly, () => []).add(item);
    }

    // 2. Sort the dates (newest first)
    final sortedDates = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

    // 3. Build the list of group states
    return sortedDates
        .map((date) => PatientPrescriptionItemGroupState(
              date: date,
              items: grouped[date]!,
            ))
        .toList();
  }
}

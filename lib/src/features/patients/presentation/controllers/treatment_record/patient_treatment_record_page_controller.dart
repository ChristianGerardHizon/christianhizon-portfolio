import 'package:gym_system/src/features/patients/domain/patient_treatment_record_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_treatment_record_page_controller.g.dart';

class PatientTreatmentRecordsPageState {
  final int page;
  final int pageSize;

  PatientTreatmentRecordsPageState({
    required this.page,
    required this.pageSize,
  });

  PatientTreatmentRecordsPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return PatientTreatmentRecordsPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class PatientTreatmentRecordsPageController
    extends _$PatientTreatmentRecordsPageController {
  @override
  PatientTreatmentRecordsPageState build() {
    return PatientTreatmentRecordsPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class PatientTreatmentRecordSearchController
    extends _$PatientTreatmentRecordSearchController {
  @override
  PatientTreatmentRecordSearch? build() {
    return null;
  }

  void updateParams(PatientTreatmentRecordSearch params) {
    state = params;
  }
}

import 'package:gym_system/src/features/patient_records/domain/patient_record_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_record_page_controller.g.dart';

class PatientRecordsPageState {
  final int page;
  final int pageSize;

  PatientRecordsPageState({
    required this.page,
    required this.pageSize,
  });

  PatientRecordsPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return PatientRecordsPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class PatientRecordsPageController extends _$PatientRecordsPageController {
  @override
  PatientRecordsPageState build() {
    return PatientRecordsPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class PatientRecordSearchController extends _$PatientRecordSearchController {
  @override
  PatientRecordSearch? build() {
    return null;
  }

  void updateParams(PatientRecordSearch params) {
    state = params;
  }
}

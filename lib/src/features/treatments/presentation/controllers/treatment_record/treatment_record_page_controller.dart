import 'package:gym_system/src/features/medical_records/domain/medical_record_search.dart';
import 'package:gym_system/src/features/treatments/domain/treatment_record_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'treatment_record_page_controller.g.dart';

class TreatmentRecordsPageState {
  final int page;
  final int pageSize;

  TreatmentRecordsPageState({
    required this.page,
    required this.pageSize,
  });

  TreatmentRecordsPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return TreatmentRecordsPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class TreatmentRecordsPageController extends _$TreatmentRecordsPageController {
  @override
  TreatmentRecordsPageState build() {
    return TreatmentRecordsPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class TreatmentRecordSearchController
    extends _$TreatmentRecordSearchController {
  @override
  TreatmentRecordSearch? build() {
    return null;
  }

  void updateParams(TreatmentRecordSearch params) {
    state = params;
  }
}

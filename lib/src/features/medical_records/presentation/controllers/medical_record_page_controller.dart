import 'package:gym_system/src/features/medical_records/domain/medical_record_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'medical_record_page_controller.g.dart';

class MedicalRecordsPageState {
  final int page;
  final int pageSize;

  MedicalRecordsPageState({
    required this.page,
    required this.pageSize,
  });

  MedicalRecordsPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return MedicalRecordsPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class MedicalRecordsPageController extends _$MedicalRecordsPageController {
  @override
  MedicalRecordsPageState build() {
    return MedicalRecordsPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class MedicalRecordSearchController extends _$MedicalRecordSearchController {
  @override
  MedicalRecordSearch? build() {
    return null;
  }

  void updateParams(MedicalRecordSearch params) {
    state = params;
  }
}

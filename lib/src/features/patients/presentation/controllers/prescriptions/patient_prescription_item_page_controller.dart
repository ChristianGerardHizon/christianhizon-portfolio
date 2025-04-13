import 'package:gym_system/src/features/patients/domain/prescription/patient_prescription_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_prescription_item_page_controller.g.dart';

class PatientPrescriptionItemPageState {
  final int page;
  final int pageSize;

  PatientPrescriptionItemPageState({
    required this.page,
    required this.pageSize,
  });

  PatientPrescriptionItemPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return PatientPrescriptionItemPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class PatientPrescriptionItemsPageController
    extends _$PatientPrescriptionItemsPageController {
  @override
  PatientPrescriptionItemPageState build() {
    return PatientPrescriptionItemPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class PatientPrescriptionItemSearchController
    extends _$PatientPrescriptionItemSearchController {
  @override
  PatientPrescriptionItemSearch? build() {
    return null;
  }

  void updateParams(PatientPrescriptionItemSearch params) {
    state = params;
  }
}

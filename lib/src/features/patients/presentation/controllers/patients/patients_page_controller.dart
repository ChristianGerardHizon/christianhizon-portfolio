import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patients_page_controller.g.dart';

class PatientsPageState {
  final int page;
  final int pageSize;

  PatientsPageState({
    required this.page,
    required this.pageSize,
  });

  PatientsPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return PatientsPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class PatientSearchController extends _$PatientSearchController {
  @override
  String? build() {
    return null;
  }

  void change(String value) {
    state = value;
  }
}

@riverpod
class PatientsPageController extends _$PatientsPageController {
  @override
  PatientsPageState build() {
    return PatientsPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

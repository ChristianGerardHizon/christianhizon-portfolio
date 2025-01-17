import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'patient_search_controller.g.dart';

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

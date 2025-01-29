import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'staff_search_controller.g.dart';

@riverpod
class StaffSearchController extends _$StaffSearchController {
  @override
  String? build() {
    return null;
  }

  void change(String value) {
    state = value;
  }
}

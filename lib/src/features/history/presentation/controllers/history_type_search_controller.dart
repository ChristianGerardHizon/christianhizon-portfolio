import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_type_search_controller.g.dart';

@riverpod
class HistoryTypeSearchController extends _$HistoryTypeSearchController {
  @override
  String? build() {
    return null;
  }

  void change(String value) {
    state = value;
  }
}

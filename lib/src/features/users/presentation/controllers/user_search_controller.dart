import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_search_controller.g.dart';

@riverpod
class UserSearchController extends _$UserSearchController {
  @override
  String? build() {
    return null;
  }

  void change(String value) {
    state = value;
  }
}

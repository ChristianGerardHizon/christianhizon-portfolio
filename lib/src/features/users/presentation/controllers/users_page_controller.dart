import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users_page_controller.g.dart';

class UsersPageState {
  final int page;
  final int pageSize;

  UsersPageState({
    required this.page,
    required this.pageSize,
  });

  UsersPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return UsersPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class UsersPageController extends _$UsersPageController {
  @override
  UsersPageState build() {
    return UsersPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

import 'package:gym_system/src/features/admins/domain/admin_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'admins_page_controller.g.dart';

class AdminsPageState {
  final int page;
  final int pageSize;

  AdminsPageState({
    required this.page,
    required this.pageSize,
  });

  AdminsPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return AdminsPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class AdminsPageController extends _$AdminsPageController {
  @override
  AdminsPageState build() {
    return AdminsPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class AdminSearchController extends _$AdminSearchController {
  @override
  AdminSearch? build() {
    return null;
  }

  void updateParams(AdminSearch params) {
    state = params;
  }
}

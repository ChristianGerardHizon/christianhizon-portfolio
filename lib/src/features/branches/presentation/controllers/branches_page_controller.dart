import 'package:gym_system/src/features/branches/domain/branch_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'branches_page_controller.g.dart';

class BranchesPageState {
  final int page;
  final int pageSize;

  BranchesPageState({
    required this.page,
    required this.pageSize,
  });

  BranchesPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return BranchesPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class BranchesPageController extends _$BranchesPageController {
  @override
  BranchesPageState build() {
    return BranchesPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class BranchSearchController extends _$BranchSearchController {
  @override
  BranchSearch? build() {
    return null;
  }

  void updateParams(BranchSearch params) {
    state = params;
  }
}

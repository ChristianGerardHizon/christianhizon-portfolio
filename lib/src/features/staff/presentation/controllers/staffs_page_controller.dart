import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'staffs_page_controller.g.dart';

class StaffsPageState {
  final int page;
  final int pageSize;

  StaffsPageState({
    required this.page,
    required this.pageSize,
  });

  StaffsPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return StaffsPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class StaffsPageController extends _$StaffsPageController {
  @override
  StaffsPageState build() {
    return StaffsPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'history_types_page_controller.g.dart';

class HistoryTypesPageState {
  final int page;
  final int pageSize;

  HistoryTypesPageState({
    required this.page,
    required this.pageSize,
  });

  HistoryTypesPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return HistoryTypesPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class HistoryTypesPageController extends _$HistoryTypesPageController {
  @override
  HistoryTypesPageState build() {
    return HistoryTypesPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

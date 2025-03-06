import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'vaccines_page_controller.g.dart';

class VaccinesPageState {
  final int page;
  final int pageSize;

  VaccinesPageState({
    required this.page,
    required this.pageSize,
  });

  VaccinesPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return VaccinesPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class VaccinesPageController extends _$VaccinesPageController {
  @override
  VaccinesPageState build() {
    return VaccinesPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

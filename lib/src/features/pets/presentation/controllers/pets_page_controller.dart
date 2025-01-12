import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pets_page_controller.g.dart';

class PetsPageState {
  final int page;
  final int pageSize;

  PetsPageState({
    required this.page,
    required this.pageSize,
  });

  PetsPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return PetsPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class PetsPageController extends _$PetsPageController {
  @override
  PetsPageState build() {
    return PetsPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

import 'package:gym_system/src/features/prescription/domain/prescription_search.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'prescription_item_page_controller.g.dart';

class PrescriptionItemsPageState {
  final int page;
  final int pageSize;

  PrescriptionItemsPageState({
    required this.page,
    required this.pageSize,
  });

  PrescriptionItemsPageState copyWith({
    int? page,
    int? pageSize,
  }) {
    return PrescriptionItemsPageState(
      page: page ?? this.page,
      pageSize: pageSize ?? this.pageSize,
    );
  }
}

@riverpod
class PrescriptionItemsPageController
    extends _$PrescriptionItemsPageController {
  @override
  PrescriptionItemsPageState build() {
    return PrescriptionItemsPageState(page: 1, pageSize: 50);
  }

  changePage(int page) {
    state = state.copyWith(page: page);
  }
}

@riverpod
class PrescriptionItemSearchController
    extends _$PrescriptionItemSearchController {
  @override
  PrescriptionItemSearch? build() {
    return null;
  }

  void updateParams(PrescriptionItemSearch params) {
    state = params;
  }
}

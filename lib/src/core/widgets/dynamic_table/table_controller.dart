import 'package:gym_system/src/core/widgets/dynamic_table/table_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'table_controller.g.dart';

@riverpod
class TableController extends _$TableController {
  @override
  TableState build(String tableKey) {
    return TableState(
      key: tableKey,
      isMobile: false,
      selected: [],
      hasNext: true,
      isLoading: true,
      page: 1,
      pageSize: 10,
      totalItems: 0,
      totalPages: 0,
      sort: null,
      filter: '',
    );
  }

  void changePage(int page) {
    state = state.copyWith(page: page, selected: []);
  }

  void changePageSize(int size) {
    state = state.copyWith(pageSize: size, selected: []);
  }

  void clearSelection() {
    state = state.copyWith(selected: []);
  }

  void toggleRow(int index) {
    if (state.selected.contains(index)) {
      state = state.copyWith(selected: [...state.selected]..remove(index));
    } else {
      state = state.copyWith(selected: [...state.selected]..add(index));
    }
  }

  void selectAll() {
    state = state.copyWith(
        selected: List.generate(state.totalItems, (index) => index));
  }

  void startLoading() {
    state = state.copyWith(isLoading: true);
  }

  void stopLoading() {
    state = state.copyWith(isLoading: false);
  }

  void fetchSuccess({
    required int totalPages,
    required int totalItems,
    required bool hasNext,
  }) {
    state = state.copyWith(
      isLoading: false,
      totalPages: totalPages,
      totalItems: totalItems,
      hasNext: hasNext,
      page: state.page,
    );
  }

  void update(TableState newState) {
    // state = newState;
  }

  void changeFilter(
    String filter,
  ) {
    // state = state.copyWith(filter: filter);
  }

  toogleTableSort(String key) {
    // /// if sortKey is null create set one with asc as true
    // if (state.sort?.key == null) {
    //   state.copyWith(sort: TableSort(key: key, isAscending: true));
    //   return;
    // }

    // /// if key is the same as current key
    // /// reverse the current sort asc
    // if (state.sort!.key == key) {
    //   state = state.copyWith(sort: state.sort!.reverse());
    //   return;
    // }

    // /// if key is not the same as current key
    // /// set the new sort key as true
    // state = state.copyWith(sort: TableSort(key: key, isAscending: true));

    // /// if the key is descending
    // /// remove the current sort key
    // if (!(state.sort!.isAscending)) {
    //   state = state.copyWith(sort: null);
    // }
  }
}

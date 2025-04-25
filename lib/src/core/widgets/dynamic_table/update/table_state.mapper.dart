// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'table_state.dart';

class TableStateMapper extends ClassMapperBase<TableState> {
  TableStateMapper._();

  static TableStateMapper? _instance;
  static TableStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableStateMapper._());
      TableSortMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'TableState';
  @override
  Function get typeFactory => <T>(f) => f<TableState<T>>();

  static int _$page(TableState v) => v.page;
  static const Field<TableState, int> _f$page =
      Field('page', _$page, opt: true, def: 1);
  static int _$pageSize(TableState v) => v.pageSize;
  static const Field<TableState, int> _f$pageSize =
      Field('pageSize', _$pageSize, opt: true, def: 10);
  static int _$totalItems(TableState v) => v.totalItems;
  static const Field<TableState, int> _f$totalItems =
      Field('totalItems', _$totalItems, opt: true, def: 0);
  static int _$totalPages(TableState v) => v.totalPages;
  static const Field<TableState, int> _f$totalPages =
      Field('totalPages', _$totalPages, opt: true, def: 1);
  static bool _$hasNext(TableState v) => v.hasNext;
  static const Field<TableState, bool> _f$hasNext =
      Field('hasNext', _$hasNext, opt: true, def: false);
  static bool _$isLoading(TableState v) => v.isLoading;
  static const Field<TableState, bool> _f$isLoading =
      Field('isLoading', _$isLoading, opt: true, def: false);
  static List<int> _$selected(TableState v) => v.selected;
  static const Field<TableState, List<int>> _f$selected =
      Field('selected', _$selected, opt: true, def: const []);
  static bool _$isMobile(TableState v) => v.isMobile;
  static const Field<TableState, bool> _f$isMobile =
      Field('isMobile', _$isMobile, opt: true, def: false);
  static TableSort? _$sort(TableState v) => v.sort;
  static const Field<TableState, TableSort> _f$sort =
      Field('sort', _$sort, opt: true);
  static String? _$filter(TableState v) => v.filter;
  static const Field<TableState, String> _f$filter =
      Field('filter', _$filter, opt: true);

  @override
  final MappableFields<TableState> fields = const {
    #page: _f$page,
    #pageSize: _f$pageSize,
    #totalItems: _f$totalItems,
    #totalPages: _f$totalPages,
    #hasNext: _f$hasNext,
    #isLoading: _f$isLoading,
    #selected: _f$selected,
    #isMobile: _f$isMobile,
    #sort: _f$sort,
    #filter: _f$filter,
  };

  static TableState<T> _instantiate<T>(DecodingData data) {
    return TableState(
        page: data.dec(_f$page),
        pageSize: data.dec(_f$pageSize),
        totalItems: data.dec(_f$totalItems),
        totalPages: data.dec(_f$totalPages),
        hasNext: data.dec(_f$hasNext),
        isLoading: data.dec(_f$isLoading),
        selected: data.dec(_f$selected),
        isMobile: data.dec(_f$isMobile),
        sort: data.dec(_f$sort),
        filter: data.dec(_f$filter));
  }

  @override
  final Function instantiate = _instantiate;

  static TableState<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableState<T>>(map);
  }

  static TableState<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<TableState<T>>(json);
  }
}

mixin TableStateMappable<T> {
  String toJson() {
    return TableStateMapper.ensureInitialized()
        .encodeJson<TableState<T>>(this as TableState<T>);
  }

  Map<String, dynamic> toMap() {
    return TableStateMapper.ensureInitialized()
        .encodeMap<TableState<T>>(this as TableState<T>);
  }

  TableStateCopyWith<TableState<T>, TableState<T>, TableState<T>, T>
      get copyWith => _TableStateCopyWithImpl<TableState<T>, TableState<T>, T>(
          this as TableState<T>, $identity, $identity);
  @override
  String toString() {
    return TableStateMapper.ensureInitialized()
        .stringifyValue(this as TableState<T>);
  }

  @override
  bool operator ==(Object other) {
    return TableStateMapper.ensureInitialized()
        .equalsValue(this as TableState<T>, other);
  }

  @override
  int get hashCode {
    return TableStateMapper.ensureInitialized()
        .hashValue(this as TableState<T>);
  }
}

extension TableStateValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, TableState<T>, $Out> {
  TableStateCopyWith<$R, TableState<T>, $Out, T> get $asTableState =>
      $base.as((v, t, t2) => _TableStateCopyWithImpl<$R, $Out, T>(v, t, t2));
}

abstract class TableStateCopyWith<$R, $In extends TableState<T>, $Out, T>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get selected;
  TableSortCopyWith<$R, TableSort, TableSort>? get sort;
  $R call(
      {int? page,
      int? pageSize,
      int? totalItems,
      int? totalPages,
      bool? hasNext,
      bool? isLoading,
      List<int>? selected,
      bool? isMobile,
      TableSort? sort,
      String? filter});
  TableStateCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TableStateCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, TableState<T>, $Out>
    implements TableStateCopyWith<$R, TableState<T>, $Out, T> {
  _TableStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableState> $mapper =
      TableStateMapper.ensureInitialized();
  @override
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get selected =>
      ListCopyWith($value.selected, (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(selected: v));
  @override
  TableSortCopyWith<$R, TableSort, TableSort>? get sort =>
      $value.sort?.copyWith.$chain((v) => call(sort: v));
  @override
  $R call(
          {int? page,
          int? pageSize,
          int? totalItems,
          int? totalPages,
          bool? hasNext,
          bool? isLoading,
          List<int>? selected,
          bool? isMobile,
          Object? sort = $none,
          Object? filter = $none}) =>
      $apply(FieldCopyWithData({
        if (page != null) #page: page,
        if (pageSize != null) #pageSize: pageSize,
        if (totalItems != null) #totalItems: totalItems,
        if (totalPages != null) #totalPages: totalPages,
        if (hasNext != null) #hasNext: hasNext,
        if (isLoading != null) #isLoading: isLoading,
        if (selected != null) #selected: selected,
        if (isMobile != null) #isMobile: isMobile,
        if (sort != $none) #sort: sort,
        if (filter != $none) #filter: filter
      }));
  @override
  TableState<T> $make(CopyWithData data) => TableState(
      page: data.get(#page, or: $value.page),
      pageSize: data.get(#pageSize, or: $value.pageSize),
      totalItems: data.get(#totalItems, or: $value.totalItems),
      totalPages: data.get(#totalPages, or: $value.totalPages),
      hasNext: data.get(#hasNext, or: $value.hasNext),
      isLoading: data.get(#isLoading, or: $value.isLoading),
      selected: data.get(#selected, or: $value.selected),
      isMobile: data.get(#isMobile, or: $value.isMobile),
      sort: data.get(#sort, or: $value.sort),
      filter: data.get(#filter, or: $value.filter));

  @override
  TableStateCopyWith<$R2, TableState<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableStateCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}

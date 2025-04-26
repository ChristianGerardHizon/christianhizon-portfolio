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

  static String _$key(TableState v) => v.key;
  static const Field<TableState, String> _f$key = Field('key', _$key);
  static int _$page(TableState v) => v.page;
  static const Field<TableState, int> _f$page = Field('page', _$page);
  static int _$pageSize(TableState v) => v.pageSize;
  static const Field<TableState, int> _f$pageSize =
      Field('pageSize', _$pageSize);
  static int _$totalItems(TableState v) => v.totalItems;
  static const Field<TableState, int> _f$totalItems =
      Field('totalItems', _$totalItems);
  static int _$totalPages(TableState v) => v.totalPages;
  static const Field<TableState, int> _f$totalPages =
      Field('totalPages', _$totalPages);
  static bool _$hasNext(TableState v) => v.hasNext;
  static const Field<TableState, bool> _f$hasNext = Field('hasNext', _$hasNext);
  static bool _$isLoading(TableState v) => v.isLoading;
  static const Field<TableState, bool> _f$isLoading =
      Field('isLoading', _$isLoading);
  static List<int> _$selected(TableState v) => v.selected;
  static const Field<TableState, List<int>> _f$selected =
      Field('selected', _$selected);
  static bool _$isMobile(TableState v) => v.isMobile;
  static const Field<TableState, bool> _f$isMobile =
      Field('isMobile', _$isMobile);
  static TableSort? _$sort(TableState v) => v.sort;
  static const Field<TableState, TableSort> _f$sort =
      Field('sort', _$sort, opt: true);
  static String? _$filter(TableState v) => v.filter;
  static const Field<TableState, String> _f$filter =
      Field('filter', _$filter, opt: true);

  @override
  final MappableFields<TableState> fields = const {
    #key: _f$key,
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

  static TableState _instantiate(DecodingData data) {
    return TableState(
        key: data.dec(_f$key),
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

  static TableState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableState>(map);
  }

  static TableState fromJson(String json) {
    return ensureInitialized().decodeJson<TableState>(json);
  }
}

mixin TableStateMappable {
  String toJson() {
    return TableStateMapper.ensureInitialized()
        .encodeJson<TableState>(this as TableState);
  }

  Map<String, dynamic> toMap() {
    return TableStateMapper.ensureInitialized()
        .encodeMap<TableState>(this as TableState);
  }

  TableStateCopyWith<TableState, TableState, TableState> get copyWith =>
      _TableStateCopyWithImpl<TableState, TableState>(
          this as TableState, $identity, $identity);
  @override
  String toString() {
    return TableStateMapper.ensureInitialized()
        .stringifyValue(this as TableState);
  }

  @override
  bool operator ==(Object other) {
    return TableStateMapper.ensureInitialized()
        .equalsValue(this as TableState, other);
  }

  @override
  int get hashCode {
    return TableStateMapper.ensureInitialized().hashValue(this as TableState);
  }
}

extension TableStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, TableState, $Out> {
  TableStateCopyWith<$R, TableState, $Out> get $asTableState =>
      $base.as((v, t, t2) => _TableStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TableStateCopyWith<$R, $In extends TableState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, int, ObjectCopyWith<$R, int, int>> get selected;
  TableSortCopyWith<$R, TableSort, TableSort>? get sort;
  $R call(
      {String? key,
      int? page,
      int? pageSize,
      int? totalItems,
      int? totalPages,
      bool? hasNext,
      bool? isLoading,
      List<int>? selected,
      bool? isMobile,
      TableSort? sort,
      String? filter});
  TableStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TableStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableState, $Out>
    implements TableStateCopyWith<$R, TableState, $Out> {
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
          {String? key,
          int? page,
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
        if (key != null) #key: key,
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
  TableState $make(CopyWithData data) => TableState(
      key: data.get(#key, or: $value.key),
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
  TableStateCopyWith<$R2, TableState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

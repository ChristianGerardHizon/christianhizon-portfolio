// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'table_sort.dart';

class TableSortMapper extends ClassMapperBase<TableSort> {
  TableSortMapper._();

  static TableSortMapper? _instance;
  static TableSortMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableSortMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TableSort';

  static String _$key(TableSort v) => v.key;
  static const Field<TableSort, String> _f$key = Field('key', _$key);
  static bool _$isAscending(TableSort v) => v.isAscending;
  static const Field<TableSort, bool> _f$isAscending =
      Field('isAscending', _$isAscending);

  @override
  final MappableFields<TableSort> fields = const {
    #key: _f$key,
    #isAscending: _f$isAscending,
  };

  static TableSort _instantiate(DecodingData data) {
    return TableSort(
        key: data.dec(_f$key), isAscending: data.dec(_f$isAscending));
  }

  @override
  final Function instantiate = _instantiate;

  static TableSort fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableSort>(map);
  }

  static TableSort fromJson(String json) {
    return ensureInitialized().decodeJson<TableSort>(json);
  }
}

mixin TableSortMappable {
  String toJson() {
    return TableSortMapper.ensureInitialized()
        .encodeJson<TableSort>(this as TableSort);
  }

  Map<String, dynamic> toMap() {
    return TableSortMapper.ensureInitialized()
        .encodeMap<TableSort>(this as TableSort);
  }

  TableSortCopyWith<TableSort, TableSort, TableSort> get copyWith =>
      _TableSortCopyWithImpl<TableSort, TableSort>(
          this as TableSort, $identity, $identity);
  @override
  String toString() {
    return TableSortMapper.ensureInitialized()
        .stringifyValue(this as TableSort);
  }

  @override
  bool operator ==(Object other) {
    return TableSortMapper.ensureInitialized()
        .equalsValue(this as TableSort, other);
  }

  @override
  int get hashCode {
    return TableSortMapper.ensureInitialized().hashValue(this as TableSort);
  }
}

extension TableSortValueCopy<$R, $Out> on ObjectCopyWith<$R, TableSort, $Out> {
  TableSortCopyWith<$R, TableSort, $Out> get $asTableSort =>
      $base.as((v, t, t2) => _TableSortCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TableSortCopyWith<$R, $In extends TableSort, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? key, bool? isAscending});
  TableSortCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TableSortCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, TableSort, $Out>
    implements TableSortCopyWith<$R, TableSort, $Out> {
  _TableSortCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableSort> $mapper =
      TableSortMapper.ensureInitialized();
  @override
  $R call({String? key, bool? isAscending}) => $apply(FieldCopyWithData({
        if (key != null) #key: key,
        if (isAscending != null) #isAscending: isAscending
      }));
  @override
  TableSort $make(CopyWithData data) => TableSort(
      key: data.get(#key, or: $value.key),
      isAscending: data.get(#isAscending, or: $value.isAscending));

  @override
  TableSortCopyWith<$R2, TableSort, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableSortCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

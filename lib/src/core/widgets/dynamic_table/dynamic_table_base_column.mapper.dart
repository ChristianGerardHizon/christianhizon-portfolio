// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dynamic_table_base_column.dart';

class DynamicTableBaseColumnMapper
    extends ClassMapperBase<DynamicTableBaseColumn> {
  DynamicTableBaseColumnMapper._();

  static DynamicTableBaseColumnMapper? _instance;
  static DynamicTableBaseColumnMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DynamicTableBaseColumnMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DynamicTableBaseColumn';

  static double _$width(DynamicTableBaseColumn v) => v.width;
  static const Field<DynamicTableBaseColumn, double> _f$width =
      Field('width', _$width);
  static String? _$key(DynamicTableBaseColumn v) => v.key;
  static const Field<DynamicTableBaseColumn, String> _f$key =
      Field('key', _$key, opt: true);
  static int _$freezePriority(DynamicTableBaseColumn v) => v.freezePriority;
  static const Field<DynamicTableBaseColumn, int> _f$freezePriority =
      Field('freezePriority', _$freezePriority, opt: true, def: 0);
  static bool _$sticky(DynamicTableBaseColumn v) => v.sticky;
  static const Field<DynamicTableBaseColumn, bool> _f$sticky =
      Field('sticky', _$sticky, opt: true, def: false);
  static int _$flex(DynamicTableBaseColumn v) => v.flex;
  static const Field<DynamicTableBaseColumn, int> _f$flex =
      Field('flex', _$flex, opt: true, def: 0);
  static double _$translation(DynamicTableBaseColumn v) => v.translation;
  static const Field<DynamicTableBaseColumn, double> _f$translation =
      Field('translation', _$translation, opt: true, def: 0);
  static double? _$minResizeWidth(DynamicTableBaseColumn v) => v.minResizeWidth;
  static const Field<DynamicTableBaseColumn, double> _f$minResizeWidth =
      Field('minResizeWidth', _$minResizeWidth, opt: true);
  static double? _$maxResizeWidth(DynamicTableBaseColumn v) => v.maxResizeWidth;
  static const Field<DynamicTableBaseColumn, double> _f$maxResizeWidth =
      Field('maxResizeWidth', _$maxResizeWidth, opt: true);
  static Function _$builder(DynamicTableBaseColumn v) =>
      (v as dynamic).builder as Function;
  static dynamic _arg$builder(f) => f<Widget Function(BuildContext, int)>();
  static const Field<DynamicTableBaseColumn, Function> _f$builder =
      Field('builder', _$builder, arg: _arg$builder);

  @override
  final MappableFields<DynamicTableBaseColumn> fields = const {
    #width: _f$width,
    #key: _f$key,
    #freezePriority: _f$freezePriority,
    #sticky: _f$sticky,
    #flex: _f$flex,
    #translation: _f$translation,
    #minResizeWidth: _f$minResizeWidth,
    #maxResizeWidth: _f$maxResizeWidth,
    #builder: _f$builder,
  };
  @override
  final bool ignoreNull = true;

  static DynamicTableBaseColumn _instantiate(DecodingData data) {
    return DynamicTableBaseColumn(
        width: data.dec(_f$width),
        key: data.dec(_f$key),
        freezePriority: data.dec(_f$freezePriority),
        sticky: data.dec(_f$sticky),
        flex: data.dec(_f$flex),
        translation: data.dec(_f$translation),
        minResizeWidth: data.dec(_f$minResizeWidth),
        maxResizeWidth: data.dec(_f$maxResizeWidth),
        builder: data.dec(_f$builder));
  }

  @override
  final Function instantiate = _instantiate;

  static DynamicTableBaseColumn fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DynamicTableBaseColumn>(map);
  }

  static DynamicTableBaseColumn fromJson(String json) {
    return ensureInitialized().decodeJson<DynamicTableBaseColumn>(json);
  }
}

mixin DynamicTableBaseColumnMappable {
  String toJson() {
    return DynamicTableBaseColumnMapper.ensureInitialized()
        .encodeJson<DynamicTableBaseColumn>(this as DynamicTableBaseColumn);
  }

  Map<String, dynamic> toMap() {
    return DynamicTableBaseColumnMapper.ensureInitialized()
        .encodeMap<DynamicTableBaseColumn>(this as DynamicTableBaseColumn);
  }

  DynamicTableBaseColumnCopyWith<DynamicTableBaseColumn, DynamicTableBaseColumn,
          DynamicTableBaseColumn>
      get copyWith => _DynamicTableBaseColumnCopyWithImpl<
              DynamicTableBaseColumn, DynamicTableBaseColumn>(
          this as DynamicTableBaseColumn, $identity, $identity);
  @override
  String toString() {
    return DynamicTableBaseColumnMapper.ensureInitialized()
        .stringifyValue(this as DynamicTableBaseColumn);
  }

  @override
  bool operator ==(Object other) {
    return DynamicTableBaseColumnMapper.ensureInitialized()
        .equalsValue(this as DynamicTableBaseColumn, other);
  }

  @override
  int get hashCode {
    return DynamicTableBaseColumnMapper.ensureInitialized()
        .hashValue(this as DynamicTableBaseColumn);
  }
}

extension DynamicTableBaseColumnValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DynamicTableBaseColumn, $Out> {
  DynamicTableBaseColumnCopyWith<$R, DynamicTableBaseColumn, $Out>
      get $asDynamicTableBaseColumn => $base.as((v, t, t2) =>
          _DynamicTableBaseColumnCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DynamicTableBaseColumnCopyWith<
    $R,
    $In extends DynamicTableBaseColumn,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {double? width,
      String? key,
      int? freezePriority,
      bool? sticky,
      int? flex,
      double? translation,
      double? minResizeWidth,
      double? maxResizeWidth,
      Widget Function(BuildContext, int)? builder});
  DynamicTableBaseColumnCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DynamicTableBaseColumnCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DynamicTableBaseColumn, $Out>
    implements
        DynamicTableBaseColumnCopyWith<$R, DynamicTableBaseColumn, $Out> {
  _DynamicTableBaseColumnCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DynamicTableBaseColumn> $mapper =
      DynamicTableBaseColumnMapper.ensureInitialized();
  @override
  $R call(
          {double? width,
          Object? key = $none,
          int? freezePriority,
          bool? sticky,
          int? flex,
          double? translation,
          Object? minResizeWidth = $none,
          Object? maxResizeWidth = $none,
          Widget Function(BuildContext, int)? builder}) =>
      $apply(FieldCopyWithData({
        if (width != null) #width: width,
        if (key != $none) #key: key,
        if (freezePriority != null) #freezePriority: freezePriority,
        if (sticky != null) #sticky: sticky,
        if (flex != null) #flex: flex,
        if (translation != null) #translation: translation,
        if (minResizeWidth != $none) #minResizeWidth: minResizeWidth,
        if (maxResizeWidth != $none) #maxResizeWidth: maxResizeWidth,
        if (builder != null) #builder: builder
      }));
  @override
  DynamicTableBaseColumn $make(CopyWithData data) => DynamicTableBaseColumn(
      width: data.get(#width, or: $value.width),
      key: data.get(#key, or: $value.key),
      freezePriority: data.get(#freezePriority, or: $value.freezePriority),
      sticky: data.get(#sticky, or: $value.sticky),
      flex: data.get(#flex, or: $value.flex),
      translation: data.get(#translation, or: $value.translation),
      minResizeWidth: data.get(#minResizeWidth, or: $value.minResizeWidth),
      maxResizeWidth: data.get(#maxResizeWidth, or: $value.maxResizeWidth),
      builder: data.get(#builder, or: $value.builder));

  @override
  DynamicTableBaseColumnCopyWith<$R2, DynamicTableBaseColumn, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DynamicTableBaseColumnCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

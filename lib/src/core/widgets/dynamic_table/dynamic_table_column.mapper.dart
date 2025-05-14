// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'dynamic_table_column.dart';

class DynamicTableColumnMapper extends ClassMapperBase<DynamicTableColumn> {
  DynamicTableColumnMapper._();

  static DynamicTableColumnMapper? _instance;
  static DynamicTableColumnMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DynamicTableColumnMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DynamicTableColumn';
  @override
  Function get typeFactory => <T>(f) => f<DynamicTableColumn<T>>();

  static String _$header(DynamicTableColumn v) => v.header;
  static const Field<DynamicTableColumn, String> _f$header =
      Field('header', _$header);
  static String? _$sortKey(DynamicTableColumn v) => v.sortKey;
  static const Field<DynamicTableColumn, String> _f$sortKey =
      Field('sortKey', _$sortKey, opt: true);
  static Alignment? _$alignment(DynamicTableColumn v) => v.alignment;
  static const Field<DynamicTableColumn, Alignment> _f$alignment =
      Field('alignment', _$alignment, opt: true);
  static EdgeInsets? _$padding(DynamicTableColumn v) => v.padding;
  static const Field<DynamicTableColumn, EdgeInsets> _f$padding =
      Field('padding', _$padding, opt: true);
  static TextStyle? _$style(DynamicTableColumn v) => v.style;
  static const Field<DynamicTableColumn, TextStyle> _f$style =
      Field('style', _$style, opt: true);
  static double _$width(DynamicTableColumn v) => v.width;
  static const Field<DynamicTableColumn, double> _f$width =
      Field('width', _$width, opt: true, def: 100);
  static int _$flex(DynamicTableColumn v) => v.flex;
  static const Field<DynamicTableColumn, int> _f$flex =
      Field('flex', _$flex, opt: true, def: 0);
  static double _$translation(DynamicTableColumn v) => v.translation;
  static const Field<DynamicTableColumn, double> _f$translation =
      Field('translation', _$translation, opt: true, def: 0);
  static double? _$minResizeWidth(DynamicTableColumn v) => v.minResizeWidth;
  static const Field<DynamicTableColumn, double> _f$minResizeWidth =
      Field('minResizeWidth', _$minResizeWidth, opt: true);
  static double? _$maxResizeWidth(DynamicTableColumn v) => v.maxResizeWidth;
  static const Field<DynamicTableColumn, double> _f$maxResizeWidth =
      Field('maxResizeWidth', _$maxResizeWidth, opt: true);
  static Function _$builder(DynamicTableColumn v) =>
      (v as dynamic).builder as Function;
  static dynamic _arg$builder<T>(f) =>
      f<Widget Function(BuildContext, T, int, int)>();
  static const Field<DynamicTableColumn, Function> _f$builder =
      Field('builder', _$builder, opt: true, arg: _arg$builder);

  @override
  final MappableFields<DynamicTableColumn> fields = const {
    #header: _f$header,
    #sortKey: _f$sortKey,
    #alignment: _f$alignment,
    #padding: _f$padding,
    #style: _f$style,
    #width: _f$width,
    #flex: _f$flex,
    #translation: _f$translation,
    #minResizeWidth: _f$minResizeWidth,
    #maxResizeWidth: _f$maxResizeWidth,
    #builder: _f$builder,
  };

  static DynamicTableColumn<T> _instantiate<T>(DecodingData data) {
    return DynamicTableColumn(
        header: data.dec(_f$header),
        sortKey: data.dec(_f$sortKey),
        alignment: data.dec(_f$alignment),
        padding: data.dec(_f$padding),
        style: data.dec(_f$style),
        width: data.dec(_f$width),
        flex: data.dec(_f$flex),
        translation: data.dec(_f$translation),
        minResizeWidth: data.dec(_f$minResizeWidth),
        maxResizeWidth: data.dec(_f$maxResizeWidth),
        builder: data.dec(_f$builder));
  }

  @override
  final Function instantiate = _instantiate;

  static DynamicTableColumn<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DynamicTableColumn<T>>(map);
  }

  static DynamicTableColumn<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<DynamicTableColumn<T>>(json);
  }
}

mixin DynamicTableColumnMappable<T> {
  String toJson() {
    return DynamicTableColumnMapper.ensureInitialized()
        .encodeJson<DynamicTableColumn<T>>(this as DynamicTableColumn<T>);
  }

  Map<String, dynamic> toMap() {
    return DynamicTableColumnMapper.ensureInitialized()
        .encodeMap<DynamicTableColumn<T>>(this as DynamicTableColumn<T>);
  }

  DynamicTableColumnCopyWith<DynamicTableColumn<T>, DynamicTableColumn<T>,
          DynamicTableColumn<T>, T>
      get copyWith => _DynamicTableColumnCopyWithImpl<
          DynamicTableColumn<T>,
          DynamicTableColumn<T>,
          T>(this as DynamicTableColumn<T>, $identity, $identity);
  @override
  String toString() {
    return DynamicTableColumnMapper.ensureInitialized()
        .stringifyValue(this as DynamicTableColumn<T>);
  }

  @override
  bool operator ==(Object other) {
    return DynamicTableColumnMapper.ensureInitialized()
        .equalsValue(this as DynamicTableColumn<T>, other);
  }

  @override
  int get hashCode {
    return DynamicTableColumnMapper.ensureInitialized()
        .hashValue(this as DynamicTableColumn<T>);
  }
}

extension DynamicTableColumnValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, DynamicTableColumn<T>, $Out> {
  DynamicTableColumnCopyWith<$R, DynamicTableColumn<T>, $Out, T>
      get $asDynamicTableColumn => $base.as(
          (v, t, t2) => _DynamicTableColumnCopyWithImpl<$R, $Out, T>(v, t, t2));
}

abstract class DynamicTableColumnCopyWith<$R, $In extends DynamicTableColumn<T>,
    $Out, T> implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? header,
      String? sortKey,
      Alignment? alignment,
      EdgeInsets? padding,
      TextStyle? style,
      double? width,
      int? flex,
      double? translation,
      double? minResizeWidth,
      double? maxResizeWidth,
      Widget Function(BuildContext, T, int, int)? builder});
  DynamicTableColumnCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _DynamicTableColumnCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, DynamicTableColumn<T>, $Out>
    implements DynamicTableColumnCopyWith<$R, DynamicTableColumn<T>, $Out, T> {
  _DynamicTableColumnCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DynamicTableColumn> $mapper =
      DynamicTableColumnMapper.ensureInitialized();
  @override
  $R call(
          {String? header,
          Object? sortKey = $none,
          Object? alignment = $none,
          Object? padding = $none,
          Object? style = $none,
          double? width,
          int? flex,
          double? translation,
          Object? minResizeWidth = $none,
          Object? maxResizeWidth = $none,
          Object? builder = $none}) =>
      $apply(FieldCopyWithData({
        if (header != null) #header: header,
        if (sortKey != $none) #sortKey: sortKey,
        if (alignment != $none) #alignment: alignment,
        if (padding != $none) #padding: padding,
        if (style != $none) #style: style,
        if (width != null) #width: width,
        if (flex != null) #flex: flex,
        if (translation != null) #translation: translation,
        if (minResizeWidth != $none) #minResizeWidth: minResizeWidth,
        if (maxResizeWidth != $none) #maxResizeWidth: maxResizeWidth,
        if (builder != $none) #builder: builder
      }));
  @override
  DynamicTableColumn<T> $make(CopyWithData data) => DynamicTableColumn(
      header: data.get(#header, or: $value.header),
      sortKey: data.get(#sortKey, or: $value.sortKey),
      alignment: data.get(#alignment, or: $value.alignment),
      padding: data.get(#padding, or: $value.padding),
      style: data.get(#style, or: $value.style),
      width: data.get(#width, or: $value.width),
      flex: data.get(#flex, or: $value.flex),
      translation: data.get(#translation, or: $value.translation),
      minResizeWidth: data.get(#minResizeWidth, or: $value.minResizeWidth),
      maxResizeWidth: data.get(#maxResizeWidth, or: $value.maxResizeWidth),
      builder: data.get(#builder, or: $value.builder));

  @override
  DynamicTableColumnCopyWith<$R2, DynamicTableColumn<T>, $Out2, T>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _DynamicTableColumnCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}

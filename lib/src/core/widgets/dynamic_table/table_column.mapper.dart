// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'table_column.dart';

class TableColumnMapper extends ClassMapperBase<TableColumn> {
  TableColumnMapper._();

  static TableColumnMapper? _instance;
  static TableColumnMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TableColumnMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'TableColumn';
  @override
  Function get typeFactory => <T>(f) => f<TableColumn<T>>();

  static String _$header(TableColumn v) => v.header;
  static const Field<TableColumn, String> _f$header = Field('header', _$header);
  static String? _$sortKey(TableColumn v) => v.sortKey;
  static const Field<TableColumn, String> _f$sortKey =
      Field('sortKey', _$sortKey, opt: true);
  static Alignment? _$alignment(TableColumn v) => v.alignment;
  static const Field<TableColumn, Alignment> _f$alignment =
      Field('alignment', _$alignment, opt: true);
  static EdgeInsets? _$padding(TableColumn v) => v.padding;
  static const Field<TableColumn, EdgeInsets> _f$padding =
      Field('padding', _$padding, opt: true);
  static TextStyle? _$style(TableColumn v) => v.style;
  static const Field<TableColumn, TextStyle> _f$style =
      Field('style', _$style, opt: true);
  static double _$width(TableColumn v) => v.width;
  static const Field<TableColumn, double> _f$width =
      Field('width', _$width, opt: true, def: 100);
  static int _$flex(TableColumn v) => v.flex;
  static const Field<TableColumn, int> _f$flex =
      Field('flex', _$flex, opt: true, def: 0);
  static double _$translation(TableColumn v) => v.translation;
  static const Field<TableColumn, double> _f$translation =
      Field('translation', _$translation, opt: true, def: 0);
  static double? _$minResizeWidth(TableColumn v) => v.minResizeWidth;
  static const Field<TableColumn, double> _f$minResizeWidth =
      Field('minResizeWidth', _$minResizeWidth, opt: true);
  static double? _$maxResizeWidth(TableColumn v) => v.maxResizeWidth;
  static const Field<TableColumn, double> _f$maxResizeWidth =
      Field('maxResizeWidth', _$maxResizeWidth, opt: true);
  static Function _$builder(TableColumn v) =>
      (v as dynamic).builder as Function;
  static dynamic _arg$builder<T>(f) =>
      f<Widget Function(BuildContext, T, int, int)>();
  static const Field<TableColumn, Function> _f$builder =
      Field('builder', _$builder, opt: true, arg: _arg$builder);

  @override
  final MappableFields<TableColumn> fields = const {
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

  static TableColumn<T> _instantiate<T>(DecodingData data) {
    return TableColumn(
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

  static TableColumn<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<TableColumn<T>>(map);
  }

  static TableColumn<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<TableColumn<T>>(json);
  }
}

mixin TableColumnMappable<T> {
  String toJson() {
    return TableColumnMapper.ensureInitialized()
        .encodeJson<TableColumn<T>>(this as TableColumn<T>);
  }

  Map<String, dynamic> toMap() {
    return TableColumnMapper.ensureInitialized()
        .encodeMap<TableColumn<T>>(this as TableColumn<T>);
  }

  TableColumnCopyWith<TableColumn<T>, TableColumn<T>, TableColumn<T>, T>
      get copyWith =>
          _TableColumnCopyWithImpl<TableColumn<T>, TableColumn<T>, T>(
              this as TableColumn<T>, $identity, $identity);
  @override
  String toString() {
    return TableColumnMapper.ensureInitialized()
        .stringifyValue(this as TableColumn<T>);
  }

  @override
  bool operator ==(Object other) {
    return TableColumnMapper.ensureInitialized()
        .equalsValue(this as TableColumn<T>, other);
  }

  @override
  int get hashCode {
    return TableColumnMapper.ensureInitialized()
        .hashValue(this as TableColumn<T>);
  }
}

extension TableColumnValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, TableColumn<T>, $Out> {
  TableColumnCopyWith<$R, TableColumn<T>, $Out, T> get $asTableColumn =>
      $base.as((v, t, t2) => _TableColumnCopyWithImpl<$R, $Out, T>(v, t, t2));
}

abstract class TableColumnCopyWith<$R, $In extends TableColumn<T>, $Out, T>
    implements ClassCopyWith<$R, $In, $Out> {
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
  TableColumnCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _TableColumnCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, TableColumn<T>, $Out>
    implements TableColumnCopyWith<$R, TableColumn<T>, $Out, T> {
  _TableColumnCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<TableColumn> $mapper =
      TableColumnMapper.ensureInitialized();
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
  TableColumn<T> $make(CopyWithData data) => TableColumn(
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
  TableColumnCopyWith<$R2, TableColumn<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableColumnCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}

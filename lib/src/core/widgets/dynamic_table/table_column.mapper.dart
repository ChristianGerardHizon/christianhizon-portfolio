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

  static String? _$sortKey(TableColumn v) => v.sortKey;
  static const Field<TableColumn, String> _f$sortKey =
      Field('sortKey', _$sortKey, opt: true);
  static String _$header(TableColumn v) => v.header;
  static const Field<TableColumn, String> _f$header = Field('header', _$header);
  static double _$width(TableColumn v) => v.width;
  static const Field<TableColumn, double> _f$width =
      Field('width', _$width, opt: true, def: 100);
  static Function _$builder(TableColumn v) =>
      (v as dynamic).builder as Function;
  static dynamic _arg$builder<T>(f) =>
      f<Widget Function(BuildContext, T, int, int)>();
  static const Field<TableColumn, Function> _f$builder =
      Field('builder', _$builder, opt: true, arg: _arg$builder);
  static TextStyle? _$style(TableColumn v) => v.style;
  static const Field<TableColumn, TextStyle> _f$style =
      Field('style', _$style, opt: true);
  static Alignment? _$alignment(TableColumn v) => v.alignment;
  static const Field<TableColumn, Alignment> _f$alignment =
      Field('alignment', _$alignment, opt: true);
  static EdgeInsets? _$padding(TableColumn v) => v.padding;
  static const Field<TableColumn, EdgeInsets> _f$padding =
      Field('padding', _$padding, opt: true);

  @override
  final MappableFields<TableColumn> fields = const {
    #sortKey: _f$sortKey,
    #header: _f$header,
    #width: _f$width,
    #builder: _f$builder,
    #style: _f$style,
    #alignment: _f$alignment,
    #padding: _f$padding,
  };

  static TableColumn<T> _instantiate<T>(DecodingData data) {
    return TableColumn(
        sortKey: data.dec(_f$sortKey),
        header: data.dec(_f$header),
        width: data.dec(_f$width),
        builder: data.dec(_f$builder),
        style: data.dec(_f$style),
        alignment: data.dec(_f$alignment),
        padding: data.dec(_f$padding));
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
      {String? sortKey,
      String? header,
      double? width,
      Widget Function(BuildContext, T, int, int)? builder,
      TextStyle? style,
      Alignment? alignment,
      EdgeInsets? padding});
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
          {Object? sortKey = $none,
          String? header,
          double? width,
          Object? builder = $none,
          Object? style = $none,
          Object? alignment = $none,
          Object? padding = $none}) =>
      $apply(FieldCopyWithData({
        if (sortKey != $none) #sortKey: sortKey,
        if (header != null) #header: header,
        if (width != null) #width: width,
        if (builder != $none) #builder: builder,
        if (style != $none) #style: style,
        if (alignment != $none) #alignment: alignment,
        if (padding != $none) #padding: padding
      }));
  @override
  TableColumn<T> $make(CopyWithData data) => TableColumn(
      sortKey: data.get(#sortKey, or: $value.sortKey),
      header: data.get(#header, or: $value.header),
      width: data.get(#width, or: $value.width),
      builder: data.get(#builder, or: $value.builder),
      style: data.get(#style, or: $value.style),
      alignment: data.get(#alignment, or: $value.alignment),
      padding: data.get(#padding, or: $value.padding));

  @override
  TableColumnCopyWith<$R2, TableColumn<T>, $Out2, T> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _TableColumnCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}

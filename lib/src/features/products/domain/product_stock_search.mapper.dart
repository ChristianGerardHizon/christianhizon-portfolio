// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_stock_search.dart';

class ProductStockSearchMapper extends ClassMapperBase<ProductStockSearch> {
  ProductStockSearchMapper._();

  static ProductStockSearchMapper? _instance;
  static ProductStockSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductStockSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductStockSearch';

  static String? _$id(ProductStockSearch v) => v.id;
  static const Field<ProductStockSearch, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$name(ProductStockSearch v) => v.name;
  static const Field<ProductStockSearch, String> _f$name =
      Field('name', _$name, opt: true);
  static DateTime? _$expiration(ProductStockSearch v) => v.expiration;
  static const Field<ProductStockSearch, DateTime> _f$expiration =
      Field('expiration', _$expiration, opt: true);

  @override
  final MappableFields<ProductStockSearch> fields = const {
    #id: _f$id,
    #name: _f$name,
    #expiration: _f$expiration,
  };

  static ProductStockSearch _instantiate(DecodingData data) {
    return ProductStockSearch(
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        expiration: data.dec(_f$expiration));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductStockSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductStockSearch>(map);
  }

  static ProductStockSearch fromJson(String json) {
    return ensureInitialized().decodeJson<ProductStockSearch>(json);
  }
}

mixin ProductStockSearchMappable {
  String toJson() {
    return ProductStockSearchMapper.ensureInitialized()
        .encodeJson<ProductStockSearch>(this as ProductStockSearch);
  }

  Map<String, dynamic> toMap() {
    return ProductStockSearchMapper.ensureInitialized()
        .encodeMap<ProductStockSearch>(this as ProductStockSearch);
  }

  ProductStockSearchCopyWith<ProductStockSearch, ProductStockSearch,
          ProductStockSearch>
      get copyWith => _ProductStockSearchCopyWithImpl<ProductStockSearch,
          ProductStockSearch>(this as ProductStockSearch, $identity, $identity);
  @override
  String toString() {
    return ProductStockSearchMapper.ensureInitialized()
        .stringifyValue(this as ProductStockSearch);
  }

  @override
  bool operator ==(Object other) {
    return ProductStockSearchMapper.ensureInitialized()
        .equalsValue(this as ProductStockSearch, other);
  }

  @override
  int get hashCode {
    return ProductStockSearchMapper.ensureInitialized()
        .hashValue(this as ProductStockSearch);
  }
}

extension ProductStockSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductStockSearch, $Out> {
  ProductStockSearchCopyWith<$R, ProductStockSearch, $Out>
      get $asProductStockSearch => $base.as(
          (v, t, t2) => _ProductStockSearchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductStockSearchCopyWith<$R, $In extends ProductStockSearch,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, DateTime? expiration});
  ProductStockSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProductStockSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductStockSearch, $Out>
    implements ProductStockSearchCopyWith<$R, ProductStockSearch, $Out> {
  _ProductStockSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductStockSearch> $mapper =
      ProductStockSearchMapper.ensureInitialized();
  @override
  $R call(
          {Object? id = $none,
          Object? name = $none,
          Object? expiration = $none}) =>
      $apply(FieldCopyWithData({
        if (id != $none) #id: id,
        if (name != $none) #name: name,
        if (expiration != $none) #expiration: expiration
      }));
  @override
  ProductStockSearch $make(CopyWithData data) => ProductStockSearch(
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      expiration: data.get(#expiration, or: $value.expiration));

  @override
  ProductStockSearchCopyWith<$R2, ProductStockSearch, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProductStockSearchCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

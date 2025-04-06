// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_inventory_search.dart';

class ProductInventorySearchMapper
    extends ClassMapperBase<ProductInventorySearch> {
  ProductInventorySearchMapper._();

  static ProductInventorySearchMapper? _instance;
  static ProductInventorySearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductInventorySearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductInventorySearch';

  static String? _$id(ProductInventorySearch v) => v.id;
  static const Field<ProductInventorySearch, String> _f$id =
      Field('id', _$id, opt: true);
  static String? _$name(ProductInventorySearch v) => v.name;
  static const Field<ProductInventorySearch, String> _f$name =
      Field('name', _$name, opt: true);

  @override
  final MappableFields<ProductInventorySearch> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static ProductInventorySearch _instantiate(DecodingData data) {
    return ProductInventorySearch(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductInventorySearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductInventorySearch>(map);
  }

  static ProductInventorySearch fromJson(String json) {
    return ensureInitialized().decodeJson<ProductInventorySearch>(json);
  }
}

mixin ProductInventorySearchMappable {
  String toJson() {
    return ProductInventorySearchMapper.ensureInitialized()
        .encodeJson<ProductInventorySearch>(this as ProductInventorySearch);
  }

  Map<String, dynamic> toMap() {
    return ProductInventorySearchMapper.ensureInitialized()
        .encodeMap<ProductInventorySearch>(this as ProductInventorySearch);
  }

  ProductInventorySearchCopyWith<ProductInventorySearch, ProductInventorySearch,
          ProductInventorySearch>
      get copyWith => _ProductInventorySearchCopyWithImpl<
              ProductInventorySearch, ProductInventorySearch>(
          this as ProductInventorySearch, $identity, $identity);
  @override
  String toString() {
    return ProductInventorySearchMapper.ensureInitialized()
        .stringifyValue(this as ProductInventorySearch);
  }

  @override
  bool operator ==(Object other) {
    return ProductInventorySearchMapper.ensureInitialized()
        .equalsValue(this as ProductInventorySearch, other);
  }

  @override
  int get hashCode {
    return ProductInventorySearchMapper.ensureInitialized()
        .hashValue(this as ProductInventorySearch);
  }
}

extension ProductInventorySearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductInventorySearch, $Out> {
  ProductInventorySearchCopyWith<$R, ProductInventorySearch, $Out>
      get $asProductInventorySearch => $base.as((v, t, t2) =>
          _ProductInventorySearchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductInventorySearchCopyWith<
    $R,
    $In extends ProductInventorySearch,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  ProductInventorySearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProductInventorySearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductInventorySearch, $Out>
    implements
        ProductInventorySearchCopyWith<$R, ProductInventorySearch, $Out> {
  _ProductInventorySearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductInventorySearch> $mapper =
      ProductInventorySearchMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, Object? name = $none}) =>
      $apply(FieldCopyWithData(
          {if (id != $none) #id: id, if (name != $none) #name: name}));
  @override
  ProductInventorySearch $make(CopyWithData data) => ProductInventorySearch(
      id: data.get(#id, or: $value.id), name: data.get(#name, or: $value.name));

  @override
  ProductInventorySearchCopyWith<$R2, ProductInventorySearch, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ProductInventorySearchCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

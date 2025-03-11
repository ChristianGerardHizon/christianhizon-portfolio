// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_search.dart';

class ProductSearchMapper extends ClassMapperBase<ProductSearch> {
  ProductSearchMapper._();

  static ProductSearchMapper? _instance;
  static ProductSearchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductSearchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductSearch';

  static String? _$id(ProductSearch v) => v.id;
  static const Field<ProductSearch, String> _f$id = Field('id', _$id);
  static String? _$name(ProductSearch v) => v.name;
  static const Field<ProductSearch, String> _f$name = Field('name', _$name);

  @override
  final MappableFields<ProductSearch> fields = const {
    #id: _f$id,
    #name: _f$name,
  };

  static ProductSearch _instantiate(DecodingData data) {
    return ProductSearch(id: data.dec(_f$id), name: data.dec(_f$name));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductSearch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductSearch>(map);
  }

  static ProductSearch fromJson(String json) {
    return ensureInitialized().decodeJson<ProductSearch>(json);
  }
}

mixin ProductSearchMappable {
  String toJson() {
    return ProductSearchMapper.ensureInitialized()
        .encodeJson<ProductSearch>(this as ProductSearch);
  }

  Map<String, dynamic> toMap() {
    return ProductSearchMapper.ensureInitialized()
        .encodeMap<ProductSearch>(this as ProductSearch);
  }

  ProductSearchCopyWith<ProductSearch, ProductSearch, ProductSearch>
      get copyWith => _ProductSearchCopyWithImpl(
          this as ProductSearch, $identity, $identity);
  @override
  String toString() {
    return ProductSearchMapper.ensureInitialized()
        .stringifyValue(this as ProductSearch);
  }

  @override
  bool operator ==(Object other) {
    return ProductSearchMapper.ensureInitialized()
        .equalsValue(this as ProductSearch, other);
  }

  @override
  int get hashCode {
    return ProductSearchMapper.ensureInitialized()
        .hashValue(this as ProductSearch);
  }
}

extension ProductSearchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductSearch, $Out> {
  ProductSearchCopyWith<$R, ProductSearch, $Out> get $asProductSearch =>
      $base.as((v, t, t2) => _ProductSearchCopyWithImpl(v, t, t2));
}

abstract class ProductSearchCopyWith<$R, $In extends ProductSearch, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name});
  ProductSearchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProductSearchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductSearch, $Out>
    implements ProductSearchCopyWith<$R, ProductSearch, $Out> {
  _ProductSearchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductSearch> $mapper =
      ProductSearchMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, Object? name = $none}) =>
      $apply(FieldCopyWithData(
          {if (id != $none) #id: id, if (name != $none) #name: name}));
  @override
  ProductSearch $make(CopyWithData data) => ProductSearch(
      id: data.get(#id, or: $value.id), name: data.get(#name, or: $value.name));

  @override
  ProductSearchCopyWith<$R2, ProductSearch, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProductSearchCopyWithImpl($value, $cast, t);
}

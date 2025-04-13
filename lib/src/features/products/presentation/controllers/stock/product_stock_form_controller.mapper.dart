// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_stock_form_controller.dart';

class ProductStockFormStateMapper
    extends ClassMapperBase<ProductStockFormState> {
  ProductStockFormStateMapper._();

  static ProductStockFormStateMapper? _instance;
  static ProductStockFormStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductStockFormStateMapper._());
      ProductMapper.ensureInitialized();
      ProductStockMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductStockFormState';

  static Product _$product(ProductStockFormState v) => v.product;
  static const Field<ProductStockFormState, Product> _f$product =
      Field('product', _$product);
  static ProductStock? _$productStock(ProductStockFormState v) =>
      v.productStock;
  static const Field<ProductStockFormState, ProductStock> _f$productStock =
      Field('productStock', _$productStock, opt: true);

  @override
  final MappableFields<ProductStockFormState> fields = const {
    #product: _f$product,
    #productStock: _f$productStock,
  };

  static ProductStockFormState _instantiate(DecodingData data) {
    return ProductStockFormState(
        product: data.dec(_f$product), productStock: data.dec(_f$productStock));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductStockFormState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductStockFormState>(map);
  }

  static ProductStockFormState fromJson(String json) {
    return ensureInitialized().decodeJson<ProductStockFormState>(json);
  }
}

mixin ProductStockFormStateMappable {
  String toJson() {
    return ProductStockFormStateMapper.ensureInitialized()
        .encodeJson<ProductStockFormState>(this as ProductStockFormState);
  }

  Map<String, dynamic> toMap() {
    return ProductStockFormStateMapper.ensureInitialized()
        .encodeMap<ProductStockFormState>(this as ProductStockFormState);
  }

  ProductStockFormStateCopyWith<ProductStockFormState, ProductStockFormState,
      ProductStockFormState> get copyWith => _ProductStockFormStateCopyWithImpl<
          ProductStockFormState, ProductStockFormState>(
      this as ProductStockFormState, $identity, $identity);
  @override
  String toString() {
    return ProductStockFormStateMapper.ensureInitialized()
        .stringifyValue(this as ProductStockFormState);
  }

  @override
  bool operator ==(Object other) {
    return ProductStockFormStateMapper.ensureInitialized()
        .equalsValue(this as ProductStockFormState, other);
  }

  @override
  int get hashCode {
    return ProductStockFormStateMapper.ensureInitialized()
        .hashValue(this as ProductStockFormState);
  }
}

extension ProductStockFormStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductStockFormState, $Out> {
  ProductStockFormStateCopyWith<$R, ProductStockFormState, $Out>
      get $asProductStockFormState => $base.as(
          (v, t, t2) => _ProductStockFormStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductStockFormStateCopyWith<
    $R,
    $In extends ProductStockFormState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ProductCopyWith<$R, Product, Product> get product;
  ProductStockCopyWith<$R, ProductStock, ProductStock>? get productStock;
  $R call({Product? product, ProductStock? productStock});
  ProductStockFormStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProductStockFormStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductStockFormState, $Out>
    implements ProductStockFormStateCopyWith<$R, ProductStockFormState, $Out> {
  _ProductStockFormStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductStockFormState> $mapper =
      ProductStockFormStateMapper.ensureInitialized();
  @override
  ProductCopyWith<$R, Product, Product> get product =>
      $value.product.copyWith.$chain((v) => call(product: v));
  @override
  ProductStockCopyWith<$R, ProductStock, ProductStock>? get productStock =>
      $value.productStock?.copyWith.$chain((v) => call(productStock: v));
  @override
  $R call({Product? product, Object? productStock = $none}) =>
      $apply(FieldCopyWithData({
        if (product != null) #product: product,
        if (productStock != $none) #productStock: productStock
      }));
  @override
  ProductStockFormState $make(CopyWithData data) => ProductStockFormState(
      product: data.get(#product, or: $value.product),
      productStock: data.get(#productStock, or: $value.productStock));

  @override
  ProductStockFormStateCopyWith<$R2, ProductStockFormState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ProductStockFormStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

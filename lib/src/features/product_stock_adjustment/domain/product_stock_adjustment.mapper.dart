// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_stock_adjustment.dart';

class ProductStockAdjustmentMapper
    extends ClassMapperBase<ProductStockAdjustment> {
  ProductStockAdjustmentMapper._();

  static ProductStockAdjustmentMapper? _instance;
  static ProductStockAdjustmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductStockAdjustmentMapper._());
      PbRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductStockAdjustment';

  static String _$id(ProductStockAdjustment v) => v.id;
  static const Field<ProductStockAdjustment, String> _f$id = Field('id', _$id);
  static String _$collectionId(ProductStockAdjustment v) => v.collectionId;
  static const Field<ProductStockAdjustment, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(ProductStockAdjustment v) => v.collectionName;
  static const Field<ProductStockAdjustment, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static bool _$isDeleted(ProductStockAdjustment v) => v.isDeleted;
  static const Field<ProductStockAdjustment, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(ProductStockAdjustment v) => v.created;
  static const Field<ProductStockAdjustment, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(ProductStockAdjustment v) => v.updated;
  static const Field<ProductStockAdjustment, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);
  static num _$oldValue(ProductStockAdjustment v) => v.oldValue;
  static const Field<ProductStockAdjustment, num> _f$oldValue =
      Field('oldValue', _$oldValue);
  static String? _$productStock(ProductStockAdjustment v) => v.productStock;
  static const Field<ProductStockAdjustment, String> _f$productStock =
      Field('productStock', _$productStock);
  static String? _$product(ProductStockAdjustment v) => v.product;
  static const Field<ProductStockAdjustment, String> _f$product =
      Field('product', _$product);
  static num _$newValue(ProductStockAdjustment v) => v.newValue;
  static const Field<ProductStockAdjustment, num> _f$newValue =
      Field('newValue', _$newValue);
  static String? _$reason(ProductStockAdjustment v) => v.reason;
  static const Field<ProductStockAdjustment, String> _f$reason =
      Field('reason', _$reason, opt: true);

  @override
  final MappableFields<ProductStockAdjustment> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #oldValue: _f$oldValue,
    #productStock: _f$productStock,
    #product: _f$product,
    #newValue: _f$newValue,
    #reason: _f$reason,
  };

  static ProductStockAdjustment _instantiate(DecodingData data) {
    return ProductStockAdjustment(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated),
        oldValue: data.dec(_f$oldValue),
        productStock: data.dec(_f$productStock),
        product: data.dec(_f$product),
        newValue: data.dec(_f$newValue),
        reason: data.dec(_f$reason));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductStockAdjustment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductStockAdjustment>(map);
  }

  static ProductStockAdjustment fromJson(String json) {
    return ensureInitialized().decodeJson<ProductStockAdjustment>(json);
  }
}

mixin ProductStockAdjustmentMappable {
  String toJson() {
    return ProductStockAdjustmentMapper.ensureInitialized()
        .encodeJson<ProductStockAdjustment>(this as ProductStockAdjustment);
  }

  Map<String, dynamic> toMap() {
    return ProductStockAdjustmentMapper.ensureInitialized()
        .encodeMap<ProductStockAdjustment>(this as ProductStockAdjustment);
  }

  ProductStockAdjustmentCopyWith<ProductStockAdjustment, ProductStockAdjustment,
          ProductStockAdjustment>
      get copyWith => _ProductStockAdjustmentCopyWithImpl<
              ProductStockAdjustment, ProductStockAdjustment>(
          this as ProductStockAdjustment, $identity, $identity);
  @override
  String toString() {
    return ProductStockAdjustmentMapper.ensureInitialized()
        .stringifyValue(this as ProductStockAdjustment);
  }

  @override
  bool operator ==(Object other) {
    return ProductStockAdjustmentMapper.ensureInitialized()
        .equalsValue(this as ProductStockAdjustment, other);
  }

  @override
  int get hashCode {
    return ProductStockAdjustmentMapper.ensureInitialized()
        .hashValue(this as ProductStockAdjustment);
  }
}

extension ProductStockAdjustmentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductStockAdjustment, $Out> {
  ProductStockAdjustmentCopyWith<$R, ProductStockAdjustment, $Out>
      get $asProductStockAdjustment => $base.as((v, t, t2) =>
          _ProductStockAdjustmentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductStockAdjustmentCopyWith<
    $R,
    $In extends ProductStockAdjustment,
    $Out> implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated,
      num? oldValue,
      String? productStock,
      String? product,
      num? newValue,
      String? reason});
  ProductStockAdjustmentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProductStockAdjustmentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductStockAdjustment, $Out>
    implements
        ProductStockAdjustmentCopyWith<$R, ProductStockAdjustment, $Out> {
  _ProductStockAdjustmentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductStockAdjustment> $mapper =
      ProductStockAdjustmentMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none,
          num? oldValue,
          Object? productStock = $none,
          Object? product = $none,
          num? newValue,
          Object? reason = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated,
        if (oldValue != null) #oldValue: oldValue,
        if (productStock != $none) #productStock: productStock,
        if (product != $none) #product: product,
        if (newValue != null) #newValue: newValue,
        if (reason != $none) #reason: reason
      }));
  @override
  ProductStockAdjustment $make(CopyWithData data) => ProductStockAdjustment(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated),
      oldValue: data.get(#oldValue, or: $value.oldValue),
      productStock: data.get(#productStock, or: $value.productStock),
      product: data.get(#product, or: $value.product),
      newValue: data.get(#newValue, or: $value.newValue),
      reason: data.get(#reason, or: $value.reason));

  @override
  ProductStockAdjustmentCopyWith<$R2, ProductStockAdjustment, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ProductStockAdjustmentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

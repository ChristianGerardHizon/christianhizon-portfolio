// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_inventory.dart';

class ProductStatusMapper extends EnumMapper<ProductStatus> {
  ProductStatusMapper._();

  static ProductStatusMapper? _instance;
  static ProductStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductStatusMapper._());
    }
    return _instance!;
  }

  static ProductStatus fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ProductStatus decode(dynamic value) {
    switch (value) {
      case r'inStock':
        return ProductStatus.inStock;
      case r'outOfStock':
        return ProductStatus.outOfStock;
      case r'lowStock':
        return ProductStatus.lowStock;
      case r'noThreshold':
        return ProductStatus.noThreshold;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ProductStatus self) {
    switch (self) {
      case ProductStatus.inStock:
        return r'inStock';
      case ProductStatus.outOfStock:
        return r'outOfStock';
      case ProductStatus.lowStock:
        return r'lowStock';
      case ProductStatus.noThreshold:
        return r'noThreshold';
    }
  }
}

extension ProductStatusMapperExtension on ProductStatus {
  String toValue() {
    ProductStatusMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ProductStatus>(this) as String;
  }
}

class ProductInventoryMapper extends ClassMapperBase<ProductInventory> {
  ProductInventoryMapper._();

  static ProductInventoryMapper? _instance;
  static ProductInventoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductInventoryMapper._());
      PbRecordMapper.ensureInitialized();
      ProductStatusMapper.ensureInitialized();
      ProductInventoryExpandMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductInventory';

  static String _$id(ProductInventory v) => v.id;
  static const Field<ProductInventory, String> _f$id = Field('id', _$id);
  static String _$collectionId(ProductInventory v) => v.collectionId;
  static const Field<ProductInventory, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(ProductInventory v) => v.collectionName;
  static const Field<ProductInventory, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String _$product(ProductInventory v) => v.product;
  static const Field<ProductInventory, String> _f$product =
      Field('product', _$product);
  static ProductStatus _$status(ProductInventory v) => v.status;
  static const Field<ProductInventory, ProductStatus> _f$status =
      Field('status', _$status);
  static ProductInventoryExpand _$expand(ProductInventory v) => v.expand;
  static const Field<ProductInventory, ProductInventoryExpand> _f$expand =
      Field('expand', _$expand);
  static num _$totalExpired(ProductInventory v) => v.totalExpired;
  static const Field<ProductInventory, num> _f$totalExpired =
      Field('totalExpired', _$totalExpired, opt: true, def: 0);
  static num _$totalQuantity(ProductInventory v) => v.totalQuantity;
  static const Field<ProductInventory, num> _f$totalQuantity =
      Field('totalQuantity', _$totalQuantity, opt: true, def: 0);
  static bool _$forSale(ProductInventory v) => v.forSale;
  static const Field<ProductInventory, bool> _f$forSale =
      Field('forSale', _$forSale, opt: true, def: false);
  static bool _$isDeleted(ProductInventory v) => v.isDeleted;
  static const Field<ProductInventory, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(ProductInventory v) => v.created;
  static const Field<ProductInventory, DateTime> _f$created =
      Field('created', _$created, opt: true);
  static DateTime? _$updated(ProductInventory v) => v.updated;
  static const Field<ProductInventory, DateTime> _f$updated =
      Field('updated', _$updated, opt: true);

  @override
  final MappableFields<ProductInventory> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #product: _f$product,
    #status: _f$status,
    #expand: _f$expand,
    #totalExpired: _f$totalExpired,
    #totalQuantity: _f$totalQuantity,
    #forSale: _f$forSale,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static ProductInventory _instantiate(DecodingData data) {
    return ProductInventory(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        product: data.dec(_f$product),
        status: data.dec(_f$status),
        expand: data.dec(_f$expand),
        totalExpired: data.dec(_f$totalExpired),
        totalQuantity: data.dec(_f$totalQuantity),
        forSale: data.dec(_f$forSale),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductInventory fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductInventory>(map);
  }

  static ProductInventory fromJson(String json) {
    return ensureInitialized().decodeJson<ProductInventory>(json);
  }
}

mixin ProductInventoryMappable {
  String toJson() {
    return ProductInventoryMapper.ensureInitialized()
        .encodeJson<ProductInventory>(this as ProductInventory);
  }

  Map<String, dynamic> toMap() {
    return ProductInventoryMapper.ensureInitialized()
        .encodeMap<ProductInventory>(this as ProductInventory);
  }

  ProductInventoryCopyWith<ProductInventory, ProductInventory, ProductInventory>
      get copyWith =>
          _ProductInventoryCopyWithImpl<ProductInventory, ProductInventory>(
              this as ProductInventory, $identity, $identity);
  @override
  String toString() {
    return ProductInventoryMapper.ensureInitialized()
        .stringifyValue(this as ProductInventory);
  }

  @override
  bool operator ==(Object other) {
    return ProductInventoryMapper.ensureInitialized()
        .equalsValue(this as ProductInventory, other);
  }

  @override
  int get hashCode {
    return ProductInventoryMapper.ensureInitialized()
        .hashValue(this as ProductInventory);
  }
}

extension ProductInventoryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductInventory, $Out> {
  ProductInventoryCopyWith<$R, ProductInventory, $Out>
      get $asProductInventory => $base
          .as((v, t, t2) => _ProductInventoryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductInventoryCopyWith<$R, $In extends ProductInventory, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  ProductInventoryExpandCopyWith<$R, ProductInventoryExpand,
      ProductInventoryExpand> get expand;
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      String? product,
      ProductStatus? status,
      ProductInventoryExpand? expand,
      num? totalExpired,
      num? totalQuantity,
      bool? forSale,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated});
  ProductInventoryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProductInventoryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductInventory, $Out>
    implements ProductInventoryCopyWith<$R, ProductInventory, $Out> {
  _ProductInventoryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductInventory> $mapper =
      ProductInventoryMapper.ensureInitialized();
  @override
  ProductInventoryExpandCopyWith<$R, ProductInventoryExpand,
          ProductInventoryExpand>
      get expand => $value.expand.copyWith.$chain((v) => call(expand: v));
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          String? product,
          ProductStatus? status,
          ProductInventoryExpand? expand,
          num? totalExpired,
          num? totalQuantity,
          bool? forSale,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (product != null) #product: product,
        if (status != null) #status: status,
        if (expand != null) #expand: expand,
        if (totalExpired != null) #totalExpired: totalExpired,
        if (totalQuantity != null) #totalQuantity: totalQuantity,
        if (forSale != null) #forSale: forSale,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  ProductInventory $make(CopyWithData data) => ProductInventory(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      product: data.get(#product, or: $value.product),
      status: data.get(#status, or: $value.status),
      expand: data.get(#expand, or: $value.expand),
      totalExpired: data.get(#totalExpired, or: $value.totalExpired),
      totalQuantity: data.get(#totalQuantity, or: $value.totalQuantity),
      forSale: data.get(#forSale, or: $value.forSale),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  ProductInventoryCopyWith<$R2, ProductInventory, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProductInventoryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProductInventoryExpandMapper
    extends ClassMapperBase<ProductInventoryExpand> {
  ProductInventoryExpandMapper._();

  static ProductInventoryExpandMapper? _instance;
  static ProductInventoryExpandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductInventoryExpandMapper._());
      ProductMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductInventoryExpand';

  static Product _$product(ProductInventoryExpand v) => v.product;
  static const Field<ProductInventoryExpand, Product> _f$product =
      Field('product', _$product);

  @override
  final MappableFields<ProductInventoryExpand> fields = const {
    #product: _f$product,
  };

  static ProductInventoryExpand _instantiate(DecodingData data) {
    return ProductInventoryExpand(product: data.dec(_f$product));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductInventoryExpand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductInventoryExpand>(map);
  }

  static ProductInventoryExpand fromJson(String json) {
    return ensureInitialized().decodeJson<ProductInventoryExpand>(json);
  }
}

mixin ProductInventoryExpandMappable {
  String toJson() {
    return ProductInventoryExpandMapper.ensureInitialized()
        .encodeJson<ProductInventoryExpand>(this as ProductInventoryExpand);
  }

  Map<String, dynamic> toMap() {
    return ProductInventoryExpandMapper.ensureInitialized()
        .encodeMap<ProductInventoryExpand>(this as ProductInventoryExpand);
  }

  ProductInventoryExpandCopyWith<ProductInventoryExpand, ProductInventoryExpand,
          ProductInventoryExpand>
      get copyWith => _ProductInventoryExpandCopyWithImpl<
              ProductInventoryExpand, ProductInventoryExpand>(
          this as ProductInventoryExpand, $identity, $identity);
  @override
  String toString() {
    return ProductInventoryExpandMapper.ensureInitialized()
        .stringifyValue(this as ProductInventoryExpand);
  }

  @override
  bool operator ==(Object other) {
    return ProductInventoryExpandMapper.ensureInitialized()
        .equalsValue(this as ProductInventoryExpand, other);
  }

  @override
  int get hashCode {
    return ProductInventoryExpandMapper.ensureInitialized()
        .hashValue(this as ProductInventoryExpand);
  }
}

extension ProductInventoryExpandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductInventoryExpand, $Out> {
  ProductInventoryExpandCopyWith<$R, ProductInventoryExpand, $Out>
      get $asProductInventoryExpand => $base.as((v, t, t2) =>
          _ProductInventoryExpandCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductInventoryExpandCopyWith<
    $R,
    $In extends ProductInventoryExpand,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ProductCopyWith<$R, Product, Product> get product;
  $R call({Product? product});
  ProductInventoryExpandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProductInventoryExpandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductInventoryExpand, $Out>
    implements
        ProductInventoryExpandCopyWith<$R, ProductInventoryExpand, $Out> {
  _ProductInventoryExpandCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductInventoryExpand> $mapper =
      ProductInventoryExpandMapper.ensureInitialized();
  @override
  ProductCopyWith<$R, Product, Product> get product =>
      $value.product.copyWith.$chain((v) => call(product: v));
  @override
  $R call({Product? product}) =>
      $apply(FieldCopyWithData({if (product != null) #product: product}));
  @override
  ProductInventoryExpand $make(CopyWithData data) =>
      ProductInventoryExpand(product: data.get(#product, or: $value.product));

  @override
  ProductInventoryExpandCopyWith<$R2, ProductInventoryExpand, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ProductInventoryExpandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

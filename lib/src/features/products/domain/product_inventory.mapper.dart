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
  static String _$name(ProductInventory v) => v.name;
  static const Field<ProductInventory, String> _f$name = Field('name', _$name);
  static String? _$description(ProductInventory v) => v.description;
  static const Field<ProductInventory, String> _f$description =
      Field('description', _$description, opt: true);
  static String? _$category(ProductInventory v) => v.category;
  static const Field<ProductInventory, String> _f$category =
      Field('category', _$category, opt: true);
  static String? _$image(ProductInventory v) => v.image;
  static const Field<ProductInventory, String> _f$image =
      Field('image', _$image, opt: true);
  static String? _$branch(ProductInventory v) => v.branch;
  static const Field<ProductInventory, String> _f$branch =
      Field('branch', _$branch, opt: true);
  static String? _$branchName(ProductInventory v) => v.branchName;
  static const Field<ProductInventory, String> _f$branchName =
      Field('branchName', _$branchName, opt: true);
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
    #name: _f$name,
    #description: _f$description,
    #category: _f$category,
    #image: _f$image,
    #branch: _f$branch,
    #branchName: _f$branchName,
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
        name: data.dec(_f$name),
        description: data.dec(_f$description),
        category: data.dec(_f$category),
        image: data.dec(_f$image),
        branch: data.dec(_f$branch),
        branchName: data.dec(_f$branchName),
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
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      String? product,
      ProductStatus? status,
      String? name,
      String? description,
      String? category,
      String? image,
      String? branch,
      String? branchName,
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
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          String? product,
          ProductStatus? status,
          String? name,
          Object? description = $none,
          Object? category = $none,
          Object? image = $none,
          Object? branch = $none,
          Object? branchName = $none,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (product != null) #product: product,
        if (status != null) #status: status,
        if (name != null) #name: name,
        if (description != $none) #description: description,
        if (category != $none) #category: category,
        if (image != $none) #image: image,
        if (branch != $none) #branch: branch,
        if (branchName != $none) #branchName: branchName,
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
      name: data.get(#name, or: $value.name),
      description: data.get(#description, or: $value.description),
      category: data.get(#category, or: $value.category),
      image: data.get(#image, or: $value.image),
      branch: data.get(#branch, or: $value.branch),
      branchName: data.get(#branchName, or: $value.branchName),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  ProductInventoryCopyWith<$R2, ProductInventory, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProductInventoryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

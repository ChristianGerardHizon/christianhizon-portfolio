// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_adjustment.dart';

class ProductAdjustmentTypeMapper extends EnumMapper<ProductAdjustmentType> {
  ProductAdjustmentTypeMapper._();

  static ProductAdjustmentTypeMapper? _instance;
  static ProductAdjustmentTypeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductAdjustmentTypeMapper._());
    }
    return _instance!;
  }

  static ProductAdjustmentType fromValue(dynamic value) {
    ensureInitialized();
    return MapperContainer.globals.fromValue(value);
  }

  @override
  ProductAdjustmentType decode(dynamic value) {
    switch (value) {
      case r'product':
        return ProductAdjustmentType.product;
      case r'productStock':
        return ProductAdjustmentType.productStock;
      default:
        throw MapperException.unknownEnumValue(value);
    }
  }

  @override
  dynamic encode(ProductAdjustmentType self) {
    switch (self) {
      case ProductAdjustmentType.product:
        return r'product';
      case ProductAdjustmentType.productStock:
        return r'productStock';
    }
  }
}

extension ProductAdjustmentTypeMapperExtension on ProductAdjustmentType {
  String toValue() {
    ProductAdjustmentTypeMapper.ensureInitialized();
    return MapperContainer.globals.toValue<ProductAdjustmentType>(this)
        as String;
  }
}

class ProductAdjustmentMapper extends SubClassMapperBase<ProductAdjustment> {
  ProductAdjustmentMapper._();

  static ProductAdjustmentMapper? _instance;
  static ProductAdjustmentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductAdjustmentMapper._());
      PbRecordMapper.ensureInitialized().addSubMapper(_instance!);
      ProductAdjustmentSimpleMapper.ensureInitialized();
      ProductAdjustmentStockMapper.ensureInitialized();
      ProductAdjustmentTypeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductAdjustment';

  static String _$id(ProductAdjustment v) => v.id;
  static const Field<ProductAdjustment, String> _f$id = Field('id', _$id);
  static String _$collectionId(ProductAdjustment v) => v.collectionId;
  static const Field<ProductAdjustment, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(ProductAdjustment v) => v.collectionName;
  static const Field<ProductAdjustment, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static bool _$isDeleted(ProductAdjustment v) => v.isDeleted;
  static const Field<ProductAdjustment, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(ProductAdjustment v) => v.created;
  static const Field<ProductAdjustment, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(ProductAdjustment v) => v.updated;
  static const Field<ProductAdjustment, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static num _$oldValue(ProductAdjustment v) => v.oldValue;
  static const Field<ProductAdjustment, num> _f$oldValue = Field(
    'oldValue',
    _$oldValue,
  );
  static num _$newValue(ProductAdjustment v) => v.newValue;
  static const Field<ProductAdjustment, num> _f$newValue = Field(
    'newValue',
    _$newValue,
  );
  static ProductAdjustmentType _$type(ProductAdjustment v) => v.type;
  static const Field<ProductAdjustment, ProductAdjustmentType> _f$type = Field(
    'type',
    _$type,
  );
  static String? _$reason(ProductAdjustment v) => v.reason;
  static const Field<ProductAdjustment, String> _f$reason = Field(
    'reason',
    _$reason,
    opt: true,
  );

  @override
  final MappableFields<ProductAdjustment> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #oldValue: _f$oldValue,
    #newValue: _f$newValue,
    #type: _f$type,
    #reason: _f$reason,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = 'ProductAdjustment';
  @override
  late final ClassMapperBase superMapper = PbRecordMapper.ensureInitialized();

  static ProductAdjustment _instantiate(DecodingData data) {
    throw MapperException.missingSubclass(
      'ProductAdjustment',
      'type',
      '${data.value['type']}',
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductAdjustment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductAdjustment>(map);
  }

  static ProductAdjustment fromJson(String json) {
    return ensureInitialized().decodeJson<ProductAdjustment>(json);
  }
}

mixin ProductAdjustmentMappable {
  String toJson();
  Map<String, dynamic> toMap();
  ProductAdjustmentCopyWith<
    ProductAdjustment,
    ProductAdjustment,
    ProductAdjustment
  >
  get copyWith;
}

abstract class ProductAdjustmentCopyWith<
  $R,
  $In extends ProductAdjustment,
  $Out
>
    implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call({
    String? id,
    String? collectionId,
    String? collectionName,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
    num? oldValue,
    num? newValue,
    String? reason,
  });
  ProductAdjustmentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class ProductAdjustmentSimpleMapper
    extends SubClassMapperBase<ProductAdjustmentSimple> {
  ProductAdjustmentSimpleMapper._();

  static ProductAdjustmentSimpleMapper? _instance;
  static ProductAdjustmentSimpleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ProductAdjustmentSimpleMapper._(),
      );
      ProductAdjustmentMapper.ensureInitialized().addSubMapper(_instance!);
      ProductAdjustmentSimpleExpandMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductAdjustmentSimple';

  static String _$product(ProductAdjustmentSimple v) => v.product;
  static const Field<ProductAdjustmentSimple, String> _f$product = Field(
    'product',
    _$product,
  );
  static String _$id(ProductAdjustmentSimple v) => v.id;
  static const Field<ProductAdjustmentSimple, String> _f$id = Field('id', _$id);
  static String _$collectionId(ProductAdjustmentSimple v) => v.collectionId;
  static const Field<ProductAdjustmentSimple, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(ProductAdjustmentSimple v) => v.collectionName;
  static const Field<ProductAdjustmentSimple, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static bool _$isDeleted(ProductAdjustmentSimple v) => v.isDeleted;
  static const Field<ProductAdjustmentSimple, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(ProductAdjustmentSimple v) => v.created;
  static const Field<ProductAdjustmentSimple, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(ProductAdjustmentSimple v) => v.updated;
  static const Field<ProductAdjustmentSimple, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static num _$oldValue(ProductAdjustmentSimple v) => v.oldValue;
  static const Field<ProductAdjustmentSimple, num> _f$oldValue = Field(
    'oldValue',
    _$oldValue,
  );
  static num _$newValue(ProductAdjustmentSimple v) => v.newValue;
  static const Field<ProductAdjustmentSimple, num> _f$newValue = Field(
    'newValue',
    _$newValue,
  );
  static ProductAdjustmentSimpleExpand _$expand(ProductAdjustmentSimple v) =>
      v.expand;
  static const Field<ProductAdjustmentSimple, ProductAdjustmentSimpleExpand>
  _f$expand = Field('expand', _$expand);
  static String? _$reason(ProductAdjustmentSimple v) => v.reason;
  static const Field<ProductAdjustmentSimple, String> _f$reason = Field(
    'reason',
    _$reason,
    opt: true,
  );
  static ProductAdjustmentType _$type(ProductAdjustmentSimple v) => v.type;
  static const Field<ProductAdjustmentSimple, ProductAdjustmentType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<ProductAdjustmentSimple> fields = const {
    #product: _f$product,
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #oldValue: _f$oldValue,
    #newValue: _f$newValue,
    #expand: _f$expand,
    #reason: _f$reason,
    #type: _f$type,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = ProductAdjustmentType.product;
  @override
  late final ClassMapperBase superMapper =
      ProductAdjustmentMapper.ensureInitialized();

  static ProductAdjustmentSimple _instantiate(DecodingData data) {
    return ProductAdjustmentSimple(
      product: data.dec(_f$product),
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      oldValue: data.dec(_f$oldValue),
      newValue: data.dec(_f$newValue),
      expand: data.dec(_f$expand),
      reason: data.dec(_f$reason),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductAdjustmentSimple fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductAdjustmentSimple>(map);
  }

  static ProductAdjustmentSimple fromJson(String json) {
    return ensureInitialized().decodeJson<ProductAdjustmentSimple>(json);
  }
}

mixin ProductAdjustmentSimpleMappable {
  String toJson() {
    return ProductAdjustmentSimpleMapper.ensureInitialized()
        .encodeJson<ProductAdjustmentSimple>(this as ProductAdjustmentSimple);
  }

  Map<String, dynamic> toMap() {
    return ProductAdjustmentSimpleMapper.ensureInitialized()
        .encodeMap<ProductAdjustmentSimple>(this as ProductAdjustmentSimple);
  }

  ProductAdjustmentSimpleCopyWith<
    ProductAdjustmentSimple,
    ProductAdjustmentSimple,
    ProductAdjustmentSimple
  >
  get copyWith =>
      _ProductAdjustmentSimpleCopyWithImpl<
        ProductAdjustmentSimple,
        ProductAdjustmentSimple
      >(this as ProductAdjustmentSimple, $identity, $identity);
  @override
  String toString() {
    return ProductAdjustmentSimpleMapper.ensureInitialized().stringifyValue(
      this as ProductAdjustmentSimple,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProductAdjustmentSimpleMapper.ensureInitialized().equalsValue(
      this as ProductAdjustmentSimple,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductAdjustmentSimpleMapper.ensureInitialized().hashValue(
      this as ProductAdjustmentSimple,
    );
  }
}

extension ProductAdjustmentSimpleValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductAdjustmentSimple, $Out> {
  ProductAdjustmentSimpleCopyWith<$R, ProductAdjustmentSimple, $Out>
  get $asProductAdjustmentSimple => $base.as(
    (v, t, t2) => _ProductAdjustmentSimpleCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ProductAdjustmentSimpleCopyWith<
  $R,
  $In extends ProductAdjustmentSimple,
  $Out
>
    implements ProductAdjustmentCopyWith<$R, $In, $Out> {
  ProductAdjustmentSimpleExpandCopyWith<
    $R,
    ProductAdjustmentSimpleExpand,
    ProductAdjustmentSimpleExpand
  >
  get expand;
  @override
  $R call({
    String? product,
    String? id,
    String? collectionId,
    String? collectionName,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
    num? oldValue,
    num? newValue,
    ProductAdjustmentSimpleExpand? expand,
    String? reason,
  });
  ProductAdjustmentSimpleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProductAdjustmentSimpleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductAdjustmentSimple, $Out>
    implements
        ProductAdjustmentSimpleCopyWith<$R, ProductAdjustmentSimple, $Out> {
  _ProductAdjustmentSimpleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductAdjustmentSimple> $mapper =
      ProductAdjustmentSimpleMapper.ensureInitialized();
  @override
  ProductAdjustmentSimpleExpandCopyWith<
    $R,
    ProductAdjustmentSimpleExpand,
    ProductAdjustmentSimpleExpand
  >
  get expand => $value.expand.copyWith.$chain((v) => call(expand: v));
  @override
  $R call({
    String? product,
    String? id,
    String? collectionId,
    String? collectionName,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    num? oldValue,
    num? newValue,
    ProductAdjustmentSimpleExpand? expand,
    Object? reason = $none,
  }) => $apply(
    FieldCopyWithData({
      if (product != null) #product: product,
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (oldValue != null) #oldValue: oldValue,
      if (newValue != null) #newValue: newValue,
      if (expand != null) #expand: expand,
      if (reason != $none) #reason: reason,
    }),
  );
  @override
  ProductAdjustmentSimple $make(CopyWithData data) => ProductAdjustmentSimple(
    product: data.get(#product, or: $value.product),
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    oldValue: data.get(#oldValue, or: $value.oldValue),
    newValue: data.get(#newValue, or: $value.newValue),
    expand: data.get(#expand, or: $value.expand),
    reason: data.get(#reason, or: $value.reason),
  );

  @override
  ProductAdjustmentSimpleCopyWith<$R2, ProductAdjustmentSimple, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProductAdjustmentSimpleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProductAdjustmentSimpleExpandMapper
    extends ClassMapperBase<ProductAdjustmentSimpleExpand> {
  ProductAdjustmentSimpleExpandMapper._();

  static ProductAdjustmentSimpleExpandMapper? _instance;
  static ProductAdjustmentSimpleExpandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ProductAdjustmentSimpleExpandMapper._(),
      );
      ProductMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductAdjustmentSimpleExpand';

  static Product? _$product(ProductAdjustmentSimpleExpand v) => v.product;
  static const Field<ProductAdjustmentSimpleExpand, Product> _f$product = Field(
    'product',
    _$product,
    opt: true,
  );

  @override
  final MappableFields<ProductAdjustmentSimpleExpand> fields = const {
    #product: _f$product,
  };

  static ProductAdjustmentSimpleExpand _instantiate(DecodingData data) {
    return ProductAdjustmentSimpleExpand(product: data.dec(_f$product));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductAdjustmentSimpleExpand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductAdjustmentSimpleExpand>(map);
  }

  static ProductAdjustmentSimpleExpand fromJson(String json) {
    return ensureInitialized().decodeJson<ProductAdjustmentSimpleExpand>(json);
  }
}

mixin ProductAdjustmentSimpleExpandMappable {
  String toJson() {
    return ProductAdjustmentSimpleExpandMapper.ensureInitialized()
        .encodeJson<ProductAdjustmentSimpleExpand>(
          this as ProductAdjustmentSimpleExpand,
        );
  }

  Map<String, dynamic> toMap() {
    return ProductAdjustmentSimpleExpandMapper.ensureInitialized()
        .encodeMap<ProductAdjustmentSimpleExpand>(
          this as ProductAdjustmentSimpleExpand,
        );
  }

  ProductAdjustmentSimpleExpandCopyWith<
    ProductAdjustmentSimpleExpand,
    ProductAdjustmentSimpleExpand,
    ProductAdjustmentSimpleExpand
  >
  get copyWith =>
      _ProductAdjustmentSimpleExpandCopyWithImpl<
        ProductAdjustmentSimpleExpand,
        ProductAdjustmentSimpleExpand
      >(this as ProductAdjustmentSimpleExpand, $identity, $identity);
  @override
  String toString() {
    return ProductAdjustmentSimpleExpandMapper.ensureInitialized()
        .stringifyValue(this as ProductAdjustmentSimpleExpand);
  }

  @override
  bool operator ==(Object other) {
    return ProductAdjustmentSimpleExpandMapper.ensureInitialized().equalsValue(
      this as ProductAdjustmentSimpleExpand,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductAdjustmentSimpleExpandMapper.ensureInitialized().hashValue(
      this as ProductAdjustmentSimpleExpand,
    );
  }
}

extension ProductAdjustmentSimpleExpandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductAdjustmentSimpleExpand, $Out> {
  ProductAdjustmentSimpleExpandCopyWith<$R, ProductAdjustmentSimpleExpand, $Out>
  get $asProductAdjustmentSimpleExpand => $base.as(
    (v, t, t2) =>
        _ProductAdjustmentSimpleExpandCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ProductAdjustmentSimpleExpandCopyWith<
  $R,
  $In extends ProductAdjustmentSimpleExpand,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ProductCopyWith<$R, Product, Product>? get product;
  $R call({Product? product});
  ProductAdjustmentSimpleExpandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProductAdjustmentSimpleExpandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductAdjustmentSimpleExpand, $Out>
    implements
        ProductAdjustmentSimpleExpandCopyWith<
          $R,
          ProductAdjustmentSimpleExpand,
          $Out
        > {
  _ProductAdjustmentSimpleExpandCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<ProductAdjustmentSimpleExpand> $mapper =
      ProductAdjustmentSimpleExpandMapper.ensureInitialized();
  @override
  ProductCopyWith<$R, Product, Product>? get product =>
      $value.product?.copyWith.$chain((v) => call(product: v));
  @override
  $R call({Object? product = $none}) =>
      $apply(FieldCopyWithData({if (product != $none) #product: product}));
  @override
  ProductAdjustmentSimpleExpand $make(CopyWithData data) =>
      ProductAdjustmentSimpleExpand(
        product: data.get(#product, or: $value.product),
      );

  @override
  ProductAdjustmentSimpleExpandCopyWith<
    $R2,
    ProductAdjustmentSimpleExpand,
    $Out2
  >
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProductAdjustmentSimpleExpandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProductAdjustmentStockMapper
    extends SubClassMapperBase<ProductAdjustmentStock> {
  ProductAdjustmentStockMapper._();

  static ProductAdjustmentStockMapper? _instance;
  static ProductAdjustmentStockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductAdjustmentStockMapper._());
      ProductAdjustmentMapper.ensureInitialized().addSubMapper(_instance!);
      ProductAdjustmentStockExpandMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductAdjustmentStock';

  static String _$productStock(ProductAdjustmentStock v) => v.productStock;
  static const Field<ProductAdjustmentStock, String> _f$productStock = Field(
    'productStock',
    _$productStock,
  );
  static String _$id(ProductAdjustmentStock v) => v.id;
  static const Field<ProductAdjustmentStock, String> _f$id = Field('id', _$id);
  static String _$collectionId(ProductAdjustmentStock v) => v.collectionId;
  static const Field<ProductAdjustmentStock, String> _f$collectionId = Field(
    'collectionId',
    _$collectionId,
  );
  static String _$collectionName(ProductAdjustmentStock v) => v.collectionName;
  static const Field<ProductAdjustmentStock, String> _f$collectionName = Field(
    'collectionName',
    _$collectionName,
  );
  static bool _$isDeleted(ProductAdjustmentStock v) => v.isDeleted;
  static const Field<ProductAdjustmentStock, bool> _f$isDeleted = Field(
    'isDeleted',
    _$isDeleted,
    opt: true,
    def: false,
  );
  static DateTime? _$created(ProductAdjustmentStock v) => v.created;
  static const Field<ProductAdjustmentStock, DateTime> _f$created = Field(
    'created',
    _$created,
    opt: true,
  );
  static DateTime? _$updated(ProductAdjustmentStock v) => v.updated;
  static const Field<ProductAdjustmentStock, DateTime> _f$updated = Field(
    'updated',
    _$updated,
    opt: true,
  );
  static num _$oldValue(ProductAdjustmentStock v) => v.oldValue;
  static const Field<ProductAdjustmentStock, num> _f$oldValue = Field(
    'oldValue',
    _$oldValue,
  );
  static num _$newValue(ProductAdjustmentStock v) => v.newValue;
  static const Field<ProductAdjustmentStock, num> _f$newValue = Field(
    'newValue',
    _$newValue,
  );
  static ProductAdjustmentStockExpand _$expand(ProductAdjustmentStock v) =>
      v.expand;
  static const Field<ProductAdjustmentStock, ProductAdjustmentStockExpand>
  _f$expand = Field('expand', _$expand);
  static String? _$reason(ProductAdjustmentStock v) => v.reason;
  static const Field<ProductAdjustmentStock, String> _f$reason = Field(
    'reason',
    _$reason,
    opt: true,
  );
  static ProductAdjustmentType _$type(ProductAdjustmentStock v) => v.type;
  static const Field<ProductAdjustmentStock, ProductAdjustmentType> _f$type =
      Field('type', _$type, mode: FieldMode.member);

  @override
  final MappableFields<ProductAdjustmentStock> fields = const {
    #productStock: _f$productStock,
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
    #oldValue: _f$oldValue,
    #newValue: _f$newValue,
    #expand: _f$expand,
    #reason: _f$reason,
    #type: _f$type,
  };

  @override
  final String discriminatorKey = 'type';
  @override
  final dynamic discriminatorValue = ProductAdjustmentType.productStock;
  @override
  late final ClassMapperBase superMapper =
      ProductAdjustmentMapper.ensureInitialized();

  static ProductAdjustmentStock _instantiate(DecodingData data) {
    return ProductAdjustmentStock(
      productStock: data.dec(_f$productStock),
      id: data.dec(_f$id),
      collectionId: data.dec(_f$collectionId),
      collectionName: data.dec(_f$collectionName),
      isDeleted: data.dec(_f$isDeleted),
      created: data.dec(_f$created),
      updated: data.dec(_f$updated),
      oldValue: data.dec(_f$oldValue),
      newValue: data.dec(_f$newValue),
      expand: data.dec(_f$expand),
      reason: data.dec(_f$reason),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductAdjustmentStock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductAdjustmentStock>(map);
  }

  static ProductAdjustmentStock fromJson(String json) {
    return ensureInitialized().decodeJson<ProductAdjustmentStock>(json);
  }
}

mixin ProductAdjustmentStockMappable {
  String toJson() {
    return ProductAdjustmentStockMapper.ensureInitialized()
        .encodeJson<ProductAdjustmentStock>(this as ProductAdjustmentStock);
  }

  Map<String, dynamic> toMap() {
    return ProductAdjustmentStockMapper.ensureInitialized()
        .encodeMap<ProductAdjustmentStock>(this as ProductAdjustmentStock);
  }

  ProductAdjustmentStockCopyWith<
    ProductAdjustmentStock,
    ProductAdjustmentStock,
    ProductAdjustmentStock
  >
  get copyWith =>
      _ProductAdjustmentStockCopyWithImpl<
        ProductAdjustmentStock,
        ProductAdjustmentStock
      >(this as ProductAdjustmentStock, $identity, $identity);
  @override
  String toString() {
    return ProductAdjustmentStockMapper.ensureInitialized().stringifyValue(
      this as ProductAdjustmentStock,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProductAdjustmentStockMapper.ensureInitialized().equalsValue(
      this as ProductAdjustmentStock,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductAdjustmentStockMapper.ensureInitialized().hashValue(
      this as ProductAdjustmentStock,
    );
  }
}

extension ProductAdjustmentStockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductAdjustmentStock, $Out> {
  ProductAdjustmentStockCopyWith<$R, ProductAdjustmentStock, $Out>
  get $asProductAdjustmentStock => $base.as(
    (v, t, t2) => _ProductAdjustmentStockCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ProductAdjustmentStockCopyWith<
  $R,
  $In extends ProductAdjustmentStock,
  $Out
>
    implements ProductAdjustmentCopyWith<$R, $In, $Out> {
  ProductAdjustmentStockExpandCopyWith<
    $R,
    ProductAdjustmentStockExpand,
    ProductAdjustmentStockExpand
  >
  get expand;
  @override
  $R call({
    String? productStock,
    String? id,
    String? collectionId,
    String? collectionName,
    bool? isDeleted,
    DateTime? created,
    DateTime? updated,
    num? oldValue,
    num? newValue,
    ProductAdjustmentStockExpand? expand,
    String? reason,
  });
  ProductAdjustmentStockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProductAdjustmentStockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductAdjustmentStock, $Out>
    implements
        ProductAdjustmentStockCopyWith<$R, ProductAdjustmentStock, $Out> {
  _ProductAdjustmentStockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductAdjustmentStock> $mapper =
      ProductAdjustmentStockMapper.ensureInitialized();
  @override
  ProductAdjustmentStockExpandCopyWith<
    $R,
    ProductAdjustmentStockExpand,
    ProductAdjustmentStockExpand
  >
  get expand => $value.expand.copyWith.$chain((v) => call(expand: v));
  @override
  $R call({
    String? productStock,
    String? id,
    String? collectionId,
    String? collectionName,
    bool? isDeleted,
    Object? created = $none,
    Object? updated = $none,
    num? oldValue,
    num? newValue,
    ProductAdjustmentStockExpand? expand,
    Object? reason = $none,
  }) => $apply(
    FieldCopyWithData({
      if (productStock != null) #productStock: productStock,
      if (id != null) #id: id,
      if (collectionId != null) #collectionId: collectionId,
      if (collectionName != null) #collectionName: collectionName,
      if (isDeleted != null) #isDeleted: isDeleted,
      if (created != $none) #created: created,
      if (updated != $none) #updated: updated,
      if (oldValue != null) #oldValue: oldValue,
      if (newValue != null) #newValue: newValue,
      if (expand != null) #expand: expand,
      if (reason != $none) #reason: reason,
    }),
  );
  @override
  ProductAdjustmentStock $make(CopyWithData data) => ProductAdjustmentStock(
    productStock: data.get(#productStock, or: $value.productStock),
    id: data.get(#id, or: $value.id),
    collectionId: data.get(#collectionId, or: $value.collectionId),
    collectionName: data.get(#collectionName, or: $value.collectionName),
    isDeleted: data.get(#isDeleted, or: $value.isDeleted),
    created: data.get(#created, or: $value.created),
    updated: data.get(#updated, or: $value.updated),
    oldValue: data.get(#oldValue, or: $value.oldValue),
    newValue: data.get(#newValue, or: $value.newValue),
    expand: data.get(#expand, or: $value.expand),
    reason: data.get(#reason, or: $value.reason),
  );

  @override
  ProductAdjustmentStockCopyWith<$R2, ProductAdjustmentStock, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProductAdjustmentStockCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProductAdjustmentStockExpandMapper
    extends ClassMapperBase<ProductAdjustmentStockExpand> {
  ProductAdjustmentStockExpandMapper._();

  static ProductAdjustmentStockExpandMapper? _instance;
  static ProductAdjustmentStockExpandMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(
        _instance = ProductAdjustmentStockExpandMapper._(),
      );
      ProductStockMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductAdjustmentStockExpand';

  static ProductStock _$productStock(ProductAdjustmentStockExpand v) =>
      v.productStock;
  static const Field<ProductAdjustmentStockExpand, ProductStock>
  _f$productStock = Field('productStock', _$productStock);

  @override
  final MappableFields<ProductAdjustmentStockExpand> fields = const {
    #productStock: _f$productStock,
  };

  static ProductAdjustmentStockExpand _instantiate(DecodingData data) {
    return ProductAdjustmentStockExpand(
      productStock: data.dec(_f$productStock),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductAdjustmentStockExpand fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductAdjustmentStockExpand>(map);
  }

  static ProductAdjustmentStockExpand fromJson(String json) {
    return ensureInitialized().decodeJson<ProductAdjustmentStockExpand>(json);
  }
}

mixin ProductAdjustmentStockExpandMappable {
  String toJson() {
    return ProductAdjustmentStockExpandMapper.ensureInitialized()
        .encodeJson<ProductAdjustmentStockExpand>(
          this as ProductAdjustmentStockExpand,
        );
  }

  Map<String, dynamic> toMap() {
    return ProductAdjustmentStockExpandMapper.ensureInitialized()
        .encodeMap<ProductAdjustmentStockExpand>(
          this as ProductAdjustmentStockExpand,
        );
  }

  ProductAdjustmentStockExpandCopyWith<
    ProductAdjustmentStockExpand,
    ProductAdjustmentStockExpand,
    ProductAdjustmentStockExpand
  >
  get copyWith =>
      _ProductAdjustmentStockExpandCopyWithImpl<
        ProductAdjustmentStockExpand,
        ProductAdjustmentStockExpand
      >(this as ProductAdjustmentStockExpand, $identity, $identity);
  @override
  String toString() {
    return ProductAdjustmentStockExpandMapper.ensureInitialized()
        .stringifyValue(this as ProductAdjustmentStockExpand);
  }

  @override
  bool operator ==(Object other) {
    return ProductAdjustmentStockExpandMapper.ensureInitialized().equalsValue(
      this as ProductAdjustmentStockExpand,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductAdjustmentStockExpandMapper.ensureInitialized().hashValue(
      this as ProductAdjustmentStockExpand,
    );
  }
}

extension ProductAdjustmentStockExpandValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductAdjustmentStockExpand, $Out> {
  ProductAdjustmentStockExpandCopyWith<$R, ProductAdjustmentStockExpand, $Out>
  get $asProductAdjustmentStockExpand => $base.as(
    (v, t, t2) => _ProductAdjustmentStockExpandCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ProductAdjustmentStockExpandCopyWith<
  $R,
  $In extends ProductAdjustmentStockExpand,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ProductStockCopyWith<$R, ProductStock, ProductStock> get productStock;
  $R call({ProductStock? productStock});
  ProductAdjustmentStockExpandCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProductAdjustmentStockExpandCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductAdjustmentStockExpand, $Out>
    implements
        ProductAdjustmentStockExpandCopyWith<
          $R,
          ProductAdjustmentStockExpand,
          $Out
        > {
  _ProductAdjustmentStockExpandCopyWithImpl(
    super.value,
    super.then,
    super.then2,
  );

  @override
  late final ClassMapperBase<ProductAdjustmentStockExpand> $mapper =
      ProductAdjustmentStockExpandMapper.ensureInitialized();
  @override
  ProductStockCopyWith<$R, ProductStock, ProductStock> get productStock =>
      $value.productStock.copyWith.$chain((v) => call(productStock: v));
  @override
  $R call({ProductStock? productStock}) => $apply(
    FieldCopyWithData({if (productStock != null) #productStock: productStock}),
  );
  @override
  ProductAdjustmentStockExpand $make(CopyWithData data) =>
      ProductAdjustmentStockExpand(
        productStock: data.get(#productStock, or: $value.productStock),
      );

  @override
  ProductAdjustmentStockExpandCopyWith<$R2, ProductAdjustmentStockExpand, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProductAdjustmentStockExpandCopyWithImpl<$R2, $Out2>($value, $cast, t);
}


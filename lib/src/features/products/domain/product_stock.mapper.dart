// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_stock.dart';

class ProductStockMapper extends ClassMapperBase<ProductStock> {
  ProductStockMapper._();

  static ProductStockMapper? _instance;
  static ProductStockMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductStockMapper._());
      PbRecordMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductStock';

  static String _$id(ProductStock v) => v.id;
  static const Field<ProductStock, String> _f$id = Field('id', _$id);
  static String _$collectionId(ProductStock v) => v.collectionId;
  static const Field<ProductStock, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(ProductStock v) => v.collectionName;
  static const Field<ProductStock, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static DateTime? _$created(ProductStock v) => v.created;
  static const Field<ProductStock, DateTime> _f$created =
      Field('created', _$created);
  static bool _$isDeleted(ProductStock v) => v.isDeleted;
  static const Field<ProductStock, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted);
  static DateTime? _$updated(ProductStock v) => v.updated;
  static const Field<ProductStock, DateTime> _f$updated =
      Field('updated', _$updated);
  static String? _$lotNo(ProductStock v) => v.lotNo;
  static const Field<ProductStock, String> _f$lotNo =
      Field('lotNo', _$lotNo, opt: true);
  static DateTime? _$expiryDate(ProductStock v) => v.expiryDate;
  static const Field<ProductStock, DateTime> _f$expiryDate =
      Field('expiryDate', _$expiryDate, opt: true);
  static String? _$notes(ProductStock v) => v.notes;
  static const Field<ProductStock, String> _f$notes =
      Field('notes', _$notes, opt: true);

  @override
  final MappableFields<ProductStock> fields = const {
    #id: _f$id,
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #created: _f$created,
    #isDeleted: _f$isDeleted,
    #updated: _f$updated,
    #lotNo: _f$lotNo,
    #expiryDate: _f$expiryDate,
    #notes: _f$notes,
  };

  static ProductStock _instantiate(DecodingData data) {
    return ProductStock(
        id: data.dec(_f$id),
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        created: data.dec(_f$created),
        isDeleted: data.dec(_f$isDeleted),
        updated: data.dec(_f$updated),
        lotNo: data.dec(_f$lotNo),
        expiryDate: data.dec(_f$expiryDate),
        notes: data.dec(_f$notes));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductStock fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductStock>(map);
  }

  static ProductStock fromJson(String json) {
    return ensureInitialized().decodeJson<ProductStock>(json);
  }
}

mixin ProductStockMappable {
  String toJson() {
    return ProductStockMapper.ensureInitialized()
        .encodeJson<ProductStock>(this as ProductStock);
  }

  Map<String, dynamic> toMap() {
    return ProductStockMapper.ensureInitialized()
        .encodeMap<ProductStock>(this as ProductStock);
  }

  ProductStockCopyWith<ProductStock, ProductStock, ProductStock> get copyWith =>
      _ProductStockCopyWithImpl<ProductStock, ProductStock>(
          this as ProductStock, $identity, $identity);
  @override
  String toString() {
    return ProductStockMapper.ensureInitialized()
        .stringifyValue(this as ProductStock);
  }

  @override
  bool operator ==(Object other) {
    return ProductStockMapper.ensureInitialized()
        .equalsValue(this as ProductStock, other);
  }

  @override
  int get hashCode {
    return ProductStockMapper.ensureInitialized()
        .hashValue(this as ProductStock);
  }
}

extension ProductStockValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductStock, $Out> {
  ProductStockCopyWith<$R, ProductStock, $Out> get $asProductStock =>
      $base.as((v, t, t2) => _ProductStockCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductStockCopyWith<$R, $In extends ProductStock, $Out>
    implements PbRecordCopyWith<$R, $In, $Out> {
  @override
  $R call(
      {String? id,
      String? collectionId,
      String? collectionName,
      DateTime? created,
      bool? isDeleted,
      DateTime? updated,
      String? lotNo,
      DateTime? expiryDate,
      String? notes});
  ProductStockCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProductStockCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductStock, $Out>
    implements ProductStockCopyWith<$R, ProductStock, $Out> {
  _ProductStockCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductStock> $mapper =
      ProductStockMapper.ensureInitialized();
  @override
  $R call(
          {String? id,
          String? collectionId,
          String? collectionName,
          Object? created = $none,
          bool? isDeleted,
          Object? updated = $none,
          Object? lotNo = $none,
          Object? expiryDate = $none,
          Object? notes = $none}) =>
      $apply(FieldCopyWithData({
        if (id != null) #id: id,
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (created != $none) #created: created,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (updated != $none) #updated: updated,
        if (lotNo != $none) #lotNo: lotNo,
        if (expiryDate != $none) #expiryDate: expiryDate,
        if (notes != $none) #notes: notes
      }));
  @override
  ProductStock $make(CopyWithData data) => ProductStock(
      id: data.get(#id, or: $value.id),
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      created: data.get(#created, or: $value.created),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      updated: data.get(#updated, or: $value.updated),
      lotNo: data.get(#lotNo, or: $value.lotNo),
      expiryDate: data.get(#expiryDate, or: $value.expiryDate),
      notes: data.get(#notes, or: $value.notes));

  @override
  ProductStockCopyWith<$R2, ProductStock, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProductStockCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

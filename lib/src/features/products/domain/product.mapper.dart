// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product.dart';

class ProductMapper extends ClassMapperBase<Product> {
  ProductMapper._();

  static ProductMapper? _instance;
  static ProductMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Product';

  static String _$collectionId(Product v) => v.collectionId;
  static const Field<Product, String> _f$collectionId =
      Field('collectionId', _$collectionId);
  static String _$collectionName(Product v) => v.collectionName;
  static const Field<Product, String> _f$collectionName =
      Field('collectionName', _$collectionName);
  static String _$domain(Product v) => v.domain;
  static const Field<Product, String> _f$domain = Field('domain', _$domain);
  static String _$id(Product v) => v.id;
  static const Field<Product, String> _f$id = Field('id', _$id);
  static String _$name(Product v) => v.name;
  static const Field<Product, String> _f$name = Field('name', _$name);
  static String? _$notes(Product v) => v.notes;
  static const Field<Product, String> _f$notes =
      Field('notes', _$notes, opt: true);
  static String? _$category(Product v) => v.category;
  static const Field<Product, String> _f$category =
      Field('category', _$category, opt: true);
  static bool _$isDeleted(Product v) => v.isDeleted;
  static const Field<Product, bool> _f$isDeleted =
      Field('isDeleted', _$isDeleted, opt: true, def: false);
  static DateTime? _$created(Product v) => v.created;
  static const Field<Product, DateTime> _f$created =
      Field('created', _$created);
  static DateTime? _$updated(Product v) => v.updated;
  static const Field<Product, DateTime> _f$updated =
      Field('updated', _$updated);

  @override
  final MappableFields<Product> fields = const {
    #collectionId: _f$collectionId,
    #collectionName: _f$collectionName,
    #domain: _f$domain,
    #id: _f$id,
    #name: _f$name,
    #notes: _f$notes,
    #category: _f$category,
    #isDeleted: _f$isDeleted,
    #created: _f$created,
    #updated: _f$updated,
  };

  static Product _instantiate(DecodingData data) {
    return Product(
        collectionId: data.dec(_f$collectionId),
        collectionName: data.dec(_f$collectionName),
        domain: data.dec(_f$domain),
        id: data.dec(_f$id),
        name: data.dec(_f$name),
        notes: data.dec(_f$notes),
        category: data.dec(_f$category),
        isDeleted: data.dec(_f$isDeleted),
        created: data.dec(_f$created),
        updated: data.dec(_f$updated));
  }

  @override
  final Function instantiate = _instantiate;

  static Product fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Product>(map);
  }

  static Product fromJson(String json) {
    return ensureInitialized().decodeJson<Product>(json);
  }
}

mixin ProductMappable {
  String toJson() {
    return ProductMapper.ensureInitialized()
        .encodeJson<Product>(this as Product);
  }

  Map<String, dynamic> toMap() {
    return ProductMapper.ensureInitialized()
        .encodeMap<Product>(this as Product);
  }

  ProductCopyWith<Product, Product, Product> get copyWith =>
      _ProductCopyWithImpl<Product, Product>(
          this as Product, $identity, $identity);
  @override
  String toString() {
    return ProductMapper.ensureInitialized().stringifyValue(this as Product);
  }

  @override
  bool operator ==(Object other) {
    return ProductMapper.ensureInitialized()
        .equalsValue(this as Product, other);
  }

  @override
  int get hashCode {
    return ProductMapper.ensureInitialized().hashValue(this as Product);
  }
}

extension ProductValueCopy<$R, $Out> on ObjectCopyWith<$R, Product, $Out> {
  ProductCopyWith<$R, Product, $Out> get $asProduct =>
      $base.as((v, t, t2) => _ProductCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductCopyWith<$R, $In extends Product, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call(
      {String? collectionId,
      String? collectionName,
      String? domain,
      String? id,
      String? name,
      String? notes,
      String? category,
      bool? isDeleted,
      DateTime? created,
      DateTime? updated});
  ProductCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProductCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Product, $Out>
    implements ProductCopyWith<$R, Product, $Out> {
  _ProductCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Product> $mapper =
      ProductMapper.ensureInitialized();
  @override
  $R call(
          {String? collectionId,
          String? collectionName,
          String? domain,
          String? id,
          String? name,
          Object? notes = $none,
          Object? category = $none,
          bool? isDeleted,
          Object? created = $none,
          Object? updated = $none}) =>
      $apply(FieldCopyWithData({
        if (collectionId != null) #collectionId: collectionId,
        if (collectionName != null) #collectionName: collectionName,
        if (domain != null) #domain: domain,
        if (id != null) #id: id,
        if (name != null) #name: name,
        if (notes != $none) #notes: notes,
        if (category != $none) #category: category,
        if (isDeleted != null) #isDeleted: isDeleted,
        if (created != $none) #created: created,
        if (updated != $none) #updated: updated
      }));
  @override
  Product $make(CopyWithData data) => Product(
      collectionId: data.get(#collectionId, or: $value.collectionId),
      collectionName: data.get(#collectionName, or: $value.collectionName),
      domain: data.get(#domain, or: $value.domain),
      id: data.get(#id, or: $value.id),
      name: data.get(#name, or: $value.name),
      notes: data.get(#notes, or: $value.notes),
      category: data.get(#category, or: $value.category),
      isDeleted: data.get(#isDeleted, or: $value.isDeleted),
      created: data.get(#created, or: $value.created),
      updated: data.get(#updated, or: $value.updated));

  @override
  ProductCopyWith<$R2, Product, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProductCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

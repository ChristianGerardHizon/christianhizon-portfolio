// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_form_controller.dart';

class ProductFormStateMapper extends ClassMapperBase<ProductFormState> {
  ProductFormStateMapper._();

  static ProductFormStateMapper? _instance;
  static ProductFormStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductFormStateMapper._());
      ProductMapper.ensureInitialized();
      BranchMapper.ensureInitialized();
      ProductCategoryMapper.ensureInitialized();
      PBImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductFormState';

  static Product? _$product(ProductFormState v) => v.product;
  static const Field<ProductFormState, Product> _f$product =
      Field('product', _$product);
  static List<Branch> _$branches(ProductFormState v) => v.branches;
  static const Field<ProductFormState, List<Branch>> _f$branches =
      Field('branches', _$branches, opt: true, def: const []);
  static List<ProductCategory>? _$categories(ProductFormState v) =>
      v.categories;
  static const Field<ProductFormState, List<ProductCategory>> _f$categories =
      Field('categories', _$categories, opt: true, def: const []);
  static List<PBImage>? _$images(ProductFormState v) => v.images;
  static const Field<ProductFormState, List<PBImage>> _f$images =
      Field('images', _$images, opt: true);

  @override
  final MappableFields<ProductFormState> fields = const {
    #product: _f$product,
    #branches: _f$branches,
    #categories: _f$categories,
    #images: _f$images,
  };

  static ProductFormState _instantiate(DecodingData data) {
    return ProductFormState(
        product: data.dec(_f$product),
        branches: data.dec(_f$branches),
        categories: data.dec(_f$categories),
        images: data.dec(_f$images));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductFormState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductFormState>(map);
  }

  static ProductFormState fromJson(String json) {
    return ensureInitialized().decodeJson<ProductFormState>(json);
  }
}

mixin ProductFormStateMappable {
  String toJson() {
    return ProductFormStateMapper.ensureInitialized()
        .encodeJson<ProductFormState>(this as ProductFormState);
  }

  Map<String, dynamic> toMap() {
    return ProductFormStateMapper.ensureInitialized()
        .encodeMap<ProductFormState>(this as ProductFormState);
  }

  ProductFormStateCopyWith<ProductFormState, ProductFormState, ProductFormState>
      get copyWith =>
          _ProductFormStateCopyWithImpl<ProductFormState, ProductFormState>(
              this as ProductFormState, $identity, $identity);
  @override
  String toString() {
    return ProductFormStateMapper.ensureInitialized()
        .stringifyValue(this as ProductFormState);
  }

  @override
  bool operator ==(Object other) {
    return ProductFormStateMapper.ensureInitialized()
        .equalsValue(this as ProductFormState, other);
  }

  @override
  int get hashCode {
    return ProductFormStateMapper.ensureInitialized()
        .hashValue(this as ProductFormState);
  }
}

extension ProductFormStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductFormState, $Out> {
  ProductFormStateCopyWith<$R, ProductFormState, $Out>
      get $asProductFormState => $base
          .as((v, t, t2) => _ProductFormStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductFormStateCopyWith<$R, $In extends ProductFormState, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ProductCopyWith<$R, Product, Product>? get product;
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches;
  ListCopyWith<$R, ProductCategory,
          ProductCategoryCopyWith<$R, ProductCategory, ProductCategory>>?
      get categories;
  ListCopyWith<$R, PBImage, ObjectCopyWith<$R, PBImage, PBImage>>? get images;
  $R call(
      {Product? product,
      List<Branch>? branches,
      List<ProductCategory>? categories,
      List<PBImage>? images});
  ProductFormStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProductFormStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductFormState, $Out>
    implements ProductFormStateCopyWith<$R, ProductFormState, $Out> {
  _ProductFormStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductFormState> $mapper =
      ProductFormStateMapper.ensureInitialized();
  @override
  ProductCopyWith<$R, Product, Product>? get product =>
      $value.product?.copyWith.$chain((v) => call(product: v));
  @override
  ListCopyWith<$R, Branch, BranchCopyWith<$R, Branch, Branch>> get branches =>
      ListCopyWith($value.branches, (v, t) => v.copyWith.$chain(t),
          (v) => call(branches: v));
  @override
  ListCopyWith<$R, ProductCategory,
          ProductCategoryCopyWith<$R, ProductCategory, ProductCategory>>?
      get categories => $value.categories != null
          ? ListCopyWith($value.categories!, (v, t) => v.copyWith.$chain(t),
              (v) => call(categories: v))
          : null;
  @override
  ListCopyWith<$R, PBImage, ObjectCopyWith<$R, PBImage, PBImage>>? get images =>
      $value.images != null
          ? ListCopyWith($value.images!,
              (v, t) => ObjectCopyWith(v, $identity, t), (v) => call(images: v))
          : null;
  @override
  $R call(
          {Object? product = $none,
          List<Branch>? branches,
          Object? categories = $none,
          Object? images = $none}) =>
      $apply(FieldCopyWithData({
        if (product != $none) #product: product,
        if (branches != null) #branches: branches,
        if (categories != $none) #categories: categories,
        if (images != $none) #images: images
      }));
  @override
  ProductFormState $make(CopyWithData data) => ProductFormState(
      product: data.get(#product, or: $value.product),
      branches: data.get(#branches, or: $value.branches),
      categories: data.get(#categories, or: $value.categories),
      images: data.get(#images, or: $value.images));

  @override
  ProductFormStateCopyWith<$R2, ProductFormState, $Out2> $chain<$R2, $Out2>(
          Then<$Out2, $R2> t) =>
      _ProductFormStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

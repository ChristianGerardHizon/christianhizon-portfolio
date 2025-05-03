// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_category_form_controller.dart';

class ProductCategoryFormStateMapper
    extends ClassMapperBase<ProductCategoryFormState> {
  ProductCategoryFormStateMapper._();

  static ProductCategoryFormStateMapper? _instance;
  static ProductCategoryFormStateMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals
          .use(_instance = ProductCategoryFormStateMapper._());
      ProductCategoryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ProductCategoryFormState';

  static ProductCategory? _$category(ProductCategoryFormState v) => v.category;
  static const Field<ProductCategoryFormState, ProductCategory> _f$category =
      Field('category', _$category);
  static List<ProductCategory> _$categories(ProductCategoryFormState v) =>
      v.categories;
  static const Field<ProductCategoryFormState, List<ProductCategory>>
      _f$categories =
      Field('categories', _$categories, opt: true, def: const []);

  @override
  final MappableFields<ProductCategoryFormState> fields = const {
    #category: _f$category,
    #categories: _f$categories,
  };

  static ProductCategoryFormState _instantiate(DecodingData data) {
    return ProductCategoryFormState(
        category: data.dec(_f$category), categories: data.dec(_f$categories));
  }

  @override
  final Function instantiate = _instantiate;

  static ProductCategoryFormState fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductCategoryFormState>(map);
  }

  static ProductCategoryFormState fromJson(String json) {
    return ensureInitialized().decodeJson<ProductCategoryFormState>(json);
  }
}

mixin ProductCategoryFormStateMappable {
  String toJson() {
    return ProductCategoryFormStateMapper.ensureInitialized()
        .encodeJson<ProductCategoryFormState>(this as ProductCategoryFormState);
  }

  Map<String, dynamic> toMap() {
    return ProductCategoryFormStateMapper.ensureInitialized()
        .encodeMap<ProductCategoryFormState>(this as ProductCategoryFormState);
  }

  ProductCategoryFormStateCopyWith<ProductCategoryFormState,
          ProductCategoryFormState, ProductCategoryFormState>
      get copyWith => _ProductCategoryFormStateCopyWithImpl<
              ProductCategoryFormState, ProductCategoryFormState>(
          this as ProductCategoryFormState, $identity, $identity);
  @override
  String toString() {
    return ProductCategoryFormStateMapper.ensureInitialized()
        .stringifyValue(this as ProductCategoryFormState);
  }

  @override
  bool operator ==(Object other) {
    return ProductCategoryFormStateMapper.ensureInitialized()
        .equalsValue(this as ProductCategoryFormState, other);
  }

  @override
  int get hashCode {
    return ProductCategoryFormStateMapper.ensureInitialized()
        .hashValue(this as ProductCategoryFormState);
  }
}

extension ProductCategoryFormStateValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductCategoryFormState, $Out> {
  ProductCategoryFormStateCopyWith<$R, ProductCategoryFormState, $Out>
      get $asProductCategoryFormState => $base.as((v, t, t2) =>
          _ProductCategoryFormStateCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductCategoryFormStateCopyWith<
    $R,
    $In extends ProductCategoryFormState,
    $Out> implements ClassCopyWith<$R, $In, $Out> {
  ProductCategoryCopyWith<$R, ProductCategory, ProductCategory>? get category;
  ListCopyWith<$R, ProductCategory,
          ProductCategoryCopyWith<$R, ProductCategory, ProductCategory>>
      get categories;
  $R call({ProductCategory? category, List<ProductCategory>? categories});
  ProductCategoryFormStateCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
      Then<$Out2, $R2> t);
}

class _ProductCategoryFormStateCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductCategoryFormState, $Out>
    implements
        ProductCategoryFormStateCopyWith<$R, ProductCategoryFormState, $Out> {
  _ProductCategoryFormStateCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductCategoryFormState> $mapper =
      ProductCategoryFormStateMapper.ensureInitialized();
  @override
  ProductCategoryCopyWith<$R, ProductCategory, ProductCategory>? get category =>
      $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  ListCopyWith<$R, ProductCategory,
          ProductCategoryCopyWith<$R, ProductCategory, ProductCategory>>
      get categories => ListCopyWith($value.categories,
          (v, t) => v.copyWith.$chain(t), (v) => call(categories: v));
  @override
  $R call({Object? category = $none, List<ProductCategory>? categories}) =>
      $apply(FieldCopyWithData({
        if (category != $none) #category: category,
        if (categories != null) #categories: categories
      }));
  @override
  ProductCategoryFormState $make(CopyWithData data) => ProductCategoryFormState(
      category: data.get(#category, or: $value.category),
      categories: data.get(#categories, or: $value.categories));

  @override
  ProductCategoryFormStateCopyWith<$R2, ProductCategoryFormState, $Out2>
      $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
          _ProductCategoryFormStateCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

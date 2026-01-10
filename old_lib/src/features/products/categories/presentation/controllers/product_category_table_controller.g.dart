// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductCategoryTableController)
final productCategoryTableControllerProvider =
    ProductCategoryTableControllerFamily._();

final class ProductCategoryTableControllerProvider
    extends $AsyncNotifierProvider<ProductCategoryTableController,
        List<ProductCategory>> {
  ProductCategoryTableControllerProvider._(
      {required ProductCategoryTableControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'productCategoryTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productCategoryTableControllerHash();

  @override
  String toString() {
    return r'productCategoryTableControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductCategoryTableController create() => ProductCategoryTableController();

  @override
  bool operator ==(Object other) {
    return other is ProductCategoryTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productCategoryTableControllerHash() =>
    r'2479b3836de6d4070102e47144406c4b18a45d48';

final class ProductCategoryTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductCategoryTableController,
            AsyncValue<List<ProductCategory>>,
            List<ProductCategory>,
            FutureOr<List<ProductCategory>>,
            String> {
  ProductCategoryTableControllerFamily._()
      : super(
          retry: null,
          name: r'productCategoryTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductCategoryTableControllerProvider call(
    String tableKey,
  ) =>
      ProductCategoryTableControllerProvider._(argument: tableKey, from: this);

  @override
  String toString() => r'productCategoryTableControllerProvider';
}

abstract class _$ProductCategoryTableController
    extends $AsyncNotifier<List<ProductCategory>> {
  late final _$args = ref.$arg as String;
  String get tableKey => _$args;

  FutureOr<List<ProductCategory>> build(
    String tableKey,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<ProductCategory>>, List<ProductCategory>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<ProductCategory>>, List<ProductCategory>>,
        AsyncValue<List<ProductCategory>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

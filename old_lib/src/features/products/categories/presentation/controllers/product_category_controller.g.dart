// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductCategoryController)
final productCategoryControllerProvider = ProductCategoryControllerFamily._();

final class ProductCategoryControllerProvider extends $AsyncNotifierProvider<
    ProductCategoryController, ProductCategoryState> {
  ProductCategoryControllerProvider._(
      {required ProductCategoryControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'productCategoryControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productCategoryControllerHash();

  @override
  String toString() {
    return r'productCategoryControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductCategoryController create() => ProductCategoryController();

  @override
  bool operator ==(Object other) {
    return other is ProductCategoryControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productCategoryControllerHash() =>
    r'1012b1e1dcd77e98be225354f14cb9ba61c3e7ce';

final class ProductCategoryControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductCategoryController,
            AsyncValue<ProductCategoryState>,
            ProductCategoryState,
            FutureOr<ProductCategoryState>,
            String> {
  ProductCategoryControllerFamily._()
      : super(
          retry: null,
          name: r'productCategoryControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductCategoryControllerProvider call(
    String id,
  ) =>
      ProductCategoryControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'productCategoryControllerProvider';
}

abstract class _$ProductCategoryController
    extends $AsyncNotifier<ProductCategoryState> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<ProductCategoryState> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<ProductCategoryState>, ProductCategoryState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ProductCategoryState>, ProductCategoryState>,
        AsyncValue<ProductCategoryState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

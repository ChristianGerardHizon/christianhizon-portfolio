// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductStockController)
final productStockControllerProvider = ProductStockControllerFamily._();

final class ProductStockControllerProvider
    extends $AsyncNotifierProvider<ProductStockController, ProductStock> {
  ProductStockControllerProvider._(
      {required ProductStockControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'productStockControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productStockControllerHash();

  @override
  String toString() {
    return r'productStockControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductStockController create() => ProductStockController();

  @override
  bool operator ==(Object other) {
    return other is ProductStockControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productStockControllerHash() =>
    r'519cb593ac500c7463a76bab2b282ebb4f25afac';

final class ProductStockControllerFamily extends $Family
    with
        $ClassFamilyOverride<ProductStockController, AsyncValue<ProductStock>,
            ProductStock, FutureOr<ProductStock>, String> {
  ProductStockControllerFamily._()
      : super(
          retry: null,
          name: r'productStockControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductStockControllerProvider call(
    String id,
  ) =>
      ProductStockControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'productStockControllerProvider';
}

abstract class _$ProductStockController extends $AsyncNotifier<ProductStock> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<ProductStock> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProductStock>, ProductStock>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ProductStock>, ProductStock>,
        AsyncValue<ProductStock>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

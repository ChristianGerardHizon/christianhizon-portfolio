// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductStockTableController)
final productStockTableControllerProvider =
    ProductStockTableControllerFamily._();

final class ProductStockTableControllerProvider extends $AsyncNotifierProvider<
    ProductStockTableController, List<ProductStock>> {
  ProductStockTableControllerProvider._(
      {required ProductStockTableControllerFamily super.from,
      required (
        String,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'productStockTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productStockTableControllerHash();

  @override
  String toString() {
    return r'productStockTableControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ProductStockTableController create() => ProductStockTableController();

  @override
  bool operator ==(Object other) {
    return other is ProductStockTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productStockTableControllerHash() =>
    r'9033a25d7c98d6ef4e8f623b595efe46df8dce81';

final class ProductStockTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductStockTableController,
            AsyncValue<List<ProductStock>>,
            List<ProductStock>,
            FutureOr<List<ProductStock>>,
            (
              String,
              String,
            )> {
  ProductStockTableControllerFamily._()
      : super(
          retry: null,
          name: r'productStockTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductStockTableControllerProvider call(
    String tableKey,
    String productId,
  ) =>
      ProductStockTableControllerProvider._(argument: (
        tableKey,
        productId,
      ), from: this);

  @override
  String toString() => r'productStockTableControllerProvider';
}

abstract class _$ProductStockTableController
    extends $AsyncNotifier<List<ProductStock>> {
  late final _$args = ref.$arg as (
    String,
    String,
  );
  String get tableKey => _$args.$1;
  String get productId => _$args.$2;

  FutureOr<List<ProductStock>> build(
    String tableKey,
    String productId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<ProductStock>>, List<ProductStock>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<ProductStock>>, List<ProductStock>>,
        AsyncValue<List<ProductStock>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args.$1,
              _$args.$2,
            ));
  }
}

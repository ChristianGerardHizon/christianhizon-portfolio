// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_adjustment_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductAdjustmentTableController)
final productAdjustmentTableControllerProvider =
    ProductAdjustmentTableControllerFamily._();

final class ProductAdjustmentTableControllerProvider
    extends $AsyncNotifierProvider<ProductAdjustmentTableController,
        List<ProductAdjustment>> {
  ProductAdjustmentTableControllerProvider._(
      {required ProductAdjustmentTableControllerFamily super.from,
      required (
        String, {
        String? productId,
        String? productStockId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'productAdjustmentTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productAdjustmentTableControllerHash();

  @override
  String toString() {
    return r'productAdjustmentTableControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ProductAdjustmentTableController create() =>
      ProductAdjustmentTableController();

  @override
  bool operator ==(Object other) {
    return other is ProductAdjustmentTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productAdjustmentTableControllerHash() =>
    r'd5bffd45c3f36f9f4355419cc79c98c757b9326b';

final class ProductAdjustmentTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductAdjustmentTableController,
            AsyncValue<List<ProductAdjustment>>,
            List<ProductAdjustment>,
            FutureOr<List<ProductAdjustment>>,
            (
              String, {
              String? productId,
              String? productStockId,
            })> {
  ProductAdjustmentTableControllerFamily._()
      : super(
          retry: null,
          name: r'productAdjustmentTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductAdjustmentTableControllerProvider call(
    String tableKey, {
    String? productId,
    String? productStockId,
  }) =>
      ProductAdjustmentTableControllerProvider._(argument: (
        tableKey,
        productId: productId,
        productStockId: productStockId,
      ), from: this);

  @override
  String toString() => r'productAdjustmentTableControllerProvider';
}

abstract class _$ProductAdjustmentTableController
    extends $AsyncNotifier<List<ProductAdjustment>> {
  late final _$args = ref.$arg as (
    String, {
    String? productId,
    String? productStockId,
  });
  String get tableKey => _$args.$1;
  String? get productId => _$args.productId;
  String? get productStockId => _$args.productStockId;

  FutureOr<List<ProductAdjustment>> build(
    String tableKey, {
    String? productId,
    String? productStockId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<ProductAdjustment>>, List<ProductAdjustment>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<ProductAdjustment>>,
            List<ProductAdjustment>>,
        AsyncValue<List<ProductAdjustment>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args.$1,
              productId: _$args.productId,
              productStockId: _$args.productStockId,
            ));
  }
}

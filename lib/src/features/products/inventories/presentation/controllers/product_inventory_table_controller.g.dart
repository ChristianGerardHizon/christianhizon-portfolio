// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_inventory_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductInventoryTableController)
final productInventoryTableControllerProvider =
    ProductInventoryTableControllerFamily._();

final class ProductInventoryTableControllerProvider
    extends $AsyncNotifierProvider<ProductInventoryTableController,
        List<ProductInventory>> {
  ProductInventoryTableControllerProvider._(
      {required ProductInventoryTableControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'productInventoryTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productInventoryTableControllerHash();

  @override
  String toString() {
    return r'productInventoryTableControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductInventoryTableController create() => ProductInventoryTableController();

  @override
  bool operator ==(Object other) {
    return other is ProductInventoryTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productInventoryTableControllerHash() =>
    r'fe5adbef17f903242c25d118a46530060e2636cc';

final class ProductInventoryTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductInventoryTableController,
            AsyncValue<List<ProductInventory>>,
            List<ProductInventory>,
            FutureOr<List<ProductInventory>>,
            String> {
  ProductInventoryTableControllerFamily._()
      : super(
          retry: null,
          name: r'productInventoryTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductInventoryTableControllerProvider call(
    String tableKey,
  ) =>
      ProductInventoryTableControllerProvider._(argument: tableKey, from: this);

  @override
  String toString() => r'productInventoryTableControllerProvider';
}

abstract class _$ProductInventoryTableController
    extends $AsyncNotifier<List<ProductInventory>> {
  late final _$args = ref.$arg as String;
  String get tableKey => _$args;

  FutureOr<List<ProductInventory>> build(
    String tableKey,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<ProductInventory>>, List<ProductInventory>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<ProductInventory>>, List<ProductInventory>>,
        AsyncValue<List<ProductInventory>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

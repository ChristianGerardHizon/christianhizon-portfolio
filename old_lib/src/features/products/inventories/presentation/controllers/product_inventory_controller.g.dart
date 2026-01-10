// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_inventory_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductInventoryController)
final productInventoryControllerProvider = ProductInventoryControllerFamily._();

final class ProductInventoryControllerProvider extends $AsyncNotifierProvider<
    ProductInventoryController, ProductInventory> {
  ProductInventoryControllerProvider._(
      {required ProductInventoryControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'productInventoryControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productInventoryControllerHash();

  @override
  String toString() {
    return r'productInventoryControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductInventoryController create() => ProductInventoryController();

  @override
  bool operator ==(Object other) {
    return other is ProductInventoryControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productInventoryControllerHash() =>
    r'13f999366730c304e2c265eb806902477af90b69';

final class ProductInventoryControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductInventoryController,
            AsyncValue<ProductInventory>,
            ProductInventory,
            FutureOr<ProductInventory>,
            String> {
  ProductInventoryControllerFamily._()
      : super(
          retry: null,
          name: r'productInventoryControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductInventoryControllerProvider call(
    String id,
  ) =>
      ProductInventoryControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'productInventoryControllerProvider';
}

abstract class _$ProductInventoryController
    extends $AsyncNotifier<ProductInventory> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<ProductInventory> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ProductInventory>, ProductInventory>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ProductInventory>, ProductInventory>,
        AsyncValue<ProductInventory>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

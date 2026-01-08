// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_stock_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductStockFormController)
final productStockFormControllerProvider = ProductStockFormControllerFamily._();

final class ProductStockFormControllerProvider extends $AsyncNotifierProvider<
    ProductStockFormController, ProductStockFormState> {
  ProductStockFormControllerProvider._(
      {required ProductStockFormControllerFamily super.from,
      required (
        String?,
        String,
      )
          super.argument})
      : super(
          retry: null,
          name: r'productStockFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productStockFormControllerHash();

  @override
  String toString() {
    return r'productStockFormControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ProductStockFormController create() => ProductStockFormController();

  @override
  bool operator ==(Object other) {
    return other is ProductStockFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productStockFormControllerHash() =>
    r'a1cc548a543d02c82a961f241d7ea6bfcb5d06fd';

final class ProductStockFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductStockFormController,
            AsyncValue<ProductStockFormState>,
            ProductStockFormState,
            FutureOr<ProductStockFormState>,
            (
              String?,
              String,
            )> {
  ProductStockFormControllerFamily._()
      : super(
          retry: null,
          name: r'productStockFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductStockFormControllerProvider call(
    String? id,
    String productId,
  ) =>
      ProductStockFormControllerProvider._(argument: (
        id,
        productId,
      ), from: this);

  @override
  String toString() => r'productStockFormControllerProvider';
}

abstract class _$ProductStockFormController
    extends $AsyncNotifier<ProductStockFormState> {
  late final _$args = ref.$arg as (
    String?,
    String,
  );
  String? get id => _$args.$1;
  String get productId => _$args.$2;

  FutureOr<ProductStockFormState> build(
    String? id,
    String productId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<ProductStockFormState>, ProductStockFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ProductStockFormState>, ProductStockFormState>,
        AsyncValue<ProductStockFormState>,
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

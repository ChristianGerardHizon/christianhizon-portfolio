// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_adjustment_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductAdjustmentFormController)
final productAdjustmentFormControllerProvider =
    ProductAdjustmentFormControllerFamily._();

final class ProductAdjustmentFormControllerProvider
    extends $AsyncNotifierProvider<ProductAdjustmentFormController,
        ProductAdjustmentFormState> {
  ProductAdjustmentFormControllerProvider._(
      {required ProductAdjustmentFormControllerFamily super.from,
      required ({
        String? id,
        String? productId,
        String? productStockId,
      })
          super.argument})
      : super(
          retry: null,
          name: r'productAdjustmentFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productAdjustmentFormControllerHash();

  @override
  String toString() {
    return r'productAdjustmentFormControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  ProductAdjustmentFormController create() => ProductAdjustmentFormController();

  @override
  bool operator ==(Object other) {
    return other is ProductAdjustmentFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productAdjustmentFormControllerHash() =>
    r'2fda13c1a21b62a5c418b11d06dd2ebe5bef69f1';

final class ProductAdjustmentFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductAdjustmentFormController,
            AsyncValue<ProductAdjustmentFormState>,
            ProductAdjustmentFormState,
            FutureOr<ProductAdjustmentFormState>,
            ({
              String? id,
              String? productId,
              String? productStockId,
            })> {
  ProductAdjustmentFormControllerFamily._()
      : super(
          retry: null,
          name: r'productAdjustmentFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductAdjustmentFormControllerProvider call({
    String? id,
    String? productId,
    String? productStockId,
  }) =>
      ProductAdjustmentFormControllerProvider._(argument: (
        id: id,
        productId: productId,
        productStockId: productStockId,
      ), from: this);

  @override
  String toString() => r'productAdjustmentFormControllerProvider';
}

abstract class _$ProductAdjustmentFormController
    extends $AsyncNotifier<ProductAdjustmentFormState> {
  late final _$args = ref.$arg as ({
    String? id,
    String? productId,
    String? productStockId,
  });
  String? get id => _$args.id;
  String? get productId => _$args.productId;
  String? get productStockId => _$args.productStockId;

  FutureOr<ProductAdjustmentFormState> build({
    String? id,
    String? productId,
    String? productStockId,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProductAdjustmentFormState>,
        ProductAdjustmentFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ProductAdjustmentFormState>,
            ProductAdjustmentFormState>,
        AsyncValue<ProductAdjustmentFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              id: _$args.id,
              productId: _$args.productId,
              productStockId: _$args.productStockId,
            ));
  }
}

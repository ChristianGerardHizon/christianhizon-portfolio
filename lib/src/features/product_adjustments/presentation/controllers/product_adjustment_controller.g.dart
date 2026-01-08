// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_adjustment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductAdjustmentController)
final productAdjustmentControllerProvider =
    ProductAdjustmentControllerFamily._();

final class ProductAdjustmentControllerProvider extends $AsyncNotifierProvider<
    ProductAdjustmentController, ProductAdjustment> {
  ProductAdjustmentControllerProvider._(
      {required ProductAdjustmentControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'productAdjustmentControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productAdjustmentControllerHash();

  @override
  String toString() {
    return r'productAdjustmentControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductAdjustmentController create() => ProductAdjustmentController();

  @override
  bool operator ==(Object other) {
    return other is ProductAdjustmentControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productAdjustmentControllerHash() =>
    r'1b8e7b5637173aebfa5ae402a7ac8f022e8a4af3';

final class ProductAdjustmentControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductAdjustmentController,
            AsyncValue<ProductAdjustment>,
            ProductAdjustment,
            FutureOr<ProductAdjustment>,
            String> {
  ProductAdjustmentControllerFamily._()
      : super(
          retry: null,
          name: r'productAdjustmentControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductAdjustmentControllerProvider call(
    String id,
  ) =>
      ProductAdjustmentControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'productAdjustmentControllerProvider';
}

abstract class _$ProductAdjustmentController
    extends $AsyncNotifier<ProductAdjustment> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<ProductAdjustment> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ProductAdjustment>, ProductAdjustment>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ProductAdjustment>, ProductAdjustment>,
        AsyncValue<ProductAdjustment>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

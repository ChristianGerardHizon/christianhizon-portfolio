// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductFormController)
final productFormControllerProvider = ProductFormControllerFamily._();

final class ProductFormControllerProvider
    extends $AsyncNotifierProvider<ProductFormController, ProductFormState> {
  ProductFormControllerProvider._(
      {required ProductFormControllerFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'productFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productFormControllerHash();

  @override
  String toString() {
    return r'productFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductFormController create() => ProductFormController();

  @override
  bool operator ==(Object other) {
    return other is ProductFormControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productFormControllerHash() =>
    r'ba3159b260f68f7d9b351dd7c4a1f5de3d2cd647';

final class ProductFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductFormController,
            AsyncValue<ProductFormState>,
            ProductFormState,
            FutureOr<ProductFormState>,
            String?> {
  ProductFormControllerFamily._()
      : super(
          retry: null,
          name: r'productFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductFormControllerProvider call(
    String? id,
  ) =>
      ProductFormControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'productFormControllerProvider';
}

abstract class _$ProductFormController
    extends $AsyncNotifier<ProductFormState> {
  late final _$args = ref.$arg as String?;
  String? get id => _$args;

  FutureOr<ProductFormState> build(
    String? id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<ProductFormState>, ProductFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ProductFormState>, ProductFormState>,
        AsyncValue<ProductFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

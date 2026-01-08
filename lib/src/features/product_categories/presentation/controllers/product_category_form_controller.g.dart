// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_category_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductCategoryFormController)
final productCategoryFormControllerProvider =
    ProductCategoryFormControllerFamily._();

final class ProductCategoryFormControllerProvider
    extends $AsyncNotifierProvider<ProductCategoryFormController,
        ProductCategoryFormState> {
  ProductCategoryFormControllerProvider._(
      {required ProductCategoryFormControllerFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'productCategoryFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productCategoryFormControllerHash();

  @override
  String toString() {
    return r'productCategoryFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductCategoryFormController create() => ProductCategoryFormController();

  @override
  bool operator ==(Object other) {
    return other is ProductCategoryFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productCategoryFormControllerHash() =>
    r'31728e638887fe02555e60ae3d2bd84789ec69c6';

final class ProductCategoryFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ProductCategoryFormController,
            AsyncValue<ProductCategoryFormState>,
            ProductCategoryFormState,
            FutureOr<ProductCategoryFormState>,
            String?> {
  ProductCategoryFormControllerFamily._()
      : super(
          retry: null,
          name: r'productCategoryFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductCategoryFormControllerProvider call(
    String? id,
  ) =>
      ProductCategoryFormControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'productCategoryFormControllerProvider';
}

abstract class _$ProductCategoryFormController
    extends $AsyncNotifier<ProductCategoryFormState> {
  late final _$args = ref.$arg as String?;
  String? get id => _$args;

  FutureOr<ProductCategoryFormState> build(
    String? id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<ProductCategoryFormState>, ProductCategoryFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ProductCategoryFormState>,
            ProductCategoryFormState>,
        AsyncValue<ProductCategoryFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

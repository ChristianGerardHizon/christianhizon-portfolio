// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductController)
final productControllerProvider = ProductControllerFamily._();

final class ProductControllerProvider
    extends $AsyncNotifierProvider<ProductController, ProductState> {
  ProductControllerProvider._(
      {required ProductControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'productControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productControllerHash();

  @override
  String toString() {
    return r'productControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductController create() => ProductController();

  @override
  bool operator ==(Object other) {
    return other is ProductControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productControllerHash() => r'8ef7beca98a4916fdd23ffce375f0ea913950bfd';

final class ProductControllerFamily extends $Family
    with
        $ClassFamilyOverride<ProductController, AsyncValue<ProductState>,
            ProductState, FutureOr<ProductState>, String> {
  ProductControllerFamily._()
      : super(
          retry: null,
          name: r'productControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductControllerProvider call(
    String id,
  ) =>
      ProductControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'productControllerProvider';
}

abstract class _$ProductController extends $AsyncNotifier<ProductState> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<ProductState> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ProductState>, ProductState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ProductState>, ProductState>,
        AsyncValue<ProductState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

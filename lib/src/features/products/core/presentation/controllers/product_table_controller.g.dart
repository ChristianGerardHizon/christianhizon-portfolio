// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ProductTableController)
final productTableControllerProvider = ProductTableControllerFamily._();

final class ProductTableControllerProvider
    extends $AsyncNotifierProvider<ProductTableController, List<Product>> {
  ProductTableControllerProvider._(
      {required ProductTableControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'productTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productTableControllerHash();

  @override
  String toString() {
    return r'productTableControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ProductTableController create() => ProductTableController();

  @override
  bool operator ==(Object other) {
    return other is ProductTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$productTableControllerHash() =>
    r'9c5ec15cd8f3fbaad97fed221590341883c78684';

final class ProductTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<ProductTableController, AsyncValue<List<Product>>,
            List<Product>, FutureOr<List<Product>>, String> {
  ProductTableControllerFamily._()
      : super(
          retry: null,
          name: r'productTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ProductTableControllerProvider call(
    String tableKey,
  ) =>
      ProductTableControllerProvider._(argument: tableKey, from: this);

  @override
  String toString() => r'productTableControllerProvider';
}

abstract class _$ProductTableController extends $AsyncNotifier<List<Product>> {
  late final _$args = ref.$arg as String;
  String get tableKey => _$args;

  FutureOr<List<Product>> build(
    String tableKey,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Product>>, List<Product>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Product>>, List<Product>>,
        AsyncValue<List<Product>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

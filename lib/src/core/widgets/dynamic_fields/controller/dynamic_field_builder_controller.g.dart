// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_field_builder_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$dynamicFieldBuilderControllerHash() =>
    r'c01977a33670c1923fbde4f0e4c49987e360974e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DynamicFieldBuilderController
    extends BuildlessAutoDisposeAsyncNotifier<
        DynamicFieldBuilderControllerState> {
  late final List<DynamicField> list;

  FutureOr<DynamicFieldBuilderControllerState> build(
    List<DynamicField> list,
  );
}

/// See also [DynamicFieldBuilderController].
@ProviderFor(DynamicFieldBuilderController)
const dynamicFieldBuilderControllerProvider =
    DynamicFieldBuilderControllerFamily();

/// See also [DynamicFieldBuilderController].
class DynamicFieldBuilderControllerFamily
    extends Family<AsyncValue<DynamicFieldBuilderControllerState>> {
  /// See also [DynamicFieldBuilderController].
  const DynamicFieldBuilderControllerFamily();

  /// See also [DynamicFieldBuilderController].
  DynamicFieldBuilderControllerProvider call(
    List<DynamicField> list,
  ) {
    return DynamicFieldBuilderControllerProvider(
      list,
    );
  }

  @override
  DynamicFieldBuilderControllerProvider getProviderOverride(
    covariant DynamicFieldBuilderControllerProvider provider,
  ) {
    return call(
      provider.list,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'dynamicFieldBuilderControllerProvider';
}

/// See also [DynamicFieldBuilderController].
class DynamicFieldBuilderControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<DynamicFieldBuilderController,
        DynamicFieldBuilderControllerState> {
  /// See also [DynamicFieldBuilderController].
  DynamicFieldBuilderControllerProvider(
    List<DynamicField> list,
  ) : this._internal(
          () => DynamicFieldBuilderController()..list = list,
          from: dynamicFieldBuilderControllerProvider,
          name: r'dynamicFieldBuilderControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$dynamicFieldBuilderControllerHash,
          dependencies: DynamicFieldBuilderControllerFamily._dependencies,
          allTransitiveDependencies:
              DynamicFieldBuilderControllerFamily._allTransitiveDependencies,
          list: list,
        );

  DynamicFieldBuilderControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.list,
  }) : super.internal();

  final List<DynamicField> list;

  @override
  FutureOr<DynamicFieldBuilderControllerState> runNotifierBuild(
    covariant DynamicFieldBuilderController notifier,
  ) {
    return notifier.build(
      list,
    );
  }

  @override
  Override overrideWith(DynamicFieldBuilderController Function() create) {
    return ProviderOverride(
      origin: this,
      override: DynamicFieldBuilderControllerProvider._internal(
        () => create()..list = list,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        list: list,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<DynamicFieldBuilderController,
      DynamicFieldBuilderControllerState> createElement() {
    return _DynamicFieldBuilderControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is DynamicFieldBuilderControllerProvider && other.list == list;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, list.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin DynamicFieldBuilderControllerRef
    on AutoDisposeAsyncNotifierProviderRef<DynamicFieldBuilderControllerState> {
  /// The parameter `list` of this provider.
  List<DynamicField> get list;
}

class _DynamicFieldBuilderControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        DynamicFieldBuilderController, DynamicFieldBuilderControllerState>
    with DynamicFieldBuilderControllerRef {
  _DynamicFieldBuilderControllerProviderElement(super.provider);

  @override
  List<DynamicField> get list =>
      (origin as DynamicFieldBuilderControllerProvider).list;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

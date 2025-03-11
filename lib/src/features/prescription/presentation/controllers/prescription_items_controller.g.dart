// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_items_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prescriptionItemsControllerHash() =>
    r'30484455301dbaaa5dde774b10cccfce997fa5e2';

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

abstract class _$PrescriptionItemsController
    extends BuildlessAutoDisposeAsyncNotifier<PageResults<PrescriptionItem>> {
  late final String? id;

  FutureOr<PageResults<PrescriptionItem>> build({
    String? id,
  });
}

/// See also [PrescriptionItemsController].
@ProviderFor(PrescriptionItemsController)
const prescriptionItemsControllerProvider = PrescriptionItemsControllerFamily();

/// See also [PrescriptionItemsController].
class PrescriptionItemsControllerFamily
    extends Family<AsyncValue<PageResults<PrescriptionItem>>> {
  /// See also [PrescriptionItemsController].
  const PrescriptionItemsControllerFamily();

  /// See also [PrescriptionItemsController].
  PrescriptionItemsControllerProvider call({
    String? id,
  }) {
    return PrescriptionItemsControllerProvider(
      id: id,
    );
  }

  @override
  PrescriptionItemsControllerProvider getProviderOverride(
    covariant PrescriptionItemsControllerProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'prescriptionItemsControllerProvider';
}

/// See also [PrescriptionItemsController].
class PrescriptionItemsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PrescriptionItemsController,
        PageResults<PrescriptionItem>> {
  /// See also [PrescriptionItemsController].
  PrescriptionItemsControllerProvider({
    String? id,
  }) : this._internal(
          () => PrescriptionItemsController()..id = id,
          from: prescriptionItemsControllerProvider,
          name: r'prescriptionItemsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$prescriptionItemsControllerHash,
          dependencies: PrescriptionItemsControllerFamily._dependencies,
          allTransitiveDependencies:
              PrescriptionItemsControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PrescriptionItemsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  FutureOr<PageResults<PrescriptionItem>> runNotifierBuild(
    covariant PrescriptionItemsController notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }

  @override
  Override overrideWith(PrescriptionItemsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PrescriptionItemsControllerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PrescriptionItemsController,
      PageResults<PrescriptionItem>> createElement() {
    return _PrescriptionItemsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrescriptionItemsControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PrescriptionItemsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PageResults<PrescriptionItem>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _PrescriptionItemsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PrescriptionItemsController,
        PageResults<PrescriptionItem>> with PrescriptionItemsControllerRef {
  _PrescriptionItemsControllerProviderElement(super.provider);

  @override
  String? get id => (origin as PrescriptionItemsControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_all_items_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$prescriptionAllItemsControllerHash() =>
    r'4fdd967c681af4c099d58da67f6102867ea6ca59';

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

abstract class _$PrescriptionAllItemsController
    extends BuildlessAutoDisposeAsyncNotifier<List<PrescriptionItem>> {
  late final String id;

  FutureOr<List<PrescriptionItem>> build({
    required String id,
  });
}

/// See also [PrescriptionAllItemsController].
@ProviderFor(PrescriptionAllItemsController)
const prescriptionAllItemsControllerProvider =
    PrescriptionAllItemsControllerFamily();

/// See also [PrescriptionAllItemsController].
class PrescriptionAllItemsControllerFamily
    extends Family<AsyncValue<List<PrescriptionItem>>> {
  /// See also [PrescriptionAllItemsController].
  const PrescriptionAllItemsControllerFamily();

  /// See also [PrescriptionAllItemsController].
  PrescriptionAllItemsControllerProvider call({
    required String id,
  }) {
    return PrescriptionAllItemsControllerProvider(
      id: id,
    );
  }

  @override
  PrescriptionAllItemsControllerProvider getProviderOverride(
    covariant PrescriptionAllItemsControllerProvider provider,
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
  String? get name => r'prescriptionAllItemsControllerProvider';
}

/// See also [PrescriptionAllItemsController].
class PrescriptionAllItemsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PrescriptionAllItemsController,
        List<PrescriptionItem>> {
  /// See also [PrescriptionAllItemsController].
  PrescriptionAllItemsControllerProvider({
    required String id,
  }) : this._internal(
          () => PrescriptionAllItemsController()..id = id,
          from: prescriptionAllItemsControllerProvider,
          name: r'prescriptionAllItemsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$prescriptionAllItemsControllerHash,
          dependencies: PrescriptionAllItemsControllerFamily._dependencies,
          allTransitiveDependencies:
              PrescriptionAllItemsControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PrescriptionAllItemsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<List<PrescriptionItem>> runNotifierBuild(
    covariant PrescriptionAllItemsController notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }

  @override
  Override overrideWith(PrescriptionAllItemsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PrescriptionAllItemsControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PrescriptionAllItemsController,
      List<PrescriptionItem>> createElement() {
    return _PrescriptionAllItemsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PrescriptionAllItemsControllerProvider && other.id == id;
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
mixin PrescriptionAllItemsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<PrescriptionItem>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PrescriptionAllItemsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PrescriptionAllItemsController,
        List<PrescriptionItem>> with PrescriptionAllItemsControllerRef {
  _PrescriptionAllItemsControllerProviderElement(super.provider);

  @override
  String get id => (origin as PrescriptionAllItemsControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

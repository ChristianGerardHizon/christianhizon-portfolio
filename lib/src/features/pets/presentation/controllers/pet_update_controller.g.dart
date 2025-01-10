// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_update_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petUpdateControllerHash() =>
    r'da64c53c52ac7e293d4ce1618699b2efe722c7e1';

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

abstract class _$PetUpdateController
    extends BuildlessAutoDisposeAsyncNotifier<PetUpdateState> {
  late final String id;

  FutureOr<PetUpdateState> build(
    String id,
  );
}

/// See also [PetUpdateController].
@ProviderFor(PetUpdateController)
const petUpdateControllerProvider = PetUpdateControllerFamily();

/// See also [PetUpdateController].
class PetUpdateControllerFamily extends Family<AsyncValue<PetUpdateState>> {
  /// See also [PetUpdateController].
  const PetUpdateControllerFamily();

  /// See also [PetUpdateController].
  PetUpdateControllerProvider call(
    String id,
  ) {
    return PetUpdateControllerProvider(
      id,
    );
  }

  @override
  PetUpdateControllerProvider getProviderOverride(
    covariant PetUpdateControllerProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'petUpdateControllerProvider';
}

/// See also [PetUpdateController].
class PetUpdateControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    PetUpdateController, PetUpdateState> {
  /// See also [PetUpdateController].
  PetUpdateControllerProvider(
    String id,
  ) : this._internal(
          () => PetUpdateController()..id = id,
          from: petUpdateControllerProvider,
          name: r'petUpdateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$petUpdateControllerHash,
          dependencies: PetUpdateControllerFamily._dependencies,
          allTransitiveDependencies:
              PetUpdateControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PetUpdateControllerProvider._internal(
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
  FutureOr<PetUpdateState> runNotifierBuild(
    covariant PetUpdateController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PetUpdateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PetUpdateControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PetUpdateController, PetUpdateState>
      createElement() {
    return _PetUpdateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PetUpdateControllerProvider && other.id == id;
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
mixin PetUpdateControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PetUpdateState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PetUpdateControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PetUpdateController,
        PetUpdateState> with PetUpdateControllerRef {
  _PetUpdateControllerProviderElement(super.provider);

  @override
  String get id => (origin as PetUpdateControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

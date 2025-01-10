// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$petControllerHash() => r'a8cebba7017a7eba551cc4eaf835165ade0fd855';

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

abstract class _$PetController extends BuildlessAutoDisposeAsyncNotifier<Pet> {
  late final String id;

  FutureOr<Pet> build(
    String id,
  );
}

/// See also [PetController].
@ProviderFor(PetController)
const petControllerProvider = PetControllerFamily();

/// See also [PetController].
class PetControllerFamily extends Family<AsyncValue<Pet>> {
  /// See also [PetController].
  const PetControllerFamily();

  /// See also [PetController].
  PetControllerProvider call(
    String id,
  ) {
    return PetControllerProvider(
      id,
    );
  }

  @override
  PetControllerProvider getProviderOverride(
    covariant PetControllerProvider provider,
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
  String? get name => r'petControllerProvider';
}

/// See also [PetController].
class PetControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PetController, Pet> {
  /// See also [PetController].
  PetControllerProvider(
    String id,
  ) : this._internal(
          () => PetController()..id = id,
          from: petControllerProvider,
          name: r'petControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$petControllerHash,
          dependencies: PetControllerFamily._dependencies,
          allTransitiveDependencies:
              PetControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PetControllerProvider._internal(
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
  FutureOr<Pet> runNotifierBuild(
    covariant PetController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PetController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PetControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PetController, Pet> createElement() {
    return _PetControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PetControllerProvider && other.id == id;
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
mixin PetControllerRef on AutoDisposeAsyncNotifierProviderRef<Pet> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PetControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PetController, Pet>
    with PetControllerRef {
  _PetControllerProviderElement(super.provider);

  @override
  String get id => (origin as PetControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

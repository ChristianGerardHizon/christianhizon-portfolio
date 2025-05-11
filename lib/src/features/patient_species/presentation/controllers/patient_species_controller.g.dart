// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_species_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientSpeciesControllerHash() =>
    r'fba4aec1076ab21aeb2eb574899398266befd463';

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

abstract class _$PatientSpeciesController
    extends BuildlessAutoDisposeAsyncNotifier<PatientSpecies> {
  late final String id;

  FutureOr<PatientSpecies> build(
    String id,
  );
}

/// See also [PatientSpeciesController].
@ProviderFor(PatientSpeciesController)
const patientSpeciesControllerProvider = PatientSpeciesControllerFamily();

/// See also [PatientSpeciesController].
class PatientSpeciesControllerFamily
    extends Family<AsyncValue<PatientSpecies>> {
  /// See also [PatientSpeciesController].
  const PatientSpeciesControllerFamily();

  /// See also [PatientSpeciesController].
  PatientSpeciesControllerProvider call(
    String id,
  ) {
    return PatientSpeciesControllerProvider(
      id,
    );
  }

  @override
  PatientSpeciesControllerProvider getProviderOverride(
    covariant PatientSpeciesControllerProvider provider,
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
  String? get name => r'patientSpeciesControllerProvider';
}

/// See also [PatientSpeciesController].
class PatientSpeciesControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientSpeciesController,
        PatientSpecies> {
  /// See also [PatientSpeciesController].
  PatientSpeciesControllerProvider(
    String id,
  ) : this._internal(
          () => PatientSpeciesController()..id = id,
          from: patientSpeciesControllerProvider,
          name: r'patientSpeciesControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientSpeciesControllerHash,
          dependencies: PatientSpeciesControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientSpeciesControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientSpeciesControllerProvider._internal(
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
  FutureOr<PatientSpecies> runNotifierBuild(
    covariant PatientSpeciesController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientSpeciesController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientSpeciesControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientSpeciesController,
      PatientSpecies> createElement() {
    return _PatientSpeciesControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientSpeciesControllerProvider && other.id == id;
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
mixin PatientSpeciesControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientSpecies> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientSpeciesControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientSpeciesController,
        PatientSpecies> with PatientSpeciesControllerRef {
  _PatientSpeciesControllerProviderElement(super.provider);

  @override
  String get id => (origin as PatientSpeciesControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

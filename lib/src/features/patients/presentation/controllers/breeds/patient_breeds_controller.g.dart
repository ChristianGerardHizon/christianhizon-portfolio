// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_breeds_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientBreedsControllerHash() =>
    r'9a443a3dacd1a0ab63800231f71972c1d9be0aaa';

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

abstract class _$PatientBreedsController
    extends BuildlessAutoDisposeAsyncNotifier<List<PatientBreed>> {
  late final String speciesId;

  FutureOr<List<PatientBreed>> build(
    String speciesId,
  );
}

/// See also [PatientBreedsController].
@ProviderFor(PatientBreedsController)
const patientBreedsControllerProvider = PatientBreedsControllerFamily();

/// See also [PatientBreedsController].
class PatientBreedsControllerFamily
    extends Family<AsyncValue<List<PatientBreed>>> {
  /// See also [PatientBreedsController].
  const PatientBreedsControllerFamily();

  /// See also [PatientBreedsController].
  PatientBreedsControllerProvider call(
    String speciesId,
  ) {
    return PatientBreedsControllerProvider(
      speciesId,
    );
  }

  @override
  PatientBreedsControllerProvider getProviderOverride(
    covariant PatientBreedsControllerProvider provider,
  ) {
    return call(
      provider.speciesId,
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
  String? get name => r'patientBreedsControllerProvider';
}

/// See also [PatientBreedsController].
class PatientBreedsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientBreedsController,
        List<PatientBreed>> {
  /// See also [PatientBreedsController].
  PatientBreedsControllerProvider(
    String speciesId,
  ) : this._internal(
          () => PatientBreedsController()..speciesId = speciesId,
          from: patientBreedsControllerProvider,
          name: r'patientBreedsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientBreedsControllerHash,
          dependencies: PatientBreedsControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientBreedsControllerFamily._allTransitiveDependencies,
          speciesId: speciesId,
        );

  PatientBreedsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.speciesId,
  }) : super.internal();

  final String speciesId;

  @override
  FutureOr<List<PatientBreed>> runNotifierBuild(
    covariant PatientBreedsController notifier,
  ) {
    return notifier.build(
      speciesId,
    );
  }

  @override
  Override overrideWith(PatientBreedsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientBreedsControllerProvider._internal(
        () => create()..speciesId = speciesId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        speciesId: speciesId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientBreedsController,
      List<PatientBreed>> createElement() {
    return _PatientBreedsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientBreedsControllerProvider &&
        other.speciesId == speciesId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, speciesId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientBreedsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<PatientBreed>> {
  /// The parameter `speciesId` of this provider.
  String get speciesId;
}

class _PatientBreedsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientBreedsController,
        List<PatientBreed>> with PatientBreedsControllerRef {
  _PatientBreedsControllerProviderElement(super.provider);

  @override
  String get speciesId => (origin as PatientBreedsControllerProvider).speciesId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

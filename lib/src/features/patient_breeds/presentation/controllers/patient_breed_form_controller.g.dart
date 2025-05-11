// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_breed_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientBreedFormControllerHash() =>
    r'1dd8d4f2e389a1039346bb99a3d993fd1e41707e';

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

abstract class _$PatientBreedFormController
    extends BuildlessAutoDisposeAsyncNotifier<PatientBreedFormState> {
  late final String? id;
  late final String? patientSpeciesId;

  FutureOr<PatientBreedFormState> build(
    String? id, {
    String? patientSpeciesId,
  });
}

/// See also [PatientBreedFormController].
@ProviderFor(PatientBreedFormController)
const patientBreedFormControllerProvider = PatientBreedFormControllerFamily();

/// See also [PatientBreedFormController].
class PatientBreedFormControllerFamily
    extends Family<AsyncValue<PatientBreedFormState>> {
  /// See also [PatientBreedFormController].
  const PatientBreedFormControllerFamily();

  /// See also [PatientBreedFormController].
  PatientBreedFormControllerProvider call(
    String? id, {
    String? patientSpeciesId,
  }) {
    return PatientBreedFormControllerProvider(
      id,
      patientSpeciesId: patientSpeciesId,
    );
  }

  @override
  PatientBreedFormControllerProvider getProviderOverride(
    covariant PatientBreedFormControllerProvider provider,
  ) {
    return call(
      provider.id,
      patientSpeciesId: provider.patientSpeciesId,
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
  String? get name => r'patientBreedFormControllerProvider';
}

/// See also [PatientBreedFormController].
class PatientBreedFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientBreedFormController,
        PatientBreedFormState> {
  /// See also [PatientBreedFormController].
  PatientBreedFormControllerProvider(
    String? id, {
    String? patientSpeciesId,
  }) : this._internal(
          () => PatientBreedFormController()
            ..id = id
            ..patientSpeciesId = patientSpeciesId,
          from: patientBreedFormControllerProvider,
          name: r'patientBreedFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientBreedFormControllerHash,
          dependencies: PatientBreedFormControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientBreedFormControllerFamily._allTransitiveDependencies,
          id: id,
          patientSpeciesId: patientSpeciesId,
        );

  PatientBreedFormControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.patientSpeciesId,
  }) : super.internal();

  final String? id;
  final String? patientSpeciesId;

  @override
  FutureOr<PatientBreedFormState> runNotifierBuild(
    covariant PatientBreedFormController notifier,
  ) {
    return notifier.build(
      id,
      patientSpeciesId: patientSpeciesId,
    );
  }

  @override
  Override overrideWith(PatientBreedFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientBreedFormControllerProvider._internal(
        () => create()
          ..id = id
          ..patientSpeciesId = patientSpeciesId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        patientSpeciesId: patientSpeciesId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientBreedFormController,
      PatientBreedFormState> createElement() {
    return _PatientBreedFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientBreedFormControllerProvider &&
        other.id == id &&
        other.patientSpeciesId == patientSpeciesId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, patientSpeciesId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientBreedFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientBreedFormState> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `patientSpeciesId` of this provider.
  String? get patientSpeciesId;
}

class _PatientBreedFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientBreedFormController,
        PatientBreedFormState> with PatientBreedFormControllerRef {
  _PatientBreedFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as PatientBreedFormControllerProvider).id;
  @override
  String? get patientSpeciesId =>
      (origin as PatientBreedFormControllerProvider).patientSpeciesId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

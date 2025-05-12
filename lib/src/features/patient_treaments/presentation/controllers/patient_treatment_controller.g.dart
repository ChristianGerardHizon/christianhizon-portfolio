// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientTreatmentControllerHash() =>
    r'4ae3e68a14dab6e041ee08186a8b9099748878a3';

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

abstract class _$PatientTreatmentController
    extends BuildlessAutoDisposeAsyncNotifier<PatientTreatment> {
  late final String id;

  FutureOr<PatientTreatment> build(
    String id,
  );
}

/// See also [PatientTreatmentController].
@ProviderFor(PatientTreatmentController)
const patientTreatmentControllerProvider = PatientTreatmentControllerFamily();

/// See also [PatientTreatmentController].
class PatientTreatmentControllerFamily
    extends Family<AsyncValue<PatientTreatment>> {
  /// See also [PatientTreatmentController].
  const PatientTreatmentControllerFamily();

  /// See also [PatientTreatmentController].
  PatientTreatmentControllerProvider call(
    String id,
  ) {
    return PatientTreatmentControllerProvider(
      id,
    );
  }

  @override
  PatientTreatmentControllerProvider getProviderOverride(
    covariant PatientTreatmentControllerProvider provider,
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
  String? get name => r'patientTreatmentControllerProvider';
}

/// See also [PatientTreatmentController].
class PatientTreatmentControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientTreatmentController,
        PatientTreatment> {
  /// See also [PatientTreatmentController].
  PatientTreatmentControllerProvider(
    String id,
  ) : this._internal(
          () => PatientTreatmentController()..id = id,
          from: patientTreatmentControllerProvider,
          name: r'patientTreatmentControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientTreatmentControllerHash,
          dependencies: PatientTreatmentControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientTreatmentControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientTreatmentControllerProvider._internal(
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
  FutureOr<PatientTreatment> runNotifierBuild(
    covariant PatientTreatmentController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientTreatmentController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientTreatmentControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientTreatmentController,
      PatientTreatment> createElement() {
    return _PatientTreatmentControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentControllerProvider && other.id == id;
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
mixin PatientTreatmentControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientTreatment> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientTreatmentControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientTreatmentController,
        PatientTreatment> with PatientTreatmentControllerRef {
  _PatientTreatmentControllerProviderElement(super.provider);

  @override
  String get id => (origin as PatientTreatmentControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

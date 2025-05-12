// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientTreatmentFormControllerHash() =>
    r'ec1e21ca3583113a2a67ed705125e9ba06f9f80a';

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

abstract class _$PatientTreatmentFormController
    extends BuildlessAutoDisposeAsyncNotifier<PatientTreatmentFormState> {
  late final String? id;

  FutureOr<PatientTreatmentFormState> build(
    String? id,
  );
}

/// See also [PatientTreatmentFormController].
@ProviderFor(PatientTreatmentFormController)
const patientTreatmentFormControllerProvider =
    PatientTreatmentFormControllerFamily();

/// See also [PatientTreatmentFormController].
class PatientTreatmentFormControllerFamily
    extends Family<AsyncValue<PatientTreatmentFormState>> {
  /// See also [PatientTreatmentFormController].
  const PatientTreatmentFormControllerFamily();

  /// See also [PatientTreatmentFormController].
  PatientTreatmentFormControllerProvider call(
    String? id,
  ) {
    return PatientTreatmentFormControllerProvider(
      id,
    );
  }

  @override
  PatientTreatmentFormControllerProvider getProviderOverride(
    covariant PatientTreatmentFormControllerProvider provider,
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
  String? get name => r'patientTreatmentFormControllerProvider';
}

/// See also [PatientTreatmentFormController].
class PatientTreatmentFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientTreatmentFormController,
        PatientTreatmentFormState> {
  /// See also [PatientTreatmentFormController].
  PatientTreatmentFormControllerProvider(
    String? id,
  ) : this._internal(
          () => PatientTreatmentFormController()..id = id,
          from: patientTreatmentFormControllerProvider,
          name: r'patientTreatmentFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientTreatmentFormControllerHash,
          dependencies: PatientTreatmentFormControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientTreatmentFormControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientTreatmentFormControllerProvider._internal(
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
  FutureOr<PatientTreatmentFormState> runNotifierBuild(
    covariant PatientTreatmentFormController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientTreatmentFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientTreatmentFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientTreatmentFormController,
      PatientTreatmentFormState> createElement() {
    return _PatientTreatmentFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentFormControllerProvider && other.id == id;
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
mixin PatientTreatmentFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientTreatmentFormState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _PatientTreatmentFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientTreatmentFormController,
        PatientTreatmentFormState> with PatientTreatmentFormControllerRef {
  _PatientTreatmentFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as PatientTreatmentFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

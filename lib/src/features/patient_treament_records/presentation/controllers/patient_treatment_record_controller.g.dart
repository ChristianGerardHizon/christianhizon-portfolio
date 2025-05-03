// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientTreatmentRecordControllerHash() =>
    r'193536256f25d2650555671c199a7e1a6b3f5c8f';

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

abstract class _$PatientTreatmentRecordController
    extends BuildlessAutoDisposeAsyncNotifier<PatientTreatmentRecord> {
  late final String id;

  FutureOr<PatientTreatmentRecord> build(
    String id,
  );
}

/// See also [PatientTreatmentRecordController].
@ProviderFor(PatientTreatmentRecordController)
const patientTreatmentRecordControllerProvider =
    PatientTreatmentRecordControllerFamily();

/// See also [PatientTreatmentRecordController].
class PatientTreatmentRecordControllerFamily
    extends Family<AsyncValue<PatientTreatmentRecord>> {
  /// See also [PatientTreatmentRecordController].
  const PatientTreatmentRecordControllerFamily();

  /// See also [PatientTreatmentRecordController].
  PatientTreatmentRecordControllerProvider call(
    String id,
  ) {
    return PatientTreatmentRecordControllerProvider(
      id,
    );
  }

  @override
  PatientTreatmentRecordControllerProvider getProviderOverride(
    covariant PatientTreatmentRecordControllerProvider provider,
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
  String? get name => r'patientTreatmentRecordControllerProvider';
}

/// See also [PatientTreatmentRecordController].
class PatientTreatmentRecordControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        PatientTreatmentRecordController, PatientTreatmentRecord> {
  /// See also [PatientTreatmentRecordController].
  PatientTreatmentRecordControllerProvider(
    String id,
  ) : this._internal(
          () => PatientTreatmentRecordController()..id = id,
          from: patientTreatmentRecordControllerProvider,
          name: r'patientTreatmentRecordControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientTreatmentRecordControllerHash,
          dependencies: PatientTreatmentRecordControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientTreatmentRecordControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientTreatmentRecordControllerProvider._internal(
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
  FutureOr<PatientTreatmentRecord> runNotifierBuild(
    covariant PatientTreatmentRecordController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientTreatmentRecordController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientTreatmentRecordControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientTreatmentRecordController,
      PatientTreatmentRecord> createElement() {
    return _PatientTreatmentRecordControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentRecordControllerProvider && other.id == id;
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
mixin PatientTreatmentRecordControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientTreatmentRecord> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientTreatmentRecordControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientTreatmentRecordController,
        PatientTreatmentRecord> with PatientTreatmentRecordControllerRef {
  _PatientTreatmentRecordControllerProviderElement(super.provider);

  @override
  String get id => (origin as PatientTreatmentRecordControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

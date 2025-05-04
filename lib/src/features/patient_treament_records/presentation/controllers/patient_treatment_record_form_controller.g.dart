// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_record_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientTreatmentRecordFormControllerHash() =>
    r'20aee0932966a112df73babd07d4c1002aec9027';

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

abstract class _$PatientTreatmentRecordFormController
    extends BuildlessAutoDisposeAsyncNotifier<PatientTreatmentRecordFormState> {
  late final String? id;
  late final String patientId;

  FutureOr<PatientTreatmentRecordFormState> build({
    String? id,
    required String patientId,
  });
}

/// See also [PatientTreatmentRecordFormController].
@ProviderFor(PatientTreatmentRecordFormController)
const patientTreatmentRecordFormControllerProvider =
    PatientTreatmentRecordFormControllerFamily();

/// See also [PatientTreatmentRecordFormController].
class PatientTreatmentRecordFormControllerFamily
    extends Family<AsyncValue<PatientTreatmentRecordFormState>> {
  /// See also [PatientTreatmentRecordFormController].
  const PatientTreatmentRecordFormControllerFamily();

  /// See also [PatientTreatmentRecordFormController].
  PatientTreatmentRecordFormControllerProvider call({
    String? id,
    required String patientId,
  }) {
    return PatientTreatmentRecordFormControllerProvider(
      id: id,
      patientId: patientId,
    );
  }

  @override
  PatientTreatmentRecordFormControllerProvider getProviderOverride(
    covariant PatientTreatmentRecordFormControllerProvider provider,
  ) {
    return call(
      id: provider.id,
      patientId: provider.patientId,
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
  String? get name => r'patientTreatmentRecordFormControllerProvider';
}

/// See also [PatientTreatmentRecordFormController].
class PatientTreatmentRecordFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        PatientTreatmentRecordFormController, PatientTreatmentRecordFormState> {
  /// See also [PatientTreatmentRecordFormController].
  PatientTreatmentRecordFormControllerProvider({
    String? id,
    required String patientId,
  }) : this._internal(
          () => PatientTreatmentRecordFormController()
            ..id = id
            ..patientId = patientId,
          from: patientTreatmentRecordFormControllerProvider,
          name: r'patientTreatmentRecordFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientTreatmentRecordFormControllerHash,
          dependencies:
              PatientTreatmentRecordFormControllerFamily._dependencies,
          allTransitiveDependencies: PatientTreatmentRecordFormControllerFamily
              ._allTransitiveDependencies,
          id: id,
          patientId: patientId,
        );

  PatientTreatmentRecordFormControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.patientId,
  }) : super.internal();

  final String? id;
  final String patientId;

  @override
  FutureOr<PatientTreatmentRecordFormState> runNotifierBuild(
    covariant PatientTreatmentRecordFormController notifier,
  ) {
    return notifier.build(
      id: id,
      patientId: patientId,
    );
  }

  @override
  Override overrideWith(
      PatientTreatmentRecordFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientTreatmentRecordFormControllerProvider._internal(
        () => create()
          ..id = id
          ..patientId = patientId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        patientId: patientId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientTreatmentRecordFormController,
      PatientTreatmentRecordFormState> createElement() {
    return _PatientTreatmentRecordFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentRecordFormControllerProvider &&
        other.id == id &&
        other.patientId == patientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientTreatmentRecordFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientTreatmentRecordFormState> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _PatientTreatmentRecordFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientTreatmentRecordFormController, PatientTreatmentRecordFormState>
    with PatientTreatmentRecordFormControllerRef {
  _PatientTreatmentRecordFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as PatientTreatmentRecordFormControllerProvider).id;
  @override
  String get patientId =>
      (origin as PatientTreatmentRecordFormControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

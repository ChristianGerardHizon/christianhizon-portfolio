// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientTreatmentRecordControllerHash() =>
    r'00b285c26b43da0f9aa5a9851ade2082b7bb8cf6';

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
    extends BuildlessAutoDisposeAsyncNotifier<PageResults<TreatmentRecord>> {
  late final String patientId;
  late final String historyTypeId;

  FutureOr<PageResults<TreatmentRecord>> build({
    required String patientId,
    required String historyTypeId,
  });
}

/// See also [PatientTreatmentRecordController].
@ProviderFor(PatientTreatmentRecordController)
const patientTreatmentRecordControllerProvider =
    PatientTreatmentRecordControllerFamily();

/// See also [PatientTreatmentRecordController].
class PatientTreatmentRecordControllerFamily
    extends Family<AsyncValue<PageResults<TreatmentRecord>>> {
  /// See also [PatientTreatmentRecordController].
  const PatientTreatmentRecordControllerFamily();

  /// See also [PatientTreatmentRecordController].
  PatientTreatmentRecordControllerProvider call({
    required String patientId,
    required String historyTypeId,
  }) {
    return PatientTreatmentRecordControllerProvider(
      patientId: patientId,
      historyTypeId: historyTypeId,
    );
  }

  @override
  PatientTreatmentRecordControllerProvider getProviderOverride(
    covariant PatientTreatmentRecordControllerProvider provider,
  ) {
    return call(
      patientId: provider.patientId,
      historyTypeId: provider.historyTypeId,
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
        PatientTreatmentRecordController, PageResults<TreatmentRecord>> {
  /// See also [PatientTreatmentRecordController].
  PatientTreatmentRecordControllerProvider({
    required String patientId,
    required String historyTypeId,
  }) : this._internal(
          () => PatientTreatmentRecordController()
            ..patientId = patientId
            ..historyTypeId = historyTypeId,
          from: patientTreatmentRecordControllerProvider,
          name: r'patientTreatmentRecordControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientTreatmentRecordControllerHash,
          dependencies: PatientTreatmentRecordControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientTreatmentRecordControllerFamily._allTransitiveDependencies,
          patientId: patientId,
          historyTypeId: historyTypeId,
        );

  PatientTreatmentRecordControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.patientId,
    required this.historyTypeId,
  }) : super.internal();

  final String patientId;
  final String historyTypeId;

  @override
  FutureOr<PageResults<TreatmentRecord>> runNotifierBuild(
    covariant PatientTreatmentRecordController notifier,
  ) {
    return notifier.build(
      patientId: patientId,
      historyTypeId: historyTypeId,
    );
  }

  @override
  Override overrideWith(PatientTreatmentRecordController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientTreatmentRecordControllerProvider._internal(
        () => create()
          ..patientId = patientId
          ..historyTypeId = historyTypeId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        patientId: patientId,
        historyTypeId: historyTypeId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientTreatmentRecordController,
      PageResults<TreatmentRecord>> createElement() {
    return _PatientTreatmentRecordControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentRecordControllerProvider &&
        other.patientId == patientId &&
        other.historyTypeId == historyTypeId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);
    hash = _SystemHash.combine(hash, historyTypeId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientTreatmentRecordControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PageResults<TreatmentRecord>> {
  /// The parameter `patientId` of this provider.
  String get patientId;

  /// The parameter `historyTypeId` of this provider.
  String get historyTypeId;
}

class _PatientTreatmentRecordControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientTreatmentRecordController,
        PageResults<TreatmentRecord>> with PatientTreatmentRecordControllerRef {
  _PatientTreatmentRecordControllerProviderElement(super.provider);

  @override
  String get patientId =>
      (origin as PatientTreatmentRecordControllerProvider).patientId;
  @override
  String get historyTypeId =>
      (origin as PatientTreatmentRecordControllerProvider).historyTypeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

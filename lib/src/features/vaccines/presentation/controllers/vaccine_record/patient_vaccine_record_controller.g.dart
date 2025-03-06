// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_vaccine_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientVaccineRecordControllerHash() =>
    r'b3c650bb4042f42cd2c1f4ab79bdf442aa2759a0';

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

abstract class _$PatientVaccineRecordController
    extends BuildlessAutoDisposeAsyncNotifier<PageResults<VaccineRecord>> {
  late final String patientId;
  late final String historyTypeId;

  FutureOr<PageResults<VaccineRecord>> build({
    required String patientId,
    required String historyTypeId,
  });
}

/// See also [PatientVaccineRecordController].
@ProviderFor(PatientVaccineRecordController)
const patientVaccineRecordControllerProvider =
    PatientVaccineRecordControllerFamily();

/// See also [PatientVaccineRecordController].
class PatientVaccineRecordControllerFamily
    extends Family<AsyncValue<PageResults<VaccineRecord>>> {
  /// See also [PatientVaccineRecordController].
  const PatientVaccineRecordControllerFamily();

  /// See also [PatientVaccineRecordController].
  PatientVaccineRecordControllerProvider call({
    required String patientId,
    required String historyTypeId,
  }) {
    return PatientVaccineRecordControllerProvider(
      patientId: patientId,
      historyTypeId: historyTypeId,
    );
  }

  @override
  PatientVaccineRecordControllerProvider getProviderOverride(
    covariant PatientVaccineRecordControllerProvider provider,
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
  String? get name => r'patientVaccineRecordControllerProvider';
}

/// See also [PatientVaccineRecordController].
class PatientVaccineRecordControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientVaccineRecordController,
        PageResults<VaccineRecord>> {
  /// See also [PatientVaccineRecordController].
  PatientVaccineRecordControllerProvider({
    required String patientId,
    required String historyTypeId,
  }) : this._internal(
          () => PatientVaccineRecordController()
            ..patientId = patientId
            ..historyTypeId = historyTypeId,
          from: patientVaccineRecordControllerProvider,
          name: r'patientVaccineRecordControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientVaccineRecordControllerHash,
          dependencies: PatientVaccineRecordControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientVaccineRecordControllerFamily._allTransitiveDependencies,
          patientId: patientId,
          historyTypeId: historyTypeId,
        );

  PatientVaccineRecordControllerProvider._internal(
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
  FutureOr<PageResults<VaccineRecord>> runNotifierBuild(
    covariant PatientVaccineRecordController notifier,
  ) {
    return notifier.build(
      patientId: patientId,
      historyTypeId: historyTypeId,
    );
  }

  @override
  Override overrideWith(PatientVaccineRecordController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientVaccineRecordControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientVaccineRecordController,
      PageResults<VaccineRecord>> createElement() {
    return _PatientVaccineRecordControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientVaccineRecordControllerProvider &&
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
mixin PatientVaccineRecordControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PageResults<VaccineRecord>> {
  /// The parameter `patientId` of this provider.
  String get patientId;

  /// The parameter `historyTypeId` of this provider.
  String get historyTypeId;
}

class _PatientVaccineRecordControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientVaccineRecordController,
        PageResults<VaccineRecord>> with PatientVaccineRecordControllerRef {
  _PatientVaccineRecordControllerProviderElement(super.provider);

  @override
  String get patientId =>
      (origin as PatientVaccineRecordControllerProvider).patientId;
  @override
  String get historyTypeId =>
      (origin as PatientVaccineRecordControllerProvider).historyTypeId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

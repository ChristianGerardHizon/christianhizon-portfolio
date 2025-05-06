// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_record_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientTreatmentRecordTableControllerHash() =>
    r'ea9a5f483e84a30c507a2cb3cd94197b41387249';

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

abstract class _$PatientTreatmentRecordTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<PatientTreatmentRecord>> {
  late final String tableKey;
  late final String patientId;

  FutureOr<List<PatientTreatmentRecord>> build(
    String tableKey,
    String patientId,
  );
}

/// See also [PatientTreatmentRecordTableController].
@ProviderFor(PatientTreatmentRecordTableController)
const patientTreatmentRecordTableControllerProvider =
    PatientTreatmentRecordTableControllerFamily();

/// See also [PatientTreatmentRecordTableController].
class PatientTreatmentRecordTableControllerFamily
    extends Family<AsyncValue<List<PatientTreatmentRecord>>> {
  /// See also [PatientTreatmentRecordTableController].
  const PatientTreatmentRecordTableControllerFamily();

  /// See also [PatientTreatmentRecordTableController].
  PatientTreatmentRecordTableControllerProvider call(
    String tableKey,
    String patientId,
  ) {
    return PatientTreatmentRecordTableControllerProvider(
      tableKey,
      patientId,
    );
  }

  @override
  PatientTreatmentRecordTableControllerProvider getProviderOverride(
    covariant PatientTreatmentRecordTableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
      provider.patientId,
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
  String? get name => r'patientTreatmentRecordTableControllerProvider';
}

/// See also [PatientTreatmentRecordTableController].
class PatientTreatmentRecordTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        PatientTreatmentRecordTableController, List<PatientTreatmentRecord>> {
  /// See also [PatientTreatmentRecordTableController].
  PatientTreatmentRecordTableControllerProvider(
    String tableKey,
    String patientId,
  ) : this._internal(
          () => PatientTreatmentRecordTableController()
            ..tableKey = tableKey
            ..patientId = patientId,
          from: patientTreatmentRecordTableControllerProvider,
          name: r'patientTreatmentRecordTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientTreatmentRecordTableControllerHash,
          dependencies:
              PatientTreatmentRecordTableControllerFamily._dependencies,
          allTransitiveDependencies: PatientTreatmentRecordTableControllerFamily
              ._allTransitiveDependencies,
          tableKey: tableKey,
          patientId: patientId,
        );

  PatientTreatmentRecordTableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
    required this.patientId,
  }) : super.internal();

  final String tableKey;
  final String patientId;

  @override
  FutureOr<List<PatientTreatmentRecord>> runNotifierBuild(
    covariant PatientTreatmentRecordTableController notifier,
  ) {
    return notifier.build(
      tableKey,
      patientId,
    );
  }

  @override
  Override overrideWith(
      PatientTreatmentRecordTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientTreatmentRecordTableControllerProvider._internal(
        () => create()
          ..tableKey = tableKey
          ..patientId = patientId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
        patientId: patientId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientTreatmentRecordTableController,
      List<PatientTreatmentRecord>> createElement() {
    return _PatientTreatmentRecordTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentRecordTableControllerProvider &&
        other.tableKey == tableKey &&
        other.patientId == patientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientTreatmentRecordTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<PatientTreatmentRecord>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;

  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _PatientTreatmentRecordTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientTreatmentRecordTableController, List<PatientTreatmentRecord>>
    with PatientTreatmentRecordTableControllerRef {
  _PatientTreatmentRecordTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as PatientTreatmentRecordTableControllerProvider).tableKey;
  @override
  String get patientId =>
      (origin as PatientTreatmentRecordTableControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

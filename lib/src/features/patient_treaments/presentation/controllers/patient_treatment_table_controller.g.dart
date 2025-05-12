// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientTreatmentTableControllerHash() =>
    r'd0a9fba4c68d78b57aed4a7671f7e319d869b820';

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

abstract class _$PatientTreatmentTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<PatientTreatment>> {
  late final String tableKey;

  FutureOr<List<PatientTreatment>> build(
    String tableKey,
  );
}

/// See also [PatientTreatmentTableController].
@ProviderFor(PatientTreatmentTableController)
const patientTreatmentTableControllerProvider =
    PatientTreatmentTableControllerFamily();

/// See also [PatientTreatmentTableController].
class PatientTreatmentTableControllerFamily
    extends Family<AsyncValue<List<PatientTreatment>>> {
  /// See also [PatientTreatmentTableController].
  const PatientTreatmentTableControllerFamily();

  /// See also [PatientTreatmentTableController].
  PatientTreatmentTableControllerProvider call(
    String tableKey,
  ) {
    return PatientTreatmentTableControllerProvider(
      tableKey,
    );
  }

  @override
  PatientTreatmentTableControllerProvider getProviderOverride(
    covariant PatientTreatmentTableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
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
  String? get name => r'patientTreatmentTableControllerProvider';
}

/// See also [PatientTreatmentTableController].
class PatientTreatmentTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        PatientTreatmentTableController, List<PatientTreatment>> {
  /// See also [PatientTreatmentTableController].
  PatientTreatmentTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => PatientTreatmentTableController()..tableKey = tableKey,
          from: patientTreatmentTableControllerProvider,
          name: r'patientTreatmentTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientTreatmentTableControllerHash,
          dependencies: PatientTreatmentTableControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientTreatmentTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  PatientTreatmentTableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
  }) : super.internal();

  final String tableKey;

  @override
  FutureOr<List<PatientTreatment>> runNotifierBuild(
    covariant PatientTreatmentTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(PatientTreatmentTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientTreatmentTableControllerProvider._internal(
        () => create()..tableKey = tableKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientTreatmentTableController,
      List<PatientTreatment>> createElement() {
    return _PatientTreatmentTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentTableControllerProvider &&
        other.tableKey == tableKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientTreatmentTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<PatientTreatment>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _PatientTreatmentTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientTreatmentTableController,
        List<PatientTreatment>> with PatientTreatmentTableControllerRef {
  _PatientTreatmentTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as PatientTreatmentTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

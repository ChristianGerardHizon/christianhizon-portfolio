// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_breed_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientBreedTableControllerHash() =>
    r'e956976dd62831c1389c530861ec53de59296f80';

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

abstract class _$PatientBreedTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<PatientBreed>> {
  late final String tableKey;
  late final String? patientSpeciesId;

  FutureOr<List<PatientBreed>> build(
    String tableKey, {
    String? patientSpeciesId,
  });
}

/// See also [PatientBreedTableController].
@ProviderFor(PatientBreedTableController)
const patientBreedTableControllerProvider = PatientBreedTableControllerFamily();

/// See also [PatientBreedTableController].
class PatientBreedTableControllerFamily
    extends Family<AsyncValue<List<PatientBreed>>> {
  /// See also [PatientBreedTableController].
  const PatientBreedTableControllerFamily();

  /// See also [PatientBreedTableController].
  PatientBreedTableControllerProvider call(
    String tableKey, {
    String? patientSpeciesId,
  }) {
    return PatientBreedTableControllerProvider(
      tableKey,
      patientSpeciesId: patientSpeciesId,
    );
  }

  @override
  PatientBreedTableControllerProvider getProviderOverride(
    covariant PatientBreedTableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
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
  String? get name => r'patientBreedTableControllerProvider';
}

/// See also [PatientBreedTableController].
class PatientBreedTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientBreedTableController,
        List<PatientBreed>> {
  /// See also [PatientBreedTableController].
  PatientBreedTableControllerProvider(
    String tableKey, {
    String? patientSpeciesId,
  }) : this._internal(
          () => PatientBreedTableController()
            ..tableKey = tableKey
            ..patientSpeciesId = patientSpeciesId,
          from: patientBreedTableControllerProvider,
          name: r'patientBreedTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientBreedTableControllerHash,
          dependencies: PatientBreedTableControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientBreedTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
          patientSpeciesId: patientSpeciesId,
        );

  PatientBreedTableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
    required this.patientSpeciesId,
  }) : super.internal();

  final String tableKey;
  final String? patientSpeciesId;

  @override
  FutureOr<List<PatientBreed>> runNotifierBuild(
    covariant PatientBreedTableController notifier,
  ) {
    return notifier.build(
      tableKey,
      patientSpeciesId: patientSpeciesId,
    );
  }

  @override
  Override overrideWith(PatientBreedTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientBreedTableControllerProvider._internal(
        () => create()
          ..tableKey = tableKey
          ..patientSpeciesId = patientSpeciesId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
        patientSpeciesId: patientSpeciesId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientBreedTableController,
      List<PatientBreed>> createElement() {
    return _PatientBreedTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientBreedTableControllerProvider &&
        other.tableKey == tableKey &&
        other.patientSpeciesId == patientSpeciesId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);
    hash = _SystemHash.combine(hash, patientSpeciesId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientBreedTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<PatientBreed>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;

  /// The parameter `patientSpeciesId` of this provider.
  String? get patientSpeciesId;
}

class _PatientBreedTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientBreedTableController,
        List<PatientBreed>> with PatientBreedTableControllerRef {
  _PatientBreedTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as PatientBreedTableControllerProvider).tableKey;
  @override
  String? get patientSpeciesId =>
      (origin as PatientBreedTableControllerProvider).patientSpeciesId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

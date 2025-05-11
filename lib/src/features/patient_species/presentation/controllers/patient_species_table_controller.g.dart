// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_species_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientSpeciesTableControllerHash() =>
    r'840777f18ab9397c29c17af2c0bc8c8ecd4525c3';

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

abstract class _$PatientSpeciesTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<PatientSpecies>> {
  late final String tableKey;

  FutureOr<List<PatientSpecies>> build(
    String tableKey,
  );
}

/// See also [PatientSpeciesTableController].
@ProviderFor(PatientSpeciesTableController)
const patientSpeciesTableControllerProvider =
    PatientSpeciesTableControllerFamily();

/// See also [PatientSpeciesTableController].
class PatientSpeciesTableControllerFamily
    extends Family<AsyncValue<List<PatientSpecies>>> {
  /// See also [PatientSpeciesTableController].
  const PatientSpeciesTableControllerFamily();

  /// See also [PatientSpeciesTableController].
  PatientSpeciesTableControllerProvider call(
    String tableKey,
  ) {
    return PatientSpeciesTableControllerProvider(
      tableKey,
    );
  }

  @override
  PatientSpeciesTableControllerProvider getProviderOverride(
    covariant PatientSpeciesTableControllerProvider provider,
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
  String? get name => r'patientSpeciesTableControllerProvider';
}

/// See also [PatientSpeciesTableController].
class PatientSpeciesTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientSpeciesTableController,
        List<PatientSpecies>> {
  /// See also [PatientSpeciesTableController].
  PatientSpeciesTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => PatientSpeciesTableController()..tableKey = tableKey,
          from: patientSpeciesTableControllerProvider,
          name: r'patientSpeciesTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientSpeciesTableControllerHash,
          dependencies: PatientSpeciesTableControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientSpeciesTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  PatientSpeciesTableControllerProvider._internal(
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
  FutureOr<List<PatientSpecies>> runNotifierBuild(
    covariant PatientSpeciesTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(PatientSpeciesTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientSpeciesTableControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientSpeciesTableController,
      List<PatientSpecies>> createElement() {
    return _PatientSpeciesTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientSpeciesTableControllerProvider &&
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
mixin PatientSpeciesTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<PatientSpecies>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _PatientSpeciesTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientSpeciesTableController,
        List<PatientSpecies>> with PatientSpeciesTableControllerRef {
  _PatientSpeciesTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as PatientSpeciesTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientTableControllerHash() =>
    r'4114090dd1a325db6338160eee12b36f656a7d9c';

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

abstract class _$PatientTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<Patient>> {
  late final String tableKey;

  FutureOr<List<Patient>> build(
    String tableKey,
  );
}

/// See also [PatientTableController].
@ProviderFor(PatientTableController)
const patientTableControllerProvider = PatientTableControllerFamily();

/// See also [PatientTableController].
class PatientTableControllerFamily extends Family<AsyncValue<List<Patient>>> {
  /// See also [PatientTableController].
  const PatientTableControllerFamily();

  /// See also [PatientTableController].
  PatientTableControllerProvider call(
    String tableKey,
  ) {
    return PatientTableControllerProvider(
      tableKey,
    );
  }

  @override
  PatientTableControllerProvider getProviderOverride(
    covariant PatientTableControllerProvider provider,
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
  String? get name => r'patientTableControllerProvider';
}

/// See also [PatientTableController].
class PatientTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientTableController,
        List<Patient>> {
  /// See also [PatientTableController].
  PatientTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => PatientTableController()..tableKey = tableKey,
          from: patientTableControllerProvider,
          name: r'patientTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientTableControllerHash,
          dependencies: PatientTableControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  PatientTableControllerProvider._internal(
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
  FutureOr<List<Patient>> runNotifierBuild(
    covariant PatientTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(PatientTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientTableControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientTableController, List<Patient>>
      createElement() {
    return _PatientTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTableControllerProvider &&
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
mixin PatientTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Patient>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _PatientTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientTableController,
        List<Patient>> with PatientTableControllerRef {
  _PatientTableControllerProviderElement(super.provider);

  @override
  String get tableKey => (origin as PatientTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

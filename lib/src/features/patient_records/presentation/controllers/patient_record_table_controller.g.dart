// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientRecordTableControllerHash() =>
    r'e43c35d4e20a64c1390dd33d2b0eed7f6e2da183';

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

abstract class _$PatientRecordTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<PatientRecord>> {
  late final String tableKey;

  FutureOr<List<PatientRecord>> build(
    String tableKey,
  );
}

/// See also [PatientRecordTableController].
@ProviderFor(PatientRecordTableController)
const patientRecordTableControllerProvider =
    PatientRecordTableControllerFamily();

/// See also [PatientRecordTableController].
class PatientRecordTableControllerFamily
    extends Family<AsyncValue<List<PatientRecord>>> {
  /// See also [PatientRecordTableController].
  const PatientRecordTableControllerFamily();

  /// See also [PatientRecordTableController].
  PatientRecordTableControllerProvider call(
    String tableKey,
  ) {
    return PatientRecordTableControllerProvider(
      tableKey,
    );
  }

  @override
  PatientRecordTableControllerProvider getProviderOverride(
    covariant PatientRecordTableControllerProvider provider,
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
  String? get name => r'patientRecordTableControllerProvider';
}

/// See also [PatientRecordTableController].
class PatientRecordTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientRecordTableController,
        List<PatientRecord>> {
  /// See also [PatientRecordTableController].
  PatientRecordTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => PatientRecordTableController()..tableKey = tableKey,
          from: patientRecordTableControllerProvider,
          name: r'patientRecordTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientRecordTableControllerHash,
          dependencies: PatientRecordTableControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientRecordTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  PatientRecordTableControllerProvider._internal(
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
  FutureOr<List<PatientRecord>> runNotifierBuild(
    covariant PatientRecordTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(PatientRecordTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientRecordTableControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientRecordTableController,
      List<PatientRecord>> createElement() {
    return _PatientRecordTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientRecordTableControllerProvider &&
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
mixin PatientRecordTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<PatientRecord>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _PatientRecordTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientRecordTableController,
        List<PatientRecord>> with PatientRecordTableControllerRef {
  _PatientRecordTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as PatientRecordTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

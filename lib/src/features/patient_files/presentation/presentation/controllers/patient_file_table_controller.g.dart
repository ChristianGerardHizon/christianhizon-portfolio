// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_file_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientFileTableControllerHash() =>
    r'36c716d295b2e8d5a535949d73296b4558997da9';

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

abstract class _$PatientFileTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<PatientFile>> {
  late final String tableKey;
  late final String patientId;

  FutureOr<List<PatientFile>> build(
    String tableKey, {
    required String patientId,
  });
}

/// See also [PatientFileTableController].
@ProviderFor(PatientFileTableController)
const patientFileTableControllerProvider = PatientFileTableControllerFamily();

/// See also [PatientFileTableController].
class PatientFileTableControllerFamily
    extends Family<AsyncValue<List<PatientFile>>> {
  /// See also [PatientFileTableController].
  const PatientFileTableControllerFamily();

  /// See also [PatientFileTableController].
  PatientFileTableControllerProvider call(
    String tableKey, {
    required String patientId,
  }) {
    return PatientFileTableControllerProvider(
      tableKey,
      patientId: patientId,
    );
  }

  @override
  PatientFileTableControllerProvider getProviderOverride(
    covariant PatientFileTableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
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
  String? get name => r'patientFileTableControllerProvider';
}

/// See also [PatientFileTableController].
class PatientFileTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientFileTableController,
        List<PatientFile>> {
  /// See also [PatientFileTableController].
  PatientFileTableControllerProvider(
    String tableKey, {
    required String patientId,
  }) : this._internal(
          () => PatientFileTableController()
            ..tableKey = tableKey
            ..patientId = patientId,
          from: patientFileTableControllerProvider,
          name: r'patientFileTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientFileTableControllerHash,
          dependencies: PatientFileTableControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientFileTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
          patientId: patientId,
        );

  PatientFileTableControllerProvider._internal(
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
  FutureOr<List<PatientFile>> runNotifierBuild(
    covariant PatientFileTableController notifier,
  ) {
    return notifier.build(
      tableKey,
      patientId: patientId,
    );
  }

  @override
  Override overrideWith(PatientFileTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientFileTableControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientFileTableController,
      List<PatientFile>> createElement() {
    return _PatientFileTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientFileTableControllerProvider &&
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
mixin PatientFileTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<PatientFile>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;

  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _PatientFileTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientFileTableController,
        List<PatientFile>> with PatientFileTableControllerRef {
  _PatientFileTableControllerProviderElement(super.provider);

  @override
  String get tableKey =>
      (origin as PatientFileTableControllerProvider).tableKey;
  @override
  String get patientId =>
      (origin as PatientFileTableControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

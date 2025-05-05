// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientRecordControllerHash() =>
    r'af769bc294bdeed07d037f64005ff93184510da0';

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

abstract class _$PatientRecordController
    extends BuildlessAutoDisposeAsyncNotifier<PatientRecord> {
  late final String id;

  FutureOr<PatientRecord> build(
    String id,
  );
}

/// See also [PatientRecordController].
@ProviderFor(PatientRecordController)
const patientRecordControllerProvider = PatientRecordControllerFamily();

/// See also [PatientRecordController].
class PatientRecordControllerFamily extends Family<AsyncValue<PatientRecord>> {
  /// See also [PatientRecordController].
  const PatientRecordControllerFamily();

  /// See also [PatientRecordController].
  PatientRecordControllerProvider call(
    String id,
  ) {
    return PatientRecordControllerProvider(
      id,
    );
  }

  @override
  PatientRecordControllerProvider getProviderOverride(
    covariant PatientRecordControllerProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'patientRecordControllerProvider';
}

/// See also [PatientRecordController].
class PatientRecordControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientRecordController,
        PatientRecord> {
  /// See also [PatientRecordController].
  PatientRecordControllerProvider(
    String id,
  ) : this._internal(
          () => PatientRecordController()..id = id,
          from: patientRecordControllerProvider,
          name: r'patientRecordControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientRecordControllerHash,
          dependencies: PatientRecordControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientRecordControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientRecordControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<PatientRecord> runNotifierBuild(
    covariant PatientRecordController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientRecordController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientRecordControllerProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientRecordController,
      PatientRecord> createElement() {
    return _PatientRecordControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientRecordControllerProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientRecordControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientRecord> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientRecordControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientRecordController,
        PatientRecord> with PatientRecordControllerRef {
  _PatientRecordControllerProviderElement(super.provider);

  @override
  String get id => (origin as PatientRecordControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

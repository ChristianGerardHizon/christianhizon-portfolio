// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientControllerHash() => r'bd17935155298b4102dd46a6e10753388089c9b4';

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

abstract class _$PatientController
    extends BuildlessAutoDisposeAsyncNotifier<Patient> {
  late final String id;

  FutureOr<Patient> build(
    String id,
  );
}

/// See also [PatientController].
@ProviderFor(PatientController)
const patientControllerProvider = PatientControllerFamily();

/// See also [PatientController].
class PatientControllerFamily extends Family<AsyncValue<Patient>> {
  /// See also [PatientController].
  const PatientControllerFamily();

  /// See also [PatientController].
  PatientControllerProvider call(
    String id,
  ) {
    return PatientControllerProvider(
      id,
    );
  }

  @override
  PatientControllerProvider getProviderOverride(
    covariant PatientControllerProvider provider,
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
  String? get name => r'patientControllerProvider';
}

/// See also [PatientController].
class PatientControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientController, Patient> {
  /// See also [PatientController].
  PatientControllerProvider(
    String id,
  ) : this._internal(
          () => PatientController()..id = id,
          from: patientControllerProvider,
          name: r'patientControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientControllerHash,
          dependencies: PatientControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientControllerProvider._internal(
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
  FutureOr<Patient> runNotifierBuild(
    covariant PatientController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientController, Patient>
      createElement() {
    return _PatientControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientControllerProvider && other.id == id;
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
mixin PatientControllerRef on AutoDisposeAsyncNotifierProviderRef<Patient> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientController, Patient>
    with PatientControllerRef {
  _PatientControllerProviderElement(super.provider);

  @override
  String get id => (origin as PatientControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

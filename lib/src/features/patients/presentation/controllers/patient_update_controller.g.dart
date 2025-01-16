// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_update_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientUpdateControllerHash() =>
    r'16c41e9019aa097696530ddc21ceb69f9b8ae975';

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

abstract class _$PatientUpdateController
    extends BuildlessAutoDisposeAsyncNotifier<PatientUpdateState> {
  late final String id;

  FutureOr<PatientUpdateState> build(
    String id,
  );
}

/// See also [PatientUpdateController].
@ProviderFor(PatientUpdateController)
const patientUpdateControllerProvider = PatientUpdateControllerFamily();

/// See also [PatientUpdateController].
class PatientUpdateControllerFamily
    extends Family<AsyncValue<PatientUpdateState>> {
  /// See also [PatientUpdateController].
  const PatientUpdateControllerFamily();

  /// See also [PatientUpdateController].
  PatientUpdateControllerProvider call(
    String id,
  ) {
    return PatientUpdateControllerProvider(
      id,
    );
  }

  @override
  PatientUpdateControllerProvider getProviderOverride(
    covariant PatientUpdateControllerProvider provider,
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
  String? get name => r'patientUpdateControllerProvider';
}

/// See also [PatientUpdateController].
class PatientUpdateControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientUpdateController,
        PatientUpdateState> {
  /// See also [PatientUpdateController].
  PatientUpdateControllerProvider(
    String id,
  ) : this._internal(
          () => PatientUpdateController()..id = id,
          from: patientUpdateControllerProvider,
          name: r'patientUpdateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientUpdateControllerHash,
          dependencies: PatientUpdateControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientUpdateControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientUpdateControllerProvider._internal(
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
  FutureOr<PatientUpdateState> runNotifierBuild(
    covariant PatientUpdateController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientUpdateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientUpdateControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientUpdateController,
      PatientUpdateState> createElement() {
    return _PatientUpdateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientUpdateControllerProvider && other.id == id;
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
mixin PatientUpdateControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientUpdateState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientUpdateControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientUpdateController,
        PatientUpdateState> with PatientUpdateControllerRef {
  _PatientUpdateControllerProviderElement(super.provider);

  @override
  String get id => (origin as PatientUpdateControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

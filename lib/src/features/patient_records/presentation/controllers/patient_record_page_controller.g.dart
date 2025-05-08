// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_page_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientRecordPageControllerHash() =>
    r'02594c8f27239285b8fa89244b1c0d0d04c20247';

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

abstract class _$PatientRecordPageController
    extends BuildlessAutoDisposeAsyncNotifier<PatientRecordPageState> {
  late final String id;

  FutureOr<PatientRecordPageState> build(
    String id,
  );
}

/// See also [PatientRecordPageController].
@ProviderFor(PatientRecordPageController)
const patientRecordPageControllerProvider = PatientRecordPageControllerFamily();

/// See also [PatientRecordPageController].
class PatientRecordPageControllerFamily
    extends Family<AsyncValue<PatientRecordPageState>> {
  /// See also [PatientRecordPageController].
  const PatientRecordPageControllerFamily();

  /// See also [PatientRecordPageController].
  PatientRecordPageControllerProvider call(
    String id,
  ) {
    return PatientRecordPageControllerProvider(
      id,
    );
  }

  @override
  PatientRecordPageControllerProvider getProviderOverride(
    covariant PatientRecordPageControllerProvider provider,
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
  String? get name => r'patientRecordPageControllerProvider';
}

/// See also [PatientRecordPageController].
class PatientRecordPageControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientRecordPageController,
        PatientRecordPageState> {
  /// See also [PatientRecordPageController].
  PatientRecordPageControllerProvider(
    String id,
  ) : this._internal(
          () => PatientRecordPageController()..id = id,
          from: patientRecordPageControllerProvider,
          name: r'patientRecordPageControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientRecordPageControllerHash,
          dependencies: PatientRecordPageControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientRecordPageControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientRecordPageControllerProvider._internal(
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
  FutureOr<PatientRecordPageState> runNotifierBuild(
    covariant PatientRecordPageController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientRecordPageController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientRecordPageControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientRecordPageController,
      PatientRecordPageState> createElement() {
    return _PatientRecordPageControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientRecordPageControllerProvider && other.id == id;
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
mixin PatientRecordPageControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientRecordPageState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientRecordPageControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientRecordPageController,
        PatientRecordPageState> with PatientRecordPageControllerRef {
  _PatientRecordPageControllerProviderElement(super.provider);

  @override
  String get id => (origin as PatientRecordPageControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

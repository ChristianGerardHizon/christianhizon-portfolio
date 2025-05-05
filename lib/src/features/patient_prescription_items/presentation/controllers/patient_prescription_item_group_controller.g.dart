// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_prescription_item_group_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientPrescriptionItemGroupControllerHash() =>
    r'2946d31526f3e95124c4eadba95d144fdb54bef6';

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

abstract class _$PatientPrescriptionItemGroupController
    extends BuildlessAutoDisposeAsyncNotifier<
        List<PatientPrescriptionItemGroupState>> {
  late final String id;

  FutureOr<List<PatientPrescriptionItemGroupState>> build(
    String id,
  );
}

/// See also [PatientPrescriptionItemGroupController].
@ProviderFor(PatientPrescriptionItemGroupController)
const patientPrescriptionItemGroupControllerProvider =
    PatientPrescriptionItemGroupControllerFamily();

/// See also [PatientPrescriptionItemGroupController].
class PatientPrescriptionItemGroupControllerFamily
    extends Family<AsyncValue<List<PatientPrescriptionItemGroupState>>> {
  /// See also [PatientPrescriptionItemGroupController].
  const PatientPrescriptionItemGroupControllerFamily();

  /// See also [PatientPrescriptionItemGroupController].
  PatientPrescriptionItemGroupControllerProvider call(
    String id,
  ) {
    return PatientPrescriptionItemGroupControllerProvider(
      id,
    );
  }

  @override
  PatientPrescriptionItemGroupControllerProvider getProviderOverride(
    covariant PatientPrescriptionItemGroupControllerProvider provider,
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
  String? get name => r'patientPrescriptionItemGroupControllerProvider';
}

/// See also [PatientPrescriptionItemGroupController].
class PatientPrescriptionItemGroupControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        PatientPrescriptionItemGroupController,
        List<PatientPrescriptionItemGroupState>> {
  /// See also [PatientPrescriptionItemGroupController].
  PatientPrescriptionItemGroupControllerProvider(
    String id,
  ) : this._internal(
          () => PatientPrescriptionItemGroupController()..id = id,
          from: patientPrescriptionItemGroupControllerProvider,
          name: r'patientPrescriptionItemGroupControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientPrescriptionItemGroupControllerHash,
          dependencies:
              PatientPrescriptionItemGroupControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientPrescriptionItemGroupControllerFamily
                  ._allTransitiveDependencies,
          id: id,
        );

  PatientPrescriptionItemGroupControllerProvider._internal(
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
  FutureOr<List<PatientPrescriptionItemGroupState>> runNotifierBuild(
    covariant PatientPrescriptionItemGroupController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(
      PatientPrescriptionItemGroupController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientPrescriptionItemGroupControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<
      PatientPrescriptionItemGroupController,
      List<PatientPrescriptionItemGroupState>> createElement() {
    return _PatientPrescriptionItemGroupControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientPrescriptionItemGroupControllerProvider &&
        other.id == id;
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
mixin PatientPrescriptionItemGroupControllerRef
    on AutoDisposeAsyncNotifierProviderRef<
        List<PatientPrescriptionItemGroupState>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientPrescriptionItemGroupControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientPrescriptionItemGroupController,
        List<PatientPrescriptionItemGroupState>>
    with PatientPrescriptionItemGroupControllerRef {
  _PatientPrescriptionItemGroupControllerProviderElement(super.provider);

  @override
  String get id =>
      (origin as PatientPrescriptionItemGroupControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

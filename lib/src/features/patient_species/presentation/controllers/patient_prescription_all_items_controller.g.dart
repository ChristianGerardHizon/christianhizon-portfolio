// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_prescription_all_items_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientPrescriptionAllItemsControllerHash() =>
    r'52087d74c7c4573444d24c63f775a54e0eb91fe2';

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

abstract class _$PatientPrescriptionAllItemsController
    extends BuildlessAutoDisposeAsyncNotifier<List<PatientPrescriptionItem>> {
  late final String id;

  FutureOr<List<PatientPrescriptionItem>> build({
    required String id,
  });
}

/// See also [PatientPrescriptionAllItemsController].
@ProviderFor(PatientPrescriptionAllItemsController)
const patientPrescriptionAllItemsControllerProvider =
    PatientPrescriptionAllItemsControllerFamily();

/// See also [PatientPrescriptionAllItemsController].
class PatientPrescriptionAllItemsControllerFamily
    extends Family<AsyncValue<List<PatientPrescriptionItem>>> {
  /// See also [PatientPrescriptionAllItemsController].
  const PatientPrescriptionAllItemsControllerFamily();

  /// See also [PatientPrescriptionAllItemsController].
  PatientPrescriptionAllItemsControllerProvider call({
    required String id,
  }) {
    return PatientPrescriptionAllItemsControllerProvider(
      id: id,
    );
  }

  @override
  PatientPrescriptionAllItemsControllerProvider getProviderOverride(
    covariant PatientPrescriptionAllItemsControllerProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'patientPrescriptionAllItemsControllerProvider';
}

/// See also [PatientPrescriptionAllItemsController].
class PatientPrescriptionAllItemsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        PatientPrescriptionAllItemsController, List<PatientPrescriptionItem>> {
  /// See also [PatientPrescriptionAllItemsController].
  PatientPrescriptionAllItemsControllerProvider({
    required String id,
  }) : this._internal(
          () => PatientPrescriptionAllItemsController()..id = id,
          from: patientPrescriptionAllItemsControllerProvider,
          name: r'patientPrescriptionAllItemsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientPrescriptionAllItemsControllerHash,
          dependencies:
              PatientPrescriptionAllItemsControllerFamily._dependencies,
          allTransitiveDependencies: PatientPrescriptionAllItemsControllerFamily
              ._allTransitiveDependencies,
          id: id,
        );

  PatientPrescriptionAllItemsControllerProvider._internal(
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
  FutureOr<List<PatientPrescriptionItem>> runNotifierBuild(
    covariant PatientPrescriptionAllItemsController notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }

  @override
  Override overrideWith(
      PatientPrescriptionAllItemsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientPrescriptionAllItemsControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientPrescriptionAllItemsController,
      List<PatientPrescriptionItem>> createElement() {
    return _PatientPrescriptionAllItemsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientPrescriptionAllItemsControllerProvider &&
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
mixin PatientPrescriptionAllItemsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<PatientPrescriptionItem>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientPrescriptionAllItemsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientPrescriptionAllItemsController, List<PatientPrescriptionItem>>
    with PatientPrescriptionAllItemsControllerRef {
  _PatientPrescriptionAllItemsControllerProviderElement(super.provider);

  @override
  String get id => (origin as PatientPrescriptionAllItemsControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

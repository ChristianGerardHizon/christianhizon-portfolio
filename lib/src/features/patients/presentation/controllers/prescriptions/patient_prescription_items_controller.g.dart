// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_prescription_items_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientPrescriptionItemsControllerHash() =>
    r'07fe35f1678374a9aa0d1de5ae6d429b21aaf337';

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

abstract class _$PatientPrescriptionItemsController
    extends BuildlessAutoDisposeAsyncNotifier<PageResults<PrescriptionItem>> {
  late final String? id;

  FutureOr<PageResults<PrescriptionItem>> build({
    String? id,
  });
}

/// See also [PatientPrescriptionItemsController].
@ProviderFor(PatientPrescriptionItemsController)
const patientPrescriptionItemsControllerProvider =
    PatientPrescriptionItemsControllerFamily();

/// See also [PatientPrescriptionItemsController].
class PatientPrescriptionItemsControllerFamily
    extends Family<AsyncValue<PageResults<PrescriptionItem>>> {
  /// See also [PatientPrescriptionItemsController].
  const PatientPrescriptionItemsControllerFamily();

  /// See also [PatientPrescriptionItemsController].
  PatientPrescriptionItemsControllerProvider call({
    String? id,
  }) {
    return PatientPrescriptionItemsControllerProvider(
      id: id,
    );
  }

  @override
  PatientPrescriptionItemsControllerProvider getProviderOverride(
    covariant PatientPrescriptionItemsControllerProvider provider,
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
  String? get name => r'patientPrescriptionItemsControllerProvider';
}

/// See also [PatientPrescriptionItemsController].
class PatientPrescriptionItemsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        PatientPrescriptionItemsController, PageResults<PrescriptionItem>> {
  /// See also [PatientPrescriptionItemsController].
  PatientPrescriptionItemsControllerProvider({
    String? id,
  }) : this._internal(
          () => PatientPrescriptionItemsController()..id = id,
          from: patientPrescriptionItemsControllerProvider,
          name: r'patientPrescriptionItemsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientPrescriptionItemsControllerHash,
          dependencies: PatientPrescriptionItemsControllerFamily._dependencies,
          allTransitiveDependencies: PatientPrescriptionItemsControllerFamily
              ._allTransitiveDependencies,
          id: id,
        );

  PatientPrescriptionItemsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String? id;

  @override
  FutureOr<PageResults<PrescriptionItem>> runNotifierBuild(
    covariant PatientPrescriptionItemsController notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }

  @override
  Override overrideWith(PatientPrescriptionItemsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientPrescriptionItemsControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientPrescriptionItemsController,
      PageResults<PrescriptionItem>> createElement() {
    return _PatientPrescriptionItemsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientPrescriptionItemsControllerProvider &&
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
mixin PatientPrescriptionItemsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PageResults<PrescriptionItem>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _PatientPrescriptionItemsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientPrescriptionItemsController, PageResults<PrescriptionItem>>
    with PatientPrescriptionItemsControllerRef {
  _PatientPrescriptionItemsControllerProviderElement(super.provider);

  @override
  String? get id => (origin as PatientPrescriptionItemsControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

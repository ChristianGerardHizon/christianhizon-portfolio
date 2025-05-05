// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_prescription_item_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientPrescriptionItemFormControllerHash() =>
    r'b69dd3501a8278ac56e2b962ab5a037bf2661704';

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

abstract class _$PatientPrescriptionItemFormController
    extends BuildlessAutoDisposeAsyncNotifier<
        PatientPrescriptionItemFormState> {
  late final String parentId;
  late final String? id;

  FutureOr<PatientPrescriptionItemFormState> build({
    required String parentId,
    String? id,
  });
}

/// See also [PatientPrescriptionItemFormController].
@ProviderFor(PatientPrescriptionItemFormController)
const patientPrescriptionItemFormControllerProvider =
    PatientPrescriptionItemFormControllerFamily();

/// See also [PatientPrescriptionItemFormController].
class PatientPrescriptionItemFormControllerFamily
    extends Family<AsyncValue<PatientPrescriptionItemFormState>> {
  /// See also [PatientPrescriptionItemFormController].
  const PatientPrescriptionItemFormControllerFamily();

  /// See also [PatientPrescriptionItemFormController].
  PatientPrescriptionItemFormControllerProvider call({
    required String parentId,
    String? id,
  }) {
    return PatientPrescriptionItemFormControllerProvider(
      parentId: parentId,
      id: id,
    );
  }

  @override
  PatientPrescriptionItemFormControllerProvider getProviderOverride(
    covariant PatientPrescriptionItemFormControllerProvider provider,
  ) {
    return call(
      parentId: provider.parentId,
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
  String? get name => r'patientPrescriptionItemFormControllerProvider';
}

/// See also [PatientPrescriptionItemFormController].
class PatientPrescriptionItemFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        PatientPrescriptionItemFormController,
        PatientPrescriptionItemFormState> {
  /// See also [PatientPrescriptionItemFormController].
  PatientPrescriptionItemFormControllerProvider({
    required String parentId,
    String? id,
  }) : this._internal(
          () => PatientPrescriptionItemFormController()
            ..parentId = parentId
            ..id = id,
          from: patientPrescriptionItemFormControllerProvider,
          name: r'patientPrescriptionItemFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientPrescriptionItemFormControllerHash,
          dependencies:
              PatientPrescriptionItemFormControllerFamily._dependencies,
          allTransitiveDependencies: PatientPrescriptionItemFormControllerFamily
              ._allTransitiveDependencies,
          parentId: parentId,
          id: id,
        );

  PatientPrescriptionItemFormControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.parentId,
    required this.id,
  }) : super.internal();

  final String parentId;
  final String? id;

  @override
  FutureOr<PatientPrescriptionItemFormState> runNotifierBuild(
    covariant PatientPrescriptionItemFormController notifier,
  ) {
    return notifier.build(
      parentId: parentId,
      id: id,
    );
  }

  @override
  Override overrideWith(
      PatientPrescriptionItemFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientPrescriptionItemFormControllerProvider._internal(
        () => create()
          ..parentId = parentId
          ..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        parentId: parentId,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientPrescriptionItemFormController,
      PatientPrescriptionItemFormState> createElement() {
    return _PatientPrescriptionItemFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientPrescriptionItemFormControllerProvider &&
        other.parentId == parentId &&
        other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, parentId.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientPrescriptionItemFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientPrescriptionItemFormState> {
  /// The parameter `parentId` of this provider.
  String get parentId;

  /// The parameter `id` of this provider.
  String? get id;
}

class _PatientPrescriptionItemFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientPrescriptionItemFormController, PatientPrescriptionItemFormState>
    with PatientPrescriptionItemFormControllerRef {
  _PatientPrescriptionItemFormControllerProviderElement(super.provider);

  @override
  String get parentId =>
      (origin as PatientPrescriptionItemFormControllerProvider).parentId;
  @override
  String? get id =>
      (origin as PatientPrescriptionItemFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

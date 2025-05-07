// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_file_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientFileFormControllerHash() =>
    r'689f65839eaf5a040240be93959633cbd80ffe1d';

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

abstract class _$PatientFileFormController
    extends BuildlessAutoDisposeAsyncNotifier<PatientFileFormState> {
  late final String parentId;
  late final String? id;

  FutureOr<PatientFileFormState> build({
    required String parentId,
    String? id,
  });
}

/// See also [PatientFileFormController].
@ProviderFor(PatientFileFormController)
const patientFileFormControllerProvider = PatientFileFormControllerFamily();

/// See also [PatientFileFormController].
class PatientFileFormControllerFamily
    extends Family<AsyncValue<PatientFileFormState>> {
  /// See also [PatientFileFormController].
  const PatientFileFormControllerFamily();

  /// See also [PatientFileFormController].
  PatientFileFormControllerProvider call({
    required String parentId,
    String? id,
  }) {
    return PatientFileFormControllerProvider(
      parentId: parentId,
      id: id,
    );
  }

  @override
  PatientFileFormControllerProvider getProviderOverride(
    covariant PatientFileFormControllerProvider provider,
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
  String? get name => r'patientFileFormControllerProvider';
}

/// See also [PatientFileFormController].
class PatientFileFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientFileFormController,
        PatientFileFormState> {
  /// See also [PatientFileFormController].
  PatientFileFormControllerProvider({
    required String parentId,
    String? id,
  }) : this._internal(
          () => PatientFileFormController()
            ..parentId = parentId
            ..id = id,
          from: patientFileFormControllerProvider,
          name: r'patientFileFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientFileFormControllerHash,
          dependencies: PatientFileFormControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientFileFormControllerFamily._allTransitiveDependencies,
          parentId: parentId,
          id: id,
        );

  PatientFileFormControllerProvider._internal(
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
  FutureOr<PatientFileFormState> runNotifierBuild(
    covariant PatientFileFormController notifier,
  ) {
    return notifier.build(
      parentId: parentId,
      id: id,
    );
  }

  @override
  Override overrideWith(PatientFileFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientFileFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientFileFormController,
      PatientFileFormState> createElement() {
    return _PatientFileFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientFileFormControllerProvider &&
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
mixin PatientFileFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientFileFormState> {
  /// The parameter `parentId` of this provider.
  String get parentId;

  /// The parameter `id` of this provider.
  String? get id;
}

class _PatientFileFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientFileFormController,
        PatientFileFormState> with PatientFileFormControllerRef {
  _PatientFileFormControllerProviderElement(super.provider);

  @override
  String get parentId => (origin as PatientFileFormControllerProvider).parentId;
  @override
  String? get id => (origin as PatientFileFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

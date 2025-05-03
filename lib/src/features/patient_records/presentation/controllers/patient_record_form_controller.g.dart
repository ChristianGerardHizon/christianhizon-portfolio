// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientRecordFormControllerHash() =>
    r'd9e02a2d439df381bfc7d655c12326c8281cf063';

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

abstract class _$PatientRecordFormController
    extends BuildlessAutoDisposeAsyncNotifier<PatientRecordFormState> {
  late final String? id;
  late final String patientId;

  FutureOr<PatientRecordFormState> build({
    String? id,
    required String patientId,
  });
}

/// See also [PatientRecordFormController].
@ProviderFor(PatientRecordFormController)
const patientRecordFormControllerProvider = PatientRecordFormControllerFamily();

/// See also [PatientRecordFormController].
class PatientRecordFormControllerFamily
    extends Family<AsyncValue<PatientRecordFormState>> {
  /// See also [PatientRecordFormController].
  const PatientRecordFormControllerFamily();

  /// See also [PatientRecordFormController].
  PatientRecordFormControllerProvider call({
    String? id,
    required String patientId,
  }) {
    return PatientRecordFormControllerProvider(
      id: id,
      patientId: patientId,
    );
  }

  @override
  PatientRecordFormControllerProvider getProviderOverride(
    covariant PatientRecordFormControllerProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'patientRecordFormControllerProvider';
}

/// See also [PatientRecordFormController].
class PatientRecordFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientRecordFormController,
        PatientRecordFormState> {
  /// See also [PatientRecordFormController].
  PatientRecordFormControllerProvider({
    String? id,
    required String patientId,
  }) : this._internal(
          () => PatientRecordFormController()
            ..id = id
            ..patientId = patientId,
          from: patientRecordFormControllerProvider,
          name: r'patientRecordFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientRecordFormControllerHash,
          dependencies: PatientRecordFormControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientRecordFormControllerFamily._allTransitiveDependencies,
          id: id,
          patientId: patientId,
        );

  PatientRecordFormControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.patientId,
  }) : super.internal();

  final String? id;
  final String patientId;

  @override
  FutureOr<PatientRecordFormState> runNotifierBuild(
    covariant PatientRecordFormController notifier,
  ) {
    return notifier.build(
      id: id,
      patientId: patientId,
    );
  }

  @override
  Override overrideWith(PatientRecordFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientRecordFormControllerProvider._internal(
        () => create()
          ..id = id
          ..patientId = patientId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        patientId: patientId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientRecordFormController,
      PatientRecordFormState> createElement() {
    return _PatientRecordFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientRecordFormControllerProvider &&
        other.id == id &&
        other.patientId == patientId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, patientId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientRecordFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientRecordFormState> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `patientId` of this provider.
  String get patientId;
}

class _PatientRecordFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientRecordFormController,
        PatientRecordFormState> with PatientRecordFormControllerRef {
  _PatientRecordFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as PatientRecordFormControllerProvider).id;
  @override
  String get patientId =>
      (origin as PatientRecordFormControllerProvider).patientId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

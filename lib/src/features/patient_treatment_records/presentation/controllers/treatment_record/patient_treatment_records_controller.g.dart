// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_treatment_records_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientTreatmentRecordsControllerHash() =>
    r'a48ab46e8456af41a7ec346b37b546fbaa1653da';

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

abstract class _$PatientTreatmentRecordsController
    extends BuildlessAutoDisposeAsyncNotifier<
        PageResults<PatientTreatmentRecord>> {
  late final String? id;
  late final PatientTreatment? treatment;

  FutureOr<PageResults<PatientTreatmentRecord>> build({
    String? id,
    PatientTreatment? treatment,
  });
}

/// See also [PatientTreatmentRecordsController].
@ProviderFor(PatientTreatmentRecordsController)
const patientTreatmentRecordsControllerProvider =
    PatientTreatmentRecordsControllerFamily();

/// See also [PatientTreatmentRecordsController].
class PatientTreatmentRecordsControllerFamily
    extends Family<AsyncValue<PageResults<PatientTreatmentRecord>>> {
  /// See also [PatientTreatmentRecordsController].
  const PatientTreatmentRecordsControllerFamily();

  /// See also [PatientTreatmentRecordsController].
  PatientTreatmentRecordsControllerProvider call({
    String? id,
    PatientTreatment? treatment,
  }) {
    return PatientTreatmentRecordsControllerProvider(
      id: id,
      treatment: treatment,
    );
  }

  @override
  PatientTreatmentRecordsControllerProvider getProviderOverride(
    covariant PatientTreatmentRecordsControllerProvider provider,
  ) {
    return call(
      id: provider.id,
      treatment: provider.treatment,
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
  String? get name => r'patientTreatmentRecordsControllerProvider';
}

/// See also [PatientTreatmentRecordsController].
class PatientTreatmentRecordsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<
        PatientTreatmentRecordsController,
        PageResults<PatientTreatmentRecord>> {
  /// See also [PatientTreatmentRecordsController].
  PatientTreatmentRecordsControllerProvider({
    String? id,
    PatientTreatment? treatment,
  }) : this._internal(
          () => PatientTreatmentRecordsController()
            ..id = id
            ..treatment = treatment,
          from: patientTreatmentRecordsControllerProvider,
          name: r'patientTreatmentRecordsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientTreatmentRecordsControllerHash,
          dependencies: PatientTreatmentRecordsControllerFamily._dependencies,
          allTransitiveDependencies: PatientTreatmentRecordsControllerFamily
              ._allTransitiveDependencies,
          id: id,
          treatment: treatment,
        );

  PatientTreatmentRecordsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
    required this.treatment,
  }) : super.internal();

  final String? id;
  final PatientTreatment? treatment;

  @override
  FutureOr<PageResults<PatientTreatmentRecord>> runNotifierBuild(
    covariant PatientTreatmentRecordsController notifier,
  ) {
    return notifier.build(
      id: id,
      treatment: treatment,
    );
  }

  @override
  Override overrideWith(PatientTreatmentRecordsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientTreatmentRecordsControllerProvider._internal(
        () => create()
          ..id = id
          ..treatment = treatment,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
        treatment: treatment,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientTreatmentRecordsController,
      PageResults<PatientTreatmentRecord>> createElement() {
    return _PatientTreatmentRecordsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientTreatmentRecordsControllerProvider &&
        other.id == id &&
        other.treatment == treatment;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);
    hash = _SystemHash.combine(hash, treatment.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientTreatmentRecordsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<
        PageResults<PatientTreatmentRecord>> {
  /// The parameter `id` of this provider.
  String? get id;

  /// The parameter `treatment` of this provider.
  PatientTreatment? get treatment;
}

class _PatientTreatmentRecordsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientTreatmentRecordsController, PageResults<PatientTreatmentRecord>>
    with PatientTreatmentRecordsControllerRef {
  _PatientTreatmentRecordsControllerProviderElement(super.provider);

  @override
  String? get id => (origin as PatientTreatmentRecordsControllerProvider).id;
  @override
  PatientTreatment? get treatment =>
      (origin as PatientTreatmentRecordsControllerProvider).treatment;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

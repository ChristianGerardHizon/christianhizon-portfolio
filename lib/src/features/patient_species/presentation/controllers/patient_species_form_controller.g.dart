// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_species_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientSpeciesFormControllerHash() =>
    r'fcd622d7a186d226123784645547854c2f511385';

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

abstract class _$PatientSpeciesFormController
    extends BuildlessAutoDisposeAsyncNotifier<PatientSpeciesFormState> {
  late final String? id;

  FutureOr<PatientSpeciesFormState> build(
    String? id,
  );
}

/// See also [PatientSpeciesFormController].
@ProviderFor(PatientSpeciesFormController)
const patientSpeciesFormControllerProvider =
    PatientSpeciesFormControllerFamily();

/// See also [PatientSpeciesFormController].
class PatientSpeciesFormControllerFamily
    extends Family<AsyncValue<PatientSpeciesFormState>> {
  /// See also [PatientSpeciesFormController].
  const PatientSpeciesFormControllerFamily();

  /// See also [PatientSpeciesFormController].
  PatientSpeciesFormControllerProvider call(
    String? id,
  ) {
    return PatientSpeciesFormControllerProvider(
      id,
    );
  }

  @override
  PatientSpeciesFormControllerProvider getProviderOverride(
    covariant PatientSpeciesFormControllerProvider provider,
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
  String? get name => r'patientSpeciesFormControllerProvider';
}

/// See also [PatientSpeciesFormController].
class PatientSpeciesFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientSpeciesFormController,
        PatientSpeciesFormState> {
  /// See also [PatientSpeciesFormController].
  PatientSpeciesFormControllerProvider(
    String? id,
  ) : this._internal(
          () => PatientSpeciesFormController()..id = id,
          from: patientSpeciesFormControllerProvider,
          name: r'patientSpeciesFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientSpeciesFormControllerHash,
          dependencies: PatientSpeciesFormControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientSpeciesFormControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientSpeciesFormControllerProvider._internal(
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
  FutureOr<PatientSpeciesFormState> runNotifierBuild(
    covariant PatientSpeciesFormController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientSpeciesFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientSpeciesFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientSpeciesFormController,
      PatientSpeciesFormState> createElement() {
    return _PatientSpeciesFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientSpeciesFormControllerProvider && other.id == id;
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
mixin PatientSpeciesFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientSpeciesFormState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _PatientSpeciesFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<
        PatientSpeciesFormController,
        PatientSpeciesFormState> with PatientSpeciesFormControllerRef {
  _PatientSpeciesFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as PatientSpeciesFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientFormControllerHash() =>
    r'8cc0f6e4c7b2886e1b6b1d6e4f4c3c61efafb7e3';

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

abstract class _$PatientFormController
    extends BuildlessAutoDisposeAsyncNotifier<PatientFormState> {
  late final String? id;

  FutureOr<PatientFormState> build(
    String? id,
  );
}

/// See also [PatientFormController].
@ProviderFor(PatientFormController)
const patientFormControllerProvider = PatientFormControllerFamily();

/// See also [PatientFormController].
class PatientFormControllerFamily extends Family<AsyncValue<PatientFormState>> {
  /// See also [PatientFormController].
  const PatientFormControllerFamily();

  /// See also [PatientFormController].
  PatientFormControllerProvider call(
    String? id,
  ) {
    return PatientFormControllerProvider(
      id,
    );
  }

  @override
  PatientFormControllerProvider getProviderOverride(
    covariant PatientFormControllerProvider provider,
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
  String? get name => r'patientFormControllerProvider';
}

/// See also [PatientFormController].
class PatientFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientFormController,
        PatientFormState> {
  /// See also [PatientFormController].
  PatientFormControllerProvider(
    String? id,
  ) : this._internal(
          () => PatientFormController()..id = id,
          from: patientFormControllerProvider,
          name: r'patientFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientFormControllerHash,
          dependencies: PatientFormControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientFormControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientFormControllerProvider._internal(
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
  FutureOr<PatientFormState> runNotifierBuild(
    covariant PatientFormController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientFormController,
      PatientFormState> createElement() {
    return _PatientFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientFormControllerProvider && other.id == id;
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
mixin PatientFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientFormState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _PatientFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientFormController,
        PatientFormState> with PatientFormControllerRef {
  _PatientFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as PatientFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

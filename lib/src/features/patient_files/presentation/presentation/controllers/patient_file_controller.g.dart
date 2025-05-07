// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_file_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientFileControllerHash() =>
    r'9f15dddf8246c6c4b616a9a0a0edd0f0cabd1e9e';

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

abstract class _$PatientFileController
    extends BuildlessAutoDisposeAsyncNotifier<PatientFile> {
  late final String id;

  FutureOr<PatientFile> build(
    String id,
  );
}

/// See also [PatientFileController].
@ProviderFor(PatientFileController)
const patientFileControllerProvider = PatientFileControllerFamily();

/// See also [PatientFileController].
class PatientFileControllerFamily extends Family<AsyncValue<PatientFile>> {
  /// See also [PatientFileController].
  const PatientFileControllerFamily();

  /// See also [PatientFileController].
  PatientFileControllerProvider call(
    String id,
  ) {
    return PatientFileControllerProvider(
      id,
    );
  }

  @override
  PatientFileControllerProvider getProviderOverride(
    covariant PatientFileControllerProvider provider,
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
  String? get name => r'patientFileControllerProvider';
}

/// See also [PatientFileController].
class PatientFileControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientFileController,
        PatientFile> {
  /// See also [PatientFileController].
  PatientFileControllerProvider(
    String id,
  ) : this._internal(
          () => PatientFileController()..id = id,
          from: patientFileControllerProvider,
          name: r'patientFileControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientFileControllerHash,
          dependencies: PatientFileControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientFileControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientFileControllerProvider._internal(
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
  FutureOr<PatientFile> runNotifierBuild(
    covariant PatientFileController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(PatientFileController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientFileControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientFileController, PatientFile>
      createElement() {
    return _PatientFileControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientFileControllerProvider && other.id == id;
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
mixin PatientFileControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PatientFile> {
  /// The parameter `id` of this provider.
  String get id;
}

class _PatientFileControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientFileController,
        PatientFile> with PatientFileControllerRef {
  _PatientFileControllerProviderElement(super.provider);

  @override
  String get id => (origin as PatientFileControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

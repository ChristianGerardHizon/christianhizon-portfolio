// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_records_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientRecordsControllerHash() =>
    r'3461b85a961f24f7c8d6779e4598868c22a12ada';

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

abstract class _$PatientRecordsController
    extends BuildlessAutoDisposeAsyncNotifier<PageResults<PatientRecord>> {
  late final String? id;

  FutureOr<PageResults<PatientRecord>> build({
    String? id,
  });
}

/// See also [PatientRecordsController].
@ProviderFor(PatientRecordsController)
const patientRecordsControllerProvider = PatientRecordsControllerFamily();

/// See also [PatientRecordsController].
class PatientRecordsControllerFamily
    extends Family<AsyncValue<PageResults<PatientRecord>>> {
  /// See also [PatientRecordsController].
  const PatientRecordsControllerFamily();

  /// See also [PatientRecordsController].
  PatientRecordsControllerProvider call({
    String? id,
  }) {
    return PatientRecordsControllerProvider(
      id: id,
    );
  }

  @override
  PatientRecordsControllerProvider getProviderOverride(
    covariant PatientRecordsControllerProvider provider,
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
  String? get name => r'patientRecordsControllerProvider';
}

/// See also [PatientRecordsController].
class PatientRecordsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<PatientRecordsController,
        PageResults<PatientRecord>> {
  /// See also [PatientRecordsController].
  PatientRecordsControllerProvider({
    String? id,
  }) : this._internal(
          () => PatientRecordsController()..id = id,
          from: patientRecordsControllerProvider,
          name: r'patientRecordsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientRecordsControllerHash,
          dependencies: PatientRecordsControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientRecordsControllerFamily._allTransitiveDependencies,
          id: id,
        );

  PatientRecordsControllerProvider._internal(
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
  FutureOr<PageResults<PatientRecord>> runNotifierBuild(
    covariant PatientRecordsController notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }

  @override
  Override overrideWith(PatientRecordsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientRecordsControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<PatientRecordsController,
      PageResults<PatientRecord>> createElement() {
    return _PatientRecordsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientRecordsControllerProvider && other.id == id;
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
mixin PatientRecordsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PageResults<PatientRecord>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _PatientRecordsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientRecordsController,
        PageResults<PatientRecord>> with PatientRecordsControllerRef {
  _PatientRecordsControllerProviderElement(super.provider);

  @override
  String? get id => (origin as PatientRecordsControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

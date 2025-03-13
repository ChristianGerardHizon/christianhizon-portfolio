// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medical_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$medicalRecordControllerHash() =>
    r'13380cc7e9fdcafb62d9650c5c952fbc9024273c';

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

abstract class _$MedicalRecordController
    extends BuildlessAutoDisposeAsyncNotifier<MedicalRecord> {
  late final String id;

  FutureOr<MedicalRecord> build(
    String id,
  );
}

/// See also [MedicalRecordController].
@ProviderFor(MedicalRecordController)
const medicalRecordControllerProvider = MedicalRecordControllerFamily();

/// See also [MedicalRecordController].
class MedicalRecordControllerFamily extends Family<AsyncValue<MedicalRecord>> {
  /// See also [MedicalRecordController].
  const MedicalRecordControllerFamily();

  /// See also [MedicalRecordController].
  MedicalRecordControllerProvider call(
    String id,
  ) {
    return MedicalRecordControllerProvider(
      id,
    );
  }

  @override
  MedicalRecordControllerProvider getProviderOverride(
    covariant MedicalRecordControllerProvider provider,
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
  String? get name => r'medicalRecordControllerProvider';
}

/// See also [MedicalRecordController].
class MedicalRecordControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MedicalRecordController,
        MedicalRecord> {
  /// See also [MedicalRecordController].
  MedicalRecordControllerProvider(
    String id,
  ) : this._internal(
          () => MedicalRecordController()..id = id,
          from: medicalRecordControllerProvider,
          name: r'medicalRecordControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$medicalRecordControllerHash,
          dependencies: MedicalRecordControllerFamily._dependencies,
          allTransitiveDependencies:
              MedicalRecordControllerFamily._allTransitiveDependencies,
          id: id,
        );

  MedicalRecordControllerProvider._internal(
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
  FutureOr<MedicalRecord> runNotifierBuild(
    covariant MedicalRecordController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(MedicalRecordController Function() create) {
    return ProviderOverride(
      origin: this,
      override: MedicalRecordControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<MedicalRecordController,
      MedicalRecord> createElement() {
    return _MedicalRecordControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MedicalRecordControllerProvider && other.id == id;
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
mixin MedicalRecordControllerRef
    on AutoDisposeAsyncNotifierProviderRef<MedicalRecord> {
  /// The parameter `id` of this provider.
  String get id;
}

class _MedicalRecordControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<MedicalRecordController,
        MedicalRecord> with MedicalRecordControllerRef {
  _MedicalRecordControllerProviderElement(super.provider);

  @override
  String get id => (origin as MedicalRecordControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

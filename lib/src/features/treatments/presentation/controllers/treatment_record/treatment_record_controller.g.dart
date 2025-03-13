// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_record_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$treatmentRecordControllerHash() =>
    r'bbe6f5235d781d52f0c71f0ea33e34ed0a261ef7';

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

abstract class _$TreatmentRecordController
    extends BuildlessAutoDisposeAsyncNotifier<TreatmentRecord> {
  late final String id;

  FutureOr<TreatmentRecord> build(
    String id,
  );
}

/// See also [TreatmentRecordController].
@ProviderFor(TreatmentRecordController)
const treatmentRecordControllerProvider = TreatmentRecordControllerFamily();

/// See also [TreatmentRecordController].
class TreatmentRecordControllerFamily
    extends Family<AsyncValue<TreatmentRecord>> {
  /// See also [TreatmentRecordController].
  const TreatmentRecordControllerFamily();

  /// See also [TreatmentRecordController].
  TreatmentRecordControllerProvider call(
    String id,
  ) {
    return TreatmentRecordControllerProvider(
      id,
    );
  }

  @override
  TreatmentRecordControllerProvider getProviderOverride(
    covariant TreatmentRecordControllerProvider provider,
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
  String? get name => r'treatmentRecordControllerProvider';
}

/// See also [TreatmentRecordController].
class TreatmentRecordControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TreatmentRecordController,
        TreatmentRecord> {
  /// See also [TreatmentRecordController].
  TreatmentRecordControllerProvider(
    String id,
  ) : this._internal(
          () => TreatmentRecordController()..id = id,
          from: treatmentRecordControllerProvider,
          name: r'treatmentRecordControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$treatmentRecordControllerHash,
          dependencies: TreatmentRecordControllerFamily._dependencies,
          allTransitiveDependencies:
              TreatmentRecordControllerFamily._allTransitiveDependencies,
          id: id,
        );

  TreatmentRecordControllerProvider._internal(
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
  FutureOr<TreatmentRecord> runNotifierBuild(
    covariant TreatmentRecordController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(TreatmentRecordController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TreatmentRecordControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<TreatmentRecordController,
      TreatmentRecord> createElement() {
    return _TreatmentRecordControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TreatmentRecordControllerProvider && other.id == id;
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
mixin TreatmentRecordControllerRef
    on AutoDisposeAsyncNotifierProviderRef<TreatmentRecord> {
  /// The parameter `id` of this provider.
  String get id;
}

class _TreatmentRecordControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TreatmentRecordController,
        TreatmentRecord> with TreatmentRecordControllerRef {
  _TreatmentRecordControllerProviderElement(super.provider);

  @override
  String get id => (origin as TreatmentRecordControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

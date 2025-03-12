// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_records_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$treatmentRecordsControllerHash() =>
    r'b2c9b358145b1e9621cdd95952376f05529820b5';

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

abstract class _$TreatmentRecordsController
    extends BuildlessAutoDisposeAsyncNotifier<PageResults<TreatmentRecord>> {
  late final String? id;

  FutureOr<PageResults<TreatmentRecord>> build({
    String? id,
  });
}

/// See also [TreatmentRecordsController].
@ProviderFor(TreatmentRecordsController)
const treatmentRecordsControllerProvider = TreatmentRecordsControllerFamily();

/// See also [TreatmentRecordsController].
class TreatmentRecordsControllerFamily
    extends Family<AsyncValue<PageResults<TreatmentRecord>>> {
  /// See also [TreatmentRecordsController].
  const TreatmentRecordsControllerFamily();

  /// See also [TreatmentRecordsController].
  TreatmentRecordsControllerProvider call({
    String? id,
  }) {
    return TreatmentRecordsControllerProvider(
      id: id,
    );
  }

  @override
  TreatmentRecordsControllerProvider getProviderOverride(
    covariant TreatmentRecordsControllerProvider provider,
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
  String? get name => r'treatmentRecordsControllerProvider';
}

/// See also [TreatmentRecordsController].
class TreatmentRecordsControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<TreatmentRecordsController,
        PageResults<TreatmentRecord>> {
  /// See also [TreatmentRecordsController].
  TreatmentRecordsControllerProvider({
    String? id,
  }) : this._internal(
          () => TreatmentRecordsController()..id = id,
          from: treatmentRecordsControllerProvider,
          name: r'treatmentRecordsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$treatmentRecordsControllerHash,
          dependencies: TreatmentRecordsControllerFamily._dependencies,
          allTransitiveDependencies:
              TreatmentRecordsControllerFamily._allTransitiveDependencies,
          id: id,
        );

  TreatmentRecordsControllerProvider._internal(
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
  FutureOr<PageResults<TreatmentRecord>> runNotifierBuild(
    covariant TreatmentRecordsController notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }

  @override
  Override overrideWith(TreatmentRecordsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TreatmentRecordsControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<TreatmentRecordsController,
      PageResults<TreatmentRecord>> createElement() {
    return _TreatmentRecordsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TreatmentRecordsControllerProvider && other.id == id;
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
mixin TreatmentRecordsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<PageResults<TreatmentRecord>> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _TreatmentRecordsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<TreatmentRecordsController,
        PageResults<TreatmentRecord>> with TreatmentRecordsControllerRef {
  _TreatmentRecordsControllerProviderElement(super.provider);

  @override
  String? get id => (origin as TreatmentRecordsControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

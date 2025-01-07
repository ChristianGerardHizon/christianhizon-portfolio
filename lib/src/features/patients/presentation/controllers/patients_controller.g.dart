// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$patientsControllerHash() =>
    r'9cd02bc1145d9a0619ac4b112141de760db4725a';

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

abstract class _$PatientsController
    extends BuildlessAutoDisposeAsyncNotifier<List<Patient>> {
  late final int page;
  late final int pageSize;

  FutureOr<List<Patient>> build(
    int page, {
    int pageSize = 50,
  });
}

/// See also [PatientsController].
@ProviderFor(PatientsController)
const patientsControllerProvider = PatientsControllerFamily();

/// See also [PatientsController].
class PatientsControllerFamily extends Family<AsyncValue<List<Patient>>> {
  /// See also [PatientsController].
  const PatientsControllerFamily();

  /// See also [PatientsController].
  PatientsControllerProvider call(
    int page, {
    int pageSize = 50,
  }) {
    return PatientsControllerProvider(
      page,
      pageSize: pageSize,
    );
  }

  @override
  PatientsControllerProvider getProviderOverride(
    covariant PatientsControllerProvider provider,
  ) {
    return call(
      provider.page,
      pageSize: provider.pageSize,
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
  String? get name => r'patientsControllerProvider';
}

/// See also [PatientsController].
class PatientsControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    PatientsController, List<Patient>> {
  /// See also [PatientsController].
  PatientsControllerProvider(
    int page, {
    int pageSize = 50,
  }) : this._internal(
          () => PatientsController()
            ..page = page
            ..pageSize = pageSize,
          from: patientsControllerProvider,
          name: r'patientsControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$patientsControllerHash,
          dependencies: PatientsControllerFamily._dependencies,
          allTransitiveDependencies:
              PatientsControllerFamily._allTransitiveDependencies,
          page: page,
          pageSize: pageSize,
        );

  PatientsControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.page,
    required this.pageSize,
  }) : super.internal();

  final int page;
  final int pageSize;

  @override
  FutureOr<List<Patient>> runNotifierBuild(
    covariant PatientsController notifier,
  ) {
    return notifier.build(
      page,
      pageSize: pageSize,
    );
  }

  @override
  Override overrideWith(PatientsController Function() create) {
    return ProviderOverride(
      origin: this,
      override: PatientsControllerProvider._internal(
        () => create()
          ..page = page
          ..pageSize = pageSize,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        page: page,
        pageSize: pageSize,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<PatientsController, List<Patient>>
      createElement() {
    return _PatientsControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PatientsControllerProvider &&
        other.page == page &&
        other.pageSize == pageSize;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);
    hash = _SystemHash.combine(hash, pageSize.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PatientsControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Patient>> {
  /// The parameter `page` of this provider.
  int get page;

  /// The parameter `pageSize` of this provider.
  int get pageSize;
}

class _PatientsControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<PatientsController,
        List<Patient>> with PatientsControllerRef {
  _PatientsControllerProviderElement(super.provider);

  @override
  int get page => (origin as PatientsControllerProvider).page;
  @override
  int get pageSize => (origin as PatientsControllerProvider).pageSize;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

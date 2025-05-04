// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminTableControllerHash() =>
    r'6977f4cb5ab9790b327e309349516298bdb763c1';

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

abstract class _$AdminTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<Admin>> {
  late final String tableKey;

  FutureOr<List<Admin>> build(
    String tableKey,
  );
}

/// See also [AdminTableController].
@ProviderFor(AdminTableController)
const adminTableControllerProvider = AdminTableControllerFamily();

/// See also [AdminTableController].
class AdminTableControllerFamily extends Family<AsyncValue<List<Admin>>> {
  /// See also [AdminTableController].
  const AdminTableControllerFamily();

  /// See also [AdminTableController].
  AdminTableControllerProvider call(
    String tableKey,
  ) {
    return AdminTableControllerProvider(
      tableKey,
    );
  }

  @override
  AdminTableControllerProvider getProviderOverride(
    covariant AdminTableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
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
  String? get name => r'adminTableControllerProvider';
}

/// See also [AdminTableController].
class AdminTableControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    AdminTableController, List<Admin>> {
  /// See also [AdminTableController].
  AdminTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => AdminTableController()..tableKey = tableKey,
          from: adminTableControllerProvider,
          name: r'adminTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$adminTableControllerHash,
          dependencies: AdminTableControllerFamily._dependencies,
          allTransitiveDependencies:
              AdminTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  AdminTableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
  }) : super.internal();

  final String tableKey;

  @override
  FutureOr<List<Admin>> runNotifierBuild(
    covariant AdminTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(AdminTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AdminTableControllerProvider._internal(
        () => create()..tableKey = tableKey,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<AdminTableController, List<Admin>>
      createElement() {
    return _AdminTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminTableControllerProvider && other.tableKey == tableKey;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AdminTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<Admin>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _AdminTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AdminTableController,
        List<Admin>> with AdminTableControllerRef {
  _AdminTableControllerProviderElement(super.provider);

  @override
  String get tableKey => (origin as AdminTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

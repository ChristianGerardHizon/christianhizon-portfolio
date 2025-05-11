// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tableControllerHash() => r'7cc5518873f9cc50e97ecc3c56cf8d779f0c085c';

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

abstract class _$TableController
    extends BuildlessAutoDisposeNotifier<TableState> {
  late final String tableKey;

  TableState build(
    String tableKey,
  );
}

/// See also [TableController].
@ProviderFor(TableController)
const tableControllerProvider = TableControllerFamily();

/// See also [TableController].
class TableControllerFamily extends Family<TableState> {
  /// See also [TableController].
  const TableControllerFamily();

  /// See also [TableController].
  TableControllerProvider call(
    String tableKey,
  ) {
    return TableControllerProvider(
      tableKey,
    );
  }

  @override
  TableControllerProvider getProviderOverride(
    covariant TableControllerProvider provider,
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
  String? get name => r'tableControllerProvider';
}

/// See also [TableController].
class TableControllerProvider
    extends AutoDisposeNotifierProviderImpl<TableController, TableState> {
  /// See also [TableController].
  TableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => TableController()..tableKey = tableKey,
          from: tableControllerProvider,
          name: r'tableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tableControllerHash,
          dependencies: TableControllerFamily._dependencies,
          allTransitiveDependencies:
              TableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  TableControllerProvider._internal(
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
  TableState runNotifierBuild(
    covariant TableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(TableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TableControllerProvider._internal(
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
  AutoDisposeNotifierProviderElement<TableController, TableState>
      createElement() {
    return _TableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TableControllerProvider && other.tableKey == tableKey;
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
mixin TableControllerRef on AutoDisposeNotifierProviderRef<TableState> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _TableControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TableController, TableState>
    with TableControllerRef {
  _TableControllerProviderElement(super.provider);

  @override
  String get tableKey => (origin as TableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tableControllerHash() => r'd5e727baa83376760a500e54200f9708f409164e';

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
  late final TableState? tableState;

  TableState build(
    String tableKey, {
    TableState? tableState,
  });
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
    String tableKey, {
    TableState? tableState,
  }) {
    return TableControllerProvider(
      tableKey,
      tableState: tableState,
    );
  }

  @override
  TableControllerProvider getProviderOverride(
    covariant TableControllerProvider provider,
  ) {
    return call(
      provider.tableKey,
      tableState: provider.tableState,
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
    String tableKey, {
    TableState? tableState,
  }) : this._internal(
          () => TableController()
            ..tableKey = tableKey
            ..tableState = tableState,
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
          tableState: tableState,
        );

  TableControllerProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tableKey,
    required this.tableState,
  }) : super.internal();

  final String tableKey;
  final TableState? tableState;

  @override
  TableState runNotifierBuild(
    covariant TableController notifier,
  ) {
    return notifier.build(
      tableKey,
      tableState: tableState,
    );
  }

  @override
  Override overrideWith(TableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: TableControllerProvider._internal(
        () => create()
          ..tableKey = tableKey
          ..tableState = tableState,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tableKey: tableKey,
        tableState: tableState,
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
    return other is TableControllerProvider &&
        other.tableKey == tableKey &&
        other.tableState == tableState;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tableKey.hashCode);
    hash = _SystemHash.combine(hash, tableState.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin TableControllerRef on AutoDisposeNotifierProviderRef<TableState> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;

  /// The parameter `tableState` of this provider.
  TableState? get tableState;
}

class _TableControllerProviderElement
    extends AutoDisposeNotifierProviderElement<TableController, TableState>
    with TableControllerRef {
  _TableControllerProviderElement(super.provider);

  @override
  String get tableKey => (origin as TableControllerProvider).tableKey;
  @override
  TableState? get tableState => (origin as TableControllerProvider).tableState;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

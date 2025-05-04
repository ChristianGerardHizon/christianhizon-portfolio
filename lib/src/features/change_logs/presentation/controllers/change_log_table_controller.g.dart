// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_log_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$changeLogTableControllerHash() =>
    r'2bff4cfcaa549626890f1c986ad5d3933dac14a9';

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

abstract class _$ChangeLogTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<ChangeLog>> {
  late final String tableKey;

  FutureOr<List<ChangeLog>> build(
    String tableKey,
  );
}

/// See also [ChangeLogTableController].
@ProviderFor(ChangeLogTableController)
const changeLogTableControllerProvider = ChangeLogTableControllerFamily();

/// See also [ChangeLogTableController].
class ChangeLogTableControllerFamily
    extends Family<AsyncValue<List<ChangeLog>>> {
  /// See also [ChangeLogTableController].
  const ChangeLogTableControllerFamily();

  /// See also [ChangeLogTableController].
  ChangeLogTableControllerProvider call(
    String tableKey,
  ) {
    return ChangeLogTableControllerProvider(
      tableKey,
    );
  }

  @override
  ChangeLogTableControllerProvider getProviderOverride(
    covariant ChangeLogTableControllerProvider provider,
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
  String? get name => r'changeLogTableControllerProvider';
}

/// See also [ChangeLogTableController].
class ChangeLogTableControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ChangeLogTableController,
        List<ChangeLog>> {
  /// See also [ChangeLogTableController].
  ChangeLogTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => ChangeLogTableController()..tableKey = tableKey,
          from: changeLogTableControllerProvider,
          name: r'changeLogTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$changeLogTableControllerHash,
          dependencies: ChangeLogTableControllerFamily._dependencies,
          allTransitiveDependencies:
              ChangeLogTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  ChangeLogTableControllerProvider._internal(
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
  FutureOr<List<ChangeLog>> runNotifierBuild(
    covariant ChangeLogTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(ChangeLogTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChangeLogTableControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ChangeLogTableController,
      List<ChangeLog>> createElement() {
    return _ChangeLogTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChangeLogTableControllerProvider &&
        other.tableKey == tableKey;
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
mixin ChangeLogTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<ChangeLog>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _ChangeLogTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChangeLogTableController,
        List<ChangeLog>> with ChangeLogTableControllerRef {
  _ChangeLogTableControllerProviderElement(super.provider);

  @override
  String get tableKey => (origin as ChangeLogTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

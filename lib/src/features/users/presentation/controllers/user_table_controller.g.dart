// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userTableControllerHash() =>
    r'3efe0975528b0b77ad4a0692be1566200a8e6bf2';

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

abstract class _$UserTableController
    extends BuildlessAutoDisposeAsyncNotifier<List<User>> {
  late final String tableKey;

  FutureOr<List<User>> build(
    String tableKey,
  );
}

/// See also [UserTableController].
@ProviderFor(UserTableController)
const userTableControllerProvider = UserTableControllerFamily();

/// See also [UserTableController].
class UserTableControllerFamily extends Family<AsyncValue<List<User>>> {
  /// See also [UserTableController].
  const UserTableControllerFamily();

  /// See also [UserTableController].
  UserTableControllerProvider call(
    String tableKey,
  ) {
    return UserTableControllerProvider(
      tableKey,
    );
  }

  @override
  UserTableControllerProvider getProviderOverride(
    covariant UserTableControllerProvider provider,
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
  String? get name => r'userTableControllerProvider';
}

/// See also [UserTableController].
class UserTableControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    UserTableController, List<User>> {
  /// See also [UserTableController].
  UserTableControllerProvider(
    String tableKey,
  ) : this._internal(
          () => UserTableController()..tableKey = tableKey,
          from: userTableControllerProvider,
          name: r'userTableControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userTableControllerHash,
          dependencies: UserTableControllerFamily._dependencies,
          allTransitiveDependencies:
              UserTableControllerFamily._allTransitiveDependencies,
          tableKey: tableKey,
        );

  UserTableControllerProvider._internal(
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
  FutureOr<List<User>> runNotifierBuild(
    covariant UserTableController notifier,
  ) {
    return notifier.build(
      tableKey,
    );
  }

  @override
  Override overrideWith(UserTableController Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserTableControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserTableController, List<User>>
      createElement() {
    return _UserTableControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserTableControllerProvider && other.tableKey == tableKey;
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
mixin UserTableControllerRef
    on AutoDisposeAsyncNotifierProviderRef<List<User>> {
  /// The parameter `tableKey` of this provider.
  String get tableKey;
}

class _UserTableControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserTableController,
        List<User>> with UserTableControllerRef {
  _UserTableControllerProviderElement(super.provider);

  @override
  String get tableKey => (origin as UserTableControllerProvider).tableKey;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

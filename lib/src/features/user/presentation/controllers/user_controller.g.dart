// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userControllerHash() => r'ff5991fb017ed2a23e5c565867dd0590de5649fb';

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

abstract class _$UserController
    extends BuildlessAutoDisposeAsyncNotifier<User> {
  late final String id;

  FutureOr<User> build(
    String id,
  );
}

/// See also [UserController].
@ProviderFor(UserController)
const userControllerProvider = UserControllerFamily();

/// See also [UserController].
class UserControllerFamily extends Family<AsyncValue<User>> {
  /// See also [UserController].
  const UserControllerFamily();

  /// See also [UserController].
  UserControllerProvider call(
    String id,
  ) {
    return UserControllerProvider(
      id,
    );
  }

  @override
  UserControllerProvider getProviderOverride(
    covariant UserControllerProvider provider,
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
  String? get name => r'userControllerProvider';
}

/// See also [UserController].
class UserControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<UserController, User> {
  /// See also [UserController].
  UserControllerProvider(
    String id,
  ) : this._internal(
          () => UserController()..id = id,
          from: userControllerProvider,
          name: r'userControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userControllerHash,
          dependencies: UserControllerFamily._dependencies,
          allTransitiveDependencies:
              UserControllerFamily._allTransitiveDependencies,
          id: id,
        );

  UserControllerProvider._internal(
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
  FutureOr<User> runNotifierBuild(
    covariant UserController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(UserController Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserController, User>
      createElement() {
    return _UserControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserControllerProvider && other.id == id;
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
mixin UserControllerRef on AutoDisposeAsyncNotifierProviderRef<User> {
  /// The parameter `id` of this provider.
  String get id;
}

class _UserControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserController, User>
    with UserControllerRef {
  _UserControllerProviderElement(super.provider);

  @override
  String get id => (origin as UserControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_update_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userUpdateControllerHash() =>
    r'668c1ba4256b28cafd8bbc8bd7bb17126348d588';

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

abstract class _$UserUpdateController
    extends BuildlessAutoDisposeAsyncNotifier<UserUpdateState> {
  late final String id;

  FutureOr<UserUpdateState> build(
    String id,
  );
}

/// See also [UserUpdateController].
@ProviderFor(UserUpdateController)
const userUpdateControllerProvider = UserUpdateControllerFamily();

/// See also [UserUpdateController].
class UserUpdateControllerFamily extends Family<AsyncValue<UserUpdateState>> {
  /// See also [UserUpdateController].
  const UserUpdateControllerFamily();

  /// See also [UserUpdateController].
  UserUpdateControllerProvider call(
    String id,
  ) {
    return UserUpdateControllerProvider(
      id,
    );
  }

  @override
  UserUpdateControllerProvider getProviderOverride(
    covariant UserUpdateControllerProvider provider,
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
  String? get name => r'userUpdateControllerProvider';
}

/// See also [UserUpdateController].
class UserUpdateControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    UserUpdateController, UserUpdateState> {
  /// See also [UserUpdateController].
  UserUpdateControllerProvider(
    String id,
  ) : this._internal(
          () => UserUpdateController()..id = id,
          from: userUpdateControllerProvider,
          name: r'userUpdateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userUpdateControllerHash,
          dependencies: UserUpdateControllerFamily._dependencies,
          allTransitiveDependencies:
              UserUpdateControllerFamily._allTransitiveDependencies,
          id: id,
        );

  UserUpdateControllerProvider._internal(
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
  FutureOr<UserUpdateState> runNotifierBuild(
    covariant UserUpdateController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(UserUpdateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserUpdateControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserUpdateController, UserUpdateState>
      createElement() {
    return _UserUpdateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserUpdateControllerProvider && other.id == id;
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
mixin UserUpdateControllerRef
    on AutoDisposeAsyncNotifierProviderRef<UserUpdateState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _UserUpdateControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserUpdateController,
        UserUpdateState> with UserUpdateControllerRef {
  _UserUpdateControllerProviderElement(super.provider);

  @override
  String get id => (origin as UserUpdateControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

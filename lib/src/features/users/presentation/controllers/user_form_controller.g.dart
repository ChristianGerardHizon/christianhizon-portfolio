// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$userFormControllerHash() =>
    r'ca64cb4e81c6d84196d677f1edad41d883f52e0f';

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

abstract class _$UserFormController
    extends BuildlessAutoDisposeAsyncNotifier<UserFormState> {
  late final String? id;

  FutureOr<UserFormState> build(
    String? id,
  );
}

/// See also [UserFormController].
@ProviderFor(UserFormController)
const userFormControllerProvider = UserFormControllerFamily();

/// See also [UserFormController].
class UserFormControllerFamily extends Family<AsyncValue<UserFormState>> {
  /// See also [UserFormController].
  const UserFormControllerFamily();

  /// See also [UserFormController].
  UserFormControllerProvider call(
    String? id,
  ) {
    return UserFormControllerProvider(
      id,
    );
  }

  @override
  UserFormControllerProvider getProviderOverride(
    covariant UserFormControllerProvider provider,
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
  String? get name => r'userFormControllerProvider';
}

/// See also [UserFormController].
class UserFormControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    UserFormController, UserFormState> {
  /// See also [UserFormController].
  UserFormControllerProvider(
    String? id,
  ) : this._internal(
          () => UserFormController()..id = id,
          from: userFormControllerProvider,
          name: r'userFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$userFormControllerHash,
          dependencies: UserFormControllerFamily._dependencies,
          allTransitiveDependencies:
              UserFormControllerFamily._allTransitiveDependencies,
          id: id,
        );

  UserFormControllerProvider._internal(
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
  FutureOr<UserFormState> runNotifierBuild(
    covariant UserFormController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(UserFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: UserFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<UserFormController, UserFormState>
      createElement() {
    return _UserFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserFormControllerProvider && other.id == id;
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
mixin UserFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<UserFormState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _UserFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<UserFormController,
        UserFormState> with UserFormControllerRef {
  _UserFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as UserFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

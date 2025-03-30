// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_update_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminUpdateControllerHash() =>
    r'd7e037029341bf35a69e63c41ef11710153a639b';

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

abstract class _$AdminUpdateController
    extends BuildlessAutoDisposeAsyncNotifier<AdminUpdateState> {
  late final String id;

  FutureOr<AdminUpdateState> build(
    String id,
  );
}

/// See also [AdminUpdateController].
@ProviderFor(AdminUpdateController)
const adminUpdateControllerProvider = AdminUpdateControllerFamily();

/// See also [AdminUpdateController].
class AdminUpdateControllerFamily extends Family<AsyncValue<AdminUpdateState>> {
  /// See also [AdminUpdateController].
  const AdminUpdateControllerFamily();

  /// See also [AdminUpdateController].
  AdminUpdateControllerProvider call(
    String id,
  ) {
    return AdminUpdateControllerProvider(
      id,
    );
  }

  @override
  AdminUpdateControllerProvider getProviderOverride(
    covariant AdminUpdateControllerProvider provider,
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
  String? get name => r'adminUpdateControllerProvider';
}

/// See also [AdminUpdateController].
class AdminUpdateControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<AdminUpdateController,
        AdminUpdateState> {
  /// See also [AdminUpdateController].
  AdminUpdateControllerProvider(
    String id,
  ) : this._internal(
          () => AdminUpdateController()..id = id,
          from: adminUpdateControllerProvider,
          name: r'adminUpdateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$adminUpdateControllerHash,
          dependencies: AdminUpdateControllerFamily._dependencies,
          allTransitiveDependencies:
              AdminUpdateControllerFamily._allTransitiveDependencies,
          id: id,
        );

  AdminUpdateControllerProvider._internal(
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
  FutureOr<AdminUpdateState> runNotifierBuild(
    covariant AdminUpdateController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(AdminUpdateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AdminUpdateControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<AdminUpdateController,
      AdminUpdateState> createElement() {
    return _AdminUpdateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminUpdateControllerProvider && other.id == id;
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
mixin AdminUpdateControllerRef
    on AutoDisposeAsyncNotifierProviderRef<AdminUpdateState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _AdminUpdateControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AdminUpdateController,
        AdminUpdateState> with AdminUpdateControllerRef {
  _AdminUpdateControllerProviderElement(super.provider);

  @override
  String get id => (origin as AdminUpdateControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

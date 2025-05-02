// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$adminFormControllerHash() =>
    r'f0fb2e2c08eb48161a7048504f4038ebb11c6568';

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

abstract class _$AdminFormController
    extends BuildlessAutoDisposeAsyncNotifier<AdminFormState> {
  late final String? id;

  FutureOr<AdminFormState> build(
    String? id,
  );
}

/// See also [AdminFormController].
@ProviderFor(AdminFormController)
const adminFormControllerProvider = AdminFormControllerFamily();

/// See also [AdminFormController].
class AdminFormControllerFamily extends Family<AsyncValue<AdminFormState>> {
  /// See also [AdminFormController].
  const AdminFormControllerFamily();

  /// See also [AdminFormController].
  AdminFormControllerProvider call(
    String? id,
  ) {
    return AdminFormControllerProvider(
      id,
    );
  }

  @override
  AdminFormControllerProvider getProviderOverride(
    covariant AdminFormControllerProvider provider,
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
  String? get name => r'adminFormControllerProvider';
}

/// See also [AdminFormController].
class AdminFormControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    AdminFormController, AdminFormState> {
  /// See also [AdminFormController].
  AdminFormControllerProvider(
    String? id,
  ) : this._internal(
          () => AdminFormController()..id = id,
          from: adminFormControllerProvider,
          name: r'adminFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$adminFormControllerHash,
          dependencies: AdminFormControllerFamily._dependencies,
          allTransitiveDependencies:
              AdminFormControllerFamily._allTransitiveDependencies,
          id: id,
        );

  AdminFormControllerProvider._internal(
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
  FutureOr<AdminFormState> runNotifierBuild(
    covariant AdminFormController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(AdminFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: AdminFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<AdminFormController, AdminFormState>
      createElement() {
    return _AdminFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AdminFormControllerProvider && other.id == id;
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
mixin AdminFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<AdminFormState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _AdminFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<AdminFormController,
        AdminFormState> with AdminFormControllerRef {
  _AdminFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as AdminFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

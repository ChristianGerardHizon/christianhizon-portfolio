// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_update_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$staffUpdateControllerHash() =>
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

abstract class _$StaffUpdateController
    extends BuildlessAutoDisposeAsyncNotifier<StaffUpdateState> {
  late final String id;

  FutureOr<StaffUpdateState> build(
    String id,
  );
}

/// See also [StaffUpdateController].
@ProviderFor(StaffUpdateController)
const staffUpdateControllerProvider = StaffUpdateControllerFamily();

/// See also [StaffUpdateController].
class StaffUpdateControllerFamily extends Family<AsyncValue<StaffUpdateState>> {
  /// See also [StaffUpdateController].
  const StaffUpdateControllerFamily();

  /// See also [StaffUpdateController].
  StaffUpdateControllerProvider call(
    String id,
  ) {
    return StaffUpdateControllerProvider(
      id,
    );
  }

  @override
  StaffUpdateControllerProvider getProviderOverride(
    covariant StaffUpdateControllerProvider provider,
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
  String? get name => r'staffUpdateControllerProvider';
}

/// See also [StaffUpdateController].
class StaffUpdateControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<StaffUpdateController,
        StaffUpdateState> {
  /// See also [StaffUpdateController].
  StaffUpdateControllerProvider(
    String id,
  ) : this._internal(
          () => StaffUpdateController()..id = id,
          from: staffUpdateControllerProvider,
          name: r'staffUpdateControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$staffUpdateControllerHash,
          dependencies: StaffUpdateControllerFamily._dependencies,
          allTransitiveDependencies:
              StaffUpdateControllerFamily._allTransitiveDependencies,
          id: id,
        );

  StaffUpdateControllerProvider._internal(
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
  FutureOr<StaffUpdateState> runNotifierBuild(
    covariant StaffUpdateController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(StaffUpdateController Function() create) {
    return ProviderOverride(
      origin: this,
      override: StaffUpdateControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<StaffUpdateController,
      StaffUpdateState> createElement() {
    return _StaffUpdateControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StaffUpdateControllerProvider && other.id == id;
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
mixin StaffUpdateControllerRef
    on AutoDisposeAsyncNotifierProviderRef<StaffUpdateState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _StaffUpdateControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StaffUpdateController,
        StaffUpdateState> with StaffUpdateControllerRef {
  _StaffUpdateControllerProviderElement(super.provider);

  @override
  String get id => (origin as StaffUpdateControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

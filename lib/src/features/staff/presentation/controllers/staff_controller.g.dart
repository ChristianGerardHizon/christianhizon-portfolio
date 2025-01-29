// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$staffControllerHash() => r'fc39271a76386a12ca11be539d7a4b497757a7d3';

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

abstract class _$StaffController
    extends BuildlessAutoDisposeAsyncNotifier<Staff> {
  late final String id;

  FutureOr<Staff> build(
    String id,
  );
}

/// See also [StaffController].
@ProviderFor(StaffController)
const staffControllerProvider = StaffControllerFamily();

/// See also [StaffController].
class StaffControllerFamily extends Family<AsyncValue<Staff>> {
  /// See also [StaffController].
  const StaffControllerFamily();

  /// See also [StaffController].
  StaffControllerProvider call(
    String id,
  ) {
    return StaffControllerProvider(
      id,
    );
  }

  @override
  StaffControllerProvider getProviderOverride(
    covariant StaffControllerProvider provider,
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
  String? get name => r'staffControllerProvider';
}

/// See also [StaffController].
class StaffControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<StaffController, Staff> {
  /// See also [StaffController].
  StaffControllerProvider(
    String id,
  ) : this._internal(
          () => StaffController()..id = id,
          from: staffControllerProvider,
          name: r'staffControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$staffControllerHash,
          dependencies: StaffControllerFamily._dependencies,
          allTransitiveDependencies:
              StaffControllerFamily._allTransitiveDependencies,
          id: id,
        );

  StaffControllerProvider._internal(
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
  FutureOr<Staff> runNotifierBuild(
    covariant StaffController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(StaffController Function() create) {
    return ProviderOverride(
      origin: this,
      override: StaffControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<StaffController, Staff>
      createElement() {
    return _StaffControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StaffControllerProvider && other.id == id;
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
mixin StaffControllerRef on AutoDisposeAsyncNotifierProviderRef<Staff> {
  /// The parameter `id` of this provider.
  String get id;
}

class _StaffControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<StaffController, Staff>
    with StaffControllerRef {
  _StaffControllerProviderElement(super.provider);

  @override
  String get id => (origin as StaffControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

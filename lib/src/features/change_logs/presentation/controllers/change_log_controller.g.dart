// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_log_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$changeLogControllerHash() =>
    r'8add756cd2e74e13edc0c2498c4b043514e3bfb5';

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

abstract class _$ChangeLogController
    extends BuildlessAutoDisposeAsyncNotifier<ChangeLogState> {
  late final String id;

  FutureOr<ChangeLogState> build(
    String id,
  );
}

/// See also [ChangeLogController].
@ProviderFor(ChangeLogController)
const changeLogControllerProvider = ChangeLogControllerFamily();

/// See also [ChangeLogController].
class ChangeLogControllerFamily extends Family<AsyncValue<ChangeLogState>> {
  /// See also [ChangeLogController].
  const ChangeLogControllerFamily();

  /// See also [ChangeLogController].
  ChangeLogControllerProvider call(
    String id,
  ) {
    return ChangeLogControllerProvider(
      id,
    );
  }

  @override
  ChangeLogControllerProvider getProviderOverride(
    covariant ChangeLogControllerProvider provider,
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
  String? get name => r'changeLogControllerProvider';
}

/// See also [ChangeLogController].
class ChangeLogControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    ChangeLogController, ChangeLogState> {
  /// See also [ChangeLogController].
  ChangeLogControllerProvider(
    String id,
  ) : this._internal(
          () => ChangeLogController()..id = id,
          from: changeLogControllerProvider,
          name: r'changeLogControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$changeLogControllerHash,
          dependencies: ChangeLogControllerFamily._dependencies,
          allTransitiveDependencies:
              ChangeLogControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ChangeLogControllerProvider._internal(
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
  FutureOr<ChangeLogState> runNotifierBuild(
    covariant ChangeLogController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ChangeLogController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChangeLogControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ChangeLogController, ChangeLogState>
      createElement() {
    return _ChangeLogControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChangeLogControllerProvider && other.id == id;
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
mixin ChangeLogControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ChangeLogState> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ChangeLogControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChangeLogController,
        ChangeLogState> with ChangeLogControllerRef {
  _ChangeLogControllerProviderElement(super.provider);

  @override
  String get id => (origin as ChangeLogControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

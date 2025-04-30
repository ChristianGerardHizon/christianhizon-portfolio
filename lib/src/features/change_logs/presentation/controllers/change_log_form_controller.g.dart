// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_log_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$changeLogFormControllerHash() =>
    r'95fb4abede18ef0784c90b75c084abb739d4641e';

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

abstract class _$ChangeLogFormController
    extends BuildlessAutoDisposeAsyncNotifier<ChangeLogState> {
  late final String? id;

  FutureOr<ChangeLogState> build(
    String? id,
  );
}

/// See also [ChangeLogFormController].
@ProviderFor(ChangeLogFormController)
const changeLogFormControllerProvider = ChangeLogFormControllerFamily();

/// See also [ChangeLogFormController].
class ChangeLogFormControllerFamily extends Family<AsyncValue<ChangeLogState>> {
  /// See also [ChangeLogFormController].
  const ChangeLogFormControllerFamily();

  /// See also [ChangeLogFormController].
  ChangeLogFormControllerProvider call(
    String? id,
  ) {
    return ChangeLogFormControllerProvider(
      id,
    );
  }

  @override
  ChangeLogFormControllerProvider getProviderOverride(
    covariant ChangeLogFormControllerProvider provider,
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
  String? get name => r'changeLogFormControllerProvider';
}

/// See also [ChangeLogFormController].
class ChangeLogFormControllerProvider
    extends AutoDisposeAsyncNotifierProviderImpl<ChangeLogFormController,
        ChangeLogState> {
  /// See also [ChangeLogFormController].
  ChangeLogFormControllerProvider(
    String? id,
  ) : this._internal(
          () => ChangeLogFormController()..id = id,
          from: changeLogFormControllerProvider,
          name: r'changeLogFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$changeLogFormControllerHash,
          dependencies: ChangeLogFormControllerFamily._dependencies,
          allTransitiveDependencies:
              ChangeLogFormControllerFamily._allTransitiveDependencies,
          id: id,
        );

  ChangeLogFormControllerProvider._internal(
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
  FutureOr<ChangeLogState> runNotifierBuild(
    covariant ChangeLogFormController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(ChangeLogFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: ChangeLogFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<ChangeLogFormController,
      ChangeLogState> createElement() {
    return _ChangeLogFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ChangeLogFormControllerProvider && other.id == id;
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
mixin ChangeLogFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<ChangeLogState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _ChangeLogFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<ChangeLogFormController,
        ChangeLogState> with ChangeLogFormControllerRef {
  _ChangeLogFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as ChangeLogFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

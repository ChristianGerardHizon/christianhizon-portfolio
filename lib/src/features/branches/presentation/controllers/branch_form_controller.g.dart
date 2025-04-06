// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$branchFormControllerHash() =>
    r'23dbd2d76ee48f6c9182831e6b9adb0ceda994a5';

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

abstract class _$BranchFormController
    extends BuildlessAutoDisposeAsyncNotifier<BranchFormState> {
  late final String? id;

  FutureOr<BranchFormState> build(
    String? id,
  );
}

/// See also [BranchFormController].
@ProviderFor(BranchFormController)
const branchFormControllerProvider = BranchFormControllerFamily();

/// See also [BranchFormController].
class BranchFormControllerFamily extends Family<AsyncValue<BranchFormState>> {
  /// See also [BranchFormController].
  const BranchFormControllerFamily();

  /// See also [BranchFormController].
  BranchFormControllerProvider call(
    String? id,
  ) {
    return BranchFormControllerProvider(
      id,
    );
  }

  @override
  BranchFormControllerProvider getProviderOverride(
    covariant BranchFormControllerProvider provider,
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
  String? get name => r'branchFormControllerProvider';
}

/// See also [BranchFormController].
class BranchFormControllerProvider extends AutoDisposeAsyncNotifierProviderImpl<
    BranchFormController, BranchFormState> {
  /// See also [BranchFormController].
  BranchFormControllerProvider(
    String? id,
  ) : this._internal(
          () => BranchFormController()..id = id,
          from: branchFormControllerProvider,
          name: r'branchFormControllerProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$branchFormControllerHash,
          dependencies: BranchFormControllerFamily._dependencies,
          allTransitiveDependencies:
              BranchFormControllerFamily._allTransitiveDependencies,
          id: id,
        );

  BranchFormControllerProvider._internal(
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
  FutureOr<BranchFormState> runNotifierBuild(
    covariant BranchFormController notifier,
  ) {
    return notifier.build(
      id,
    );
  }

  @override
  Override overrideWith(BranchFormController Function() create) {
    return ProviderOverride(
      origin: this,
      override: BranchFormControllerProvider._internal(
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
  AutoDisposeAsyncNotifierProviderElement<BranchFormController, BranchFormState>
      createElement() {
    return _BranchFormControllerProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BranchFormControllerProvider && other.id == id;
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
mixin BranchFormControllerRef
    on AutoDisposeAsyncNotifierProviderRef<BranchFormState> {
  /// The parameter `id` of this provider.
  String? get id;
}

class _BranchFormControllerProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BranchFormController,
        BranchFormState> with BranchFormControllerRef {
  _BranchFormControllerProviderElement(super.provider);

  @override
  String? get id => (origin as BranchFormControllerProvider).id;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

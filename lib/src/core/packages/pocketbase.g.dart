// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pocketbase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pocketbaseHash() => r'66d7d1d57486b8aa5a070d20455d74af871248fe';

/// See also [pocketbase].
@ProviderFor(pocketbase)
final pocketbaseProvider = Provider<PocketBase>.internal(
  pocketbase,
  name: r'pocketbaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pocketbaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef PocketbaseRef = ProviderRef<PocketBase>;
String _$pbDebugControllerHash() => r'679e550fec3e9549f24b091a0d860b489f38f6c1';

/// See also [PbDebugController].
@ProviderFor(PbDebugController)
final pbDebugControllerProvider =
    AutoDisposeAsyncNotifierProvider<PbDebugController, bool>.internal(
  PbDebugController.new,
  name: r'pbDebugControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pbDebugControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PbDebugController = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package

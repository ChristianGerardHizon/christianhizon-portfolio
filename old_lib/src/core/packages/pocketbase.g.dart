// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pocketbase.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(PbDebugController)
final pbDebugControllerProvider = PbDebugControllerProvider._();

final class PbDebugControllerProvider
    extends $AsyncNotifierProvider<PbDebugController, bool> {
  PbDebugControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pbDebugControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pbDebugControllerHash();

  @$internal
  @override
  PbDebugController create() => PbDebugController();
}

String _$pbDebugControllerHash() => r'eb69786022b8b838ccbc21591ebbf124fbd40783';

abstract class _$PbDebugController extends $AsyncNotifier<bool> {
  FutureOr<bool> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool>, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<bool>, bool>,
        AsyncValue<bool>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(pocketbase)
final pocketbaseProvider = PocketbaseProvider._();

final class PocketbaseProvider
    extends $FunctionalProvider<PocketBase, PocketBase, PocketBase>
    with $Provider<PocketBase> {
  PocketbaseProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'pocketbaseProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$pocketbaseHash();

  @$internal
  @override
  $ProviderElement<PocketBase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PocketBase create(Ref ref) {
    return pocketbase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PocketBase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PocketBase>(value),
    );
  }
}

String _$pocketbaseHash() => r'664bf737e5f78268084a714a545d3671153159a7';

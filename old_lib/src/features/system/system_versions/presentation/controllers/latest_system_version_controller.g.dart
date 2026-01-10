// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'latest_system_version_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LatestSystemVersionController)
final latestSystemVersionControllerProvider =
    LatestSystemVersionControllerProvider._();

final class LatestSystemVersionControllerProvider
    extends $AsyncNotifierProvider<LatestSystemVersionController,
        SystemVersion?> {
  LatestSystemVersionControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'latestSystemVersionControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$latestSystemVersionControllerHash();

  @$internal
  @override
  LatestSystemVersionController create() => LatestSystemVersionController();
}

String _$latestSystemVersionControllerHash() =>
    r'ff49f1d586c1f5ca958f691c3531470d0d6fa470';

abstract class _$LatestSystemVersionController
    extends $AsyncNotifier<SystemVersion?> {
  FutureOr<SystemVersion?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<SystemVersion?>, SystemVersion?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<SystemVersion?>, SystemVersion?>,
        AsyncValue<SystemVersion?>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

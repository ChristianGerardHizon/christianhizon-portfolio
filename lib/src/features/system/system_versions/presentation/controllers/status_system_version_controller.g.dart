// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'status_system_version_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(StatusSystemVersionController)
final statusSystemVersionControllerProvider =
    StatusSystemVersionControllerProvider._();

final class StatusSystemVersionControllerProvider
    extends $AsyncNotifierProvider<StatusSystemVersionController,
        StatusSystemVersionState> {
  StatusSystemVersionControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'statusSystemVersionControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$statusSystemVersionControllerHash();

  @$internal
  @override
  StatusSystemVersionController create() => StatusSystemVersionController();
}

String _$statusSystemVersionControllerHash() =>
    r'53f4006c8dc6efa55f96c38e9c0847e40143adff';

abstract class _$StatusSystemVersionController
    extends $AsyncNotifier<StatusSystemVersionState> {
  FutureOr<StatusSystemVersionState> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<StatusSystemVersionState>, StatusSystemVersionState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<StatusSystemVersionState>,
            StatusSystemVersionState>,
        AsyncValue<StatusSystemVersionState>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

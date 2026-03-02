// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for fetching work history items.

@ProviderFor(WorkHistoryController)
final workHistoryControllerProvider = WorkHistoryControllerProvider._();

/// Controller for fetching work history items.
final class WorkHistoryControllerProvider extends $AsyncNotifierProvider<
    WorkHistoryController, List<WorkHistoryItem>> {
  /// Controller for fetching work history items.
  WorkHistoryControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'workHistoryControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$workHistoryControllerHash();

  @$internal
  @override
  WorkHistoryController create() => WorkHistoryController();
}

String _$workHistoryControllerHash() =>
    r'61e535665c4efa00714c48a43d48dbd0140bc229';

/// Controller for fetching work history items.

abstract class _$WorkHistoryController
    extends $AsyncNotifier<List<WorkHistoryItem>> {
  FutureOr<List<WorkHistoryItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<WorkHistoryItem>>, List<WorkHistoryItem>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<WorkHistoryItem>>, List<WorkHistoryItem>>,
        AsyncValue<List<WorkHistoryItem>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// Controller for fetching speaking events.

@ProviderFor(SpeakingEventsController)
final speakingEventsControllerProvider = SpeakingEventsControllerProvider._();

/// Controller for fetching speaking events.
final class SpeakingEventsControllerProvider extends $AsyncNotifierProvider<
    SpeakingEventsController, List<SpeakingEvent>> {
  /// Controller for fetching speaking events.
  SpeakingEventsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'speakingEventsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$speakingEventsControllerHash();

  @$internal
  @override
  SpeakingEventsController create() => SpeakingEventsController();
}

String _$speakingEventsControllerHash() =>
    r'05a9f22e0c54a61109d63b7dc8647a61e89bffe1';

/// Controller for fetching speaking events.

abstract class _$SpeakingEventsController
    extends $AsyncNotifier<List<SpeakingEvent>> {
  FutureOr<List<SpeakingEvent>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<SpeakingEvent>>, List<SpeakingEvent>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<SpeakingEvent>>, List<SpeakingEvent>>,
        AsyncValue<List<SpeakingEvent>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

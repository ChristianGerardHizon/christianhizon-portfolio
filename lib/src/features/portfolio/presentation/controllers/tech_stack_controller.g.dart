// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tech_stack_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for fetching tech stack items.

@ProviderFor(TechStackController)
final techStackControllerProvider = TechStackControllerProvider._();

/// Controller for fetching tech stack items.
final class TechStackControllerProvider
    extends $AsyncNotifierProvider<TechStackController, List<TechStackItem>> {
  /// Controller for fetching tech stack items.
  TechStackControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'techStackControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$techStackControllerHash();

  @$internal
  @override
  TechStackController create() => TechStackController();
}

String _$techStackControllerHash() =>
    r'8b0150e2349250e6554a66e4e0c680aa0631e0e2';

/// Controller for fetching tech stack items.

abstract class _$TechStackController
    extends $AsyncNotifier<List<TechStackItem>> {
  FutureOr<List<TechStackItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<TechStackItem>>, List<TechStackItem>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<TechStackItem>>, List<TechStackItem>>,
        AsyncValue<List<TechStackItem>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

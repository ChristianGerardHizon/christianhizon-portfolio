// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_items_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NavItemsController)
final navItemsControllerProvider = NavItemsControllerProvider._();

final class NavItemsControllerProvider extends $AsyncNotifierProvider<
    NavItemsController, List<CustomNavigationBarItem>> {
  NavItemsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'navItemsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$navItemsControllerHash();

  @$internal
  @override
  NavItemsController create() => NavItemsController();
}

String _$navItemsControllerHash() =>
    r'25e01a5fa360df5e972e1752fc56efc4201719fc';

abstract class _$NavItemsController
    extends $AsyncNotifier<List<CustomNavigationBarItem>> {
  FutureOr<List<CustomNavigationBarItem>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<CustomNavigationBarItem>>,
        List<CustomNavigationBarItem>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<CustomNavigationBarItem>>,
            List<CustomNavigationBarItem>>,
        AsyncValue<List<CustomNavigationBarItem>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

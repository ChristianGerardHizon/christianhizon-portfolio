// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branches_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BranchesController)
final branchesControllerProvider = BranchesControllerProvider._();

final class BranchesControllerProvider
    extends $AsyncNotifierProvider<BranchesController, List<Branch>> {
  BranchesControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'branchesControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$branchesControllerHash();

  @$internal
  @override
  BranchesController create() => BranchesController();
}

String _$branchesControllerHash() =>
    r'fa38e5d1af5988a7e6af92930c8b337e572230c0';

abstract class _$BranchesController extends $AsyncNotifier<List<Branch>> {
  FutureOr<List<Branch>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Branch>>, List<Branch>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Branch>>, List<Branch>>,
        AsyncValue<List<Branch>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

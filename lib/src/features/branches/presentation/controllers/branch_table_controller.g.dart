// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BranchTableController)
final branchTableControllerProvider = BranchTableControllerFamily._();

final class BranchTableControllerProvider
    extends $AsyncNotifierProvider<BranchTableController, List<Branch>> {
  BranchTableControllerProvider._(
      {required BranchTableControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'branchTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$branchTableControllerHash();

  @override
  String toString() {
    return r'branchTableControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BranchTableController create() => BranchTableController();

  @override
  bool operator ==(Object other) {
    return other is BranchTableControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$branchTableControllerHash() =>
    r'49bef22e402314cef0645d624c8e78131f0efe7e';

final class BranchTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<BranchTableController, AsyncValue<List<Branch>>,
            List<Branch>, FutureOr<List<Branch>>, String> {
  BranchTableControllerFamily._()
      : super(
          retry: null,
          name: r'branchTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  BranchTableControllerProvider call(
    String tableKey,
  ) =>
      BranchTableControllerProvider._(argument: tableKey, from: this);

  @override
  String toString() => r'branchTableControllerProvider';
}

abstract class _$BranchTableController extends $AsyncNotifier<List<Branch>> {
  late final _$args = ref.$arg as String;
  String get tableKey => _$args;

  FutureOr<List<Branch>> build(
    String tableKey,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Branch>>, List<Branch>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Branch>>, List<Branch>>,
        AsyncValue<List<Branch>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

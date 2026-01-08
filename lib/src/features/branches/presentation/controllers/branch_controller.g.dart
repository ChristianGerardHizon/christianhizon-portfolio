// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BranchController)
final branchControllerProvider = BranchControllerFamily._();

final class BranchControllerProvider
    extends $AsyncNotifierProvider<BranchController, Branch> {
  BranchControllerProvider._(
      {required BranchControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'branchControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$branchControllerHash();

  @override
  String toString() {
    return r'branchControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BranchController create() => BranchController();

  @override
  bool operator ==(Object other) {
    return other is BranchControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$branchControllerHash() => r'94b0a81386c398a0daad360a6e93d28592a20320';

final class BranchControllerFamily extends $Family
    with
        $ClassFamilyOverride<BranchController, AsyncValue<Branch>, Branch,
            FutureOr<Branch>, String> {
  BranchControllerFamily._()
      : super(
          retry: null,
          name: r'branchControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  BranchControllerProvider call(
    String id,
  ) =>
      BranchControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'branchControllerProvider';
}

abstract class _$BranchController extends $AsyncNotifier<Branch> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<Branch> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Branch>, Branch>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Branch>, Branch>,
        AsyncValue<Branch>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

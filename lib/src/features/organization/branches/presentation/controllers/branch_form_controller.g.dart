// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'branch_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(BranchFormController)
final branchFormControllerProvider = BranchFormControllerFamily._();

final class BranchFormControllerProvider
    extends $AsyncNotifierProvider<BranchFormController, BranchFormState> {
  BranchFormControllerProvider._(
      {required BranchFormControllerFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'branchFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$branchFormControllerHash();

  @override
  String toString() {
    return r'branchFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  BranchFormController create() => BranchFormController();

  @override
  bool operator ==(Object other) {
    return other is BranchFormControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$branchFormControllerHash() =>
    r'23dbd2d76ee48f6c9182831e6b9adb0ceda994a5';

final class BranchFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<BranchFormController, AsyncValue<BranchFormState>,
            BranchFormState, FutureOr<BranchFormState>, String?> {
  BranchFormControllerFamily._()
      : super(
          retry: null,
          name: r'branchFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  BranchFormControllerProvider call(
    String? id,
  ) =>
      BranchFormControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'branchFormControllerProvider';
}

abstract class _$BranchFormController extends $AsyncNotifier<BranchFormState> {
  late final _$args = ref.$arg as String?;
  String? get id => _$args;

  FutureOr<BranchFormState> build(
    String? id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<BranchFormState>, BranchFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<BranchFormState>, BranchFormState>,
        AsyncValue<BranchFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

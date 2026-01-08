// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminFormController)
final adminFormControllerProvider = AdminFormControllerFamily._();

final class AdminFormControllerProvider
    extends $AsyncNotifierProvider<AdminFormController, AdminFormState> {
  AdminFormControllerProvider._(
      {required AdminFormControllerFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'adminFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adminFormControllerHash();

  @override
  String toString() {
    return r'adminFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AdminFormController create() => AdminFormController();

  @override
  bool operator ==(Object other) {
    return other is AdminFormControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminFormControllerHash() =>
    r'f0fb2e2c08eb48161a7048504f4038ebb11c6568';

final class AdminFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<AdminFormController, AsyncValue<AdminFormState>,
            AdminFormState, FutureOr<AdminFormState>, String?> {
  AdminFormControllerFamily._()
      : super(
          retry: null,
          name: r'adminFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AdminFormControllerProvider call(
    String? id,
  ) =>
      AdminFormControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'adminFormControllerProvider';
}

abstract class _$AdminFormController extends $AsyncNotifier<AdminFormState> {
  late final _$args = ref.$arg as String?;
  String? get id => _$args;

  FutureOr<AdminFormState> build(
    String? id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<AdminFormState>, AdminFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<AdminFormState>, AdminFormState>,
        AsyncValue<AdminFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

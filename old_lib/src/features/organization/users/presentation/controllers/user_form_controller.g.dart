// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserFormController)
final userFormControllerProvider = UserFormControllerFamily._();

final class UserFormControllerProvider
    extends $AsyncNotifierProvider<UserFormController, UserFormState> {
  UserFormControllerProvider._(
      {required UserFormControllerFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'userFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userFormControllerHash();

  @override
  String toString() {
    return r'userFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserFormController create() => UserFormController();

  @override
  bool operator ==(Object other) {
    return other is UserFormControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userFormControllerHash() =>
    r'da0368f6b5764bcc736b0b24e5d37b3d08ddf255';

final class UserFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<UserFormController, AsyncValue<UserFormState>,
            UserFormState, FutureOr<UserFormState>, String?> {
  UserFormControllerFamily._()
      : super(
          retry: null,
          name: r'userFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserFormControllerProvider call(
    String? id,
  ) =>
      UserFormControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'userFormControllerProvider';
}

abstract class _$UserFormController extends $AsyncNotifier<UserFormState> {
  late final _$args = ref.$arg as String?;
  String? get id => _$args;

  FutureOr<UserFormState> build(
    String? id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserFormState>, UserFormState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<UserFormState>, UserFormState>,
        AsyncValue<UserFormState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

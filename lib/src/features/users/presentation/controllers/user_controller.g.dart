// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserController)
final userControllerProvider = UserControllerFamily._();

final class UserControllerProvider
    extends $AsyncNotifierProvider<UserController, User> {
  UserControllerProvider._(
      {required UserControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'userControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userControllerHash();

  @override
  String toString() {
    return r'userControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserController create() => UserController();

  @override
  bool operator ==(Object other) {
    return other is UserControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userControllerHash() => r'feb8f3ec4aede1f022a502ab9e939f8d540f32ef';

final class UserControllerFamily extends $Family
    with
        $ClassFamilyOverride<UserController, AsyncValue<User>, User,
            FutureOr<User>, String> {
  UserControllerFamily._()
      : super(
          retry: null,
          name: r'userControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserControllerProvider call(
    String id,
  ) =>
      UserControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'userControllerProvider';
}

abstract class _$UserController extends $AsyncNotifier<User> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<User> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<User>, User>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<User>, User>,
        AsyncValue<User>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

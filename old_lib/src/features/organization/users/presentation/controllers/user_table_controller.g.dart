// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserTableController)
final userTableControllerProvider = UserTableControllerFamily._();

final class UserTableControllerProvider
    extends $AsyncNotifierProvider<UserTableController, List<User>> {
  UserTableControllerProvider._(
      {required UserTableControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'userTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$userTableControllerHash();

  @override
  String toString() {
    return r'userTableControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserTableController create() => UserTableController();

  @override
  bool operator ==(Object other) {
    return other is UserTableControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userTableControllerHash() =>
    r'f124a9b2edf7a59de0af2f45b6237a799e9ef4c7';

final class UserTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<UserTableController, AsyncValue<List<User>>,
            List<User>, FutureOr<List<User>>, String> {
  UserTableControllerFamily._()
      : super(
          retry: null,
          name: r'userTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  UserTableControllerProvider call(
    String tableKey,
  ) =>
      UserTableControllerProvider._(argument: tableKey, from: this);

  @override
  String toString() => r'userTableControllerProvider';
}

abstract class _$UserTableController extends $AsyncNotifier<List<User>> {
  late final _$args = ref.$arg as String;
  String get tableKey => _$args;

  FutureOr<List<User>> build(
    String tableKey,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<User>>, List<User>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<User>>, List<User>>,
        AsyncValue<List<User>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

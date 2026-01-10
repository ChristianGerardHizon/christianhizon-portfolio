// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_update_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminUpdateController)
final adminUpdateControllerProvider = AdminUpdateControllerFamily._();

final class AdminUpdateControllerProvider
    extends $AsyncNotifierProvider<AdminUpdateController, AdminUpdateState> {
  AdminUpdateControllerProvider._(
      {required AdminUpdateControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'adminUpdateControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adminUpdateControllerHash();

  @override
  String toString() {
    return r'adminUpdateControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AdminUpdateController create() => AdminUpdateController();

  @override
  bool operator ==(Object other) {
    return other is AdminUpdateControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminUpdateControllerHash() =>
    r'd7e037029341bf35a69e63c41ef11710153a639b';

final class AdminUpdateControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            AdminUpdateController,
            AsyncValue<AdminUpdateState>,
            AdminUpdateState,
            FutureOr<AdminUpdateState>,
            String> {
  AdminUpdateControllerFamily._()
      : super(
          retry: null,
          name: r'adminUpdateControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AdminUpdateControllerProvider call(
    String id,
  ) =>
      AdminUpdateControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'adminUpdateControllerProvider';
}

abstract class _$AdminUpdateController
    extends $AsyncNotifier<AdminUpdateState> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<AdminUpdateState> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<AdminUpdateState>, AdminUpdateState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<AdminUpdateState>, AdminUpdateState>,
        AsyncValue<AdminUpdateState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

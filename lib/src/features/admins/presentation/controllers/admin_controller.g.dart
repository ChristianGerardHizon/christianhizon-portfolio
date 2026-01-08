// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminController)
final adminControllerProvider = AdminControllerFamily._();

final class AdminControllerProvider
    extends $AsyncNotifierProvider<AdminController, Admin> {
  AdminControllerProvider._(
      {required AdminControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'adminControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adminControllerHash();

  @override
  String toString() {
    return r'adminControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AdminController create() => AdminController();

  @override
  bool operator ==(Object other) {
    return other is AdminControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminControllerHash() => r'5e38e82ddc971ce50fffde82947b2435e8a37e53';

final class AdminControllerFamily extends $Family
    with
        $ClassFamilyOverride<AdminController, AsyncValue<Admin>, Admin,
            FutureOr<Admin>, String> {
  AdminControllerFamily._()
      : super(
          retry: null,
          name: r'adminControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AdminControllerProvider call(
    String id,
  ) =>
      AdminControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'adminControllerProvider';
}

abstract class _$AdminController extends $AsyncNotifier<Admin> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<Admin> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<Admin>, Admin>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<Admin>, Admin>,
        AsyncValue<Admin>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

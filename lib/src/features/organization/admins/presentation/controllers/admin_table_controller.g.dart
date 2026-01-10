// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AdminTableController)
final adminTableControllerProvider = AdminTableControllerFamily._();

final class AdminTableControllerProvider
    extends $AsyncNotifierProvider<AdminTableController, List<Admin>> {
  AdminTableControllerProvider._(
      {required AdminTableControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'adminTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$adminTableControllerHash();

  @override
  String toString() {
    return r'adminTableControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  AdminTableController create() => AdminTableController();

  @override
  bool operator ==(Object other) {
    return other is AdminTableControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$adminTableControllerHash() =>
    r'0d2af82856c0b88f0c36873c4baa45c345287804';

final class AdminTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<AdminTableController, AsyncValue<List<Admin>>,
            List<Admin>, FutureOr<List<Admin>>, String> {
  AdminTableControllerFamily._()
      : super(
          retry: null,
          name: r'adminTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  AdminTableControllerProvider call(
    String tableKey,
  ) =>
      AdminTableControllerProvider._(argument: tableKey, from: this);

  @override
  String toString() => r'adminTableControllerProvider';
}

abstract class _$AdminTableController extends $AsyncNotifier<List<Admin>> {
  late final _$args = ref.$arg as String;
  String get tableKey => _$args;

  FutureOr<List<Admin>> build(
    String tableKey,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Admin>>, List<Admin>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Admin>>, List<Admin>>,
        AsyncValue<List<Admin>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

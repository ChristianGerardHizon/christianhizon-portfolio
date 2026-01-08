// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_log_table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChangeLogTableController)
final changeLogTableControllerProvider = ChangeLogTableControllerFamily._();

final class ChangeLogTableControllerProvider
    extends $AsyncNotifierProvider<ChangeLogTableController, List<ChangeLog>> {
  ChangeLogTableControllerProvider._(
      {required ChangeLogTableControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'changeLogTableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$changeLogTableControllerHash();

  @override
  String toString() {
    return r'changeLogTableControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChangeLogTableController create() => ChangeLogTableController();

  @override
  bool operator ==(Object other) {
    return other is ChangeLogTableControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$changeLogTableControllerHash() =>
    r'aeddb2d977c3dae46b0bfe37573531be0daf5aa4';

final class ChangeLogTableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ChangeLogTableController,
            AsyncValue<List<ChangeLog>>,
            List<ChangeLog>,
            FutureOr<List<ChangeLog>>,
            String> {
  ChangeLogTableControllerFamily._()
      : super(
          retry: null,
          name: r'changeLogTableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ChangeLogTableControllerProvider call(
    String tableKey,
  ) =>
      ChangeLogTableControllerProvider._(argument: tableKey, from: this);

  @override
  String toString() => r'changeLogTableControllerProvider';
}

abstract class _$ChangeLogTableController
    extends $AsyncNotifier<List<ChangeLog>> {
  late final _$args = ref.$arg as String;
  String get tableKey => _$args;

  FutureOr<List<ChangeLog>> build(
    String tableKey,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<ChangeLog>>, List<ChangeLog>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<ChangeLog>>, List<ChangeLog>>,
        AsyncValue<List<ChangeLog>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'table_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(TableController)
final tableControllerProvider = TableControllerFamily._();

final class TableControllerProvider
    extends $NotifierProvider<TableController, TableState> {
  TableControllerProvider._(
      {required TableControllerFamily super.from,
      required (
        String, {
        TableState? tableState,
      })
          super.argument})
      : super(
          retry: null,
          name: r'tableControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$tableControllerHash();

  @override
  String toString() {
    return r'tableControllerProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  TableController create() => TableController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TableState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TableState>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TableControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$tableControllerHash() => r'd5e727baa83376760a500e54200f9708f409164e';

final class TableControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            TableController,
            TableState,
            TableState,
            TableState,
            (
              String, {
              TableState? tableState,
            })> {
  TableControllerFamily._()
      : super(
          retry: null,
          name: r'tableControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  TableControllerProvider call(
    String tableKey, {
    TableState? tableState,
  }) =>
      TableControllerProvider._(argument: (
        tableKey,
        tableState: tableState,
      ), from: this);

  @override
  String toString() => r'tableControllerProvider';
}

abstract class _$TableController extends $Notifier<TableState> {
  late final _$args = ref.$arg as (
    String, {
    TableState? tableState,
  });
  String get tableKey => _$args.$1;
  TableState? get tableState => _$args.tableState;

  TableState build(
    String tableKey, {
    TableState? tableState,
  });
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<TableState, TableState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<TableState, TableState>, TableState, Object?, Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args.$1,
              tableState: _$args.tableState,
            ));
  }
}

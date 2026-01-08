// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_log_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChangeLogController)
final changeLogControllerProvider = ChangeLogControllerFamily._();

final class ChangeLogControllerProvider
    extends $AsyncNotifierProvider<ChangeLogController, ChangeLogState> {
  ChangeLogControllerProvider._(
      {required ChangeLogControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'changeLogControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$changeLogControllerHash();

  @override
  String toString() {
    return r'changeLogControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChangeLogController create() => ChangeLogController();

  @override
  bool operator ==(Object other) {
    return other is ChangeLogControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$changeLogControllerHash() =>
    r'8add756cd2e74e13edc0c2498c4b043514e3bfb5';

final class ChangeLogControllerFamily extends $Family
    with
        $ClassFamilyOverride<ChangeLogController, AsyncValue<ChangeLogState>,
            ChangeLogState, FutureOr<ChangeLogState>, String> {
  ChangeLogControllerFamily._()
      : super(
          retry: null,
          name: r'changeLogControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ChangeLogControllerProvider call(
    String id,
  ) =>
      ChangeLogControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'changeLogControllerProvider';
}

abstract class _$ChangeLogController extends $AsyncNotifier<ChangeLogState> {
  late final _$args = ref.$arg as String;
  String get id => _$args;

  FutureOr<ChangeLogState> build(
    String id,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ChangeLogState>, ChangeLogState>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<ChangeLogState>, ChangeLogState>,
        AsyncValue<ChangeLogState>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

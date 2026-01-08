// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'change_log_form_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ChangeLogFormController)
final changeLogFormControllerProvider = ChangeLogFormControllerFamily._();

final class ChangeLogFormControllerProvider
    extends $AsyncNotifierProvider<ChangeLogFormController, ChangeLogState> {
  ChangeLogFormControllerProvider._(
      {required ChangeLogFormControllerFamily super.from,
      required String? super.argument})
      : super(
          retry: null,
          name: r'changeLogFormControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$changeLogFormControllerHash();

  @override
  String toString() {
    return r'changeLogFormControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ChangeLogFormController create() => ChangeLogFormController();

  @override
  bool operator ==(Object other) {
    return other is ChangeLogFormControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$changeLogFormControllerHash() =>
    r'95fb4abede18ef0784c90b75c084abb739d4641e';

final class ChangeLogFormControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            ChangeLogFormController,
            AsyncValue<ChangeLogState>,
            ChangeLogState,
            FutureOr<ChangeLogState>,
            String?> {
  ChangeLogFormControllerFamily._()
      : super(
          retry: null,
          name: r'changeLogFormControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  ChangeLogFormControllerProvider call(
    String? id,
  ) =>
      ChangeLogFormControllerProvider._(argument: id, from: this);

  @override
  String toString() => r'changeLogFormControllerProvider';
}

abstract class _$ChangeLogFormController
    extends $AsyncNotifier<ChangeLogState> {
  late final _$args = ref.$arg as String?;
  String? get id => _$args;

  FutureOr<ChangeLogState> build(
    String? id,
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

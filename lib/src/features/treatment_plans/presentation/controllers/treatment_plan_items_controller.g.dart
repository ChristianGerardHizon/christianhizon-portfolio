// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_plan_items_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing treatment plan items for a specific plan.
///
/// This is a family provider - each plan has its own items state.

@ProviderFor(TreatmentPlanItemsController)
final treatmentPlanItemsControllerProvider =
    TreatmentPlanItemsControllerFamily._();

/// Controller for managing treatment plan items for a specific plan.
///
/// This is a family provider - each plan has its own items state.
final class TreatmentPlanItemsControllerProvider extends $AsyncNotifierProvider<
    TreatmentPlanItemsController, List<TreatmentPlanItem>> {
  /// Controller for managing treatment plan items for a specific plan.
  ///
  /// This is a family provider - each plan has its own items state.
  TreatmentPlanItemsControllerProvider._(
      {required TreatmentPlanItemsControllerFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'treatmentPlanItemsControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$treatmentPlanItemsControllerHash();

  @override
  String toString() {
    return r'treatmentPlanItemsControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  TreatmentPlanItemsController create() => TreatmentPlanItemsController();

  @override
  bool operator ==(Object other) {
    return other is TreatmentPlanItemsControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$treatmentPlanItemsControllerHash() =>
    r'd74f1a284e27b32784a8c3d5adf8dd2c3ca74d9d';

/// Controller for managing treatment plan items for a specific plan.
///
/// This is a family provider - each plan has its own items state.

final class TreatmentPlanItemsControllerFamily extends $Family
    with
        $ClassFamilyOverride<
            TreatmentPlanItemsController,
            AsyncValue<List<TreatmentPlanItem>>,
            List<TreatmentPlanItem>,
            FutureOr<List<TreatmentPlanItem>>,
            String> {
  TreatmentPlanItemsControllerFamily._()
      : super(
          retry: null,
          name: r'treatmentPlanItemsControllerProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Controller for managing treatment plan items for a specific plan.
  ///
  /// This is a family provider - each plan has its own items state.

  TreatmentPlanItemsControllerProvider call(
    String planId,
  ) =>
      TreatmentPlanItemsControllerProvider._(argument: planId, from: this);

  @override
  String toString() => r'treatmentPlanItemsControllerProvider';
}

/// Controller for managing treatment plan items for a specific plan.
///
/// This is a family provider - each plan has its own items state.

abstract class _$TreatmentPlanItemsController
    extends $AsyncNotifier<List<TreatmentPlanItem>> {
  late final _$args = ref.$arg as String;
  String get planId => _$args;

  FutureOr<List<TreatmentPlanItem>> build(
    String planId,
  );
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref
        as $Ref<AsyncValue<List<TreatmentPlanItem>>, List<TreatmentPlanItem>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<TreatmentPlanItem>>,
            List<TreatmentPlanItem>>,
        AsyncValue<List<TreatmentPlanItem>>,
        Object?,
        Object?>;
    element.handleCreate(
        ref,
        () => build(
              _$args,
            ));
  }
}

/// Provider for a single treatment plan item by ID.

@ProviderFor(treatmentPlanItem)
final treatmentPlanItemProvider = TreatmentPlanItemFamily._();

/// Provider for a single treatment plan item by ID.

final class TreatmentPlanItemProvider extends $FunctionalProvider<
        AsyncValue<TreatmentPlanItem?>,
        TreatmentPlanItem?,
        FutureOr<TreatmentPlanItem?>>
    with
        $FutureModifier<TreatmentPlanItem?>,
        $FutureProvider<TreatmentPlanItem?> {
  /// Provider for a single treatment plan item by ID.
  TreatmentPlanItemProvider._(
      {required TreatmentPlanItemFamily super.from,
      required String super.argument})
      : super(
          retry: null,
          name: r'treatmentPlanItemProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$treatmentPlanItemHash();

  @override
  String toString() {
    return r'treatmentPlanItemProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TreatmentPlanItem?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<TreatmentPlanItem?> create(Ref ref) {
    final argument = this.argument as String;
    return treatmentPlanItem(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TreatmentPlanItemProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$treatmentPlanItemHash() => r'265076dedd07ff60e3be8f56a4185e7f9824a1c2';

/// Provider for a single treatment plan item by ID.

final class TreatmentPlanItemFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TreatmentPlanItem?>, String> {
  TreatmentPlanItemFamily._()
      : super(
          retry: null,
          name: r'treatmentPlanItemProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a single treatment plan item by ID.

  TreatmentPlanItemProvider call(
    String id,
  ) =>
      TreatmentPlanItemProvider._(argument: id, from: this);

  @override
  String toString() => r'treatmentPlanItemProvider';
}

/// Provider for upcoming treatment plan items across all plans.

@ProviderFor(upcomingTreatmentPlanItems)
final upcomingTreatmentPlanItemsProvider = UpcomingTreatmentPlanItemsFamily._();

/// Provider for upcoming treatment plan items across all plans.

final class UpcomingTreatmentPlanItemsProvider extends $FunctionalProvider<
        AsyncValue<List<TreatmentPlanItem>>,
        List<TreatmentPlanItem>,
        FutureOr<List<TreatmentPlanItem>>>
    with
        $FutureModifier<List<TreatmentPlanItem>>,
        $FutureProvider<List<TreatmentPlanItem>> {
  /// Provider for upcoming treatment plan items across all plans.
  UpcomingTreatmentPlanItemsProvider._(
      {required UpcomingTreatmentPlanItemsFamily super.from,
      required int super.argument})
      : super(
          retry: null,
          name: r'upcomingTreatmentPlanItemsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$upcomingTreatmentPlanItemsHash();

  @override
  String toString() {
    return r'upcomingTreatmentPlanItemsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<TreatmentPlanItem>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<TreatmentPlanItem>> create(Ref ref) {
    final argument = this.argument as int;
    return upcomingTreatmentPlanItems(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UpcomingTreatmentPlanItemsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$upcomingTreatmentPlanItemsHash() =>
    r'5c29031846f8c3512a1ccb828178e5f83308f066';

/// Provider for upcoming treatment plan items across all plans.

final class UpcomingTreatmentPlanItemsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<TreatmentPlanItem>>, int> {
  UpcomingTreatmentPlanItemsFamily._()
      : super(
          retry: null,
          name: r'upcomingTreatmentPlanItemsProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for upcoming treatment plan items across all plans.

  UpcomingTreatmentPlanItemsProvider call(
    int daysAhead,
  ) =>
      UpcomingTreatmentPlanItemsProvider._(argument: daysAhead, from: this);

  @override
  String toString() => r'upcomingTreatmentPlanItemsProvider';
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_plan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for fetching a single treatment plan by ID.

@ProviderFor(treatmentPlan)
final treatmentPlanProvider = TreatmentPlanFamily._();

/// Provider for fetching a single treatment plan by ID.

final class TreatmentPlanProvider extends $FunctionalProvider<
        AsyncValue<TreatmentPlan?>, TreatmentPlan?, FutureOr<TreatmentPlan?>>
    with $FutureModifier<TreatmentPlan?>, $FutureProvider<TreatmentPlan?> {
  /// Provider for fetching a single treatment plan by ID.
  TreatmentPlanProvider._(
      {required TreatmentPlanFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'treatmentPlanProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$treatmentPlanHash();

  @override
  String toString() {
    return r'treatmentPlanProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<TreatmentPlan?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<TreatmentPlan?> create(Ref ref) {
    final argument = this.argument as String;
    return treatmentPlan(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is TreatmentPlanProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$treatmentPlanHash() => r'5f60b7eb0547dbc699e59d62ff59083bdf15e7d7';

/// Provider for fetching a single treatment plan by ID.

final class TreatmentPlanFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<TreatmentPlan?>, String> {
  TreatmentPlanFamily._()
      : super(
          retry: null,
          name: r'treatmentPlanProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for fetching a single treatment plan by ID.

  TreatmentPlanProvider call(
    String id,
  ) =>
      TreatmentPlanProvider._(argument: id, from: this);

  @override
  String toString() => r'treatmentPlanProvider';
}

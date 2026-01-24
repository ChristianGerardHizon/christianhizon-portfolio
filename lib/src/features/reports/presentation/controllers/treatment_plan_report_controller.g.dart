// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_plan_report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches and provides treatment plan report data.

@ProviderFor(treatmentPlanReport)
final treatmentPlanReportProvider = TreatmentPlanReportProvider._();

/// Fetches and provides treatment plan report data.

final class TreatmentPlanReportProvider extends $FunctionalProvider<
        AsyncValue<TreatmentPlanReport>,
        TreatmentPlanReport,
        FutureOr<TreatmentPlanReport>>
    with
        $FutureModifier<TreatmentPlanReport>,
        $FutureProvider<TreatmentPlanReport> {
  /// Fetches and provides treatment plan report data.
  TreatmentPlanReportProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'treatmentPlanReportProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$treatmentPlanReportHash();

  @$internal
  @override
  $FutureProviderElement<TreatmentPlanReport> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<TreatmentPlanReport> create(Ref ref) {
    return treatmentPlanReport(ref);
  }
}

String _$treatmentPlanReportHash() =>
    r'b1ec0a504cdbb4c1325037c27af59ff5a8dd676d';

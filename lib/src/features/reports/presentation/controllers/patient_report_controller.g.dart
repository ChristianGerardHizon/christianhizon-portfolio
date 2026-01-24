// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches and provides patient report data.

@ProviderFor(patientReport)
final patientReportProvider = PatientReportProvider._();

/// Fetches and provides patient report data.

final class PatientReportProvider extends $FunctionalProvider<
        AsyncValue<PatientReport>, PatientReport, FutureOr<PatientReport>>
    with $FutureModifier<PatientReport>, $FutureProvider<PatientReport> {
  /// Fetches and provides patient report data.
  PatientReportProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientReportProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientReportHash();

  @$internal
  @override
  $FutureProviderElement<PatientReport> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PatientReport> create(Ref ref) {
    return patientReport(ref);
  }
}

String _$patientReportHash() => r'215ce2912ba4e9346ae1994cd56dd110014b4792';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_report_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches and provides appointment report data.

@ProviderFor(appointmentReport)
final appointmentReportProvider = AppointmentReportProvider._();

/// Fetches and provides appointment report data.

final class AppointmentReportProvider extends $FunctionalProvider<
        AsyncValue<AppointmentReport>,
        AppointmentReport,
        FutureOr<AppointmentReport>>
    with
        $FutureModifier<AppointmentReport>,
        $FutureProvider<AppointmentReport> {
  /// Fetches and provides appointment report data.
  AppointmentReportProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appointmentReportProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appointmentReportHash();

  @$internal
  @override
  $FutureProviderElement<AppointmentReport> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<AppointmentReport> create(Ref ref) {
    return appointmentReport(ref);
  }
}

String _$appointmentReportHash() => r'40a926997a0e217126044bfa5435167d90761eff';

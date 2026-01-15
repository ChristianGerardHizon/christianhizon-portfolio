// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedule_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the appointment schedule repository.

@ProviderFor(appointmentScheduleRepository)
final appointmentScheduleRepositoryProvider =
    AppointmentScheduleRepositoryProvider._();

/// Provider for the appointment schedule repository.

final class AppointmentScheduleRepositoryProvider extends $FunctionalProvider<
        AppointmentScheduleRepository,
        AppointmentScheduleRepository,
        AppointmentScheduleRepository>
    with $Provider<AppointmentScheduleRepository> {
  /// Provider for the appointment schedule repository.
  AppointmentScheduleRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appointmentScheduleRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appointmentScheduleRepositoryHash();

  @$internal
  @override
  $ProviderElement<AppointmentScheduleRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppointmentScheduleRepository create(Ref ref) {
    return appointmentScheduleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppointmentScheduleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<AppointmentScheduleRepository>(value),
    );
  }
}

String _$appointmentScheduleRepositoryHash() =>
    r'ba573e74aec13cfa44fbb4815286bbf536558d90';

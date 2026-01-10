// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_schedule_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appointmentScheduleRepository)
final appointmentScheduleRepositoryProvider =
    AppointmentScheduleRepositoryProvider._();

final class AppointmentScheduleRepositoryProvider extends $FunctionalProvider<
        PBCollectionRepository<AppointmentSchedule>,
        PBCollectionRepository<AppointmentSchedule>,
        PBCollectionRepository<AppointmentSchedule>>
    with $Provider<PBCollectionRepository<AppointmentSchedule>> {
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
  $ProviderElement<PBCollectionRepository<AppointmentSchedule>> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PBCollectionRepository<AppointmentSchedule> create(Ref ref) {
    return appointmentScheduleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(
      PBCollectionRepository<AppointmentSchedule> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride:
          $SyncValueProvider<PBCollectionRepository<AppointmentSchedule>>(
              value),
    );
  }
}

String _$appointmentScheduleRepositoryHash() =>
    r'd5e170a66c7ee0dfe94b5c6ece818ea846e126b2';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_appointments_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing paginated appointments list.

@ProviderFor(PaginatedAppointmentsController)
final paginatedAppointmentsControllerProvider =
    PaginatedAppointmentsControllerProvider._();

/// Controller for managing paginated appointments list.
final class PaginatedAppointmentsControllerProvider
    extends $AsyncNotifierProvider<PaginatedAppointmentsController,
        PaginatedState<AppointmentSchedule>> {
  /// Controller for managing paginated appointments list.
  PaginatedAppointmentsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'paginatedAppointmentsControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$paginatedAppointmentsControllerHash();

  @$internal
  @override
  PaginatedAppointmentsController create() => PaginatedAppointmentsController();
}

String _$paginatedAppointmentsControllerHash() =>
    r'457a2ede57681ff43fa1f0091c1fd9170ed68793';

/// Controller for managing paginated appointments list.

abstract class _$PaginatedAppointmentsController
    extends $AsyncNotifier<PaginatedState<AppointmentSchedule>> {
  FutureOr<PaginatedState<AppointmentSchedule>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<
        AsyncValue<PaginatedState<AppointmentSchedule>>,
        PaginatedState<AppointmentSchedule>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<PaginatedState<AppointmentSchedule>>,
            PaginatedState<AppointmentSchedule>>,
        AsyncValue<PaginatedState<AppointmentSchedule>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

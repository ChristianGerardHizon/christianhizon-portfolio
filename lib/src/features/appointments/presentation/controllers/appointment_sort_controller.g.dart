// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_sort_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for managing appointment list sort configuration.

@ProviderFor(AppointmentSortController)
final appointmentSortControllerProvider = AppointmentSortControllerProvider._();

/// Provider for managing appointment list sort configuration.
final class AppointmentSortControllerProvider
    extends $NotifierProvider<AppointmentSortController, SortConfig> {
  /// Provider for managing appointment list sort configuration.
  AppointmentSortControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appointmentSortControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appointmentSortControllerHash();

  @$internal
  @override
  AppointmentSortController create() => AppointmentSortController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SortConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SortConfig>(value),
    );
  }
}

String _$appointmentSortControllerHash() =>
    r'4a8ba0d1eb9863976b0fd45208668ee5fb49fe74';

/// Provider for managing appointment list sort configuration.

abstract class _$AppointmentSortController extends $Notifier<SortConfig> {
  SortConfig build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<SortConfig, SortConfig>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<SortConfig, SortConfig>, SortConfig, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

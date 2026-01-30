// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment_search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for appointment search query state.

@ProviderFor(AppointmentSearchQuery)
final appointmentSearchQueryProvider = AppointmentSearchQueryProvider._();

/// Provider for appointment search query state.
final class AppointmentSearchQueryProvider
    extends $NotifierProvider<AppointmentSearchQuery, String> {
  /// Provider for appointment search query state.
  AppointmentSearchQueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appointmentSearchQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appointmentSearchQueryHash();

  @$internal
  @override
  AppointmentSearchQuery create() => AppointmentSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$appointmentSearchQueryHash() =>
    r'f41a5b4252ef21c9231bce118f36a8da3d3e0281';

/// Provider for appointment search query state.

abstract class _$AppointmentSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

/// Provider for managing which fields are included in appointment search.

@ProviderFor(AppointmentSearchFields)
final appointmentSearchFieldsProvider = AppointmentSearchFieldsProvider._();

/// Provider for managing which fields are included in appointment search.
final class AppointmentSearchFieldsProvider
    extends $NotifierProvider<AppointmentSearchFields, Set<String>> {
  /// Provider for managing which fields are included in appointment search.
  AppointmentSearchFieldsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'appointmentSearchFieldsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$appointmentSearchFieldsHash();

  @$internal
  @override
  AppointmentSearchFields create() => AppointmentSearchFields();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$appointmentSearchFieldsHash() =>
    r'6fb777dd26b7008bb2e6b22eaf670a7a9986a18d';

/// Provider for managing which fields are included in appointment search.

abstract class _$AppointmentSearchFields extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Set<String>, Set<String>>, Set<String>, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}

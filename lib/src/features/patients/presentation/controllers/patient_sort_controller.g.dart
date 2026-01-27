// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_sort_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for managing patient list sort configuration.

@ProviderFor(PatientSortController)
final patientSortControllerProvider = PatientSortControllerProvider._();

/// Provider for managing patient list sort configuration.
final class PatientSortControllerProvider
    extends $NotifierProvider<PatientSortController, SortConfig> {
  /// Provider for managing patient list sort configuration.
  PatientSortControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientSortControllerProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientSortControllerHash();

  @$internal
  @override
  PatientSortController create() => PatientSortController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SortConfig value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SortConfig>(value),
    );
  }
}

String _$patientSortControllerHash() =>
    r'e2b16757732cff4c95d2b7a172287dad2d2f1b9c';

/// Provider for managing patient list sort configuration.

abstract class _$PatientSortController extends $Notifier<SortConfig> {
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

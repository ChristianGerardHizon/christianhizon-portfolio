// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_search_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for patient search query state.

@ProviderFor(PatientSearchQuery)
final patientSearchQueryProvider = PatientSearchQueryProvider._();

/// Provider for patient search query state.
final class PatientSearchQueryProvider
    extends $NotifierProvider<PatientSearchQuery, String> {
  /// Provider for patient search query state.
  PatientSearchQueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientSearchQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientSearchQueryHash();

  @$internal
  @override
  PatientSearchQuery create() => PatientSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$patientSearchQueryHash() =>
    r'5bd0bc17691c2fa6c2d75d721f44d0dfbcb2ed8a';

/// Provider for patient search query state.

abstract class _$PatientSearchQuery extends $Notifier<String> {
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

/// Provider for managing which fields are included in patient search.

@ProviderFor(PatientSearchFields)
final patientSearchFieldsProvider = PatientSearchFieldsProvider._();

/// Provider for managing which fields are included in patient search.
final class PatientSearchFieldsProvider
    extends $NotifierProvider<PatientSearchFields, Set<String>> {
  /// Provider for managing which fields are included in patient search.
  PatientSearchFieldsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientSearchFieldsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientSearchFieldsHash();

  @$internal
  @override
  PatientSearchFields create() => PatientSearchFields();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$patientSearchFieldsHash() =>
    r'76d296acdd455fc3320160c9b04c1db9505f87cd';

/// Provider for managing which fields are included in patient search.

abstract class _$PatientSearchFields extends $Notifier<Set<String>> {
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patients_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Controller for managing patient list state.
///
/// Provides methods for fetching, searching, and CRUD operations on patients.

@ProviderFor(PatientsController)
final patientsControllerProvider = PatientsControllerProvider._();

/// Controller for managing patient list state.
///
/// Provides methods for fetching, searching, and CRUD operations on patients.
final class PatientsControllerProvider
    extends $AsyncNotifierProvider<PatientsController, List<Patient>> {
  /// Controller for managing patient list state.
  ///
  /// Provides methods for fetching, searching, and CRUD operations on patients.
  PatientsControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'patientsControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientsControllerHash();

  @$internal
  @override
  PatientsController create() => PatientsController();
}

String _$patientsControllerHash() =>
    r'd42c67269e2309ad1e4d536ad531461dd322f54d';

/// Controller for managing patient list state.
///
/// Provides methods for fetching, searching, and CRUD operations on patients.

abstract class _$PatientsController extends $AsyncNotifier<List<Patient>> {
  FutureOr<List<Patient>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Patient>>, List<Patient>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Patient>>, List<Patient>>,
        AsyncValue<List<Patient>>,
        Object?,
        Object?>;
    element.handleCreate(ref, build);
  }
}

/// Provider for a single patient by ID.

@ProviderFor(patient)
final patientProvider = PatientFamily._();

/// Provider for a single patient by ID.

final class PatientProvider extends $FunctionalProvider<AsyncValue<Patient?>,
        Patient?, FutureOr<Patient?>>
    with $FutureModifier<Patient?>, $FutureProvider<Patient?> {
  /// Provider for a single patient by ID.
  PatientProvider._(
      {required PatientFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'patientProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientHash();

  @override
  String toString() {
    return r'patientProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Patient?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Patient?> create(Ref ref) {
    final argument = this.argument as String;
    return patient(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PatientProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientHash() => r'cae0cdcde36811dbd4447606802d303fe35e650a';

/// Provider for a single patient by ID.

final class PatientFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Patient?>, String> {
  PatientFamily._()
      : super(
          retry: null,
          name: r'patientProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a single patient by ID.

  PatientProvider call(
    String id,
  ) =>
      PatientProvider._(argument: id, from: this);

  @override
  String toString() => r'patientProvider';
}

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

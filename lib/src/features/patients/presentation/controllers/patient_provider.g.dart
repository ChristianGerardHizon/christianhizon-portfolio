// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'patient_record_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for a single patient record by ID.

@ProviderFor(patientRecord)
final patientRecordProvider = PatientRecordFamily._();

/// Provider for a single patient record by ID.

final class PatientRecordProvider extends $FunctionalProvider<
        AsyncValue<PatientRecord?>, PatientRecord?, FutureOr<PatientRecord?>>
    with $FutureModifier<PatientRecord?>, $FutureProvider<PatientRecord?> {
  /// Provider for a single patient record by ID.
  PatientRecordProvider._(
      {required PatientRecordFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'patientRecordProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$patientRecordHash();

  @override
  String toString() {
    return r'patientRecordProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PatientRecord?> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<PatientRecord?> create(Ref ref) {
    final argument = this.argument as String;
    return patientRecord(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is PatientRecordProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$patientRecordHash() => r'66a25c6baf4f8624038ac7c9747505b26363efae';

/// Provider for a single patient record by ID.

final class PatientRecordFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PatientRecord?>, String> {
  PatientRecordFamily._()
      : super(
          retry: null,
          name: r'patientRecordProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  /// Provider for a single patient record by ID.

  PatientRecordProvider call(
    String id,
  ) =>
      PatientRecordProvider._(argument: id, from: this);

  @override
  String toString() => r'patientRecordProvider';
}

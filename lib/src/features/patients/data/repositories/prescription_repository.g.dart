// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prescription_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the prescription repository.

@ProviderFor(prescriptionRepository)
final prescriptionRepositoryProvider = PrescriptionRepositoryProvider._();

/// Provider for the prescription repository.

final class PrescriptionRepositoryProvider extends $FunctionalProvider<
    PrescriptionRepository,
    PrescriptionRepository,
    PrescriptionRepository> with $Provider<PrescriptionRepository> {
  /// Provider for the prescription repository.
  PrescriptionRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'prescriptionRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$prescriptionRepositoryHash();

  @$internal
  @override
  $ProviderElement<PrescriptionRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PrescriptionRepository create(Ref ref) {
    return prescriptionRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PrescriptionRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PrescriptionRepository>(value),
    );
  }
}

String _$prescriptionRepositoryHash() =>
    r'591d44de777f0703c2f75da605891b4e96489739';

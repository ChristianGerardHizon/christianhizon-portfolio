// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_template_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the treatment template repository.

@ProviderFor(treatmentTemplateRepository)
final treatmentTemplateRepositoryProvider =
    TreatmentTemplateRepositoryProvider._();

/// Provider for the treatment template repository.

final class TreatmentTemplateRepositoryProvider extends $FunctionalProvider<
    TreatmentTemplateRepository,
    TreatmentTemplateRepository,
    TreatmentTemplateRepository> with $Provider<TreatmentTemplateRepository> {
  /// Provider for the treatment template repository.
  TreatmentTemplateRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'treatmentTemplateRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$treatmentTemplateRepositoryHash();

  @$internal
  @override
  $ProviderElement<TreatmentTemplateRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TreatmentTemplateRepository create(Ref ref) {
    return treatmentTemplateRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TreatmentTemplateRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TreatmentTemplateRepository>(value),
    );
  }
}

String _$treatmentTemplateRepositoryHash() =>
    r'f3b66b2308226cb7bc1551ee04bcade9bfbce27b';

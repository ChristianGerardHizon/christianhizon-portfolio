// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_plan_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the treatment plan repository.

@ProviderFor(treatmentPlanRepository)
final treatmentPlanRepositoryProvider = TreatmentPlanRepositoryProvider._();

/// Provider for the treatment plan repository.

final class TreatmentPlanRepositoryProvider extends $FunctionalProvider<
    TreatmentPlanRepository,
    TreatmentPlanRepository,
    TreatmentPlanRepository> with $Provider<TreatmentPlanRepository> {
  /// Provider for the treatment plan repository.
  TreatmentPlanRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'treatmentPlanRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$treatmentPlanRepositoryHash();

  @$internal
  @override
  $ProviderElement<TreatmentPlanRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TreatmentPlanRepository create(Ref ref) {
    return treatmentPlanRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TreatmentPlanRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TreatmentPlanRepository>(value),
    );
  }
}

String _$treatmentPlanRepositoryHash() =>
    r'23d80794e0f3ac762cb13072e7c17ca1a9fac0d3';

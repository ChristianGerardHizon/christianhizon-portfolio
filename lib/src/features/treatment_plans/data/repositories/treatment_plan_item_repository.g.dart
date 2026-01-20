// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_plan_item_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provider for the treatment plan item repository.

@ProviderFor(treatmentPlanItemRepository)
final treatmentPlanItemRepositoryProvider =
    TreatmentPlanItemRepositoryProvider._();

/// Provider for the treatment plan item repository.

final class TreatmentPlanItemRepositoryProvider extends $FunctionalProvider<
    TreatmentPlanItemRepository,
    TreatmentPlanItemRepository,
    TreatmentPlanItemRepository> with $Provider<TreatmentPlanItemRepository> {
  /// Provider for the treatment plan item repository.
  TreatmentPlanItemRepositoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'treatmentPlanItemRepositoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$treatmentPlanItemRepositoryHash();

  @$internal
  @override
  $ProviderElement<TreatmentPlanItemRepository> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TreatmentPlanItemRepository create(Ref ref) {
    return treatmentPlanItemRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TreatmentPlanItemRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TreatmentPlanItemRepository>(value),
    );
  }
}

String _$treatmentPlanItemRepositoryHash() =>
    r'5289af6711d52913a0386d1e86d75fb9883ab626';

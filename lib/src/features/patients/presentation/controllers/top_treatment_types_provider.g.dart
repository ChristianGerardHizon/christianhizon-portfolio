// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'top_treatment_types_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches the top 5 most-used treatment type IDs from [vw_top_treatment_types].
///
/// Results are branch-filtered and sorted by usage count descending.
/// Uses keepAlive so the data is fetched once and reused across dialog opens.

@ProviderFor(topTreatmentTypeIds)
final topTreatmentTypeIdsProvider = TopTreatmentTypeIdsProvider._();

/// Fetches the top 5 most-used treatment type IDs from [vw_top_treatment_types].
///
/// Results are branch-filtered and sorted by usage count descending.
/// Uses keepAlive so the data is fetched once and reused across dialog opens.

final class TopTreatmentTypeIdsProvider extends $FunctionalProvider<
        AsyncValue<List<String>>, List<String>, FutureOr<List<String>>>
    with $FutureModifier<List<String>>, $FutureProvider<List<String>> {
  /// Fetches the top 5 most-used treatment type IDs from [vw_top_treatment_types].
  ///
  /// Results are branch-filtered and sorted by usage count descending.
  /// Uses keepAlive so the data is fetched once and reused across dialog opens.
  TopTreatmentTypeIdsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'topTreatmentTypeIdsProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$topTreatmentTypeIdsHash();

  @$internal
  @override
  $FutureProviderElement<List<String>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<String>> create(Ref ref) {
    return topTreatmentTypeIds(ref);
  }
}

String _$topTreatmentTypeIdsHash() =>
    r'696ee790bc7288f1abb64b4f802d2923c4b349fb';

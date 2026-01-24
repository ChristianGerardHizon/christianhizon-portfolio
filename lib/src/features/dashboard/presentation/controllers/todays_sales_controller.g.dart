// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todays_sales_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Today's sales data.

@ProviderFor(todaySales)
final todaySalesProvider = TodaySalesProvider._();

/// Today's sales data.

final class TodaySalesProvider extends $FunctionalProvider<
        AsyncValue<List<Sale>>, List<Sale>, FutureOr<List<Sale>>>
    with $FutureModifier<List<Sale>>, $FutureProvider<List<Sale>> {
  /// Today's sales data.
  TodaySalesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todaySalesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todaySalesHash();

  @$internal
  @override
  $FutureProviderElement<List<Sale>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Sale>> create(Ref ref) {
    return todaySales(ref);
  }
}

String _$todaySalesHash() => r'7f97ca36e73d06fc0f07be545dcd6ed803bcb480';

/// Today's sales summary (count and total amount).
/// Uses vw_todays_sales view for optimized query.

@ProviderFor(todaySalesSummary)
final todaySalesSummaryProvider = TodaySalesSummaryProvider._();

/// Today's sales summary (count and total amount).
/// Uses vw_todays_sales view for optimized query.

final class TodaySalesSummaryProvider extends $FunctionalProvider<
        AsyncValue<TodaySalesSummary>,
        TodaySalesSummary,
        FutureOr<TodaySalesSummary>>
    with
        $FutureModifier<TodaySalesSummary>,
        $FutureProvider<TodaySalesSummary> {
  /// Today's sales summary (count and total amount).
  /// Uses vw_todays_sales view for optimized query.
  TodaySalesSummaryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todaySalesSummaryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todaySalesSummaryHash();

  @$internal
  @override
  $FutureProviderElement<TodaySalesSummary> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<TodaySalesSummary> create(Ref ref) {
    return todaySalesSummary(ref);
  }
}

String _$todaySalesSummaryHash() => r'b229ecf360868363bd58eed42145404199756a5e';

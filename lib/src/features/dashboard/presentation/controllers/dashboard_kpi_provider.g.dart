// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_kpi_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Count of products that are near expiration (within 30 days).
/// Delegates to the unified inventory alerts controller for both lot-tracked
/// and non-lot-tracked products.

@ProviderFor(productsNearExpirationCount)
final productsNearExpirationCountProvider =
    ProductsNearExpirationCountProvider._();

/// Count of products that are near expiration (within 30 days).
/// Delegates to the unified inventory alerts controller for both lot-tracked
/// and non-lot-tracked products.

final class ProductsNearExpirationCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Count of products that are near expiration (within 30 days).
  /// Delegates to the unified inventory alerts controller for both lot-tracked
  /// and non-lot-tracked products.
  ProductsNearExpirationCountProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productsNearExpirationCountProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productsNearExpirationCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return productsNearExpirationCount(ref);
  }
}

String _$productsNearExpirationCountHash() =>
    r'6d033a9d0938b4888d7b09f12db6c15b5e881080';

/// Count of products that are expired.
/// Delegates to the unified inventory alerts controller for both lot-tracked
/// and non-lot-tracked products.

@ProviderFor(productsExpiredCount)
final productsExpiredCountProvider = ProductsExpiredCountProvider._();

/// Count of products that are expired.
/// Delegates to the unified inventory alerts controller for both lot-tracked
/// and non-lot-tracked products.

final class ProductsExpiredCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Count of products that are expired.
  /// Delegates to the unified inventory alerts controller for both lot-tracked
  /// and non-lot-tracked products.
  ProductsExpiredCountProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'productsExpiredCountProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$productsExpiredCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return productsExpiredCount(ref);
  }
}

String _$productsExpiredCountHash() =>
    r'9ba10f936908802e3f98d8a8f5440349f071783f';

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

String _$todaySalesHash() => r'8364bf71c8a05aa6e197799736e5dd5d2c32342b';

/// Today's sales summary (count and total amount).

@ProviderFor(todaySalesSummary)
final todaySalesSummaryProvider = TodaySalesSummaryProvider._();

/// Today's sales summary (count and total amount).

final class TodaySalesSummaryProvider extends $FunctionalProvider<
        AsyncValue<TodaySalesSummary>,
        TodaySalesSummary,
        FutureOr<TodaySalesSummary>>
    with
        $FutureModifier<TodaySalesSummary>,
        $FutureProvider<TodaySalesSummary> {
  /// Today's sales summary (count and total amount).
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

String _$todaySalesSummaryHash() => r'5cbfe5774ae395f2a437fd0343ebd09e02de7a21';

/// Count of active patients.

@ProviderFor(activePatientsCount)
final activePatientsCountProvider = ActivePatientsCountProvider._();

/// Count of active patients.

final class ActivePatientsCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Count of active patients.
  ActivePatientsCountProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'activePatientsCountProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$activePatientsCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return activePatientsCount(ref);
  }
}

String _$activePatientsCountHash() =>
    r'74dd69127df2f6010efb40c0a1b41fe44d756ad5';

/// Count of products with low stock.
/// Delegates to the unified inventory alerts controller for both lot-tracked
/// and non-lot-tracked products.

@ProviderFor(lowStockProductsCount)
final lowStockProductsCountProvider = LowStockProductsCountProvider._();

/// Count of products with low stock.
/// Delegates to the unified inventory alerts controller for both lot-tracked
/// and non-lot-tracked products.

final class LowStockProductsCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Count of products with low stock.
  /// Delegates to the unified inventory alerts controller for both lot-tracked
  /// and non-lot-tracked products.
  LowStockProductsCountProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'lowStockProductsCountProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$lowStockProductsCountHash();

  @$internal
  @override
  $FutureProviderElement<int> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<int> create(Ref ref) {
    return lowStockProductsCount(ref);
  }
}

String _$lowStockProductsCountHash() =>
    r'ab8d76053c11fe2fe42d1cab369a1ccaae8a4c3b';

/// Today's appointments breakdown by status.

@ProviderFor(todayAppointmentsBreakdown)
final todayAppointmentsBreakdownProvider =
    TodayAppointmentsBreakdownProvider._();

/// Today's appointments breakdown by status.

final class TodayAppointmentsBreakdownProvider extends $FunctionalProvider<
    TodayAppointmentsBreakdown,
    TodayAppointmentsBreakdown,
    TodayAppointmentsBreakdown> with $Provider<TodayAppointmentsBreakdown> {
  /// Today's appointments breakdown by status.
  TodayAppointmentsBreakdownProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'todayAppointmentsBreakdownProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$todayAppointmentsBreakdownHash();

  @$internal
  @override
  $ProviderElement<TodayAppointmentsBreakdown> $createElement(
          $ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TodayAppointmentsBreakdown create(Ref ref) {
    return todayAppointmentsBreakdown(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TodayAppointmentsBreakdown value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TodayAppointmentsBreakdown>(value),
    );
  }
}

String _$todayAppointmentsBreakdownHash() =>
    r'2500bbc23d61e0d4a96e02584f4442651b392227';

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

/// Count of active patients.
/// Uses vw_active_patients_count view for optimized query.

@ProviderFor(activePatientsCount)
final activePatientsCountProvider = ActivePatientsCountProvider._();

/// Count of active patients.
/// Uses vw_active_patients_count view for optimized query.

final class ActivePatientsCountProvider
    extends $FunctionalProvider<AsyncValue<int>, int, FutureOr<int>>
    with $FutureModifier<int>, $FutureProvider<int> {
  /// Count of active patients.
  /// Uses vw_active_patients_count view for optimized query.
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
    r'f8b8d7595f12c264dbe12945700f7e6e55cd2fb8';

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
/// Uses vw_todays_appointments view for optimized query.

@ProviderFor(todayAppointmentsBreakdown)
final todayAppointmentsBreakdownProvider =
    TodayAppointmentsBreakdownProvider._();

/// Today's appointments breakdown by status.
/// Uses vw_todays_appointments view for optimized query.

final class TodayAppointmentsBreakdownProvider extends $FunctionalProvider<
        AsyncValue<TodayAppointmentsBreakdown>,
        TodayAppointmentsBreakdown,
        FutureOr<TodayAppointmentsBreakdown>>
    with
        $FutureModifier<TodayAppointmentsBreakdown>,
        $FutureProvider<TodayAppointmentsBreakdown> {
  /// Today's appointments breakdown by status.
  /// Uses vw_todays_appointments view for optimized query.
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
  $FutureProviderElement<TodayAppointmentsBreakdown> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<TodayAppointmentsBreakdown> create(Ref ref) {
    return todayAppointmentsBreakdown(ref);
  }
}

String _$todayAppointmentsBreakdownHash() =>
    r'ab90b11b4c4c1e40e8fb9bf3da12e0b026a247ec';

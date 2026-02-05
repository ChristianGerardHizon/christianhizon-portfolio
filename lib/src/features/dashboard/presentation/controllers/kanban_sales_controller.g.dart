// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kanban_sales_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Fetches all active sales (non-voided) grouped by order status.
/// Filtered by current branch, sorted by most recent first.

@ProviderFor(kanbanSales)
final kanbanSalesProvider = KanbanSalesProvider._();

/// Fetches all active sales (non-voided) grouped by order status.
/// Filtered by current branch, sorted by most recent first.

final class KanbanSalesProvider extends $FunctionalProvider<
        AsyncValue<KanbanSalesData>, KanbanSalesData, FutureOr<KanbanSalesData>>
    with $FutureModifier<KanbanSalesData>, $FutureProvider<KanbanSalesData> {
  /// Fetches all active sales (non-voided) grouped by order status.
  /// Filtered by current branch, sorted by most recent first.
  KanbanSalesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'kanbanSalesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$kanbanSalesHash();

  @$internal
  @override
  $FutureProviderElement<KanbanSalesData> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<KanbanSalesData> create(Ref ref) {
    return kanbanSales(ref);
  }
}

String _$kanbanSalesHash() => r'ce938fd5150186685e7f77fc4a882b72a03f3ea0';

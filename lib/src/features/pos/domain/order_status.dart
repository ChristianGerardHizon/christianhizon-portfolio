import 'package:dart_mappable/dart_mappable.dart';

part 'order_status.mapper.dart';

/// Status of an order in the fulfillment workflow.
@MappableEnum()
enum OrderStatus {
  pending,
  processing,
  ready,
  pickedUp,
}

/// Extension to get display names for order statuses.
extension OrderStatusX on OrderStatus {
  String get displayName {
    switch (this) {
      case OrderStatus.pending:
        return 'Pending';
      case OrderStatus.processing:
        return 'Processing';
      case OrderStatus.ready:
        return 'Ready';
      case OrderStatus.pickedUp:
        return 'Picked Up';
    }
  }

  /// Returns the icon for this order status.
  String get iconName {
    switch (this) {
      case OrderStatus.pending:
        return 'schedule';
      case OrderStatus.processing:
        return 'autorenew';
      case OrderStatus.ready:
        return 'check_circle';
      case OrderStatus.pickedUp:
        return 'local_shipping';
    }
  }
}

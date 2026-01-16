import 'package:dart_mappable/dart_mappable.dart';

part 'sale_status.mapper.dart';

/// Status of a sale transaction.
@MappableEnum()
enum SaleStatus {
  completed,
  refunded,
  voided,
}

/// Extension to get display names for sale statuses.
extension SaleStatusX on SaleStatus {
  String get displayName {
    switch (this) {
      case SaleStatus.completed:
        return 'Completed';
      case SaleStatus.refunded:
        return 'Refunded';
      case SaleStatus.voided:
        return 'Voided';
    }
  }
}

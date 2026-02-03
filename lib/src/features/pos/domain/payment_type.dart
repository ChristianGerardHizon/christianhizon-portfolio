import 'package:dart_mappable/dart_mappable.dart';

part 'payment_type.mapper.dart';

/// Type of payment transaction.
@MappableEnum()
enum PaymentType {
  payment,
  deposit,
  refund,
}

/// Extension to get display names for payment types.
extension PaymentTypeX on PaymentType {
  String get displayName {
    switch (this) {
      case PaymentType.payment:
        return 'Payment';
      case PaymentType.deposit:
        return 'GCash/Bank';
      case PaymentType.refund:
        return 'Refund';
    }
  }
}

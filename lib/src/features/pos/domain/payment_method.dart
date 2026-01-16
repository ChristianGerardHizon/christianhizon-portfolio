import 'package:dart_mappable/dart_mappable.dart';

part 'payment_method.mapper.dart';

/// Payment methods supported by the POS system.
@MappableEnum()
enum PaymentMethod {
  cash,
  card,
  bankTransfer,
  check,
}

/// Extension to get display names for payment methods.
extension PaymentMethodX on PaymentMethod {
  String get displayName {
    switch (this) {
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.card:
        return 'Card';
      case PaymentMethod.bankTransfer:
        return 'Bank Transfer';
      case PaymentMethod.check:
        return 'Check';
    }
  }
}

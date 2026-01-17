import 'package:intl/intl.dart';

/// Formats a number as Philippine Peso currency with comma separators.
///
/// Example: 1234.56 -> "₱1,234.56"
String formatCurrency(num amount) {
  final formatter = NumberFormat('#,##0.00', 'en_PH');
  return '₱${formatter.format(amount)}';
}

/// Extension on num for convenient currency formatting.
extension CurrencyFormat on num {
  /// Formats this number as Philippine Peso currency.
  ///
  /// Example: 1234.56.toCurrency() -> "₱1,234.56"
  String toCurrency() => formatCurrency(this);
}

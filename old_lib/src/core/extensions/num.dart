import 'package:intl/intl.dart';

extension NumOptionalExtension on num? {
  String optional({String placeholder = ''}) {
    if (this == null) return placeholder;
    return this.toString();
  }
}

extension NumExtension on num {
  String toCurrency() =>
      NumberFormat.currency(locale: 'en_US', symbol: '\$').format(this);

  String toPHPeso() =>
      NumberFormat.currency(locale: 'en_US', symbol: '₱').format(this);
}

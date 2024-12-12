import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  String  yyyyMMdd() =>  DateFormat('yyyy-MM-dd').format(this);

  String  yyyyMMddHHmm() =>  DateFormat('yyyy-MM-dd HH:mm').format(this);

  String  yyyyMMddHHmmA() =>  DateFormat('yyyy-MM-dd hh:mm a').format(this);
}

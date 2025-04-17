import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  String yyyyMMdd() => DateFormat('yyyy-MM-dd').format(this);

  String yyyyMMddHHmm() => DateFormat('yyyy-MM-dd HH:mm').format(this);

  String yyyyMMddHHmmA() => DateFormat('yyyy-MM-dd hh:mm a').format(this);

  String get ddMMyyyy => DateFormat('dd/MM/yyyy').format(this);

  String get MMddyyyy => DateFormat('MM/dd/yyyy').format(this);

  String get isoDate => DateFormat('yyyy-MM-dd').format(this);

  String get shortReadable => DateFormat('d MMM yyyy').format(this);

  String get weekdayShort => DateFormat('EEE, d MMM').format(this);

  String get fullReadable => DateFormat('EEEE, d MMMM y').format(this);
}

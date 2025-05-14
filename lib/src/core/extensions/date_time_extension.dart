import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  DateTime get startOfDay => DateTime(year, month, day);
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  String get fullDateTime => DateFormat('MMM d, yyyy h:mm a').format(this);
  String get fullDate => DateFormat('MMM d, yyyy').format(this);

  String yyyyMMdd() => DateFormat('yyyy-MM-dd').format(this);

  String yyyyMMddHHmm() => DateFormat('yyyy-MM-dd HH:mm').format(this);

  String yyyyMMddHHmmA() => DateFormat('yyyy-MM-dd hh:mm a').format(this);

  String get ddMMyyyy => DateFormat('dd/MM/yyyy').format(this);

  String get MMddyyyy => DateFormat('MM/dd/yyyy').format(this);

  String get isoDate => DateFormat('yyyy-MM-dd').format(this);

  String get shortReadable => DateFormat('d MMM yyyy').format(this);

  String get weekdayShort => DateFormat('EEE, d MMM').format(this);

  String get fullReadable => DateFormat('EEEE, d MMMM y').format(this);

  // Y-m-d H:i:s.uZ
  String get pbFormat =>
      DateFormat('yyyy-MM-dd HH:mm:ss.SSSZ').format(this.toUtc());

  DateTime get dateOnly => DateTime(year, month, day);
}

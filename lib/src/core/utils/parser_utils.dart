class ParserUtils {

  // date
  static DateTime? parseDate(dynamic date) {
    if(date.isEmpty) return null;
    if(date is DateTime) return date;
    if(date is String) return DateTime.tryParse(date);
    return null;
  }
}
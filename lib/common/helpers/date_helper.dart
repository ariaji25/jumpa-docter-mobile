import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static String? changeFormatIdToDateTimeFormat({DateTime? date}) {
    if (date != null) {
      return DateFormat('yyyy-MM-dd').format(date);
    }
    return null;
  }

  static DateTime? convertStringToDate({String? date}) {
    if (date != null) {
      DateTime result = DateTime.parse(date);
      return result;
    }
    return null;
  }

  static String dhis2DateFormat(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return formattedDate;
  }
}

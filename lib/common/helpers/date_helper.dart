import 'package:intl/intl.dart';

class DateHelper {
  DateHelper._();

  static String? changeFormatIdToDateTimeFormat(
      {DateTime? date, bool newPatternId = false}) {
    if (date != null) {
      return DateFormat(newPatternId ? 'dd-MM-yyyy' : 'yyyy-MM-dd')
          .format(date);
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

  static String? dateTimeToLocalDate(String? date) {
    if (date != null) {
      DateTime result = DateTime.parse(date);
      String formattedDate = DateFormat('dd-MM-yyyy').format(result);
      return formattedDate;
    }

    return null;
  }

  static DateTime? covertStringToDateTime({required String value}) {
    if (value == "") {
      return null;
    }
    List<String> splitValue = value.split("-");
    return DateTime.parse(splitValue[0].length >= 4
        ? value
        : "${splitValue[2]}-${splitValue[1]}-${splitValue[0]}");
  }

  static String getTimezon() {
    final now = DateTime.now();
    final timeZone = now.timeZoneOffset;

    String timeZoneAbbreviation;
    if (timeZone.inHours == 7) {
      timeZoneAbbreviation = 'WIB';
    } else if (timeZone.inHours == 8) {
      timeZoneAbbreviation = 'WITA';
    } else if (timeZone.inHours == 9) {
      timeZoneAbbreviation = 'WIT';
    } else {
      timeZoneAbbreviation = timeZone.toString();
    }

    return timeZoneAbbreviation;
  }
}

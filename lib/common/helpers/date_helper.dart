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

// static String? convertToLocalTime(String time, BuildContext context) {
//   final int hour = int.tryParse(time.split(":")[0]) ?? 00;
//   final int minute = int.tryParse(time.split(":")[1]) ?? 00;
//   TimeOfDay noonTime = TimeOfDay(hour: hour, minute: minute);
//   TimeOfDay morningTime = TimeOfDay(hour: hour, minute: minute);
//   if (morningTime.period == DayPeriod.am) {
//     return "${morningTime.format(context)} AM";
//   } else {
//     return "${noonTime.format(context)} PM";
//   }
// }
}

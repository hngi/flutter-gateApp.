import 'package:intl/intl.dart';

class GatManDateFormatter {
  GatManDateFormatter._();

  static String toDateFormatYMD(DateTime date) {
    var formatter = new DateFormat('yyyy-MM-dd');
    String formatted = formatter.format(date);
    return formatted;
  }

  static String getFormattedDate(String date,
      {bool withYear = false, withYearAbbr = false}) {
    var formatter = DateFormat('dd, MMMM');
    if (withYear) {
      formatter = DateFormat('dd, MMMM y');
    } else if (withYearAbbr) {
      formatter = DateFormat('dd, MMMM y');
    }

    String parsed = formatter.format(DateTime.parse(date));

    return parsed;
  }

  static String getFormattedTime(String date, {bool onlyHour = false}) {
    var formatter = DateFormat('hh:mm a');
    if (onlyHour) formatter = DateFormat('ha');
    String parsed = formatter.format(DateTime.parse(date));

    return parsed;
  }
}

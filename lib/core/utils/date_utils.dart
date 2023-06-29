import 'package:intl/intl.dart';

class DateUtilsApp {
  static String formatDateMonthDayYear(String? inputDate) {
    if (inputDate == null) return "No date";
    DateTime date = DateTime.parse(inputDate);
    final formattedDate = DateFormat('MMMM dd, yyyy').format(date);
    return formattedDate;
  }
}

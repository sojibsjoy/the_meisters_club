import 'package:intl/intl.dart';

class CustomDateFormator {
  CustomDateFormator._();

  static dateFormatByMonthName({String? date}){
    return  DateFormat('dd MMM yyyy').format(
        DateTime.parse(date!).toLocal()
    ).toString();
  }

  static time_format_by_AM_PM({String? time}){
    return  DateFormat('KK:MM a').format(
        DateTime.parse(time!).toLocal()
    ).toString();
  }

  static dateTime_Format_By_MonthName_With_AM_PM({String? date}){
    return  DateFormat('dd MMM, KK:MM a').format(
        DateTime.parse(date!).toLocal()
    ).toString();
  }
}
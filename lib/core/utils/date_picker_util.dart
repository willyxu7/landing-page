import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class DatePickerUtil {
  static const Locale _indonesiaLocale = Locale('id', 'ID');
  static final DateTime _initialDate = DateTime.now();

  static Future<DateTime?> datePicker(BuildContext context) async {
    final Future<DateTime?> selectedDate = showDatePicker(
        context: context,
        initialDate: _initialDate,
        locale: _indonesiaLocale,
        firstDate: DateTime(1950),
        lastDate: DateTime.now(),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
                colorScheme: const ColorScheme.light(
                    primary: AppColor.primary,
                    onPrimary: Colors.white,
                    onSurface: Colors.black)),
            child: child!,
          );
        });

    return selectedDate;
  }

  static Future<DateTime?> selectWorkingTime(BuildContext context) async {
    final Future<DateTime?> futureSelectedDate = showDatePicker(
        context: context,
        initialDate: _initialDate,
        locale: _indonesiaLocale,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData(
                colorScheme: const ColorScheme.light(
                    primary: AppColor.primary,
                    onPrimary: Colors.white,
                    onSurface: Colors.black)),
            child: child!,
          );
        });

    return futureSelectedDate;
  }

  static String convertToIndonesianDateWithWeekday(DateTime date) {
    return DateFormat.yMMMMEEEEd('idr').format(date);
  }

  static List<int> generateStartYears() {
    List<int> years = [];

    DateTime fiftyYearAgo = DateTime(DateTime.now().year - 50, 1);
    DateTime now = DateTime(DateTime.now().year, 1);
    int monthsDifference = DateUtils.monthDelta(fiftyYearAgo, now);
    int yearsDifference = monthsDifference ~/ 12;

    int year = fiftyYearAgo.year;

    for (int i = 0; i <= yearsDifference; i++) {
      years.add(year);
      year++;
    }

    return years;
  }

  static List<int> generateEndYears(String selectedStartYear) {
    List<int> years = [];

    DateTime startYear = DateTime(int.parse(selectedStartYear), 1);
    DateTime now = DateTime(DateTime.now().year, 1);
    int monthsDifference = DateUtils.monthDelta(startYear, now);
    int yearsDifference = monthsDifference ~/ 12;

    int year = startYear.year;

    for (int i = 0; i <= yearsDifference; i++) {
      years.add(year);
      year++;
    }

    return years;
  }

  static List<String> indonesianMonths() {
    return [
      "Januari",
      "Februari",
      "Maret",
      "April",
      "Mei",
      "Juni",
      "Juli",
      "Agustus",
      "September",
      "Oktober",
      "November",
      "Desember"
    ];
  }

  static int getMonthIntNumber(String monthName) {
    int monthInNumber = 0;
    switch(monthName) {
      case "Januari":
        monthInNumber = 1;
        break;
      case "Februari" :
        monthInNumber = 2;
        break;
      case "Maret" :
        monthInNumber = 3;
        break;
      case "April" :
        monthInNumber = 4;
        break;
      case "Mei" :
        monthInNumber = 5;
        break;
      case "Juni" :
        monthInNumber = 6;
        break;
      case "Juli" :
        monthInNumber = 7;
        break;
      case "Agustus" :
        monthInNumber = 8;
        break;
      case "September" :
        monthInNumber = 9;
        break;
      case "Oktober" :
        monthInNumber = 10;
        break;
      case "November" :
        monthInNumber = 11;
        break;
      case "Desember" :
        monthInNumber = 12;
        break;
    }

    return monthInNumber;
  }
}

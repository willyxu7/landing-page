import 'package:flutter/material.dart';

import '../../features/kukerja/landing_page/style/app_color.dart';

class TimePickerUtil {
  static Future<TimeOfDay?> picker(BuildContext context) async {
    TimeOfDay? selectedHour = await showTimePicker(
        context: context,
        initialTime: const TimeOfDay(hour: 0, minute: 0),
        helpText: 'PILIH JAM',
        cancelText: 'BATAL',
        confirmText: 'OKE',
        builder: (BuildContext context, Widget? child) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
            child: Theme(
                data: ThemeData(
                    colorScheme: const ColorScheme.light(
                        primary: AppColor.primary,
                        onPrimary: Colors.white,
                        onSurface: Colors.black)),
                child: child!),
          );
        });

    return selectedHour;
  }

  static DateTime convertTimeOfDayToDateTime(TimeOfDay time) {
    final now = DateTime.now();
    return DateTime(
        now.year,
        now.month,
        now.day,
        time.hour,
        time.minute);
  }

}
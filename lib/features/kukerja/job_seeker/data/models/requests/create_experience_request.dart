import 'package:kukerja_web/core/utils/date_picker_util.dart';

class CreateExperienceRequest {
  late String indexWidget,
      companyName,
      profession,
      industry,
      startMonth,
      endMonth,
      startYear,
      endYear;

  late String? experience;

  CreateExperienceRequest(
      {required this.indexWidget,
        required this.companyName,
        required this.profession,
        required this.industry,
        this.experience,
        required this.startMonth,
        required this.endMonth,
        required this.startYear,
        required this.endYear});

  Map<String, dynamic> toMap() => {
    "companyName": companyName,
    "position": profession,
    "industry": industry,
    "description": experience,
    "startMonth": DatePickerUtil.getMonthIntNumber(startMonth),
    "tillMonth": DatePickerUtil.getMonthIntNumber(endMonth),
    "startYear": startYear,
    "tillYear": endYear
  };
}

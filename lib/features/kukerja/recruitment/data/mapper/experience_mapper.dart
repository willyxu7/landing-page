import 'package:kukerja_web/features/kukerja/recruitment/domain/entities/experience.dart';

class ExperienceMapper {
  static Experience mapEmployeeExperienceJsonToExperience(
      var employeeExperienceJson) {
    return Experience(
        position: employeeExperienceJson['position'].toString(),
        companyName: employeeExperienceJson['companyName'].toString(),
        industry: employeeExperienceJson['industry'].toString(),
        description: employeeExperienceJson['description'].toString(),
        startMonth: employeeExperienceJson['startMonth'].toString(),
        tillMonth: employeeExperienceJson['tillMonth'].toString(),
        startYear: employeeExperienceJson['startYear'].toString(),
        tillYear: employeeExperienceJson['tillYear'].toString());
  }
}

import 'package:kukerja_web/features/kukerja/recruitment/domain/entities/experience.dart';

import 'education.dart';

class Employee {
  late final String id;
  late final String name;
  late final String imageProfileUrl;
  late final List<Experience>? experiences;
  late final List<Education>? educations;
  late final DateTime? birthDate;

  Employee({
    required this.id,
    required this.name,
    required this.imageProfileUrl,
    this.experiences,
    this.educations,
    this.birthDate,
  });

  String get lastExperience {
    String lastExperience = '';

    for (Experience experience in experiences!) {
      if (experience.tillYear != null) {
        experiences?.sort((a, b) => a.tillYear!.compareTo(b.tillYear!));
        lastExperience =
            '${experiences!.last.position} at ${experiences!.last.companyName}';
      } else {
        lastExperience =
            '${experiences![0].position} at ${experiences!.last.companyName}';
      }
    }

    return lastExperience;
  }

  int get age {
    DateTime currentDate = DateTime.now();
    int age = currentDate.year - birthDate!.year;
    int month1 = currentDate.month;
    int month2 = birthDate!.month;
    if (month2 > month1) {
      age--;
    } else if (month1 == month2) {
      int day1 = currentDate.day;
      int day2 = birthDate!.day;
      if (day2 > day1) {
        age--;
      }
    }

    return age;
  }
}

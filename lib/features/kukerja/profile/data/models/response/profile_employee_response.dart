import 'package:flutter/cupertino.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/entities/education.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/entities/employee.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/entities/experience.dart';

class ProfileEmployeeResponse extends Employee with ChangeNotifier {
  late String link;

  ProfileEmployeeResponse({
    required id,
    required imageProfileUrl,
    required name,
    required experiences,
    required educations,
    required birthDate,
    required this.link,
  }) : super(
          id: id,
          imageProfileUrl: imageProfileUrl,
          name: name,
          experiences: experiences,
          educations: educations,
          birthDate: birthDate,
        );

  factory ProfileEmployeeResponse.fromMap(Map<String, dynamic> employee) {
    return ProfileEmployeeResponse(
        id: employee['userId'],
        imageProfileUrl: employee['image_url'],
        name: employee['name'],
        experiences: Experience.listFromMap(employee['experience']),
        educations: Education.listFromMap(employee['education'])
            .where((education) => education.isCourse == false)
            .toList(),
        birthDate: DateTime.parse(
          employee['birthDate'],
        ),
        link: employee['link']);
  }

  static List<ProfileEmployeeResponse> listFromMap(List<dynamic> employees) {
    try {
      List<ProfileEmployeeResponse> profileEmployeeResponses = [];

      for (int i = 0; i < employees.length; i++) {
        profileEmployeeResponses
            .add(ProfileEmployeeResponse.fromMap(employees[i]));
      }

      return profileEmployeeResponses;
    } catch (exception) {
      rethrow;
    }
  }
}

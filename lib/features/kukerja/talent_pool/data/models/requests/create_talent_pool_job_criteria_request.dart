import 'dart:convert';

class CreateTalentPoolJobCriteriaRequest {
  late String userId;
  late String phoneNumber;
  late List<String> platforms;
  late List<String> industries;
  late String currentWorkingHours;
  late String currentStudyHours;
  late String typeJob;
  late bool isReadyIntern;
  late String locationType;
  late String? mileage;
  late bool isHaveVehicle;
  late List<String> driverLicenses;
  late bool isVaccinated;
  late bool isHaveSkck;
  late List<String> roles;
  late List<String>? experienceAttachments;

  CreateTalentPoolJobCriteriaRequest({
    required this.userId,
    required this.phoneNumber,
    required this.platforms,
    required this.industries,
    required this.currentWorkingHours,
    required this.currentStudyHours,
    required this.typeJob,
    required this.isReadyIntern,
    required this.locationType,
    this.mileage,
    required this.isHaveVehicle,
    required this.driverLicenses,
    required this.isVaccinated,
    required this.isHaveSkck,
    required this.roles,
    this.experienceAttachments,
  });

  Map<String, dynamic> toMap() => {
        "userId": userId,
        "phonenumber": phoneNumber,
        "platforms": platforms,
        "industries": industries,
        "currentWorkingHours": currentWorkingHours,
        "currentStudyHours": currentStudyHours,
        "typeJob": typeJob,
        "internship": isReadyIntern,
        "locationType": locationType,
        "vehicle": isHaveVehicle,
        "driverLicenses": driverLicenses,
        "vaccine": isVaccinated,
        "skck": isHaveSkck,
        "roles": roles,
        "experienceAttachments": experienceAttachments
      };

  String toJson() => jsonEncode(toMap());

}

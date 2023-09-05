import 'dart:convert';

class CreateEmployerInformationRequest {
  late String type;
  late String companyName;
  late String companyEmail;
  late String companyAddress;
  late String phoneNumber;
  late String city;
  late String industry;

  CreateEmployerInformationRequest({
    required this.type,
    required this.companyName,
    required this.companyEmail,
    required this.companyAddress,
    required this.phoneNumber,
    required this.city,
    required this.industry,
  });

  Map<String, dynamic> toMap() => {
        "type": type,
        "name": companyName,
        "email": companyEmail,
        "address": companyAddress,
        "phonenumber": phoneNumber,
        "city": city,
        "industry": industry
      };

  String toJson() => jsonEncode(toMap());
}

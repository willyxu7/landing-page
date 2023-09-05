import 'dart:convert';

class CheckCompanyInformationRequest {
  String companyName;
  String phoneNumber;
  String email;

  CheckCompanyInformationRequest(
      {required this.companyName,
      required this.phoneNumber,
      required this.email});

  Map<String, dynamic> toMap() {
    return {
      "name": companyName,
      "phonenumber": phoneNumber,
      "email": email
    };
  }

  String toJson() => jsonEncode(toMap());

  // email,
  // phonenumber,
  // idToken,
  // type,
  // name,
  // gender,
  // status,
  // religion,
  // birthDate,
  // city,
  // industry,
  // interest,
  // education,
  // experience,
  // currentJob,
  // imageUrl,
  // idCardUrl,
  // idCard,
  // address,
  // tagline,
  // establish,
  // description,
  // employerType,
  // businessImages,

}

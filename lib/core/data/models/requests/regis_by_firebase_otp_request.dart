import 'dart:convert';

class RegisByFirebaseOtpRequest {
  late String idToken;
  late String phoneNumber;
  late String referralBy;
  late bool isWeb;

  RegisByFirebaseOtpRequest({
    required this.idToken,
    required this.phoneNumber,
    required this.referralBy,
    this.isWeb = true,
  });

  Map<String, dynamic> toMap() => {
        "idToken": idToken,
        "phonenumber": phoneNumber,
        "referralBy": referralBy,
        "isWeb": isWeb
      };

  String toJson() => jsonEncode(toMap());
}

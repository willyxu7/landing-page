import 'dart:convert';

class LoginByFirebaseOtpRequest {
  late String phoneNumber;
  late String idToken;
  late String type;

  LoginByFirebaseOtpRequest(
      {required this.phoneNumber, required this.idToken, required this.type});

  Map<String, dynamic> toMap() => {
    "phonenumber": phoneNumber,
    "idToken": idToken,
    "type": type
  };

  String toJson() => jsonEncode(toMap());
}

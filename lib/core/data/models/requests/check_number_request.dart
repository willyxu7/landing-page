import 'dart:convert';

class CheckNumberRequest {

  late String phoneNumber, type;

  CheckNumberRequest({required this.phoneNumber, required this.type});

  Map<String, dynamic> toMap() => {
    "type": type,
    "phonenumber": phoneNumber
  };

  String toJson() => jsonEncode(toMap());

}
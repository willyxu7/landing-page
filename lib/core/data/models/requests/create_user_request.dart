import 'dart:convert';

import '../../../domain/entities/user.dart';

class CreateUserRequest extends User {
  late String _phoneCountryCode;

  CreateUserRequest();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'city': city
    };
  }

  String get phoneCountryCode => _phoneCountryCode;

  set phoneCountryCode(String value) {
    _phoneCountryCode = value;
  }

  @override
  String get phoneNumber => _phoneCountryCode + super.phoneNumber;

  String toJson() => jsonEncode(toMap());

  @override
  List<Object?> get props =>
      [id, name, email, _phoneCountryCode, phoneNumber, city];
}

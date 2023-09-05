import '../../../domain/entities/user.dart';

class UserResponse {
  String id;
  String name;
  String phoneNumber;
  String city;

  UserResponse(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.city});

  factory UserResponse.fromHttpRequest(Map<String, dynamic> response) {
    if (response["type"] == "Employer") {
      var employer = response["profile_employer"];
      return UserResponse(
          id: response["_id"] ?? "",
          name: employer["name"] ?? "",
          phoneNumber: response["phonenumber"] ?? "",
          city: employer["city"] ?? "");
    } else {
      var employee = response["profile_employee"];
      return UserResponse(
          id: response["_id"] ?? "",
          name: employee["name"] ?? "",
          phoneNumber: response["phonenumber"] ?? "",
          city: employee["city"] ?? "");
    }
  }

  static User mapUserResponseToUser(UserResponse userResponse) => User()
    ..id = userResponse.id
    ..name = userResponse.name
    ..email = ""
    ..phoneNumber = userResponse.phoneNumber
    ..city = userResponse.city;
}

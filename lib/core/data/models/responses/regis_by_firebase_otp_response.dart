class RegisByFirebaseOtpResponse {
  late String id;
  late String accessToken;
  late String expiresIn;
  late String phoneNumber;
  late String refreshToken;

  RegisByFirebaseOtpResponse(
      {required this.id,
      required this.accessToken,
      required this.expiresIn,
      required this.phoneNumber,
      required this.refreshToken});

  factory RegisByFirebaseOtpResponse.fromMap(Map<String, dynamic> response) =>
      RegisByFirebaseOtpResponse(
          id: response["id"],
          accessToken: response["accessToken"],
          expiresIn: response["expiresIn"],
          phoneNumber: response["phonenumber"],
          refreshToken: response["refreshToken"]);
}

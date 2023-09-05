class LoginByFirebaseOtpResponse {
  late String userId, accessToken, refreshToken, expiresIn, phoneNumber;

  LoginByFirebaseOtpResponse({required this.userId,
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.phoneNumber});

  factory LoginByFirebaseOtpResponse.fromHttpRequest(
      Map<String, dynamic> response) =>
      LoginByFirebaseOtpResponse(userId: response["id"],
          accessToken: response["accessToken"],
          refreshToken: response["refreshToken"],
          expiresIn: response["expiresIn"],
          phoneNumber: response["phonenumber"]);

}

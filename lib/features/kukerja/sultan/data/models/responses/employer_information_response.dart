class EmployerInformationResponse {
  late String id = "";
  late String phoneNumber = "";

  EmployerInformationResponse({required this.id, required this.phoneNumber});

  factory EmployerInformationResponse.fromMap(Map<String, dynamic> response) =>
      EmployerInformationResponse(
          id: response["id"], phoneNumber: response["phonenumber"]);
}

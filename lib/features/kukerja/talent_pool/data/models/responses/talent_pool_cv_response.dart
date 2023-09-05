class TalentPoolCVResponse {
  late String id = "";
  late String phoneNumber = "";

  TalentPoolCVResponse({required this.id, required this.phoneNumber});

  factory TalentPoolCVResponse.fromMap(Map<String, dynamic> response) =>
      TalentPoolCVResponse(
          id: response["id"], phoneNumber: response["phonenumber"]);
}

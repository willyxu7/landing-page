class TalentPoolJobCriteriaResponse {
  late String id;
  late String phoneNumber;

  TalentPoolJobCriteriaResponse({required this.id, required this.phoneNumber});

  factory TalentPoolJobCriteriaResponse.fromMap(
          Map<String, dynamic> response) =>
      TalentPoolJobCriteriaResponse(
          id: response["_id"], phoneNumber: response["phonenumber"]);
}

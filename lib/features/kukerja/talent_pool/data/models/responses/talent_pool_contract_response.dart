class TalentPoolContractResponse {
  late bool error;

  TalentPoolContractResponse({required this.error});

  factory TalentPoolContractResponse.fromMap(Map<String, dynamic> response) =>
      TalentPoolContractResponse(error: response["error"]);

}

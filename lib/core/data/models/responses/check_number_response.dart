class CheckNumberResponse {
  late bool isDuplicate, isSameType;

  CheckNumberResponse({required this.isDuplicate, required this.isSameType});

  factory CheckNumberResponse.fromHttpRequest(Map<String, dynamic> response) =>
      CheckNumberResponse(
          isDuplicate: response["isDuplicate"],
          isSameType: response["isSameType"]);
}

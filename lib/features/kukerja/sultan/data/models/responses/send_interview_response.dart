class SendInterviewResponse {
  late String id;
  late String jobId;

  SendInterviewResponse({required this.id, required this.jobId});

  factory SendInterviewResponse.fromHttpRequest(
          Map<String, dynamic> response) =>
      SendInterviewResponse(id: response["_id"], jobId: response["jobId"]);
}

class ProfessionDataResponse {
  late String name;
  late String id;

  ProfessionDataResponse({required this.name, required this.id});

  factory ProfessionDataResponse.fromMap(Map<String, dynamic> response) =>
      ProfessionDataResponse(name: response["name"], id: response["id"]);
}

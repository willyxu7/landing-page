class ProfessionResponse {
  final List<String> professions;

  ProfessionResponse({required this.professions});

  factory ProfessionResponse.fromMap(Map<String, dynamic> response) {
    return ProfessionResponse(professions: List<String>.from(response["list"]));
  }

}
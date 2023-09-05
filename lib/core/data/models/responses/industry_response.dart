class IndustryResponse {
  final List<String> industries;

  IndustryResponse({required this.industries});

  factory IndustryResponse.fromMap(Map<String, dynamic> response) {
    return IndustryResponse(industries: List<String>.from(response["data"]));
  }
}
class CityResponse {
  final String id, name;

  CityResponse({required this.id, required this.name});

  factory CityResponse.fromMap(Map<String, dynamic> response) {
    return CityResponse(id: response['id'], name: response['name']);
  }

  static List<CityResponse> listFromMap(List<dynamic> cities) {
    return cities.map((city) => CityResponse.fromMap(city)).toList();
  }
}

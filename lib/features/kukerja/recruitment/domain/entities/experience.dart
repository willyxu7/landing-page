class Experience {
  late final String companyName;
  late final String position;
  late String? industry;
  late String? description;
  late String? startMonth;
  late String? tillMonth;
  late String? startYear;
  late String? tillYear;

  Experience(
      {required this.companyName,
      required this.position,
      this.industry,
      this.description,
      this.startMonth,
      this.tillMonth,
      this.startYear,
      this.tillYear});

  factory Experience.fromMap(Map<String, dynamic> responseData) {
    return Experience(
      companyName: responseData['companyName'].toString(),
      position: responseData['position'].toString(),
      industry: responseData['industry'].toString(),
      description: responseData['description'].toString(),
      startMonth: responseData['startMonth'].toString(),
      tillMonth: responseData['tillMonth'].toString(),
      startYear: responseData['startYear'].toString(),
      tillYear: responseData['tillYear'].toString(),
    );
  }

  static List<Experience> listFromMap(List<dynamic> experiences) {
    return experiences
        .map((experience) => Experience.fromMap(experience))
        .toList();
  }
}

class Education {
  late String place;
  late String? image;
  late String? description;
  late String? prodi;
  late String level;
  late bool isCurrentEdu;
  late bool isCourse;
  late String startYear;
  late String tillYear;

  Education(
      {required this.place,
      this.image,
      this.description,
      this.prodi,
      required this.level,
      required this.isCurrentEdu,
      required this.isCourse,
      required this.startYear,
      required this.tillYear});

  factory Education.fromMap(Map<String, dynamic> responseData) {
    return Education(
        place: responseData['place'],
        level: responseData['level'],
        isCurrentEdu: responseData['isCurrentEdu'],
        isCourse: responseData['isCourse'],
        startYear: responseData['startYear'].toString(),
        tillYear: responseData['tillYear'].toString());
  }

  static List<Education> listFromMap(List<dynamic> educations) {
    return educations.map((education) => Education.fromMap(education)).toList();
  }
}

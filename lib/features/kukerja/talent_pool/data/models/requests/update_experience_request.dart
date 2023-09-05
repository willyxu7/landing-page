class UpdateExperienceRequest {
  late String companyName,
      profession,
      industry,
      startMonth,
      endMonth,
      startYear,
      endYear;

  late String? experience;

  UpdateExperienceRequest(
      {required this.companyName,
      required this.profession,
      required this.industry,
      this.experience,
      required this.startMonth,
      required this.endMonth,
      required this.startYear,
      required this.endYear});
}

class CheckCompanyInformationResponse {

  bool isCompanyNameDuplicate;
  bool isEmailDuplicate;
  bool isPhoneNumberDuplicate;

  CheckCompanyInformationResponse(
      {required this.isCompanyNameDuplicate,
      required this.isEmailDuplicate,
      required this.isPhoneNumberDuplicate});

  factory CheckCompanyInformationResponse.fromJson(Map<String, dynamic> json) {
    return CheckCompanyInformationResponse(
        isCompanyNameDuplicate: json['nameIsDuplicate'],
        isEmailDuplicate: json['emailIsDuplicate'],
        isPhoneNumberDuplicate: json['phonenumberIsDuplicate']);
  }

}

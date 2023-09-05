class CreateJobSeekerResponse {
  late String id, name, phoneNumber, imageUrl;

  CreateJobSeekerResponse(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.imageUrl});

  factory CreateJobSeekerResponse.fromHttpRequest(
          Map<String, dynamic> response) =>
      CreateJobSeekerResponse(
          id: response["id"],
          name: response["profile_employee"]["name"],
          phoneNumber: response["phonenumber"],
          imageUrl: response["profile_employee"]["image_url"]);
}

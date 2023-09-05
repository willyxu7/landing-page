class CreateEmployerResponse {
  late String id, name, phoneNumber, imageUrl;

  CreateEmployerResponse(
      {required this.id,
      required this.name,
      required this.phoneNumber,
      required this.imageUrl});

  factory CreateEmployerResponse.fromHttpRequest(
          Map<String, dynamic> response) =>
      CreateEmployerResponse(
          id: response["id"],
          name: response["profile_employer"]["name"],
          phoneNumber: response["phonenumber"],
          imageUrl: response["profile_employer"]["image_url"]);
}

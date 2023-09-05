import 'dart:convert';
import 'dart:typed_data';

class CreateEmployerRequest {
  late Uint8List outdoorImageUrl;

  late DateTime established;

  late String name,
      email,
      industry,
      position,
      address,
      shortInformation,
      city,
      phoneNumber,
      type;

  late List<String> businessImages;

  CreateEmployerRequest(
      {required this.name,
      required this.email,
      required this.industry,
      required this.established,
      required this.position,
      required this.address,
      required this.shortInformation,
      required this.city,
      required this.phoneNumber,
      required this.type,
      required this.outdoorImageUrl,
      required this.businessImages});

  Map<String, dynamic> toMap() => {
        "name": name,
        "email": email,
        "address": address,
        "establish": established.toIso8601String(),
        "description": shortInformation,
        "employerType": position,
        "businessImages": businessImages,
        "city": city,
        "phonenumber": phoneNumber,
        "type": type,
        "industry": industry,
        "outdoorImageUrl": base64Encode(outdoorImageUrl),
      };

  String toJson() => jsonEncode(toMap());

  @override
  String toString() {
    return 'CreateEmployerRequest{outdoorImageUrl: $outdoorImageUrl, established: $established, name: $name, email: $email, industry: $industry, position: $position, address: $address, shortInformation: $shortInformation, city: $city, phoneNumber: $phoneNumber, type: $type, businessImages: $businessImages}';
  }
}

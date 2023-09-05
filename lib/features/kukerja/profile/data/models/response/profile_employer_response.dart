import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:kukerja_web/features/kukerja/profile/data/models/response/coordinates.dart';

class ProfileEmployerResponse with ChangeNotifier {
  String? address;
  String? imageUrl;
  String? name;
  String? tagline;
  String? industry;
  String? description;
  String? establish;
  String? city;
  String? employerType;
  String? outdoorImageUrl;
  Coordinates? coordinates;
  List<dynamic>? businessImages;

  ProfileEmployerResponse({
    this.address,
    this.imageUrl,
    this.name,
    this.tagline,
    this.industry,
    this.description,
    this.establish,
    this.city,
    this.employerType,
    this.outdoorImageUrl,
    this.coordinates,
    this.businessImages,
  });

  Map<String, dynamic> toMap() {
    return {
      'address': address,
      'image_url': imageUrl,
      'name': name,
      'tagline': tagline,
      'industry': industry,
      'description': description,
      'establish': establish,
      'city': city,
      'employer_type': employerType,
      'outdoor_image_url': outdoorImageUrl,
      'coordinates': coordinates?.toMap(),
      'businessImages': businessImages,
    };
  }

  factory ProfileEmployerResponse.fromMap(Map<String, dynamic> map) {
    return ProfileEmployerResponse(
      address: map['address'],
      imageUrl: map['image_url'],
      name: map['name'],
      tagline: map['tagline'],
      industry: map['industry'],
      description: map['description'],
      establish: map['establish'],
      city: map['city'],
      employerType: map['employer_type'],
      outdoorImageUrl: map['outdoor_image_url'],
      coordinates: Coordinates.fromMap(map['coordinates']),
      businessImages: List<dynamic>.from(map['businessImages']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileEmployerResponse.fromJson(String source) =>
      ProfileEmployerResponse.fromMap(json.decode(source));
}

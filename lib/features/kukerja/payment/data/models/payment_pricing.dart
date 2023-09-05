import 'dart:convert';

import 'package:flutter/material.dart';

class EventDetail with ChangeNotifier {
  final String? location;
  final String? city;
  final String? description;
  final DateTime? startSaleDate;
  final DateTime? endSaleDate;
  final DateTime? startEventDate;
  final DateTime? endEventDate;
  final bool? isOnlineEvent;
  final String? imageUrl;
  final String? note;
  final String? videoUrl;

  EventDetail({
    this.location,
    this.city,
    this.description,
    this.startSaleDate,
    this.endSaleDate,
    this.startEventDate,
    this.endEventDate,
    this.isOnlineEvent = false,
    this.imageUrl,
    this.note,
    this.videoUrl,
  });

  Map<String, dynamic> toMap() {
    return {
      'location': location,
      'city': city,
      'description': description,
      'startSaleDate': startSaleDate?.millisecondsSinceEpoch,
      'endSaleDate': endSaleDate?.millisecondsSinceEpoch,
      'startEventDate': startEventDate?.millisecondsSinceEpoch,
      'endEventDate': endEventDate?.millisecondsSinceEpoch,
      'isOnlineEvent': isOnlineEvent,
      'imageUrl': imageUrl,
      'note': note,
      'videoUrl': videoUrl,
    };
  }

  factory EventDetail.fromMap(Map<String, dynamic> map) {
    return EventDetail(
      imageUrl: map['imageUrl'],
      location: map['location'],
      city: map['city'],
      description: map['description'],
      isOnlineEvent: map['isOnlineEvent'],
      note: map['note'],
      startSaleDate: map['startSaleDate'] != null
          ? DateTime.parse(map['startSaleDate'])
          : null,
      endSaleDate: map['endSaleDate'] != null
          ? DateTime.parse(map['endSaleDate'])
          : null,
      startEventDate: map['startEventDate'] != null
          ? DateTime.parse(map['startEventDate'])
          : null,
      endEventDate: map['endEventDate'] != null
          ? DateTime.parse(map['endEventDate'])
          : null,
      videoUrl: map['videoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EventDetail.fromJson(String source) =>
      EventDetail.fromMap(json.decode(source));
}

class Pricing with ChangeNotifier {
  final String? id;
  final int? quantity;
  final int? actualPrice;
  final int? offerPrice;
  final List<dynamic>? specialPriceList;
  final int? price;
  final String? name;
  final String? category;
  final String? type;
  final String? charge;
  final Map<String, dynamic>? feature;
  final Map<String, dynamic>? duration;
  final EventDetail? eventDetail;

  Pricing({
    this.id,
    this.quantity,
    this.actualPrice,
    this.offerPrice,
    this.specialPriceList,
    this.price,
    this.name,
    this.category,
    this.type,
    this.charge,
    this.feature,
    this.duration,
    this.eventDetail,
  });

  factory Pricing.fromMap(Map<String, dynamic> json) {
    return Pricing(
      category: json['category'],
      charge: json['charge'],
      id: json['_id'],
      name: json['name'],
      price: json['price'],
      actualPrice: json['actualPrice'],
      offerPrice: json['offerPrice'],
      specialPriceList: json['specialPriceList'],
      quantity: json['quantity'],
      type: json['type'],
      feature: json['feature'],
      eventDetail: json['eventDetail'] != null
          ? EventDetail.fromMap(json['eventDetail'])
          : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'quantity': quantity,
      'actualPrice': actualPrice,
      'offerPrice': offerPrice,
      'specialPriceList': specialPriceList,
      'price': price,
      'name': name,
      'category': category,
      'type': type,
      'charge': charge,
      'feature': feature,
      'duration': duration,
      'eventDetail': eventDetail?.toMap(),
    };
  }

  String toJson() => json.encode(toMap());

  factory Pricing.fromJson(String source) =>
      Pricing.fromMap(json.decode(source));
}

class Pricings with ChangeNotifier {
  final List<Pricing>? pricings;
  Pricings([this.pricings]);

  factory Pricings.fromJson(Map<String, dynamic> json) {
    var objsJson = json['data'] as List;
    List<Pricing> pricings = objsJson.map((e) => Pricing.fromMap(e)).toList();
    return Pricings(pricings);
  }
}

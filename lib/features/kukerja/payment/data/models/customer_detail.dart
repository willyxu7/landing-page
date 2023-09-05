import 'dart:convert';

import 'package:flutter/material.dart';

class CustomerDetail with ChangeNotifier {
  String name;
  String phonenumber;
  String email;
  int quantity;

  CustomerDetail({
    required this.name,
    required this.phonenumber,
    required this.email,
    required this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'first_name': name,
      'phone': phonenumber,
      'email': email,
      'quantity': quantity,
    };
  }

  factory CustomerDetail.fromMap(Map<String, dynamic> map) {
    return CustomerDetail(
      name: map['first_name'] ?? '',
      phonenumber: map['phone'] ?? '',
      email: map['email'] ?? '',
      quantity: map['quantity'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomerDetail.fromJson(String source) =>
      CustomerDetail.fromMap(json.decode(source));
}

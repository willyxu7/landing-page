import 'dart:convert';

import 'package:flutter/foundation.dart';

class JobDetailsRequest with ChangeNotifier {
  final String id;

  JobDetailsRequest({
    required this.id,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory JobDetailsRequest.fromMap(Map<String, dynamic> map) {
    return JobDetailsRequest(
      id: map['id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory JobDetailsRequest.fromJson(String source) =>
      JobDetailsRequest.fromMap(json.decode(source));
}

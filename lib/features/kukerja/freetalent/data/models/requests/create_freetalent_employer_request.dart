import 'dart:convert';

import 'package:kukerja_web/core/data/models/requests/create_user_request.dart';

class CreateFreetalentEmployerRequest {
  CreateUserRequest createUserRequest;

  String description,
      address,
      scheduleNote,
      startWorkingHour,
      endWorkingHour,
      workingTime;
  String role;
  List<String> workingDays;

  CreateFreetalentEmployerRequest({
    required this.createUserRequest,
    required this.address,
    required this.description,
    required this.endWorkingHour,
    required this.role,
    required this.scheduleNote,
    required this.startWorkingHour,
    required this.workingTime,
    required this.workingDays
  });

  Map<String, dynamic> toMap() {
    return {
      'name': createUserRequest.name,
      'phonenumber': createUserRequest.phoneNumber,
      'email': createUserRequest.email,
      'city': createUserRequest.city,
      'address': address,
      'description': description,
      'onDemandRole': role,
      'scheduleNote': scheduleNote,
      'workingDays': workingDays,
      'workingHours': addWorkingHours(),
      'workingTime': workingTime
    };
  }

  String toJson() => jsonEncode(toMap());

  String concatWorkingHour(String startWorkingHour, String endWorkingHour) =>
      "$startWorkingHour-$endWorkingHour";

  List<String> addWorkingHours() {
    List<String> workingHours = [];
    workingHours.add(concatWorkingHour(startWorkingHour, endWorkingHour));

    return workingHours;
  }
}

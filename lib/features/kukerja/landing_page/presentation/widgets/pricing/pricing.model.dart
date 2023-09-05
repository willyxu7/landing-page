
import 'package:flutter/material.dart';

class Benefit {
  Icon fileLocation;
  String title;
  Benefit({
    required this.fileLocation,
    required this.title,
  });
}

class Course {
  String fileLocation;
  String title;
  String description;
  String level;
  String prePrice;
  String finalPrice;
  List<Benefit> benefits;
  Course({
    required this.fileLocation,
    required this.title,
    required this.description,
    required this.level,
    required this.prePrice,
    required this.finalPrice,
    required this.benefits,
  });
}

class Section {
  String title;
  String category;
  String description;
  List<Course> courses;
  Section({
    required this.title,
    required this.category,
    required this.description,
    required this.courses,
  });
}
import 'package:flutter/material.dart';

import '../../data/models/request/ask_for_worker_request.dart';
import '../../domain/usecases/ask_for_worker_use_case.dart';

class AskForWorkerProvider with ChangeNotifier {
  late String selectedGender,
      selectedAge,
      selectedEducationQualification,
      selectedLocation;

  final AskForWorkerUseCase _askForWorkerUseCase = AskForWorkerUseCase();

  late List<String> _cities = [];
  final List<String> _industries = ['Food & Beverage', 'Startup'];
  final List<String> _genders = ['Pria', 'Wanita', 'Pria&Wanita'];
  final List<String> _ages = ['Max 35 tahun', 'Max 40 tahun', 'Bebas'];
  final List<String> _educationQualifications = [
    'Min. SMA',
    'Min. Diploma',
    'Bebas'
  ];

  List<String> get industries => _industries;

  List<String> get cities => _cities;

  List<String> get genders => _genders;

  List<String> get ages => _ages;

  List<String> get educationQualifications => _educationQualifications;

  void setCities(List<String> cities) {
    _cities = cities;
    // isLoading = false;
    notifyListeners();
  }

  void setSelectedGender(String selectedGender) {
    this.selectedGender = selectedGender;
    notifyListeners();
  }

  void setSelectedAge(String selectedAge) {
    this.selectedAge = selectedAge;
    notifyListeners();
  }

  void setSelectedEducationQualification(
      String selectedEducationQualification) {
    this.selectedEducationQualification = selectedEducationQualification;
    notifyListeners();
  }

  void setSelectedLocation(String selectedLocation) {
    this.selectedLocation = selectedLocation;
    notifyListeners();
  }

  Future<void> postAskForWorker(AskForWorkerRequest askForWorkerRequest) async {
    await _askForWorkerUseCase.postAskForWorker(askForWorkerRequest);
  }

}

import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/applicant_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/usecases/applicant_use_case.dart';

class ApplicantProvider with ChangeNotifier {
  bool _isShowClaimBalance = true;
  bool _isLoading = true;
  ApplicantResponse applicant = ApplicantResponse();
  final ApplicantUseCase _applicantUseCase = ApplicantUseCase();
  late String _id = '';

  bool get isShowClaimBalance => _isShowClaimBalance;

  bool get isLoading => _isLoading;

  String get id => _id;

  set id(String id) {
    _id = id;
    notifyListeners();
  }

  void hideShowClaimBalance() {
    _isShowClaimBalance = false;
    notifyListeners();
  }

  void showClainBalance() {
    _isShowClaimBalance = true;
    notifyListeners();
  }

  void setNotLoading() {
    _isLoading = false;
  }

  Future<void> fetchApplicants(String id) async {
    applicant = await _applicantUseCase.getApplicants(id);
    setNotLoading();
    notifyListeners();
  }

}
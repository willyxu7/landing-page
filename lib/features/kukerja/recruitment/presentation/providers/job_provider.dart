import 'package:flutter/foundation.dart';
import 'package:kukerja_web/features/kukerja/recruitment/data/models/response/job_details_response.dart';
import 'package:kukerja_web/features/kukerja/recruitment/domain/usecases/job_details_use_case.dart';

class JobProvider with ChangeNotifier {
  JobDetailsResponse jobDetails = JobDetailsResponse();
  final JobDetailsUseCase _jobDetailsUseCase = JobDetailsUseCase();
  late String _id = '';
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future<void> fetchJobDetails(String id) async {
    setLoading(true);
    jobDetails = await _jobDetailsUseCase.getJobDetails(id);
    setLoading(false);
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
  }

  String get id => _id;

  set id(String id) {
    _id = id;
    notifyListeners();
  }
}

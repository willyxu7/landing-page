import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_extra_request.dart';

class ActivityRequest {
  final String type;
  final String? detail;
  final ActivityExtraRequest? extra;

  ActivityRequest({required this.type, this.detail, this.extra});
}

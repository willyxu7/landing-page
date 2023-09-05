import 'dart:convert';

import 'package:kukerja_web/features/kukerja/activity/data/models/requests/activity_request.dart';
import 'package:kukerja_web/features/kukerja/activity/data/models/responses/activity_response.dart';

import 'package:http/http.dart' as http;

import '../../../../../env/prod_env.dart';

class PostActivityUseCase {
  static Future<ActivityResponse> exec(ActivityRequest activityRequest) async {
    Map<String, dynamic> extra = mapExtra(activityRequest);

    var body = {
      'type': activityRequest.type,
      'detail': activityRequest.detail ?? '',
      'extra': json.encode(extra)
    };

    var response = await http.post(
        Uri.parse('${ProdEnv.apiURL}/management/logs/web/activity'),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
        },
        body: body);

    var jsonObject = json.decode(response.body);

    return ActivityResponse(isSuccess: jsonObject['success']);
  }

  static Map<String, dynamic> mapExtra(ActivityRequest activityRequest) {
    Map<String, dynamic> extra = {};

    if (activityRequest.extra?.state != null) extra['state'] = activityRequest.extra?.state;
    if (activityRequest.extra?.screen != null) extra['screen'] = activityRequest.extra?.screen;
    if (activityRequest.extra?.widget != null) extra['widget'] = activityRequest.extra?.widget;
    if (activityRequest.extra?.source != null) extra['source'] = activityRequest.extra?.source;
    if (activityRequest.extra?.userId != null) extra['userId'] = activityRequest.extra?.userId;

    return extra;
  }

}

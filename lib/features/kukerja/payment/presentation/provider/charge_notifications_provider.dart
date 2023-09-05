import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kukerja_web/env/prod_env.dart';
import 'package:kukerja_web/features/kukerja/payment/data/models/payment_charge.dart';
import 'dart:convert';

class ChargeNotificationProvider with ChangeNotifier {
  ChargeNotificationModel? _paymentNotification;
  ChargeNotificationModel? get paymentNotification => _paymentNotification;

  Future<ChargeNotificationModel> checkPayment(String orderId) async {
    final url =
        Uri.parse('${ProdEnv.apiURL}/management/paymentsSnap/checkPayment');

    final http.Response response = await http.patch(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'orderId': orderId,
        }));

    final responseData = json.decode(response.body);
    // print(responseData);
    if (response.statusCode == 200) {
      ChargeNotificationModel data =
          ChargeNotificationModel.fromMap(responseData['data']);
      return data;
    } else {
      throw Exception('Failed to load get Notif : $responseData');
    }
  }
}

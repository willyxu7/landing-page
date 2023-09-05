import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kukerja_web/features/kukerja/payment/data/models/customer_detail.dart';
import 'dart:convert';
import 'package:kukerja_web/features/kukerja/payment/data/models/payment_charge.dart';

import '../../../../../env/prod_env.dart';

class SnapChargeProvider with ChangeNotifier {
  ChargeModel? _chargeModel;
  CustomerDetail? _customerDetail;

  ChargeModel? get chargeModel => _chargeModel;
  CustomerDetail? get customerDetail => _customerDetail;

  Future<ChargeModel?> charge(String pricingId) async {
    // Map<String, dynamic> body = {"item_detais": itemDetails};
    final url =
        Uri.parse('${ProdEnv.apiURL}/management/paymentsSnap/chargeByWeb');
    final http.Response response = await http.post(url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          // "authorization": "Bearer $accessToken",
        },
        body: jsonEncode(<String, dynamic>{
          "pricingId": pricingId,
          "customer_details": _customerDetail?.toMap(),
        }));
    final data = json.decode(response.body);
    // print('DATA $data');
    // if (response.statusCode == 401) {
    //   checkIsUnAuth(401);
    // }
    if (response.statusCode == 200) {
      _chargeModel = ChargeModel.snapRedirecting(data['data']);
    } else {
      throw Exception('Failed to post ${response.body} ');
    }
    notifyListeners();
    return _chargeModel;
  }

  Future<Uint8List> getTicketPdf(String orderId) async {
    final url = Uri.parse(
        '${ProdEnv.apiURL}/management/paymentsSnap/getTicketPdf?orderId=$orderId');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        // "authorization": "Bearer $accessToken",
        'Content-Type': 'application/pdf; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to post ${response.body} ');
    }
  }

  Future<ChargeModel> payBill(String? code) async {
    // Map<String, dynamic> body = {"item_detais": itemDetails};
    final url = Uri.parse(
        '${ProdEnv.apiURL}/management/paymentsSnap/payBillByWeb/$code');
    final http.Response response =
        await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // "authorization": "Bearer $accessToken",
    });
    final data = json.decode(response.body);
    // print('DATA $data');
    // if (response.statusCode == 401) {
    //   checkIsUnAuth(401);
    // }
    if (response.statusCode == 200) {
      _chargeModel = ChargeModel.snapRedirecting(data['data']);
    } else {
      throw Exception('Failed to post ${response.body} ');
    }
    notifyListeners();
    return _chargeModel!;
  }

  Future<ChargeModel> getBill(String? code) async {
    // Map<String, dynamic> body = {"item_detais": itemDetails};
    final url = Uri.parse(
        '${ProdEnv.apiURL}/management/paymentsSnap/getBillByWeb/$code');
    final http.Response response =
        await http.get(url, headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      // "authorization": "Bearer $accessToken",
    });
    final data = json.decode(response.body);
    // print('DATA $data');
    // if (response.statusCode == 401) {
    //   checkIsUnAuth(401);
    // }
    if (response.statusCode == 200) {
      _chargeModel = ChargeModel.billingFromJson(data);
    } else {
      throw Exception('Failed to post ${response.body} ');
    }
    notifyListeners();
    return _chargeModel!;
  }

  Future<Uint8List> getBillPdf(String code) async {
    final url = Uri.parse(
        '${ProdEnv.apiURL}/management/paymentsSnap/getBillPdf?code=$code');
    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        // "authorization": "Bearer $accessToken",
        'Content-Type': 'application/pdf; charset=UTF-8',
      },
    );
    if (response.statusCode == 200) {
      return response.bodyBytes;
    } else {
      throw Exception('Failed to post ${response.body} ');
    }
  }

  void setCustomerDetails(CustomerDetail value) {
    _customerDetail = value;
    notifyListeners();
  }
}

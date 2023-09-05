import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kukerja_web/env/prod_env.dart';
import 'package:kukerja_web/features/kukerja/payment/data/models/payment_pricing.dart';
import 'package:http/http.dart' as http;

class PricingProvider with ChangeNotifier {
  Pricing? tempPricing;
  List<Pricing>? dataList;
  List<Pricing>? listPricing = [];
  List<bool> listSpecialPricing = [];

  Future<List<Pricing>?> getPricings() async {
    final url = Uri.parse('${ProdEnv.apiURL}/management/pricings/list');

    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // "authorization": "Bearer $accessToken",
      },
    );

    final data = json.decode(response.body);
    // print(response.body);
    if (response.statusCode == 200) {
      // print(data);
      listPricing = Pricings.fromJson(data).pricings;
      // print(listPricing?.toList());
      notifyListeners();
      return listPricing;
    } else {
      throw Exception(
          'Failed to load subscribe : ${jsonEncode(response.body)}');
    }
  }

  Future<Pricing> getPricingDetail(String id) async {
    final url = Uri.parse('${ProdEnv.apiURL}/management/pricings/detail/$id');

    final http.Response response = await http.get(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        // "authorization": "Bearer $accessToken",
      },
    );

    final responseData = json.decode(response.body);
    // print('GET DETAIL ${response.body}');
    if (response.statusCode == 200) {
      final pricingDetail = Pricing.fromMap(responseData['data']);
      return pricingDetail;
    } else {
      throw Exception(
          'Failed to load subscribe : ${jsonEncode(response.body)}');
    }
  }
}

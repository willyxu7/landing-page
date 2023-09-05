import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:kukerja_web/features/kukerja/profile/data/models/response/profile_employer_response.dart';

class ChargeModel with ChangeNotifier {
  final String? url,
      message,
      transactionStatus,
      paymentId,
      orderId,
      token,
      paymentType;
  final ChargeNotificationModel? itemDetails;
  final bool? error;
  final ProfileEmployerResponse? employer;

  ChargeModel({
    this.itemDetails,
    this.paymentType,
    this.paymentId,
    this.token,
    this.orderId,
    this.url,
    this.transactionStatus,
    this.message,
    this.error,
    this.employer,
  });
  factory ChargeModel.fromJson(Map<String, dynamic> json) {
    return ChargeModel(
      transactionStatus: json['transaction_status'],
    );
  }

  factory ChargeModel.error(Map<String, dynamic> json) {
    return ChargeModel(error: json['error'], message: json['message']);
  }

  factory ChargeModel.billingFromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return ChargeModel(
      employer: data['user'] != null
          ? data['user']['type'] == 'Employer'
              ? ProfileEmployerResponse.fromMap(
                  data['user']['profile_employer'])
              : null
          : null,
      orderId: data!['orderId'],
      itemDetails: data['payment'] != null
          ? ChargeNotificationModel.fromMap(data['payment'])
          : null,
    );
  }

  factory ChargeModel.snapRedirecting(Map<String, dynamic> json) {
    return ChargeModel(
      url: json['redirect_url'],
      token: json['token'],
    );
  }

  factory ChargeModel.redirecting(Map<String, dynamic> json) {
    return ChargeModel(
        url: json['redirect_url'],
        orderId: json['order_id'],
        paymentId: json['paymentId']);
  }

  factory ChargeModel.linkGopayFromJson(Map<String, dynamic> json) {
    return ChargeModel(
        message: json['message'], transactionStatus: json['transaction_id']);
  }

  factory ChargeModel.succesFromJson(Map<String, dynamic> json) {
    return ChargeModel(
      message: json['message'],
    );
  }
  factory ChargeModel.notifFromJson(Map<String, dynamic> json) {
    return ChargeModel(
      message: json['status_message'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (paymentType != null) {
      data['payment_type'] = paymentType;
    }
    if (itemDetails != null) {
      data['item_details'] = itemDetails;
    }
    return data;
  }
}

class ChargeNotificationModel {
  final String? paymentType;
  final int? nominal;
  final String? plan;
  final String? transactionTime;
  final String? status;

  ChargeNotificationModel({
    this.paymentType,
    this.nominal,
    this.plan,
    this.transactionTime,
    this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'payment_type': paymentType,
      'gross_amount': nominal,
      'plan': plan,
      'transaction_time': transactionTime,
      'status': status,
    };
  }

  factory ChargeNotificationModel.fromMap(Map<String, dynamic> json) {
    return ChargeNotificationModel(
      paymentType: json['payment_type'],
      nominal: json['nominal'],
      plan: json['plan'],
      transactionTime: json['transaction_time'],
      status: json['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ChargeNotificationModel.fromJson(String source) =>
      ChargeNotificationModel.fromMap(json.decode(source));
}

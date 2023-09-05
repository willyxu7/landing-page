import 'package:flutter/material.dart';
import 'package:kukerja_web/core/widgets/app_loading_widget.dart';
import 'package:kukerja_web/features/kukerja/payment/data/models/payment_charge.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/charge_notifications_provider.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/layout/payment_response.dart';
import 'package:provider/provider.dart';

class PaymentLoadingProgress extends StatefulWidget {
  static const String route = '/payment/MTSnapResponse';
  static const String route2 = '/payments/mtsf';

  const PaymentLoadingProgress({Key? key}) : super(key: key);

  @override
  State<PaymentLoadingProgress> createState() => _PaymentLoadingProgressState();
}

class _PaymentLoadingProgressState extends State<PaymentLoadingProgress> {
  Future<ChargeNotificationModel>? _future;
  String? _orderId;

  @override
  void initState() {
    super.initState();

    _orderId = Uri.base.queryParameters['order_id']!;

    _future = context.read<ChargeNotificationProvider>().checkPayment(_orderId!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, AsyncSnapshot<ChargeNotificationModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Scaffold(
            body: PaymentResponse(
              notification: snapshot.data,
              orderId: _orderId,
            ),
          );
        } else {
          return const AppLoadingWidget();
        }
      },
    );
  }
}

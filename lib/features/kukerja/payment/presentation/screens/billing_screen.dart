import 'package:flutter/material.dart';
import 'package:kukerja_web/core/widgets/app_loading_widget.dart';
import 'package:kukerja_web/features/kukerja/payment/data/models/payment_charge.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/layout/billing_response.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/snap_provider.dart';
import 'package:provider/provider.dart';

class BillingScreen extends StatefulWidget {
  static const String route = '/payment-bill';

  const BillingScreen({Key? key}) : super(key: key);

  @override
  State<BillingScreen> createState() => _BillingScreenState();
}

class _BillingScreenState extends State<BillingScreen> {
  Future<ChargeModel>? _future;
  String? _code;

  @override
  void initState() {
    super.initState();

    _code = Uri.base.queryParameters['code']!;

    _future = context.read<SnapChargeProvider>().getBill(_code!);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, AsyncSnapshot<ChargeModel?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          return Scaffold(
            body: BillingResponseLayout(
              notification: snapshot.data,
              code: _code,
            ),
          );
        } else {
          return const AppLoadingWidget();
        }
      },
    );
  }
}

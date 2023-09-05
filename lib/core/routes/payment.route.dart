import 'package:kukerja_web/features/kukerja/payment/presentation/screens/billing_screen.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/screens/loading_progress.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/screens/loading_snap_progress.dart';
import 'package:qlevar_router/qlevar_router.dart';

class PaymentRoute {
  // static List<GoRoute> routes() {
  //   return [
  //     GoRoute(
  //       name: 'payment/MTSnapResponse',
  //       path: PaymentLoadingProgress.route,
  //       builder: (context, state) => const PaymentLoadingProgress(),
  //     ),
  //     GoRoute(
  //       name: 'payments/mtsf',
  //       path: PaymentLoadingProgress.route2,
  //       builder: (context, state) => const PaymentLoadingProgress(),
  //     ),
  //     GoRoute(
  //       name: 'payment/midtransResponse',
  //       path: SnapPaymentLoadingProgress.route,
  //       builder: (context, state) => const SnapPaymentLoadingProgress(),
  //     ),
  //     GoRoute(
  //       name: 'payment-bill',
  //       path: BillingScreen.route,
  //       builder: (context, state) => const BillingScreen(),
  //     ),
  //   ];
  // }

  List<QRoute> routes() => [
        QRoute(
          name: "payment/MTSnapResponse",
          path: PaymentLoadingProgress.route,
          builder: () => const PaymentLoadingProgress(),
        ),
        QRoute(
          name: "payments/mtsf",
          path: PaymentLoadingProgress.route2,
          builder: () => const PaymentLoadingProgress(),
        ),
        QRoute(
          name: "payment/midtransResponse",
          path: SnapPaymentLoadingProgress.route,
          builder: () => const SnapPaymentLoadingProgress(),
        ),
        QRoute(
          name: "payment-bill",
          path: BillingScreen.route,
          builder: () => const BillingScreen(),
        ),
      ];
}

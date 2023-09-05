import 'package:qlevar_router/qlevar_router.dart';

import '../../features/kukerja/payment/presentation/layout/ticket_detail.dart';
import '../../features/kukerja/payment/presentation/screens/tickets_screen.dart';

class TicketRoute {
  // static List<GoRoute> routes() {
  //   return [
  //     GoRoute(
  //       name: 'tickets',
  //       path: TicketsScreen.route,
  //       builder: (context, state) => const TicketsScreen(),
  //     ),
  //     GoRoute(
  //       name: 'ticket-detail',
  //       path: TicketDetail.route,
  //       builder: (context, state) {
  //         Map<dynamic, Pricing>? object;
  //         if (state.extra != null) {
  //           object = state.extra as Map<dynamic, Pricing>;
  //         }
  //         return object != null
  //             ? ChangeNotifierProvider.value(
  //           value: object['pricing'],
  //           child: const TicketDetail(
  //             isOntap: true,
  //           ),
  //         )
  //             : const TicketDetail();
  //       },
  //     ),
  //   ];
  // }

  QRoute route() => QRoute(
    name: "tickets",
    path: TicketsScreen.route,
    builder: () => const TicketsScreen(),
    children: [
      QRoute(path: TicketDetail.route, builder: () => const TicketDetail())
    ],
  );
}
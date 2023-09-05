import 'package:kukerja_web/features/kukerja/sultan/presentation/screens/sultan_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SultanRoute {
  // static List<GoRoute> routes() {
  //   return [
  //     GoRoute(
  //         name: "sultan",
  //         path: SultanScreen.route,
  //         builder: (context, state) => const SultanScreen())
  //   ];
  // }

  QRoute route() => QRoute(
        path: SultanScreen.route,
        builder: () => const SultanScreen(),
      );
}

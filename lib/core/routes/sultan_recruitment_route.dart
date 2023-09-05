import 'package:kukerja_web/core/middlewares/auth_middleware.dart';
import 'package:kukerja_web/core/middlewares/sultan_recruitment_middleware.dart';
import 'package:kukerja_web/features/kukerja/sultan/presentation/screens/sultan_recruitment_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SultanRecruitmentRoute {
  // static List<GoRoute> routes() {
  //   return [
  //     GoRoute(
  //         name: "sultan-recruitment",
  //         path: SultanRecruitmentScreen.route,
  //         builder: (context, state) => const SultanRecruitmentScreen())
  //   ];
  // }

  QRoute route() => QRoute(
        path: SultanRecruitmentScreen.route,
        builder: () => const SultanRecruitmentScreen(),
        middleware: [
          SultanRecruitmentMiddleware(),
          AuthMiddleware(redirectRoute: "/registration/employer")
        ],
      );
}

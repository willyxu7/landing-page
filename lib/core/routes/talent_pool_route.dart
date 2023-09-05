import 'package:go_router/go_router.dart';
import 'package:kukerja_web/core/middlewares/auth_middleware.dart';
import 'package:kukerja_web/core/middlewares/talent_pool_middleware.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/screens/talent_pool_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

class TalentPoolRoute {
  @Deprecated("use 'QRoute' instead")
  static List<GoRoute> routes() {
    return [
      GoRoute(
          name: "talent-pools",
          path: TalentPoolScreen.route,
          builder: (context, state) => const TalentPoolScreen())
    ];
  }

  QRoute route() => QRoute(
        path: TalentPoolScreen.route,
        builder: () => const TalentPoolScreen(),
        middleware: [
          TalentPoolMiddleware(),
          AuthMiddleware(redirectRoute: "/registration/job-seeker")
        ],
      );
}

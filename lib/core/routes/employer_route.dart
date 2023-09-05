import 'package:kukerja_web/core/middlewares/auth_middleware.dart';
import 'package:kukerja_web/features/kukerja/employer/presentation/screens/create_employer_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

class EmployerRoute {
  static const String baseRoute = "/employers";

  // static List<GoRoute> routes() {
  //   return [
  //     GoRoute(
  //       name: "employer/create",
  //       path: "$baseRoute/${CreateEmployerScreen.route}",
  //       builder: (context, state) => const CreateEmployerScreen(),
  //     )
  //   ];
  // }

  QRoute route() => QRoute(
      name: "employers/create",
      path: "$baseRoute/${CreateEmployerScreen.route}",
      builder: () => const CreateEmployerScreen(),
      middleware: [AuthMiddleware()]);
}

import 'package:qlevar_router/qlevar_router.dart';

import '../../features/kukerja/freetalent/presentation/screens/freetalent_employer_form_screen.dart';
import '../../features/kukerja/freetalent/presentation/screens/freetalent_employer_screen.dart';

class FreetalentEmpRoute {
  // static List<GoRoute> routes() {
  //   return [
  //     GoRoute(
  //         name: 'freetalents-emp',
  //         path: FreetalentEmployerScreen.route,
  //         builder: (context, state) => const FreetalentEmployerScreen()),
  //     GoRoute(
  //         name: 'freetalents-emp-create',
  //         path: FreetalentEmployerFormScreen.route,
  //         builder: (context, state) => const FreetalentEmployerFormScreen())
  //   ];
  // }

  QRoute route() => QRoute(
        path: FreetalentEmployerScreen.route,
        builder: () => const FreetalentEmployerScreen(),
        children: [
          QRoute(
            path: FreetalentEmployerFormScreen.route,
            builder: () => const FreetalentEmployerFormScreen(),
          )
        ],
      );
}

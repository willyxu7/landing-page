import 'package:kukerja_web/features/kukerja/freetalent/presentation/screens/freentalent_job_seeker_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

class FreetalentJsRoute {
  QRoute route() => QRoute(
        path: FreetalentJobSeekerScreen.route,
        builder: () => const FreetalentJobSeekerScreen(),
      );
}

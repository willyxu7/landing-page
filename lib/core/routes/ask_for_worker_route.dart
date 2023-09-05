import 'package:kukerja_web/features/kukerja/recruitment/presentation/screens/ask_for_worker_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AskForWorkerRoute {
  QRoute route() => QRoute(
        path: AskForWorkerScreen.route,
        builder: () => const AskForWorkerScreen(),
      );
}

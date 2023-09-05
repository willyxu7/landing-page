import 'package:kukerja_web/features/kukerja/recruitment/presentation/screens/job_details_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

class JobRoute {
  QRoute route() => QRoute(
        name: "jobs",
        path: "${JobDetailsScreen.route}/:id",
        builder: () => const JobDetailsScreen(),
      );
}

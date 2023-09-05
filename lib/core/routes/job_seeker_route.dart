import 'package:kukerja_web/core/widgets/not_found.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/screens/create_job_seeker_screen.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/screens/job_seeker_profile_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../middlewares/auth_middleware.dart';

class JobSeekerRoute {
  static const String jobSeekerPage = "job-seekers";
  static const String baseRoute = "/job-seekers";

  QRoute route() => QRoute(
          name: "$jobSeekerPage/index",
          path: baseRoute,
          builder: () => const NotFound(),
          children: [
            QRoute(
                name: "$jobSeekerPage/create",
                path: CreateJobSeekerScreen.route,
                builder: () => const CreateJobSeekerScreen(),
                middleware: [AuthMiddleware()]
            ),
            QRoute(
              name: "$jobSeekerPage/profile",
              path: "${JobSeekerProfileScreen.route}/:profileImagePath",
              builder: () => JobSeekerProfileScreen(),
            )
          ]);
}

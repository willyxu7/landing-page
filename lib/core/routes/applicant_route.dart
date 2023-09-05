import 'package:kukerja_web/features/kukerja/recruitment/presentation/screens/applicant_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

class ApplicantRoute {
  QRoute route() => QRoute(
        name: "applicants",
        path: "${ApplicantScreen.route}/:id",
        builder: () => const ApplicantScreen(),
      );
}

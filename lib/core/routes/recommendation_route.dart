import 'package:kukerja_web/features/kukerja/recruitment/presentation/screens/recommendation_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

class RecommendationRoute {
  QRoute route() => QRoute(
        path: "${RecommendationScreen.route}/:employerId",
        builder: () => const RecommendationScreen(),
      );
}

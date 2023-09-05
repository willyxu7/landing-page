import 'package:kukerja_web/core/providers/authentication_provider.dart';
import 'package:kukerja_web/core/providers/city_provider.dart';
import 'package:kukerja_web/core/providers/job_role_provider.dart';
import 'package:kukerja_web/core/providers/login_info_provider.dart';
import 'package:kukerja_web/core/providers/user_provider.dart';
import 'package:kukerja_web/features/kukerja/employer/presentation/providers/employer_provider.dart';
import 'package:kukerja_web/features/kukerja/freetalent/presentation/providers/freetalent_employer_provider.dart';
import 'package:kukerja_web/features/kukerja/job_seeker/presentation/providers/job_seeker_provider.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/charge_notifications_provider.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/pricing_provider.dart';
import 'package:kukerja_web/features/kukerja/payment/presentation/provider/snap_provider.dart';
import 'package:kukerja_web/features/kukerja/recruitment/presentation/providers/ask_for_worker_provider.dart';
import 'package:kukerja_web/features/kukerja/talent_pool/presentation/providers/talent_pool_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/kukerja/recruitment/presentation/providers/applicant_provider.dart';
import '../../features/kukerja/recruitment/presentation/providers/job_provider.dart';
import '../../features/kukerja/recruitment/presentation/providers/recommendation_provider.dart';
import '../../features/kukerja/sultan/presentation/providers/sultan_recruitment_provider.dart';

class AppProvider {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (_) => AuthenticationProvider()),
    ChangeNotifierProvider(create: (_) => ApplicantProvider()),
    ChangeNotifierProvider(create: (_) => AskForWorkerProvider()),
    ChangeNotifierProvider(create: (_) => ChargeNotificationProvider()),
    ChangeNotifierProvider(create: (_) => CityProvider()),
    ChangeNotifierProvider(create: (_) => EmployerProvider()),
    ChangeNotifierProvider(create: (_) => FreetalentEmployerProvider()),
    ChangeNotifierProvider(create: (_) => JobProvider()),
    ChangeNotifierProvider(create: (_) => JobRoleProvider()),
    ChangeNotifierProvider(create: (_) => JobSeekerProvider()),
    ChangeNotifierProvider(create: (_) => LoginInfoProvider()),
    ChangeNotifierProvider(create: (_) => PricingProvider()),
    ChangeNotifierProvider(create: (_) => RecommendationProvider()),
    ChangeNotifierProvider(create: (_) => SnapChargeProvider()),
    ChangeNotifierProvider(create: (_) => SultanRecruitmentProvider()),
    ChangeNotifierProvider(create: (_) => TalentPoolProvider()),
    ChangeNotifierProvider(create: (_) => UserProvider()),
  ];
}

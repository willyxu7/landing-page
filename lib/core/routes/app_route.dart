import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kukerja_web/core/routes/applicant_route.dart';
import 'package:kukerja_web/core/routes/ask_for_worker_route.dart';
import 'package:kukerja_web/core/routes/authentication_route.dart';
import 'package:kukerja_web/core/routes/employer_route.dart';
import 'package:kukerja_web/core/routes/freetalent_emp_route.dart';
import 'package:kukerja_web/core/routes/freetalent_js_route.dart';
import 'package:kukerja_web/core/routes/job_route.dart';
import 'package:kukerja_web/core/routes/payment.route.dart';
import 'package:kukerja_web/core/routes/recommendation_route.dart';
import 'package:kukerja_web/core/routes/sultan_recruitment_route.dart';
import 'package:kukerja_web/core/routes/sultan_route.dart';
import 'package:kukerja_web/core/routes/talent_pool_route.dart';
import 'package:kukerja_web/core/routes/ticket_route.dart';
import 'package:kukerja_web/env/kukerja_env.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/screens/frequently_asked_question_screen.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/screens/privacy_and_policy_screen.dart';
import 'package:kukerja_web/features/kukerja/landing_page/presentation/screens/terms_and_conditions_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

import '../../features/kukerja/landing_page/presentation/screens/homepage.dart';
import '../widgets/not_found.dart';
import 'job_seeker_route.dart';

class AppRoute {
  @Deprecated("use QRoute instead")
  GoRouter init(BuildContext context) {
    return GoRouter(
        errorPageBuilder: (context, state) =>
        const MaterialPage<void>(child: NotFound()),
        routes: [
          // ...AuthenticationRoute.routes(),
          // ...EmployerRoute.routes(),
          // GoRoute(
          //     name: 'home',
          //     path: HomePage.route,
          //     builder: (context, state) => const HomePage()),
          // GoRoute(
          //     name: 'frequently-asked-questions',
          //     path: FrequentlyAskedQuestionScreen.route,
          //     builder: (context, state) =>
          //         const FrequentlyAskedQuestionScreen()),
          // GoRoute(
          //     name: 'privacy-and-policy',
          //     path: PrivacyAndPolicyScreen.route,
          //     builder: (context, state) => const PrivacyAndPolicyScreen()),
          // GoRoute(
          //     name: 'terms-and-conditions',
          //     path: TermsAndConditionsScreen.route,
          //     builder: (context, state) => const TermsAndConditionsScreen()),
          // GoRoute(
          //     name: 'applicants',
          //     path: '${ApplicantScreen.route}/:id',
          //     builder: (context, state) {
          //       final id = state.params['id'];
          //       final source = state.queryParams['source'];
          //       return ApplicantScreen(
          //         id: id!,
          //         source: source,
          //       );
          //     }),
          // GoRoute(
          //     name: 'jobs',
          //     path: '${JobDetailsScreen.route}/:id',
          //     builder: (context, state) {
          //       final id = state.params['id'];
          //       final source = state.queryParams['source'];
          //       return JobDetailsScreen(
          //         id: id!,
          //         source: source,
          //       );
          //     }),
          // GoRoute(
          //     name: 'recommendations',
          //     path: '${RecommendationScreen.route}/:employerId',
          //     builder: (context, state) {
          //       final employerId = state.params['employerId'];
          //       return RecommendationScreen(
          //         employerId: employerId!,
          //       );
          //     }),
          // GoRoute(
          //     name: 'job-seeker-profile-picture',
          //     path: JobSeekerProfileScreen.route,
          //     builder: (context, state) => JobSeekerProfileScreen(
          //           profileImagePath: state.extra as String,
          //         )),
          // GoRoute(
          //     name: 'ask-for-workers',
          //     path: AskForWorkerScreen.route,
          //     builder: (context, state) => const AskForWorkerScreen()),

          // Freetalent job seeker routes
          // GoRoute(
          //     name: 'freetalents-js',
          //     path: FreetalentJobSeekerScreen.route,
          //     builder: (context, state) => const FreetalentJobSeekerScreen()),
          // ...FreetalentEmpRoute.routes(),
          // ...PaymentRoute.routes(),
          // ...SultanRoute.routes(),
          // ...SultanRecruitmentRoute.routes(),
          // ...TalentPoolRoute.routes(),
          // GoRoute(
          //     name: 'old-recommended-job-seekers',
          //     path: OldRecommendedJobSeekerScreen.route,
          //     builder: (context, state) => const OldRecommendedJobSeekerScreen()),
          // GoRoute(
          //     name: 'job-seeker-cv',
          //     path: JobSeekerCvWidget.route,
          //     builder: (context, state) => const JobSeekerCvScreen())
        ],
        redirect: (state) {
          if (state.subloc == "/join") KukerjaEnv.launchKukerjaAppLink();

          return null;
        });
  }

  void setup() {
    QR.settings.notFoundPage =
        QRoute(path: '/404', builder: () => const NotFound());
  }

  List<QRoute> routes() {
    return [
      QRoute(name: "home", path: "/", builder: () => const HomePage()),
      QRoute(
          name: "frequently-asked-questions",
          path: FrequentlyAskedQuestionScreen.route,
          builder: () => const FrequentlyAskedQuestionScreen()),
      QRoute(
          name: "privacy-and-policy",
          path: PrivacyAndPolicyScreen.route,
          builder: () => const PrivacyAndPolicyScreen()),
      QRoute(
          name: "terms-and-conditions",
          path: TermsAndConditionsScreen.route,
          builder: () => const TermsAndConditionsScreen()),
      ...AuthenticationRoute().routes(),
      ApplicantRoute().route(),
      AskForWorkerRoute().route(),
      EmployerRoute().route(),
      FreetalentEmpRoute().route(),
      FreetalentJsRoute().route(),
      JobRoute().route(),
      JobSeekerRoute().route(),
      ...PaymentRoute().routes(),
      RecommendationRoute().route(),
      SultanRoute().route(),
      SultanRecruitmentRoute().route(),
      TalentPoolRoute().route(),
      TicketRoute().route(),
    ];
  }
}

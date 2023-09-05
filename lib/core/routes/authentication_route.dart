import 'package:kukerja_web/core/widgets/not_found.dart';
import 'package:kukerja_web/features/kukerja/authentication/presentation/screens/authenticate_otp_screen.dart';
import 'package:kukerja_web/features/kukerja/authentication/presentation/screens/registration_job_seeker_screen.dart';
import 'package:kukerja_web/features/kukerja/authentication/presentation/screens/registration_employer_screen.dart';
import 'package:kukerja_web/features/kukerja/authentication/presentation/screens/sign_in_job_seeker_screen.dart';
import 'package:kukerja_web/features/kukerja/authentication/presentation/screens/sign_in_employer_screen.dart';
import 'package:kukerja_web/features/kukerja/authentication/presentation/screens/sign_in_screen.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AuthenticationRoute {
  // static List<GoRoute> routes() {
  //   return [
  //     GoRoute(
  //       name: "sign-in",
  //       path: SignInScreen.route,
  //       builder: (context, state) => const SignInScreen(),
  //       routes: [
  //         GoRoute(
  //           name: "sign-in/employer",
  //           path: SignInEmployerScreen.route,
  //           builder: (context, state) => const SignInEmployerScreen(),
  //         ),
  //         GoRoute(
  //           name: "sign-in/employee",
  //           path: SignInEmployeeScreen.route,
  //           builder: (context, state) => const SignInEmployeeScreen(),
  //         ),
  //       ],
  //     ),
  //     GoRoute(
  //       name: "registration",
  //       path: "/registration",
  //       builder: (context, state) => const NotFound(),
  //       routes: [
  //         GoRoute(
  //           name: "registration/employer",
  //           path: RegistrationEmployerScreen.route,
  //           builder: (context, state) => const RegistrationEmployerScreen(),
  //         ),
  //         GoRoute(
  //           name: "registration/employee",
  //           path: RegistrationEmployeeScreen.route,
  //           builder: (context, state) => const RegistrationEmployeeScreen(),
  //         ),
  //       ],
  //     ),
  //     GoRoute(
  //         name: "authenticate-otp",
  //         path: "${AuthenticateOtpScreen.route}/:phoneNumber",
  //         builder: (context, state) {
  //           String? phoneNumber = state.params["phoneNumber"];
  //           return AuthenticateOtpScreen(
  //             phoneNumber: phoneNumber!,
  //           );
  //         })
  //   ];
  // }

  List<QRoute> routes() => [
    signInRoutes(),
    registrationRoutes(),
    otpRoute()
  ];

  QRoute signInRoutes() => QRoute(
          name: "sign-in",
          path: SignInScreen.route,
          builder: () => const SignInScreen(),
          children: [
            QRoute(
                path: SignInEmployerScreen.route,
                builder: () => const SignInEmployerScreen()),
            QRoute(
                path: SignInJobSeekerScreen.route,
                builder: () => const SignInJobSeekerScreen()),
          ]);

  QRoute registrationRoutes() => QRoute(
          name: "registration",
          path: "registration",
          builder: () => const NotFound(),
          children: [
            QRoute(
                path: RegistrationEmployerScreen.route,
                builder: () => const RegistrationEmployerScreen()),
            QRoute(
                path: RegistrationJobSeekerScreen.route,
                builder: () => const RegistrationJobSeekerScreen()),
          ]);

  QRoute otpRoute() => QRoute(
      path: "${AuthenticateOtpScreen.route}/:phoneNumber",
      builder: () => const AuthenticateOtpScreen());
}

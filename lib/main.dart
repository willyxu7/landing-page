import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kukerja_web/core/providers/app_provider.dart';
import 'package:kukerja_web/core/routes/app_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qlevar_router/qlevar_router.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:url_strategy/url_strategy.dart';

Future<void> main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setPathUrlStrategy();
  runApp(MultiProvider(
    providers: AppProvider.providers,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final appRoute = AppRoute();
    appRoute.setup();
    return MaterialApp.router(
      routeInformationParser: const QRouteInformationParser(),
      routerDelegate: QRouterDelegate(appRoute.routes()),
      builder: (context, widget) => ResponsiveWrapper.builder(
        ClampingScrollWrapper.builder(context, widget!),
        breakpoints: [
          const ResponsiveBreakpoint.resize(480, name: MOBILE),
          const ResponsiveBreakpoint.autoScale(800, name: TABLET),
          const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
          const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
        ],
      ),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
      supportedLocales: const [
        Locale('en'),
        Locale('id'),
      ],
      title: 'Kukerja',
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.blue,
      ),
    );

    // final router = AppRoute().init(context);

    //
    // return MaterialApp.router(
    //   routeInformationParser: router.routeInformationParser,
    //   routerDelegate: router.routerDelegate,
    //   builder: (context, widget) => ResponsiveWrapper.builder(
    //     ClampingScrollWrapper.builder(context, widget!),
    //     breakpoints: [
    //       const ResponsiveBreakpoint.resize(480, name: MOBILE),
    //       const ResponsiveBreakpoint.autoScale(800, name: TABLET),
    //       const ResponsiveBreakpoint.resize(1000, name: DESKTOP),
    //       const ResponsiveBreakpoint.autoScale(2460, name: '4K'),
    //     ],
    //   ),
    //   debugShowCheckedModeBanner: false,
    //   localizationsDelegates: const [GlobalMaterialLocalizations.delegate],
    //   supportedLocales: const [
    //     Locale('en'),
    //     Locale('id'),
    //   ],
    //   title: 'Kukerja',
    //   theme: ThemeData(
    //     fontFamily: 'Quicksand',
    //     primarySwatch: Colors.blue,
    //   ),
    // );
  }
}

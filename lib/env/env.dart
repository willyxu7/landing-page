import 'package:envify/envify.dart';
part 'env.g.dart';

@Envify()
abstract class Env {
  static const String adminKukerjaApiUrl = _Env.adminKukerjaApiUrl;
  static const String adminKukerjaApiUrlTest = _Env.adminKukerjaApiUrlDev;
  static const String kukerjaAppLink = _Env.kukerjaAppLink;
  static const String kukerjaFbLink = _Env.kukerjaFbLink;
  static const String kukerjaIgLink = _Env.kukerjaIgLink;
  static const String kukerjaYtLink = _Env.kukerjaYtLink;
  static const String kukerjaContactUsLink = _Env.kukerjaContactUsLink;
  static const String kukerjaWaLink = _Env.kukerjaWaLink;
  static const String freetalentWaLink = _Env.freetalentWaLink;
  static const String sultanWaLink = _Env.sultanWaLink;
  static const String recommendedWebLink = _Env.recommendedWebLink;
  static const String recommendedAndroidLink = _Env.recommendedAndroidLink;
}

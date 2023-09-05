import 'package:kukerja_web/core/utils/local_storage_util.dart';
import 'package:qlevar_router/qlevar_router.dart';

class AuthMiddleware extends QMiddleware {
  String redirectRoute;

  AuthMiddleware({this.redirectRoute = "/sign-in"});

  @override
  Future<String?> redirectGuard(String path) async {
    return await LocalStorageUtil.readAccessToken() != null
        ? null
        : redirectRoute;
  }
}

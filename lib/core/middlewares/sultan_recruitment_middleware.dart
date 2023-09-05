import 'package:kukerja_web/core/utils/local_storage_util.dart';
import 'package:qlevar_router/qlevar_router.dart';

class SultanRecruitmentMiddleware extends QMiddleware {
  @override
  Future onMatch() async {
    return await LocalStorageUtil.readAccessToken() != null
        ? null
        : await LocalStorageUtil.writeFromSultanRecruitment();
  }
}
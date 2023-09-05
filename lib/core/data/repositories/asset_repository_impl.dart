import 'package:kukerja_web/core/domain/repositories/asset_repository.dart';
import 'package:kukerja_web/core/exceptions/app_exception.dart';
import 'package:kukerja_web/core/helpers/api_helper.dart';

class AssetRepositoryImpl extends AssetRepository {
  final APIHelper _apiHelper = APIHelper();

  @override
  Future<void> uploadImage(String base64Image) async {
    try {
      await _apiHelper.post("/management/assets/uploadImage", base64Image,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json"
          });
    } on AppException catch (_) {
      rethrow;
    }
  }
}

import 'package:kukerja_web/core/domain/repositories/asset_repository.dart';

class AssetUseCase {
  final AssetRepository _assetRepository;

  AssetUseCase(this._assetRepository);

  Future<void> uploadImage(String base64Image) async {
    await _assetRepository.uploadImage(base64Image);
  }

}
import 'package:kukerja_web/core/domain/entities/feature_menu.dart';
import 'package:kukerja_web/core/domain/repositories/feature_menu_repository.dart';

class FeatureMenuUseCase {

  late FeatureMenuRepository _featureMenuRepository;

  FeatureMenuUseCase(FeatureMenuRepository featureMenuRepository) {
    _featureMenuRepository = featureMenuRepository;
  }

  List<FeatureMenu> getFeatureMenus() {
    return _featureMenuRepository.getFeatureMenus();
  }
}
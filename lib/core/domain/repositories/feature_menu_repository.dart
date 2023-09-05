import 'package:kukerja_web/core/domain/entities/feature_menu.dart';

abstract class FeatureMenuRepository {
  List<FeatureMenu> getFeatureMenus();
}
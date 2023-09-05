import 'package:kukerja_web/core/domain/entities/feature_menu.dart';

abstract class FeatureDataSource {
  List<FeatureMenu> getFeatureMenus();
}
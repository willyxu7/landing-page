import 'package:flutter/cupertino.dart';

class CityProvider with ChangeNotifier {
  late List<String> _cities = [];
  late String _selectedLocation;

  List<String> get cities => _cities;

  String get selectedLocation => _selectedLocation;

  set cities(List<String> cities) {
    _cities = cities;
    notifyListeners();
  }

  set selectedLocation(String selectedLocation) {
    _selectedLocation = selectedLocation;
    notifyListeners();
  }
}

// provider/diet_provider.dart
import 'package:flutter/material.dart';

class DietProvider extends ChangeNotifier {
  String selectedDay = 'Senin';
  String selectedDiet = 'Vegetarian';
  String selectedMealTime = 'Pagi';

  List<Map<String, String>> menuItems = [
    {'name': 'Salad', 'image': 'assets/images/category/diet/salad.jpeg'},
    {'name': 'Daging Sapi', 'image': 'assets/images/category/diet/sapi.jpeg'},
    {'name': 'Sayuran', 'image': 'assets/images/category/diet/sayuran.jpeg'},
    {'name': 'Telur', 'image': 'assets/images/category/diet/telur.jpeg'},
    {'name': 'Nasi Merah', 'image': 'assets/images/category/diet/nasimerah.jpg'},
    {'name': 'Sup Kentang', 'image': 'assets/images/category/diet/supkentang.jpg'},
  ];

  Map<String, bool> selectedMenus = {};

  DietProvider() {
    for (var item in menuItems) {
      selectedMenus[item['name']!] = false;
    }
  }

  void setDay(String day) {
    selectedDay = day;
    notifyListeners();
  }

  void setDiet(String diet) {
    selectedDiet = diet;
    notifyListeners();
  }

  void setMealTime(String meal) {
    selectedMealTime = meal;
    notifyListeners();
  }

  void toggleMenu(String name) {
    selectedMenus[name] = !(selectedMenus[name] ?? false);
    notifyListeners();
  }

  void setMenu(String name, bool value) {
    selectedMenus[name] = value;
    notifyListeners();
  }
}

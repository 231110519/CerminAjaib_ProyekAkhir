// provider/detail_provider.dart
import 'package:flutter/material.dart';

class FoodItem {
  final String category;
  final String name;
  final String description;
  final String imagePath;

  FoodItem({
    required this.category,
    required this.name,
    required this.description,
    required this.imagePath,
  });
}

class DetailProvider with ChangeNotifier {
  FoodItem? _selectedItem;

  FoodItem? get selectedItem => _selectedItem;

  void setItem(FoodItem item) {
    _selectedItem = item;
    notifyListeners();
  }
}

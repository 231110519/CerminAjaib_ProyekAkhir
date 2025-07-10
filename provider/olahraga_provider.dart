// provider/olahraga_provider.dart
import 'package:flutter/material.dart';

class OlahragaProvider with ChangeNotifier {
  String selectedWaktu = 'Pagi';
  String? selectedUsia;

  void setWaktu(String waktu) {
    selectedWaktu = waktu;
    notifyListeners();
  }

  void setUsia(String usia) {
    selectedUsia = usia;
    notifyListeners();
  }

  final Map<String, Map<String, List<String>>> rekomendasiGabungan = {
    'Pagi': {
      'Remaja': ['Jogging', 'Push up ringan'],
      'Dewasa': ['Stretching', 'Lari ringan'],
      'Lansia': ['Jalan santai', 'Tai chi ringan'],
    },
    'Siang': {
      'Remaja': ['Senam ringan', 'Basket santai'],
      'Dewasa': ['Jalan kaki', 'Stretching kantor'],
      'Lansia': ['Gerakan duduk ringan'],
    },
    'Malam': {
      'Remaja': ['Yoga', 'Senam ringan'],
      'Dewasa': ['Stretching', 'Meditasi'],
      'Lansia': ['Peregangan ringan', 'Pernapasan dalam'],
    },
  };
}

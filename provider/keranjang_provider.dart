// provider/keranjang_provider.dart
import 'package:flutter/material.dart';

class KeranjangProvider with ChangeNotifier {
  final List<String> kategoriList = [
    'Semua Makanan',
    'Sayuran',
    'Buah-Buahan',
    'Protein',
  ];

  final Map<String, List<String>> kategoriMakanan = {
    'Sayuran': ['Kangkung', 'Brokoli', 'Wortel'],
    'Buah-Buahan': ['Apel', 'Pisang', 'Alpukat'],
    'Protein': ['Susu', 'Tempe', 'Telur'],
  };

  final Map<String, Set<String>> keranjangPerKategori = {
    'Sayuran': {},
    'Buah-Buahan': {},
    'Protein': {},
  };

  final Map<String, Map<String, String>> kategoriMakananGambar = {
    'Sayuran': {
      'Kangkung': 'assets/images/category/sayuran/kangkung.jpg',
      'Brokoli': 'assets/images/category/sayuran/brokoli.jpg',
      'Wortel': 'assets/images/category/sayuran/wortel.jpg',
    },
    'Buah-Buahan': {
      'Apel': 'assets/images/category/buah/apel.jpg',
      'Pisang': 'assets/images/category/buah/pisang.jpg',
      'Alpukat': 'assets/images/category/buah/alpukat.jpg',
    },
    'Protein': {
      'Susu': 'assets/images/category/protein/susu.jpg',
      'Tempe': 'assets/images/category/protein/tempe.jpg',
      'Telur': 'assets/images/category/protein/telur.jpg',
    },
  };

  String? _kategoriTerpilih;
  String? get kategoriTerpilih => _kategoriTerpilih;

  void pilihKategori(String? kategori) {
    _kategoriTerpilih = kategori;
    notifyListeners();
  }

  List<String> getMakananList() {
    if (_kategoriTerpilih == null) return [];
    if (_kategoriTerpilih == 'Semua Makanan') {
      return kategoriMakanan.values.expand((e) => e).toList();
    }
    return kategoriMakanan[_kategoriTerpilih] ?? [];
  }

  String? getGambarPath(String nama) {
    for (var entry in kategoriMakananGambar.entries) {
      if (entry.value.containsKey(nama)) {
        return entry.value[nama];
      }
    }
    return null;
  }

  String? getKategoriMakanan(String nama) {
    for (var entry in kategoriMakanan.entries) {
      if (entry.value.contains(nama)) {
        return entry.key;
      }
    }
    return null;
  }

  bool isSelected(String nama) {
    return keranjangPerKategori.values.any((set) => set.contains(nama));
  }

  void toggleMakanan(String nama) {
    final kategori = getKategoriMakanan(nama);
    if (kategori != null) {
      if (keranjangPerKategori[kategori]!.contains(nama)) {
        keranjangPerKategori[kategori]!.remove(nama);
      } else {
        keranjangPerKategori[kategori]!.add(nama);
      }
      notifyListeners();
    }
  }

  void clearKategori(String kategori) {}
}

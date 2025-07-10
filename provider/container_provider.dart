// provider/container_provider.dart
import 'package:flutter/material.dart';

class ContainerItem {
  final String label;
  final IconData icon;

  ContainerItem({required this.label, required this.icon});
}

class ContainerProvider with ChangeNotifier {
  final List<ContainerItem> _allItems = [
    ContainerItem(label: 'Olahraga', icon: Icons.fitness_center),
    ContainerItem(label: 'Makanan', icon: Icons.fastfood),
    ContainerItem(label: 'Tidur', icon: Icons.bed),
    ContainerItem(label: 'Detail Makanan', icon: Icons.description),
  ];

  List<Map<String, String>> _history = [];
  List<Map<String, String>> _notifOlahraga = [];

  String _searchQuery = '';

  List<ContainerItem> get filteredItems {
    if (_searchQuery.isEmpty) return _allItems;
    return _allItems
        .where((item) =>
            item.label.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  List<Map<String, String>> get history => List.unmodifiable(_history);
  List<Map<String, String>> get notifOlahraga => List.unmodifiable(_notifOlahraga);

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void addChatToHistory(Map<String, String> chatItem) {
    final name = chatItem['name'];
    if (_history.any((item) => item['type'] == 'chat' && item['name'] == name))
      return;
    _history.add(chatItem);
    notifyListeners();
  }

  void addCallToHistory(String callDescription) {
    _history.add({'type': 'call', 'description': callDescription});
    notifyListeners();
  }

  void removeHistoryItem(int index) {
    if (index >= 0 && index < _history.length) {
      _history.removeAt(index);
      notifyListeners();
    }
  }

  void clearHistory() {
    _history.clear();
    notifyListeners();
  }

  void removeHistoryItemByDescription(String description) {
    _history.removeWhere((item) => item['description'] == description);
    notifyListeners();
  }

  void removeHistoryItemByName(String name) {
    _history.removeWhere(
      (item) => item['type'] == 'chat' && item['name'] == name,
    );
    notifyListeners();
  }

  void addNotifOlahraga(Map<String, String> notif) {
    _notifOlahraga.add(notif);
    notifyListeners();
  }
}

final List<Map<String, dynamic>> doctors = [
  {
    'name': 'Dr. Fendy Angkasa',
    'specialty': 'Spesialis Gizi',
    'description':
        'Ahli dalam menangani masalah nutrisi dan diet untuk semua usia dengan pengalaman lebih dari 15 tahun.',
    'image': 'assets/images/category/dokter/fendy.jpg',
    'rating': 5,
  },
  {
    'name': 'Dr. Kendrick Salim',
    'specialty': 'Spesialis Pengobatan Gaya Hidup',
    'description':
        'Berfokus pada pencegahan penyakit kronis melalui perubahan gaya hidup sehat selama lebih dari 20 tahun.',
    'image': 'assets/images/category/dokter/kendrick.jpg',
    'rating': 5,
  },
  {
    'name': 'Dr. Luis Aprilliansen',
    'specialty': 'Spesialis Gizi',
    'description':
        'Menangani kebutuhan gizi pasien dengan pendekatan individual dan pengalaman lebih dari 12 tahun.',
    'image': 'assets/images/category/dokter/luis.jpg',
    'rating': 5,
  },
  {
    'name': 'Dr. Fandy Sanusi',
    'specialty': 'Spesialis Gizi',
    'description':
        'Membantu pasien mencapai kesehatan optimal melalui konsultasi gizi yang terarah dan efektif.',
    'image': 'assets/images/category/dokter/fandy.jpg',
    'rating': 5,
  },
  {
    'name': 'Dr. Osfredo',
    'specialty': 'Spesialis Pengobatan Gaya Hidup',
    'description':
        'Mengintegrasikan pola makan sehat, aktivitas fisik, dan manajemen stres untuk meningkatkan kualitas hidup.',
    'image': 'assets/images/category/dokter/fredo.jpg',
    'rating': 5,
  },
  {
    'name': 'Dr. Kent Denise',
    'specialty': 'Spesialis Kedokteran Olahraga',
    'description':
        'Membantu atlet dan individu aktif dalam pencegahan serta pemulihan cedera olahraga.',
    'image': 'assets/images/category/dokter/kent.jpg',
    'rating': 5,
  },
  {
    'name': 'Dr. Nicky',
    'specialty': 'Spesialis Kedokteran Olahraga',
    'description':
        'Berpengalaman dalam rehabilitasi dan peningkatan performa fisik bagi atlet dan pasien aktif.',
    'image': 'assets/images/category/dokter/nicky.jpg',
    'rating': 5,
  },
];
  
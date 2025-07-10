// screens/CategoryBMI/olahraga.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/CategoryBMI/countdownpage.dart';
import 'package:projek_cerminajaib/screens/notifikasi/notifan.dart';

class Olahraga extends StatefulWidget {
  final String bmiStatus;
  const Olahraga({super.key, required this.bmiStatus});

  @override
  State<Olahraga> createState() => _OlahragaState();
}

class _OlahragaState extends State<Olahraga> {
  List<Map<String, String>> notifData = [];

  final List<Map<String, String>> categories = const [
    {'name': 'Yoga', 'icon': '🧘'},
    {'name': 'Cardio', 'icon': '🏃'},
    {'name': 'Stretching', 'icon': '🤸'},
    {'name': 'Strength', 'icon': '🏋️'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pilih Jenis Olahraga')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          children:
              categories.map((item) {
                return GestureDetector(
                  onTap: () async {
                    final Map<String, String>? newNotif = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CountdownPage(category: item['name']!),
                      ),
                    );

                    if (newNotif != null) {
                      setState(() {
                        notifData.add(newNotif);
                      });
                    }
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(
                            context,
                          ).shadowColor.withOpacity(0.05), // Soft shadow
                          blurRadius: 6,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          item['icon']!,
                          style: const TextStyle(fontSize: 48),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          item['name']!,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.notifications),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const Notifan()),
          );
        },
      ),
    );
  }
}

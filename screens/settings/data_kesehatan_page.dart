// screens/settings/data_kesehatan_page.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/widgets/health_progress_bar.dart';
import 'package:projek_cerminajaib/widgets/targer_slider.dart';


class DataKesehatanPage extends StatefulWidget {
  const DataKesehatanPage({super.key});

  @override
  State<DataKesehatanPage> createState() => _DataKesehatanPageState();
}

class _DataKesehatanPageState extends State<DataKesehatanPage> {
  double targetLangkah = 10000;
  double targetKalori = 500;

  double progressLangkah = 6000; 
  double progressKalori = 320; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data Kesehatan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('Langkah Harian', Icons.directions_walk),
          const SizedBox(height: 8),
          HealthProgressBar(
            progressValue: progressLangkah / targetLangkah,
            label:
                '${progressLangkah.toInt()} / ${targetLangkah.toInt()} langkah',
          ),
          const SizedBox(height: 8),
          TargetSlider(
            title: 'Target Langkah Harian',
            min: 1000,
            max: 20000,
            value: targetLangkah,
            unit: 'langkah',
            onChanged: (value) {
              setState(() {
                targetLangkah = value;
              });
            },
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Detak Jantung', Icons.favorite),
          const SizedBox(height: 12),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            padding: const EdgeInsets.all(16),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('• Rata-rata: 78 bpm'),
                SizedBox(height: 4),
                Text('• Tertinggi hari ini: 92 bpm'),
                SizedBox(height: 4),
                Text('• Terendah hari ini: 65 bpm'),
              ],
            ),
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Kalori Terbakar', Icons.local_fire_department),
          const SizedBox(height: 8),
          HealthProgressBar(
            progressValue: progressKalori / targetKalori,
            label: '${progressKalori.toInt()} / ${targetKalori.toInt()} kkal',
            color: Colors.orange,
          ),
          const SizedBox(height: 8),
          TargetSlider(
            title: 'Target Kalori Harian',
            min: 100,
            max: 1000,
            value: targetKalori,
            unit: 'kkal',
            onChanged: (value) {
              setState(() {
                targetKalori = value;
              });
            },
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('Catatan Tambahan', Icons.note_alt),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.teal.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.all(12),
            child: const Text(
              'Data diambil dari perangkat kebugaran yang terhubung dan diperbarui setiap 30 menit.',
              style: TextStyle(fontSize: 13, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: Colors.teal),
        const SizedBox(width: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}

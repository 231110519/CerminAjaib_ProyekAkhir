// screens/settings/riwayat_konsultasi_page.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';

class RiwayatKonsultasiPage extends StatefulWidget {
  const RiwayatKonsultasiPage({super.key});

  @override
  State<RiwayatKonsultasiPage> createState() => _RiwayatKonsultasiPageState();
}

class _RiwayatKonsultasiPageState extends State<RiwayatKonsultasiPage> {
  final Map<String, double> ratings = {};

  @override
  void initState() {
    super.initState();
    for (var doctor in doctors) {
      ratings[doctor['name']] = 0; 
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Riwayat Konsultasi')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: doctors.length,
          itemBuilder: (context, index) {
            final doctor = doctors[index];
            final name = doctor['name'];
            final imagePath = doctor['image'];

            return Card(
              elevation: 4,
              margin: const EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.asset(
                            imagePath,
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                doctor['specialty'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        ),
                       
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      doctor['description'],
                      style: const TextStyle(fontSize: 13.5),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: const [
                        Text('Nilai Layanan:'),
                        SizedBox(width: 6),
                        Tooltip(
                          message:
                              'Geser untuk memberikan penilaian layanan dokter ini',
                          child: Icon(Icons.info_outline, size: 18),
                        ),
                      ],
                    ),
                    Slider(
                      value: ratings[name] ?? 0,
                      min: 0,
                      max: 5,
                      divisions: 5,
                      label: '${ratings[name]?.round()}',
                      activeColor: Colors.orange,
                      onChanged: (value) {
                        setState(() {
                          ratings[name] = value;
                        });
                      },
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < (ratings[name]?.round() ?? 0)
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orange,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

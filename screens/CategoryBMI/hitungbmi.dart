import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/CategoryBMI/diet.dart';
import 'package:projek_cerminajaib/screens/CategoryBMI/olahraga.dart';

class Hitungbmi extends StatefulWidget {
  const Hitungbmi({super.key});

  @override
  State<Hitungbmi> createState() => _HitungbmiState();
}

class _HitungbmiState extends State<Hitungbmi> {
  String _gender = 'Pria';
  double _height = 160;
  double _weight = 60;
  double? _bmi;
  String _status = "";
  String _recommendation = "";

  void _calculateBMI() {
    if (_height <= 0 || _weight <= 0) {
      setState(() {
        _bmi = null;
        _status = "Tidak valid";
        _recommendation = "Masukkan tinggi dan berat yang lebih dari 0.";
      });
      return;
    }

    final bmi = _weight / ((_height / 100) * (_height / 100));
    String status, recommendation;

    if (bmi < 18.5) {
      status = "UnderWeight";
      recommendation = "Tambah massa otot & konsumsi kalori sehat.";
    } else if (bmi < 24.9) {
      status = "Normal";
      recommendation = "Pertahankan gaya hidup sehat & olahraga.";
    } else if (bmi < 29.9) {
      status = "OverWeight";
      recommendation = "Turunkan berat dengan olahraga & diet.";
    } else if (bmi < 34.9) {
      status = "Obesitas";
      recommendation = "Turunkan berat dengan olahraga & diet.";
    } else {
      status = "Extremely Obese";
      recommendation = "Fokus pada pembakaran kalori & pola makan sehat.";
    }

    setState(() {
      _bmi = bmi;
      _status = status;
      _recommendation = recommendation;
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Hitung BMI"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Image.asset(
              'assets/images/category/BMI/beratnormal.jpeg',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: _gender,
              decoration: InputDecoration(
                labelText: "Gender",
                prefixIcon: const Icon(Icons.person, color: Colors.greenAccent),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              items:
                  ['Pria', 'Wanita']
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
              onChanged: (val) => setState(() => _gender = val!),
            ),
            const SizedBox(height: 24),
            Text(
              "Tinggi Badan: ${_height.toStringAsFixed(0)} cm",
              style: const TextStyle(fontSize: 16),
            ),
            Slider(
              value: _height,
              min: 0,
              max: 220,
              divisions: 220,
              label: "${_height.toStringAsFixed(0)} cm",
              onChanged: (value) => setState(() => _height = value),
            ),
            const SizedBox(height: 16),
            Text(
              "Berat Badan: ${_weight.toStringAsFixed(1)} kg",
              style: const TextStyle(fontSize: 16),
            ),
            Slider(
              value: _weight,
              min: 0,
              max: 150,
              divisions: 150,
              label: "${_weight.toStringAsFixed(1)} kg",
              onChanged: (value) => setState(() => _weight = value),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _calculateBMI,
              icon: const Icon(Icons.calculate),
              label: const Text(
                "Hitung BMI",
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent.shade700,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 24),

            if (_bmi != null)
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                color: isDark ? Colors.black : Colors.green[50],
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "BMI Anda: ${_bmi!.toStringAsFixed(1)}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Status: $_status",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(_recommendation),
                      const SizedBox(height: 16),
                      Wrap(
                        spacing: 10,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => Olahraga(bmiStatus: _status),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.fitness_center,
                              color: Colors.greenAccent,
                            ),
                            label: const Text("Olahraga"),
                          ),
                          OutlinedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DietPlannerPage(),
                                ),
                              );
                            },
                            icon: const Icon(
                              Icons.restaurant_menu,
                              color: Colors.green,
                            ),
                            label: const Text("Lihat Diet"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

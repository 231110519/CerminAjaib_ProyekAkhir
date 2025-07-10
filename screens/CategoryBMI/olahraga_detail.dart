// screens/CategoryBMI/olahraga_detail.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/CategoryBMI/exercise.dart';


class OlahragaDetail extends StatefulWidget {
  final String category;
  final String bmiStatus;

  const OlahragaDetail({
    super.key,
    required this.category,
    required this.bmiStatus,
  });

  @override
  State<OlahragaDetail> createState() => _OlahragaDetailState();
}

class _OlahragaDetailState extends State<OlahragaDetail> {
  String _difficulty = 'Mudah';
  late List<ExerciseItem> exercises;

  @override
  void initState() {
    super.initState();
    exercises = getExercises(widget.category, widget.bmiStatus, _difficulty);
  }

  @override
  void dispose() {
    for (var e in exercises) {
      e.timer?.cancel();
    }
    super.dispose();
  }

  void _startTimer(int index) {
    final item = exercises[index];
    item.isRunning = true;
    item.timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        item.duration += const Duration(seconds: 1);
      });
    });
  }

  void _stopTimer(int index) {
    final item = exercises[index];
    item.isRunning = false;
    item.timer?.cancel();
  }

  void _resetTimer(int index) {
    final item = exercises[index];
    item.timer?.cancel();
    item.isRunning = false;
    item.duration = Duration.zero;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} - Latihan'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Pilih Tingkat Kesulitan:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: _difficulty,
              onChanged: (value) {
                setState(() {
                  _difficulty = value!;
                  exercises = getExercises(widget.category, widget.bmiStatus, _difficulty);
                });
              },
              items: ['Mudah', 'Sedang', 'Sulit']
                  .map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            const Text(
              'Latihan yang bisa Anda coba:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final item = exercises[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(16),
                      title: Text(item.name),
                      subtitle: Text(_formatDuration(item.duration)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(item.isRunning ? Icons.pause : Icons.play_arrow),
                            onPressed: () {
                              setState(() {
                                item.isRunning ? _stopTimer(index) : _startTimer(index);
                              });
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.stop),
                            onPressed: () {
                              setState(() {
                                _resetTimer(index);
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  List<ExerciseItem> getExercises(String category, String bmi, String difficulty) {
    List<String> names;

    switch (category) {
      case 'Yoga':
        names = bmi == 'UnderWeight'
            ? (difficulty == 'Mudah'
                ? ['Yoga relaksasi', 'Latihan pernapasan']
                : difficulty == 'Sedang'
                    ? ['Posisi pohon', 'Tree pose']
                    : ['Warrior pose', 'Warrior II pose'])
            : bmi == 'Normal'
                ? (difficulty == 'Mudah'
                    ? ['Cat-cow pose', 'Cobra pose']
                    : difficulty == 'Sedang'
                        ? ['Warrior pose', 'Triangle pose']
                        : ['Chair pose', 'Lotus pose'])
                : ['Latihan tidak tersedia'];
        break;
      case 'Cardio':
        names = bmi == 'UnderWeight'
            ? (difficulty == 'Mudah'
                ? ['Bersepeda santai', 'Jogging ringan']
                : difficulty == 'Sedang'
                    ? ['Lari ringan', 'Bersepeda cepat']
                    : ['HIIT lompat tali', 'Sprint'])
            : bmi == 'Normal'
                ? (difficulty == 'Mudah'
                    ? ['Jogging ringan', 'Bersepeda']
                    : difficulty == 'Sedang'
                        ? ['Skipping', 'HIIT']
                        : ['Sprint', 'HIIT intensitas tinggi'])
                : ['Latihan tidak tersedia'];
        break;
      case 'Stretching':
        names = difficulty == 'Mudah'
            ? ['Quad stretch', 'Hamstring stretch']
            : difficulty == 'Sedang'
                ? ['Triceps stretch', 'Chest stretch']
                : ['Hip flexor stretch', 'Spinal twist'];
        break;
      case 'Strength':
        names = difficulty == 'Mudah'
            ? ['Push-up', 'Squat']
            : difficulty == 'Sedang'
                ? ['Deadlift ringan', 'Plank']
                : ['Weighted Squat', 'Pull-up'];
        break;
      default:
        names = ['Latihan tidak tersedia'];
    }

    return names.map((e) => ExerciseItem(name: e)).toList();
  }
}

// screens/CategoryBMI/countdownpage.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';

class CountdownPage extends StatefulWidget {
  final String category;
  const CountdownPage({super.key, required this.category});

  @override
  State<CountdownPage> createState() => _CountdownPageState();
}

class _CountdownPageState extends State<CountdownPage> {
  Duration selected = const Duration(minutes: 5);
  Duration remaining = const Duration(minutes: 5);
  Timer? timer;
  bool running = false;

  void start() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (remaining.inSeconds <= 1) {
        timer?.cancel();
        setState(() => running = false);
        _showDone();
      } else {
        setState(() => remaining -= const Duration(seconds: 1));
      }
    });
    setState(() => running = true);
  }

  void pause() {
    timer?.cancel();
    setState(() => running = false);
  }

  void reset() {
    timer?.cancel();
    setState(() {
      running = false;
      remaining = selected;
    });

    final containerProvider = Provider.of<ContainerProvider>(
      context,
      listen: false,
    );
    containerProvider.addNotifOlahraga({
      'kategori': widget.category,
      'nama': widget.category,
      'durasiAwal': fmt(selected),
      'durasiAkhir': fmt(remaining),
    });

    Navigator.pop(context);
  }

  String fmt(Duration d) =>
      '${d.inMinutes.toString().padLeft(2, '0')}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  void _showDone() {
    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Selesai!'),
            content: Text('Waktu ${widget.category} selesai.'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
    );
  }

  void _showPicker() {
    int min = selected.inMinutes;
    int sec = selected.inSeconds % 60;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder:
          (_) => Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Pilih Durasi',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton<int>(
                      value: min,
                      items: List.generate(
                        60,
                        (i) => DropdownMenuItem(value: i, child: Text('$i m')),
                      ),
                      onChanged: (v) => setState(() => min = v!),
                    ),
                    const SizedBox(width: 16),
                    DropdownButton<int>(
                      value: sec,
                      items: List.generate(
                        60,
                        (i) => DropdownMenuItem(value: i, child: Text('$i s')),
                      ),
                      onChanged: (v) => setState(() => sec = v!),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    final d = Duration(minutes: min, seconds: sec);
                    if (d.inSeconds > 0) {
                      setState(() {
                        selected = d;
                        remaining = d;
                      });
                    }
                    Navigator.pop(context);
                  },
                  child: const Text('Terapkan'),
                ),
              ],
            ),
          ),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Colors.green;

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.category} Timer'),
        actions: [
          IconButton(
            icon: const Icon(Icons.timer),
            tooltip: 'Pilih Durasi',
            onPressed: running ? null : _showPicker,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              fmt(remaining),
              style: const TextStyle(fontSize: 72, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: running ? pause : start,
                  icon: Icon(running ? Icons.pause : Icons.play_arrow),
                  label: Text(running ? 'Berhenti' : 'Mulai'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: themeColor,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: reset,
                  icon: const Icon(Icons.check_circle, color: Colors.black),
                  label: const Text(
                    'Selesaikan',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

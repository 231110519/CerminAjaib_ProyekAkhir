// screens/settings/privasi_keamanan_page.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';


class PrivasiKeamananPage extends StatefulWidget {
  const PrivasiKeamananPage({super.key});

  @override
  State<PrivasiKeamananPage> createState() => _PrivasiKeamananPageState();
}

class _PrivasiKeamananPageState extends State<PrivasiKeamananPage> {
  bool _enkripsiAktif = true;
  bool _izinBerbagi = false;
  double _tingkatPrivasi = 3;

  void _konfirmasiHapusAkun() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const _HapusAkunDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Privasi & Keamanan')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Pengaturan Privasi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          SwitchListTile(
            title: const Text('Enkripsi Data Medis'),
            subtitle: const Text('Data disimpan dengan enkripsi untuk keamanan ekstra'),
            value: _enkripsiAktif,
            onChanged: (value) => setState(() => _enkripsiAktif = value),
            secondary: const Tooltip(
              message: 'Meningkatkan keamanan data medis Anda',
              child: Icon(Icons.lock),
            ),
          ),
          SwitchListTile(
            title: const Text('Izin Berbagi Data'),
            subtitle: const Text('Izinkan dokter melihat data kesehatan Anda'),
            value: _izinBerbagi,
            onChanged: (value) => setState(() => _izinBerbagi = value),
            secondary: const Tooltip(
              message: 'Diperlukan agar dokter dapat memberikan diagnosis lebih baik',
              child: Icon(Icons.share),
            ),
          ),
          const SizedBox(height: 20),
          const Text(
            'Tingkat Privasi',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Tooltip(
            message: 'Sesuaikan seberapa banyak data yang dapat digunakan untuk personalisasi',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Slider(
                  value: _tingkatPrivasi,
                  min: 1,
                  max: 5,
                  divisions: 4,
                  label: 'Level ${_tingkatPrivasi.round()}',
                  activeColor: Colors.green,
                  onChanged: (value) => setState(() => _tingkatPrivasi = value),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [Text('Minimal'), Text('Maksimal')],
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            icon: const Icon(Icons.delete_forever),
            label: const Text('Hapus Akun'),
            onPressed: _konfirmasiHapusAkun,
          ),
        ],
      ),
    );
  }
}

class _HapusAkunDialog extends StatefulWidget {
  const _HapusAkunDialog();

  @override
  State<_HapusAkunDialog> createState() => _HapusAkunDialogState();
}

class _HapusAkunDialogState extends State<_HapusAkunDialog> {
  double _percent = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startProgress();
  }

  void _startProgress() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      setState(() {
        _percent += 0.02;
        if (_percent >= 1.0) {
          _timer?.cancel();
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Akun berhasil dihapus')),
          );
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Menghapus Akun...'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularPercentIndicator(
            radius: 60.0,
            lineWidth: 8.0,
            percent: _percent.clamp(0.0, 1.0),
            center: Text('${(_percent * 100).toInt()}%'),
            progressColor: Colors.redAccent,
          ),
          const SizedBox(height: 16),
          const Text('Sedang menghapus akun kamu secara permanen...'),
        ],
      ),
    );
  }
}

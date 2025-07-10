// screens/chat/tambah.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';

class Tambah extends StatefulWidget {
  final VoidCallback onDokterAdded;

  const Tambah({super.key, required this.onDokterAdded});

  @override
  State<Tambah> createState() => _TambahState();
}

class _TambahState extends State<Tambah> {
  String name = '';
  String specialty = '';
  String description = '';
  int rating = 0;
  String imageUrl = '';
  bool isLoading = false;

  Widget _buildImagePreview() {
    if (imageUrl.isNotEmpty) {
      return Image.network(
        imageUrl,
        height: 100,
        width: 100,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 100,
            width: 100,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 40, color: Colors.red),
          );
        },
      );
    } else {
      return Container(
        height: 100,
        width: 100,
        color: Colors.grey[300],
        child: const Icon(Icons.image, size: 40),
      );
    }
  }

  void _simpanDokter() async {
    if (name.isEmpty || specialty.isEmpty || imageUrl.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('❌ Semua field harus diisi')),
      );
      return;
    }

    setState(() => isLoading = true);
    await Future.delayed(const Duration(seconds: 2));

    doctors.add({
      'name': name,
      'specialty': specialty,
      'rating': rating.clamp(0, 5),
      'image': imageUrl,
      'description': description.isEmpty
          ? 'Deskripsi belum ditambahkan.'
          : description,
    });

    setState(() => isLoading = false);
    widget.onDokterAdded();
    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('✅ Dokter berhasil ditambahkan')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Tambah Dokter'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            _buildImagePreview(),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'URL Gambar'),
              onChanged: (value) => setState(() => imageUrl = value.trim()),
            ),
            const SizedBox(height: 10),
            TextField(
              decoration: const InputDecoration(labelText: 'Nama Dokter'),
              onChanged: (value) => name = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Spesialis'),
              onChanged: (value) => specialty = value,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Rating (0-5)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => rating = int.tryParse(value) ?? 0,
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'Deskripsi Dokter'),
              maxLines: 3,
              onChanged: (value) => description = value,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          onPressed: isLoading ? null : _simpanDokter,
          child: isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('Simpan'),
        ),
      ],
    );
  }
}

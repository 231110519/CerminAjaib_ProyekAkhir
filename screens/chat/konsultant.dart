import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';
import 'package:projek_cerminajaib/screens/chat/tambah.dart';

class Konsultant extends StatefulWidget {
  final int initialTabIndex;

  const Konsultant({super.key, this.initialTabIndex = 0});

  @override
  State<Konsultant> createState() => _KonsultantState();
}

class _KonsultantState extends State<Konsultant>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> favoriteDoctors = [];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
      initialIndex: widget.initialTabIndex,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void toggleFavorite(Map<String, dynamic> doctor) {
    final isFav = favoriteDoctors.contains(doctor);
    setState(() {
      isFav ? favoriteDoctors.remove(doctor) : favoriteDoctors.add(doctor);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFav
              ? '❌ ${doctor['name']} dihapus dari favorite.'
              : '✅ ${doctor['name']} ditambahkan ke favorite.',
        ),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _bukaDialogTambahDokter() {
    showDialog(
      context: context,
      builder: (_) => Tambah(onDokterAdded: () => setState(() {})),
    );
  }

  Widget buildDoctorImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Container(
        height: 70,
        width: 70,
        color: Colors.grey[300],
        child: const Icon(Icons.person, size: 40),
      );
    }

    if (imageUrl.startsWith('http')) {
      return Image.network(
        imageUrl,
        height: 70,
        width: 70,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            height: 70,
            width: 70,
            color: Colors.grey[300],
            child: const Icon(Icons.broken_image, size: 40, color: Colors.red),
          );
        },
      );
    }

    return Image.asset(imageUrl, height: 70, width: 70, fit: BoxFit.cover);
  }

  Widget buildDoctorList(List<Map<String, dynamic>> data) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: data.length,
      itemBuilder: (context, index) {
        final d = data[index];
        final isFav = favoriteDoctors.contains(d);

        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.greenAccent),
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: buildDoctorImage(d['image']),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            d['name'],
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.greenAccent,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      d['specialty'],
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(
                        5,
                        (i) => Icon(
                          i < d['rating'] ? Icons.star : Icons.star_border,
                          color: Colors.orange,
                          size: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: isFav ? Colors.red : Colors.grey,
                ),
                onPressed: () => toggleFavorite(d),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final Color appBarColor = isDark ? Colors.grey[900]! : Colors.greenAccent;
    final Color labelColor = Colors.green;
    final Color unselectedColor =
        isDark ? Colors.grey[400]! : Colors.grey[700]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Kontak', style: TextStyle(fontSize: 18)),
        centerTitle: true,
        backgroundColor: appBarColor,
        foregroundColor: isDark ? Colors.white : Colors.black,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.green,
          labelColor: labelColor,
          unselectedLabelColor: unselectedColor,
          tabs: const [Tab(text: 'Kontak'), Tab(text: 'Favorite')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [buildDoctorList(doctors), buildDoctorList(favoriteDoctors)],
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.add,
        activeIcon: Icons.close,
        backgroundColor: Colors.green,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.add),
            label: 'Tambah Dokter',
            onTap: _bukaDialogTambahDokter,
          ),
        ],
      ),
    );
  }
}

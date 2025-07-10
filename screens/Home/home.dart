import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/CategoryBMI/hitungbmi.dart';
import 'package:projek_cerminajaib/screens/CategoryMKD/rangkuman.dart';
import 'package:projek_cerminajaib/screens/CategoryNews/newtab.dart';
import 'package:projek_cerminajaib/screens/chat/konsultant.dart';
import 'package:projek_cerminajaib/screens/notifikasi/notifan.dart';
import 'package:projek_cerminajaib/screens/profil/profil_page.dart';
import 'package:projek_cerminajaib/screens/Home/riwayat_page.dart';
import 'package:projek_cerminajaib/screens/settings/settings_page.dart';
import 'package:projek_cerminajaib/widgets/doctorlist.dart';
import 'package:projek_cerminajaib/widgets/navigation_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const RiwayatPage(),
    const ProfilPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'Riwayat'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Beranda'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const Notifan()),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings, size: 30),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsPage()),
              );
            },
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Category',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 120,
              child: GridView(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: [
                  CategoryItem(
                    icon: Icons.description,
                    label: "Detail",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Rangkuman()),
                      );
                    },
                  ),
                  CategoryItem(
                    icon: Icons.fitness_center,
                    label: "Olahraga",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => Hitungbmi()),
                      );
                    },
                  ),
                  CategoryItem(
                    icon: Icons.people,
                    label: "Daftar kontak",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const Konsultant()),
                      );
                    },
                  ),
                  CategoryItem(
                    icon: Icons.library_books,
                    label: "News",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => NewsAppPage()),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Konsultasi Dokter',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Expanded(
              child: DefaultTabController(
                length: 3,
                child: Column(
                  children: [
                    TabBar(
                      labelColor: Colors.green,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: Colors.green,
                      tabs: [
                        Tab(
                          text: 'Spesialis Gizi',
                          icon: Icon(Icons.restaurant),
                        ),
                        Tab(
                          text: 'Gaya Hidup',
                          icon: Icon(Icons.fitness_center),
                        ),
                        Tab(
                          text: 'Kedokteran Olahraga',
                          icon: Icon(Icons.sports),
                        ),
                      ],
                      labelStyle: TextStyle(fontSize: 12),
                    ),
                    Expanded(
                      child: TabBarView(
                        children: [
                          DoctorList(specialty: 'Spesialis Gizi'),
                          DoctorList(
                            specialty: 'Spesialis Pengobatan Gaya Hidup',
                          ),
                          DoctorList(
                            specialty: 'Spesialis Kedokteran Olahraga',
                          ),
                        ],
                      ),
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

class CategoryItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const CategoryItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.greenAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 40, color: Colors.white),
            const SizedBox(height: 6),
            Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

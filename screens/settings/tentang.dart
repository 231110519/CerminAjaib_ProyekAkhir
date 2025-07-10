// screens/settings/tentang.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/profil/minicard.dart';
import 'package:projek_cerminajaib/screens/settings/settings_page.dart';

class TentangPage extends StatelessWidget {
  const TentangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tentang"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SettingsPage()),
            );
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            color: Colors.greenAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child: Image.asset(
                    "assets/images/category/dokter/fendy.jpg",
                    height: 180,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Konsultasi Dengan Dokter Fendy",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Dr. Fendy Spesialis Gizi",
                        style: TextStyle(color: Colors.black87, fontSize: 12),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        "Dapatkan konsultasi kesehatan terpercaya langsung dari ahlinya.",
                        style: TextStyle(fontSize: 13, color: Colors.black87),
                      ),
                      const SizedBox(height: 12),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.75,
            children: const [
              MiniCard(
                imagePath: "assets/images/category/news/doktergizi1.jpg",
                title: "Berita Gizi",
                subtitle:
                    "Update terbaru mengenai gizi, gaya hidup sehat, dan kedokteran olahraga hanya di Cermin Ajaib.",
              ),
              MiniCard(
                imagePath: "assets/images/category/sayuran/brokoli.jpg",
                title: "Sayur Brokoli",
                subtitle:
                    "Informasi lengkap tentang sayuran dan manfaatnya hanya di aplikasi Cermin Ajaib.",
              ),
              MiniCard(
                imagePath: "assets/images/category/buah/alpukat.jpg",
                title: "Buah Alpukat",
                subtitle:
                    "Detail lengkap mengenai buah dan kandungan gizinya tersedia di Cermin Ajaib.",
              ),
              MiniCard(
                imagePath: "assets/images/category/diet/salad.jpeg",
                title: "Salad",
                subtitle:
                    "Program diet plan disediakan agar pengguna dapat mengikuti langkah-langkah diet yang sehat.",
              ),
            ],
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              "📌 Cermin Ajaib menyediakan berbagai fitur yang dapat diakses oleh pengguna, di antaranya: fitur konsultasi dengan dokter, diet plan untuk membantu menyusun rencana diet, informasi detail tentang makanan beserta kandungan gizi dan manfaatnya, serta berita seputar kesehatan dan gaya hidup. Masih banyak fitur lainnya yang membantu kamu hidup lebih sehat dan seimbang.",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}

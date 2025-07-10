import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/CategoryNews/news.dart';

class NewsAppPage extends StatefulWidget {
  const NewsAppPage({super.key});

  @override
  State<NewsAppPage> createState() => _NewsAppPageState();
}

class _NewsAppPageState extends State<NewsAppPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: isDark ? Colors.black : Colors.green,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            "News",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            indicatorWeight: 3.5,
            labelColor: Colors.white,
            unselectedLabelColor: isDark ? Colors.grey[400] : Colors.white70,
            labelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            tabs: const [
              Tab(text: "Spesialis Gizi"),
              Tab(text: "Gaya Hidup"),
              Tab(text: "Kedokteran Olahraga"),
            ],
          ),
        ),
        body: Column(
          children: [
            // 🔶 Banner peringatan
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                decoration: BoxDecoration(
                  color: isDark ? Colors.orange[700] : Colors.orange[100],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.warning_amber_rounded,
                      color: isDark ? Colors.orange[200] : Colors.orange[800],
                      size: 28,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '⚠️ Berita yang ditampilkan tidak dijamin 100% benar. '
                        'Silakan verifikasi dari sumber terpercaya.',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: isDark ? Colors.white : Colors.black,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 🔹 Trending News
            buildTrendingNowSection(context),

            // 🔹 List berita per tab
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  buildNewsList("Kesehatan", context),
                  buildNewsList("Medis", context),
                  buildNewsList("Olahraga", context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

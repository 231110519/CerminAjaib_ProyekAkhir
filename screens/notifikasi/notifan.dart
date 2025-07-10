// screens/notifikasi/notifan.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/notifikasi/notifalltab.dart';
import 'package:projek_cerminajaib/screens/notifikasi/notifolahragatab.dart';
import 'package:projek_cerminajaib/screens/notifikasi/notiforderantab.dart';

class Notifan extends StatelessWidget {
  const Notifan({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Notifikasi"),
          centerTitle: true,
          backgroundColor:
              isDark
                  ? Theme.of(context).appBarTheme.backgroundColor ??
                      Colors.grey[900]
                  : const Color.fromARGB(255, 0, 255, 98),
          foregroundColor: isDark ? Colors.white : Colors.black,
          bottom: const TabBar(
            indicatorColor: Colors.green,
            labelColor: Colors.green, // warna teks tab aktif
            unselectedLabelColor: Colors.grey, // warna teks tab tidak aktif
            tabs: [
              Tab(text: "All"),
              Tab(text: "Olahraga"),
              Tab(text: "Orderan"),
            ],
          ),
        ),
        body: const TabBarView(
          children: [NotifAllTab(), NotifOlahragaTab(), NotifOrderanTab()],
        ),
      ),
    );
  }
}

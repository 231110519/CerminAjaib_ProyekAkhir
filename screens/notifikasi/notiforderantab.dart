// screens/notifikasi/notiforderantab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/keranjang_provider.dart';
import 'package:projek_cerminajaib/screens/notifikasi/notifcard.dart';

class NotifOrderanTab extends StatelessWidget {
  const NotifOrderanTab({super.key});

  @override
  Widget build(BuildContext context) {
    final keranjangProvider = context.watch<KeranjangProvider>();

    final orderanNotifs = keranjangProvider.keranjangPerKategori.entries
        .expand((entry) => entry.value.map((item) => {
              'kategori': entry.key,
              'nama': item,
            }))
        .toList();

    return orderanNotifs.isEmpty
        ? const Center(child: Text("Belum ada orderan."))
        : ListView(
            padding: const EdgeInsets.all(16),
            children: orderanNotifs.map((notif) {
              final String nama = notif['nama'] ?? '-';
              final String kategori = notif['kategori'] ?? '-';

              return NotifCard(
                icon: Icons.shopping_cart,
                title: 'Orderan $nama ($kategori)',
                subtitle: 'Pesanan telah dibuat.',
              );
            }).toList(),
          );
  }
}

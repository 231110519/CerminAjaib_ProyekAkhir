// screens/notifikasi/notifalltab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';
import 'package:projek_cerminajaib/provider/keranjang_provider.dart';
import 'package:projek_cerminajaib/screens/notifikasi/notifcard.dart';

class NotifAllTab extends StatelessWidget {
  const NotifAllTab({super.key});

  @override
  Widget build(BuildContext context) {
    final keranjangProvider = context.watch<KeranjangProvider>();
    final containerProvider = context.watch<ContainerProvider>();

    final orderanNotifs =
        keranjangProvider.keranjangPerKategori.entries
            .expand(
              (entry) => entry.value.map(
                (item) => {
                  'kategori': entry.key,
                  'nama': item,
                  'tipe': 'Orderan',
                },
              ),
            )
            .toList();
    final olahragaNotifs = containerProvider.notifOlahraga.map(
      (notif) => {
        'kategori': 'Olahraga',
        'nama': notif['nama'],
        'durasiAwal': notif['durasiAwal'],
        'durasiAkhir': notif['durasiAkhir'],
        'tipe': 'Olahraga',
      },
    );

    final allNotifs = [...olahragaNotifs, ...orderanNotifs];

    return allNotifs.isEmpty
        ? const Center(child: Text("Belum ada notifikasi."))
        : ListView(
          padding: const EdgeInsets.all(16),
          children:
              allNotifs.map((notif) {
                final tipe = notif['tipe'];
                final nama = notif['nama'] ?? '';
                final kategori = notif['kategori'] ?? '-';

                if (tipe == 'Olahraga') {
                  return NotifCard(
                    icon: Icons.fitness_center,
                    title: 'Latihan $nama telah diselesaikan',
                    subtitle:
                        'Durasi awal: ${notif['durasiAwal'] ?? '-'}\nDiselesaikan pada: ${notif['durasiAkhir'] ?? '-'}',
                  );
                } else {
                  return NotifCard(
                    icon: Icons.shopping_cart,
                    title: 'Orderan $nama ($kategori)',
                    subtitle: 'Pesanan Telah Di buat.',
                  );
                }
              }).toList(),
        );
  }
}

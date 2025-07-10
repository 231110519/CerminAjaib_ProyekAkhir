// screens/notifikasi/notifolahragatab.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';
import 'package:projek_cerminajaib/screens/notifikasi/notifcard.dart';

class NotifOlahragaTab extends StatelessWidget {
  const NotifOlahragaTab({super.key});

  @override
  Widget build(BuildContext context) {
    final olahragaNotifs = context.watch<ContainerProvider>().notifOlahraga;

    return olahragaNotifs.isEmpty
        ? const Center(child: Text('Belum ada aktivitas olahraga yang diselesaikan.'))
        : ListView(
            padding: const EdgeInsets.all(16),
            children: olahragaNotifs.map((notif) {
              return NotifCard(
                icon: Icons.fitness_center,
                title: 'Latihan ${notif['nama']} telah diselesaikan',
                subtitle:
                    'Durasi awal: ${notif['durasiAwal']}\nDiselesaikan pada: ${notif['durasiAkhir']}',
              );
            }).toList(),
          );
  }
}

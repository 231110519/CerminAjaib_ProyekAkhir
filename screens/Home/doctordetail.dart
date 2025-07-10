import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';
import 'package:projek_cerminajaib/screens/Home/chat_page.dart';
import 'package:projek_cerminajaib/screens/Home/call_page.dart';

class Doctordetail extends StatelessWidget {
  final String name;
  final String specialty;
  final String description;
  final String imageUrl;
  final int rating;

  const Doctordetail({
    super.key,
    required this.name,
    required this.specialty,
    required this.description,
    required this.imageUrl,
    required this.rating,
  });

  bool isBase64(String str) {
    return str.length > 100 && !str.startsWith('http');
  }

  bool isNetwork(String str) {
    return str.startsWith('http');
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    try {
      if (isBase64(imageUrl)) {
        imageWidget = CircleAvatar(
          radius: 30,
          backgroundImage: MemoryImage(base64Decode(imageUrl)),
        );
      } else if (isNetwork(imageUrl)) {
        imageWidget = CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(imageUrl),
          onBackgroundImageError: (_, __) {},
        );
      } else {
        imageWidget = CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage(imageUrl),
        );
      }
    } catch (e) {
      imageWidget = const CircleAvatar(radius: 30, child: Icon(Icons.error));
    }

    return Scaffold(
      appBar: AppBar(title: Text(name)),
      body: ListView(
        children: [
          ListTile(
            contentPadding: const EdgeInsets.all(16),
            leading: imageWidget,
            title: Text(
              name,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            subtitle: Text(specialty),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(5, (index) {
                return Icon(
                  index < rating ? Icons.star : Icons.star_border,
                  color: Colors.orange,
                  size: 20,
                );
              }),
            ),
          ),
          const Divider(),
          ListTile(
            title: const Text('Deskripsi'),
            subtitle: Text(
              description.isNotEmpty
                  ? description
                  : 'Belum ada deskripsi untuk dokter ini.',
            ),
          ),
          const Divider(),
          const ListTile(
            title: Text('Jadwal Konsultasi'),
            subtitle: Text('Senin - Jumat: 09:00 AM - 05:00 PM'),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.chat, color: Colors.blue),
            title: const Text('Chat dengan Dokter'),
            onTap: () {
              Provider.of<ContainerProvider>(
                context,
                listen: false,
              ).addChatToHistory({
                'type': 'chat',
                'name': name,
                'imageUrl': imageUrl,
              });
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) => ChatPage(doctorName: name, doctorImage: imageUrl),
                ),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.phone, color: Colors.green),
            title: const Text('Telepon Dokter'),
            onTap: () {
              showDialog(
                context: context,
                builder: (_) {
                  return AlertDialog(
                    title: const Text('Konfirmasi'),
                    content: Text(
                      'Apakah Anda yakin ingin menelepon Dr. $name?',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child: const Text('Tidak'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                          Provider.of<ContainerProvider>(
                            context,
                            listen: false,
                          ).addCallToHistory('Telepon ke Dr. $name');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => CallPage(doctorName: name),
                            ),
                          );
                        },
                        child: const Text('Ya'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}

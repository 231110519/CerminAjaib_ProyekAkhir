// widgets/doctorlist.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/provider/container_provider.dart';
import 'package:projek_cerminajaib/screens/Home/doctordetail.dart';

class DoctorList extends StatelessWidget {
  final String specialty;

  const DoctorList({super.key, required this.specialty});

  bool isBase64(String str) {
    return str.length > 100 && !str.startsWith('http');
  }

  bool isNetworkImage(String str) {
    return str.startsWith('http');
  }

  @override
  Widget build(BuildContext context) {
    final filteredDoctors =
        doctors.where((doc) => doc['specialty'] == specialty).toList();

    if (filteredDoctors.isEmpty) {
      return const Center(child: Text('Tidak ada dokter tersedia.'));
    }

    return ListView.builder(
      itemCount: filteredDoctors.length,
      itemBuilder: (context, index) {
        final doctor = filteredDoctors[index];
        final imageStr = doctor['image'] as String? ?? '';

        Widget imageWidget;

        try {
          if (isBase64(imageStr)) {
            imageWidget = Image.memory(
              base64Decode(imageStr),
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            );
          } else if (isNetworkImage(imageStr)) {
            imageWidget = Image.network(
              imageStr,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
            );
          } else {
            imageWidget = Image.asset(
              imageStr,
              width: 60,
              height: 60,
              fit: BoxFit.cover,
            );
          }
        } catch (e) {
          imageWidget = Container(
            width: 60,
            height: 60,
            color: Colors.red[100],
            child: const Icon(Icons.error),
          );
        }

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
                child: imageWidget,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          doctor['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const Icon(
                          Icons.check_circle,
                          color: Colors.greenAccent,
                          size: 18,
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doctor['specialty'] ?? '',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: List.generate(5, (starIndex) {
                        return Icon(
                          starIndex < (doctor['rating'] ?? 0)
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.orange,
                          size: 18,
                        );
                      }),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.greenAccent,
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder:
                          (_) => Doctordetail(
                            name: doctor['name'],
                            specialty: doctor['specialty'],
                            description: doctor['description'],
                            imageUrl: doctor['image'],
                            rating: doctor['rating'],
                          ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/keranjang_provider.dart';
import '../notifikasi/notifan.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<KeranjangProvider>(context);
    final kategoriTerpilih = provider.kategoriTerpilih;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Keranjang Makanan'),
        centerTitle: true,
        backgroundColor: theme.appBarTheme.backgroundColor,
        foregroundColor: theme.appBarTheme.foregroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Pilih Kategori:',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              children:
                  provider.kategoriList.map((kategori) {
                    final isSelected = kategori == kategoriTerpilih;
                    return ChoiceChip(
                      label: Text(
                        kategori,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              isSelected
                                  ? Colors.white
                                  : theme.textTheme.bodyMedium?.color,
                        ),
                      ),
                      selected: isSelected,
                      onSelected: (selected) {
                        provider.pilihKategori(selected ? kategori : null);
                      },
                      selectedColor: Colors.green.shade400,
                      backgroundColor:
                          isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),

            if (kategoriTerpilih != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Pilih $kategoriTerpilih:',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children:
                        provider.getMakananList().map((nama) {
                          final selected = provider.isSelected(nama);
                          final gambarPath = provider.getGambarPath(nama);
                          return GestureDetector(
                            onTap: () => provider.toggleMakanan(nama),
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color:
                                    selected
                                        ? Colors.green.shade50
                                        : isDark
                                        ? Colors.grey.shade900
                                        : Colors.grey.shade100,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      selected
                                          ? Colors.green
                                          : isDark
                                          ? Colors.grey.shade700
                                          : Colors.grey.shade300,
                                  width: 1.5,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        isDark
                                            ? Colors.black.withOpacity(0.2)
                                            : Colors.black.withOpacity(0.05),
                                    blurRadius: 4,
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  if (gambarPath != null)
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        gambarPath,
                                        width: 70,
                                        height: 70,
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  const SizedBox(height: 8),
                                  Text(
                                    nama,
                                    style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                  ),
                  const SizedBox(height: 30),
                ],
              ),

            const Divider(thickness: 1),
            const SizedBox(height: 10),

            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Keranjang:',
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),

            ...provider.keranjangPerKategori.entries.map((entry) {
              final kategori = entry.key;
              final itemList = entry.value;
              if (itemList.isEmpty) return const SizedBox.shrink();
              return Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.green.shade100),
                  boxShadow: [
                    BoxShadow(
                      color:
                          isDark
                              ? Colors.black.withOpacity(0.3)
                              : Colors.grey.withOpacity(0.1),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      kategori,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Wrap(
                        spacing: 12,
                        runSpacing: 12,
                        children:
                            itemList.map((item) {
                              final imagePath = provider.getGambarPath(item);
                              return Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 8,
                                ),
                                decoration: BoxDecoration(
                                  color:
                                      isDark
                                          ? Colors.green.shade900
                                          : Colors.green.shade50,
                                  borderRadius: BorderRadius.circular(24),
                                  border: Border.all(
                                    color: Colors.green.shade200,
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (imagePath != null)
                                      CircleAvatar(
                                        radius: 14,
                                        backgroundImage: AssetImage(imagePath),
                                      ),
                                    const SizedBox(width: 8),
                                    Text(
                                      item,
                                      style: theme.textTheme.bodyMedium
                                          ?.copyWith(
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            }),

            if (provider.keranjangPerKategori.values.every(
              (set) => set.isEmpty,
            ))
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Belum ada makanan dipilih.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
                  ),
                ),
              ),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const Notifan()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade400,
                minimumSize: const Size(double.infinity, 50),
              ),
              child: const Text(
                'Order Sekarang',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

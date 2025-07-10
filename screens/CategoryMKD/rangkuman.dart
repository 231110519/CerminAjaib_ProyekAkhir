import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/provider/detail_provider.dart';
import 'package:projek_cerminajaib/screens/CategoryMKD/detail.dart';
import 'package:provider/provider.dart';

class Rangkuman extends StatefulWidget {
  const Rangkuman({super.key});

  @override
  _RangkumanPageState createState() => _RangkumanPageState();
}

class _RangkumanPageState extends State<Rangkuman> {
  final List<FoodItem> allFoodItems = [
    FoodItem(
      category: 'Sayuran',
      name: 'Kangkung',
      description:
          'Mengandung vitamin A, C, dan K, serta folat, yang mendukung kesehatan mata, kulit, dan sistem kekebalan tubuh. Kangkung juga kaya akan zat besi, yang penting untuk pembentukan sel darah merah.',
      imagePath: 'assets/images/category/sayuran/kangkung.jpg',
    ),
    FoodItem(
      category: 'Sayuran',
      name: 'Brokoli',
      description:
          'Sayuran kaya antioksidan, vitamin C, dan serat. Baik untuk kesehatan jantung, imunitas, dan pencernaan.',
      imagePath: 'assets/images/category/sayuran/brokoli.jpg',
    ),
    FoodItem(
      category: 'Sayuran',
      name: 'Wortel',
      description:
          'Mengandung beta-karoten (vitamin A), baik untuk kesehatan mata dan kulit.',
      imagePath: 'assets/images/category/sayuran/wortel.jpg',
    ),
    FoodItem(
      category: 'Buah-buahan',
      name: 'Apel',
      description:
          'Kaya serat, vitamin C, dan antioksidan. Mendukung kesehatan jantung, pencernaan, dan sistem kekebalan tubuh.',
      imagePath: 'assets/images/category/buah/apel.jpg',
    ),
    FoodItem(
      category: 'Buah-buahan',
      name: 'Pisang',
      description:
          'Sumber kalium yang membantu mengatur tekanan darah dan mendukung fungsi otot serta saraf.',
      imagePath: 'assets/images/category/buah/pisang.jpg',
    ),
    FoodItem(
      category: 'Buah-buahan',
      name: 'Alpukat',
      description:
          'Mengandung lemak sehat, vitamin E, dan kalium. Baik untuk kesehatan jantung, kulit, dan keseimbangan elektrolit.',
      imagePath: 'assets/images/category/buah/alpukat.jpg',
    ),
    FoodItem(
      category: 'Protein',
      name: 'Telur',
      description:
          'Sumber protein lengkap dengan kandungan asam amino esensial yang baik untuk otot dan fungsi tubuh.',
      imagePath: 'assets/images/category/protein/telur.jpg',
    ),
    FoodItem(
      category: 'Protein',
      name: 'Susu',
      description:
          'Mengandung protein berkualitas tinggi, kalsium, dan vitamin D yang baik untuk kesehatan tulang dan gigi, serta mendukung pertumbuhan dan perbaikan jaringan tubuh.',
      imagePath: 'assets/images/category/protein/susu.jpg',
    ),
    FoodItem(
      category: 'Protein',
      name: 'Tempe',
      description:
          'Sumber protein nabati yang kaya akan probiotik, vitamin B12, dan mineral yang mendukung pencernaan dan sistem kekebalan tubuh.',
      imagePath: 'assets/images/category/protein/tempe.jpg',
    ),
  ];

  final List<String> categories = [
    'ALL FOOD',
    'Sayuran',
    'Buah-buahan',
    'Protein',
  ];
  String selectedCategory = 'ALL FOOD';

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final filteredItems =
        selectedCategory == 'ALL FOOD'
            ? allFoodItems
            : allFoodItems
                .where((item) => item.category == selectedCategory)
                .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Makanan'),
        backgroundColor: isDark ? Colors.black : Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  categories.map((category) {
                    final isSelected = selectedCategory == category;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: Text(
                          category,
                          style: TextStyle(
                            fontWeight:
                                isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                            color:
                                isSelected
                                    ? (isDark ? Colors.white : Colors.black)
                                    : Theme.of(
                                      context,
                                    ).textTheme.bodyMedium?.color,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor:
                            isDark
                                ? Colors.greenAccent.shade700
                                : const Color.fromARGB(255, 124, 255, 168),
                        checkmarkColor: isDark ? Colors.white : Colors.black,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                      ),
                    );
                  }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return GestureDetector(
                  onTap: () {
                    Provider.of<DetailProvider>(
                      context,
                      listen: false,
                    ).setItem(item);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Detail()),
                    );
                  },
                  child: Card(
                    color: Theme.of(context).cardColor,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(12),
                            bottomLeft: Radius.circular(12),
                          ),
                          child: Image.asset(
                            item.imagePath,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.name,
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  item.description,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

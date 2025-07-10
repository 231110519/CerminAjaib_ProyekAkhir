// screens/CategoryBMI/diet.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/provider/diet_provider.dart';
import 'package:provider/provider.dart';

class DietPlannerPage extends StatelessWidget {
  final List<String> days = [
    'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
  ];
  final List<String> dietTypes = ['Vegetarian', 'Non-Vegetarian'];
  final List<String> mealTimes = ['Pagi', 'Siang', 'Malam'];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DietProvider>(context);
    return Scaffold(
      appBar: AppBar(title: Text('Perencanaan Diet'), centerTitle: true),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("📅 Pilih Hari", style: _sectionTitleStyle()),
            SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: provider.selectedDay,
              items: days.map((day) => DropdownMenuItem(
                value: day, child: Text(day),
              )).toList(),
              onChanged: (val) => provider.setDay(val!),
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            SizedBox(height: 20),

            Text("🥗 Tipe Diet", style: _sectionTitleStyle()),
            Wrap(
              spacing: 10,
              children: dietTypes.map((type) => ChoiceChip(
                label: Text(type),
                selected: provider.selectedDiet == type,
                onSelected: (_) => provider.setDiet(type),
              )).toList(),
            ),
            SizedBox(height: 20),

            Text("🍽️ Waktu Makan", style: _sectionTitleStyle()),
            Wrap(
              spacing: 10,
              children: mealTimes.map((meal) => ChoiceChip(
                label: Text(meal),
                selected: provider.selectedMealTime == meal,
                onSelected: (_) => provider.setMealTime(meal),
              )).toList(),
            ),
            SizedBox(height: 20),

            Text("📋 Pilih Menu", style: _sectionTitleStyle()),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.1,
              children: provider.menuItems.map((menu) {
                final name = menu['name']!;
                final image = menu['image']!;
                return GestureDetector(
                  onTap: () => provider.toggleMenu(name),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Column(
                      children: [
                        Expanded(
                          child: Image.asset(image, fit: BoxFit.cover, width: double.infinity),
                        ),
                        CheckboxListTile(
                          title: Text(name, style: TextStyle(fontSize: 14)),
                          value: provider.selectedMenus[name],
                          onChanged: (val) => provider.setMenu(name, val!),
                          controlAffinity: ListTileControlAffinity.leading,
                        )
                      ],
                    ),
                  ),
                );
              }).toList(),
            )
          ],
        ),
      ),
    );
  }

  TextStyle _sectionTitleStyle() => TextStyle(
    fontSize: 18, fontWeight: FontWeight.bold, color: Colors.green[800]);
}

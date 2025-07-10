// lib/widgets/target_slider.dart
import 'package:flutter/material.dart';

class TargetSlider extends StatelessWidget {
  final String title;
  final double min;
  final double max;
  final double value;
  final String unit;
  final ValueChanged<double> onChanged;

  const TargetSlider({
    super.key,
    required this.title,
    required this.min,
    required this.max,
    required this.value,
    required this.unit,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title: ${value.toInt()} $unit',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          divisions: ((max - min) ~/ 100),
          label: '${value.toInt()} $unit',
          onChanged: onChanged,
          activeColor: Colors.teal,
        ),
      ],
    );
  }
}

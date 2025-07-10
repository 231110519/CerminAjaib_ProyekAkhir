import 'package:flutter/material.dart';

class InfoTooltipIcon extends StatelessWidget {
  final String message;

  const InfoTooltipIcon({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      preferBelow: false,
      child: const Icon(Icons.info_outline, size: 18, color: Colors.grey),
    );
  }
}

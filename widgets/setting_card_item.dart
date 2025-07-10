import 'package:flutter/material.dart';

class SettingCardItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback? onTap;

  final bool isSwitch;
  final bool switchValue;
  final void Function(bool)? onSwitchChanged;

  final bool isDropdown;
  final String? dropdownValue;
  final void Function(String?)? onDropdownChanged;
  final List<DropdownMenuItem<String>>? dropdownItems;

  const SettingCardItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.onTap,
    this.isSwitch = false,
    this.switchValue = false,
    this.onSwitchChanged,
    this.isDropdown = false,
    this.dropdownValue,
    this.onDropdownChanged,
    this.dropdownItems,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 1,
      child: ListTile(
        onTap: isSwitch || isDropdown ? null : onTap,
        leading: Icon(icon, color: Colors.teal),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: _buildTrailingWidget(),
      ),
    );
  }

  Widget? _buildTrailingWidget() {
    if (isSwitch) {
      return Switch(value: switchValue, onChanged: onSwitchChanged);
    } else if (isDropdown &&
        dropdownValue != null &&
        onDropdownChanged != null &&
        dropdownItems != null) {
      return DropdownButton<String>(
        value: dropdownValue,
        onChanged: onDropdownChanged,
        items: dropdownItems,
      );
    }
    return const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey);
  }
}

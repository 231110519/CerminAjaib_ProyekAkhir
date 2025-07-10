// screens/settings/settings_page.dart
import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/main.dart';
import 'package:projek_cerminajaib/screens/Home/home.dart';

import 'package:projek_cerminajaib/screens/settings/privasi_keamanan_page.dart';
import 'package:provider/provider.dart';
import 'package:projek_cerminajaib/provider/theme_provider.dart';
import 'package:projek_cerminajaib/screens/settings/tentang.dart';
import 'package:projek_cerminajaib/screens/settings/data_kesehatan_page.dart';
import 'package:projek_cerminajaib/screens/settings/riwayat_konsultasi_page.dart';
import 'package:projek_cerminajaib/widgets/setting_card_item.dart';
import 'package:projek_cerminajaib/widgets/info_tooltip_icon.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String selectedLanguage = 'Indonesia';

  void _changeLanguage(String? language) {
    if (language == null) return;

    Locale newLocale;
    switch (language) {
      case 'English':
        newLocale = const Locale('en');
        break;
      case 'Spanish':
        newLocale = const Locale('es');
        break;
      case 'Japanese':
        newLocale = const Locale('ja');
        break;
      case 'Indonesia':
      default:
        newLocale = const Locale('id');
    }

    setState(() {
      selectedLanguage = language;
      MyApp.setLocale(context, newLocale);
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color:
                Theme.of(context).brightness == Brightness.dark
                    ? Colors
                        .white // Putih untuk dark mode
                    : Colors.black, // Hitam untuk light mode
          ),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()),
            );
          },
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Row(
            children: [
              Text(
                t.accountAndHealthData,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              const InfoTooltipIcon(
                message: 'Data tentang riwayat dan kondisi kesehatan Anda',
              ),
            ],
          ),
          const SizedBox(height: 8),
          SettingCardItem(
            icon: Icons.favorite,
            title: t.healthData,
            subtitle: t.manageHealthData,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DataKesehatanPage()),
              );
            },
          ),
          SettingCardItem(
            icon: Icons.history,
            title: t.consultationHistory,
            subtitle: t.viewChatAndSchedule,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const RiwayatKonsultasiPage(),
                ),
              );
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                t.appPreferences,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              const InfoTooltipIcon(message: 'Pengaturan tema, dan bahasa'),
            ],
          ),
          const SizedBox(height: 8),

          SettingCardItem(
            icon: Icons.dark_mode,
            title: t.darkMode,
            subtitle: t.enableNightMode,
            isSwitch: true,
            switchValue: themeProvider.isDarkMode,
            onSwitchChanged: (value) {
              themeProvider.toggleTheme(value);
            },
          ),
          SettingCardItem(
            icon: Icons.language,
            title: t.language,
            subtitle: t.chooseLanguage,
            isDropdown: true,
            dropdownValue: selectedLanguage,
            onDropdownChanged: _changeLanguage,
            dropdownItems: const [
              DropdownMenuItem(value: 'Indonesia', child: Text('Indonesia')),
              DropdownMenuItem(value: 'English', child: Text('English')),
              DropdownMenuItem(value: 'Spanish', child: Text('Spanish')),
              DropdownMenuItem(value: 'Japanese', child: Text('Japanese')),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Text(
                t.privacyAndHelp,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 6),
              const InfoTooltipIcon(
                message: 'Kebijakan privasi dan informasi aplikasi',
              ),
            ],
          ),
          const SizedBox(height: 8),
          SettingCardItem(
            icon: Icons.privacy_tip,
            title: t.privacySecurity,
            subtitle: t.manageAccess,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const PrivasiKeamananPage()),
              );
            },
          ),
          SettingCardItem(
            icon: Icons.info_outline,
            title: t.aboutApp,
            subtitle: t.versionInfo,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const TentangPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}

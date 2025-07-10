import 'package:flutter/material.dart';
import 'package:projek_cerminajaib/screens/profil/profil_page.dart';
import 'package:projek_cerminajaib/screens/Home/riwayat_page.dart';
import 'package:projek_cerminajaib/screens/chat/konsultant.dart';
import 'package:projek_cerminajaib/screens/settings/settings_page.dart';
import 'package:projek_cerminajaib/widgets/logout_bottomsheet.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Drawer(
      backgroundColor: theme.scaffoldBackgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('Nama Pengguna'),
            accountEmail: const Text('user@email.com'),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage('assets/images/profil.jpg'),
            ),
            decoration: BoxDecoration(
              color: isDark ? Colors.black : Colors.green,
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Beranda',
            onTap: () => Navigator.pop(context),
            isDark: isDark,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.history,
            title: 'Riwayat',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const RiwayatPage()),
              );
            },
            isDark: isDark,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.favorite,
            title: 'Favorite Dokter',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Konsultant(initialTabIndex: 1),
                ),
              );
            },
            isDark: isDark,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.person,
            title: 'Profil',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const ProfilPage()),
              );
            },
            isDark: isDark,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.settings,
            title: 'Pengaturan',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const SettingsPage()),
              );
            },
            isDark: isDark,
          ),
          const Divider(),
          _buildDrawerItem(
            context,
            icon: Icons.logout,
            title: 'Logout',
            onTap: () {
              Navigator.pop(context);
              showLogoutBottomSheet(context);
            },
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required bool isDark,
  }) {
    return ListTile(
      leading: Icon(icon, color: isDark ? Colors.white : Colors.black),
      title: Text(
        title,
        style: TextStyle(color: isDark ? Colors.white : Colors.black),
      ),
      onTap: onTap,
    );
  }
}

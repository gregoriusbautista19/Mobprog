import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pengaturan Akun"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        children: [
          _buildSettingsGroup(
            context,
            title: "Akun",
            children: [
              _buildSettingsItem(
                icon: Icons.person_outline,
                title: "Ubah Profil",
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.lock_outline,
                title: "Ganti Kata Sandi",
                onTap: () {},
              ),
              _buildSettingsItem(
                icon: Icons.location_on_outlined,
                title: "Daftar Alamat",
                onTap: () {},
              ),
            ],
          ),
          _buildSettingsGroup(
            context,
            title: "Notifikasi",
            children: [
              SwitchListTile(
                secondary: const Icon(Icons.notifications_active_outlined),
                title: const Text("Notifikasi Promo"),
                value: true,
                onChanged: (bool value) {},
              ),
              SwitchListTile(
                secondary: const Icon(Icons.chat_bubble_outline),
                title: const Text("Notifikasi Chat"),
                value: true,
                onChanged: (bool value) {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  // --- FUNGSI HELPER DIPINDAHKAN KE SINI ---
  Widget _buildSettingsGroup(BuildContext context, {required String title, required List<Widget> children}) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(
              color: Colors.grey.shade600,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }
}


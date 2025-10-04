import 'package:flutter/material.dart';
import 'manage_products_page.dart';
import 'store_profile_page.dart';
import 'store_profile.dart';
import 'messages_inbox_page.dart';
import 'analytics_page.dart';
import 'notifications_page.dart';

class SellerDashboardPage extends StatefulWidget {
  const SellerDashboardPage({super.key});

  @override
  State<SellerDashboardPage> createState() => _SellerDashboardPageState();
}

class _SellerDashboardPageState extends State<SellerDashboardPage> {
  // Fungsi untuk me-refresh UI
  void _refreshDashboard() {
    setState(() {
      // Memanggil setState kosong akan memaksa widget untuk membangun ulang
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text("Seller Center", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Fitur Scan belum tersedia.")),
              );
            },
            tooltip: 'Scan',
          ),
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const NotificationsPage()),
              );
            },
            tooltip: 'Notifikasi',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(12.0),
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 16),
          _buildOrderSummary(context),
          const SizedBox(height: 16),
          _buildQuickActions(context),
          const SizedBox(height: 16),
          _buildBusinessAdvisor(),
        ],
      ),
    );
  }

  // Widget untuk bagian profil di atas
  Widget _buildProfileHeader(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 30,
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.store, color: Colors.white, size: 30),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storeProfileData.name,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text("Lv. 1 | Followers: 0", style: TextStyle(color: Colors.grey.shade600)),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  // Widget untuk ringkasan pesanan
  Widget _buildOrderSummary(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pesanan Saya", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildOrderStatusItem(context, icon: Icons.pending_actions, label: "Diproses", count: 0),
                _buildOrderStatusItem(context, icon: Icons.local_shipping, label: "Dikirim", count: 0),
                _buildOrderStatusItem(context, icon: Icons.assignment_return, label: "Pengembalian", count: 0),
                _buildOrderStatusItem(context, icon: Icons.reviews, label: "Ulasan", count: 0),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper untuk item di ringkasan pesanan
  Widget _buildOrderStatusItem(BuildContext context, {required IconData icon, required String label, required int count}) {
    return Column(
      children: [
        Icon(icon, color: Colors.grey.shade700, size: 30),
        const SizedBox(height: 8),
        Text(count.toString(), style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
      ],
    );
  }

  // Widget untuk menu-menu utama
  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Alat Penjual", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black87)),
        const SizedBox(height: 10),
        GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: 4,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          children: [
            _buildActionItem(context, icon: Icons.inventory_2, label: "Produk", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const ManageProductsPage()));
            }),
            _buildActionItem(context, icon: Icons.storefront, label: "Profil Toko", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const StoreProfilePage()))
                  .then((_) => _refreshDashboard());
            }),
            _buildActionItem(context, icon: Icons.message, label: "Pesan", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagesInboxPage()));
            }),
            _buildActionItem(context, icon: Icons.show_chart, label: "Data", onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalyticsPage()));
            }),
          ],
        )
      ],
    );
  }

  // Helper untuk item di menu grid
  Widget _buildActionItem(BuildContext context, {required IconData icon, required String label, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Card(
        elevation: 1.5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary, size: 32),
            const SizedBox(height: 8),
            Text(label, textAlign: TextAlign.center, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }

  // Widget untuk bagian Business Advisor
  Widget _buildBusinessAdvisor() {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: const Icon(Icons.lightbulb_outline, color: Colors.orangeAccent),
        title: const Text("Business Advisor", style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: const Text("Dapatkan wawasan untuk meningkatkan penjualan."),
        trailing: const Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }
}


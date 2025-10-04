import 'package:flutter/material.dart';
import '../models/analytics_data.dart';

class AnalyticsPage extends StatelessWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final data = dummyAnalyticsData; // Mengambil data contoh

    return Scaffold(
      appBar: AppBar(
        title: const Text("Analitik Toko"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildKeyMetrics(context, data),
          const SizedBox(height: 24),
          _buildSalesChart(context, data),
          const SizedBox(height: 24),
          _buildTopProducts(context, data),
        ],
      ),
    );
  }

  // Widget untuk menampilkan metrik utama (pendapatan, pengunjung, dll.)
  Widget _buildKeyMetrics(BuildContext context, AnalyticsData data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildMetricItem("Pendapatan", "Rp ${data.totalRevenue.toStringAsFixed(0)}"),
            _buildMetricItem("Pengunjung", data.totalVisitors.toString()),
            _buildMetricItem("Konversi", "${data.conversionRate}%"),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricItem(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(color: Colors.grey.shade600, fontSize: 14)),
      ],
    );
  }

  // Widget untuk menampilkan grafik penjualan
  Widget _buildSalesChart(BuildContext context, AnalyticsData data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Pendapatan Minggu Ini", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            // Placeholder untuk grafik. Di aplikasi nyata, ini akan diganti dengan paket grafik.
            AspectRatio(
              aspectRatio: 1.7,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey.shade200,
                ),
                child: const Center(
                  child: Text(
                    "Grafik Penjualan (Placeholder)",
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget untuk menampilkan daftar produk terlaris
  Widget _buildTopProducts(BuildContext context, AnalyticsData data) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Produk Terlaris", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...data.topProducts.map((product) {
              return ListTile(
                contentPadding: EdgeInsets.zero,
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(product.imageUrl, width: 50, height: 50, fit: BoxFit.cover),
                ),
                title: Text(product.name),
                subtitle: Text("${product.sold} terjual"),
                trailing: Text("Rp ${product.revenue.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.w600)),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}


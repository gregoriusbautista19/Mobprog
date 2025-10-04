import 'package:flutter/material.dart';
import '../models/purchase_history.dart';

class PurchaseHistoryPage extends StatelessWidget {
  const PurchaseHistoryPage({super.key});

  // Helper untuk mendapatkan warna status
  Color _getStatusColor(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.lunas:
        return Colors.green;
      case PaymentStatus.tertunda:
        return Colors.orange;
      case PaymentStatus.dibatalkan:
        return Colors.red;
    }
  }

  // Helper untuk mendapatkan teks status
  String _getStatusText(PaymentStatus status) {
    switch (status) {
      case PaymentStatus.lunas:
        return "Lunas";
      case PaymentStatus.tertunda:
        return "Tertunda";
      case PaymentStatus.dibatalkan:
        return "Dibatalkan";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Riwayat Pembelian"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: dummyPurchaseHistory.isEmpty
          ? const Center(
              child: Text("Anda belum pernah melakukan transaksi."),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: dummyPurchaseHistory.length,
              itemBuilder: (ctx, index) {
                final item = dummyPurchaseHistory[index];
                return Card(
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Order ID: ${item.orderId}",
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: _getStatusColor(item.status),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                _getStatusText(item.status),
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                            ),
                          ],
                        ),
                        const Divider(),
                        // Daftar produk
                        ...item.products.map((product) => ListTile(
                              leading: Image.asset(product.imageUrl, width: 40, fit: BoxFit.cover),
                              title: Text(product.name),
                              subtitle: Text("Rp ${product.price.toStringAsFixed(0)}"),
                            )),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Total: Rp ${item.totalPrice.toStringAsFixed(0)}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                            Text(
                              "${item.purchaseDate.day}/${item.purchaseDate.month}/${item.purchaseDate.year}",
                              style: TextStyle(
                                  color: Colors.grey.shade600, fontSize: 12),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}


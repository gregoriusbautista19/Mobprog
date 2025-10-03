import 'package:flutter/material.dart';
import '../models/product.dart';
import '../main.dart';

class ProductDetailPage extends StatelessWidget {
  final Product product;

  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.name),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 📸 Gambar produk
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                product.imageUrl,
                width: double.infinity,
                height: 250,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),

            // 📌 Nama & Harga
            Text(
              product.name,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Rp ${product.price.toStringAsFixed(0)}",
              style: const TextStyle(
                fontSize: 20,
                color: Colors.orange,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),

            // ⭐ Rating & Sold
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber.shade700),
                const SizedBox(width: 4),
                Text("${product.rating} • Terjual ${product.sold}"),
              ],
            ),
            const SizedBox(height: 16),

            // 📖 Deskripsi
            const Text(
              "Deskripsi",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(product.description),
            const SizedBox(height: 30),

            // 🛒 Tombol aksi
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      // ✅ Cek apakah produk sudah ada di cart
                      final existingIndex = cartItems.indexWhere(
                        (p) => p.id == product.id,
                      );
                      if (existingIndex != -1) {
                        cartItems[existingIndex].quantity++;
                      } else {
                        cartItems.add(product);
                      }

                      // Arahkan ke cart page
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyHomePage(
                            title: "OnMart",
                            initialIndex: 2, // langsung ke tab Cart
                          ),
                        ),
                      );
                    },
                    child: const Text("Tambah ke Keranjang"),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: () {
                      // 👉 Di sini bisa arahkan ke halaman checkout langsung
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            "Pembelian langsung ${product.name} berhasil!",
                          ),
                        ),
                      );
                    },
                    child: const Text("Beli Langsung"),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

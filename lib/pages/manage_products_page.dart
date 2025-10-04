import 'package:flutter/material.dart';
import '../models/product.dart';
import 'add_product_page.dart';
import 'edit_product_page.dart';

class ManageProductsPage extends StatefulWidget {
  const ManageProductsPage({super.key});

  @override
  State<ManageProductsPage> createState() => _ManageProductsPageState();
}

class _ManageProductsPageState extends State<ManageProductsPage> {
  void _deleteProduct(String productId) {
    setState(() {
      dummyProducts.removeWhere((product) => product.id == productId);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Produk berhasil dihapus!'),
        backgroundColor: Colors.red,
      ),
    );
  }

  void _navigateAndRefresh() {
    setState(() {});
  }

  // Widget baru untuk tampilan saat daftar produk kosong
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_shopping_cart_rounded, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 20),
          const Text(
            "Anda belum punya produk",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black54),
          ),
          const SizedBox(height: 8),
          const Text(
            "Ayo tambah produk pertamamu untuk mulai berjualan.",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text("Tambah Produk Baru"),
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddProductPage()),
              ).then((_) => _navigateAndRefresh());
            },
          ),
        ],
      ),
    );
  }
  
  // Widget baru untuk menampilkan daftar produk
  Widget _buildProductList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: dummyProducts.length,
      itemBuilder: (context, index) {
        final product = dummyProducts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
          elevation: 2,
          child: ListTile(
            contentPadding: const EdgeInsets.all(10),
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                product.imageUrl,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.image_not_supported, size: 50); // Fallback
                },
              ),
            ),
            title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Text("Stok: ${product.stock}"),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: const Icon(Icons.edit, color: Colors.blueAccent),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => EditProductPage(product: product)),
                    ).then((_) => _navigateAndRefresh());
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => _deleteProduct(product.id),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kelola Produk"),
        actions: [
          // Tombol tambah hanya muncul jika sudah ada produk
          if (dummyProducts.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddProductPage()),
                ).then((_) => _navigateAndRefresh());
              },
              tooltip: 'Tambah Produk Baru',
            ),
        ],
      ),
      body: dummyProducts.isEmpty ? _buildEmptyState() : _buildProductList(),
    );
  }
}


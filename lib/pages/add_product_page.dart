import 'package:flutter/material.dart';
import '../models/product.dart';
// NOTE: Untuk fitur upload foto asli, Anda perlu menambahkan package 'image_picker'
// dan hapus komentar pada baris di bawah ini.
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

class AddProductPage extends StatefulWidget {
  const AddProductPage({super.key});

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _stockController = TextEditingController();
  String? _selectedCategory;
  String? _selectedImagePath; // Untuk menyimpan path gambar yang dipilih

  final List<String> _categories = [
    "shoes",
    "Men_fashion",
    "Women_fashion",
    "electronics",
    "accessories",
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _stockController.dispose();
    super.dispose();
  }

  // --- SIMULASI FUNGSI PILIH GAMBAR ---
  // Ganti fungsi ini dengan image_picker saat sudah siap.
  Future<void> _pickImage() async {
    // Ini adalah simulasi. Di aplikasi nyata, Anda akan menggunakan:
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // if (image != null) {
    //   setState(() {
    //     _selectedImagePath = image.path;
    //   });
    // }

    // Untuk sekarang, kita gunakan gambar placeholder dari assets
    setState(() {
      _selectedImagePath = "assets/product/placeholder.png";
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Simulasi: Gambar placeholder dipilih.")),
    );
  }

  void _saveProduct() {
    // Validasi bahwa gambar sudah dipilih
    if (_selectedImagePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Anda harus memilih foto produk terlebih dahulu.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (_formKey.currentState!.validate()) {
      final newProduct = Product(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        price: double.parse(_priceController.text),
        description: _descriptionController.text,
        category: _selectedCategory!,
        imageUrl: _selectedImagePath!, // Menggunakan path gambar yang dipilih
        rating: 0,
        sold: 0,
        stock: int.parse(_stockController.text),
        sellerId: "seller123",
      );

      dummyProducts.add(newProduct);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Produk baru berhasil ditambahkan!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Produk Baru"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProduct,
            tooltip: 'Simpan Produk',
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // --- WIDGET UNTUK PILIH FOTO ---
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  height: 150,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                    // KODE YANG DIPERBAIKI: Menghapus 'dashPattern'
                    border: Border.all(color: Colors.grey.shade400, width: 1.5),
                  ),
                  child: _selectedImagePath == null
                      ? const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add_a_photo_outlined, size: 40, color: Colors.grey),
                            SizedBox(height: 8),
                            Text("Tambah Foto Produk", style: TextStyle(color: Colors.grey)),
                          ],
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          // Di aplikasi nyata, gunakan Image.file(_selectedImagePath!)
                          child: Image.asset(_selectedImagePath!, fit: BoxFit.cover),
                        ),
                ),
              ),
              const SizedBox(height: 24),
              // --- FORMULIR LAINNYA ---
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nama Produk', border: OutlineInputBorder()),
                validator: (value) => (value == null || value.isEmpty) ? 'Nama produk tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: 'Harga', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Harga tidak boleh kosong';
                  if (double.tryParse(value) == null) return 'Harga harus berupa angka';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // ... sisa form sama seperti sebelumnya ...
              TextFormField(
                controller: _stockController,
                decoration: const InputDecoration(labelText: 'Stok', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                 validator: (value) {
                  if (value == null || value.isEmpty) return 'Stok tidak boleh kosong';
                  if (int.tryParse(value) == null) return 'Stok harus berupa angka bulat';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _selectedCategory,
                hint: const Text('Pilih Kategori'),
                items: _categories.map((String category) {
                  return DropdownMenuItem<String>(value: category, child: Text(category));
                }).toList(),
                onChanged: (newValue) => setState(() => _selectedCategory = newValue),
                validator: (value) => (value == null) ? 'Kategori harus dipilih' : null,
                decoration: const InputDecoration(border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Deskripsi', border: OutlineInputBorder()),
                maxLines: 4,
                validator: (value) => (value == null || value.isEmpty) ? 'Deskripsi tidak boleh kosong' : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}


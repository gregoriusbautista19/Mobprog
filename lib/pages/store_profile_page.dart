import 'package:flutter/material.dart';

// Halaman untuk menampilkan dan mengedit profil toko.
class StoreProfilePage extends StatefulWidget {
  const StoreProfilePage({super.key});

  @override
  State<StoreProfilePage> createState() => _StoreProfilePageState();
}

class _StoreProfilePageState extends State<StoreProfilePage> {
  // Controller untuk mengelola teks di input fields.
  final _storeNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController(); // <-- TAMBAHAN BARU

  // Mode untuk menentukan apakah sedang melihat atau mengedit.
  bool _isEditing = false;

  @override
  void initState() {
    super.initState();
    // Isi dengan data awal (data dummy).
    // Nantinya, data ini akan diambil dari database.
    _storeNameController.text = "Toko Jaya Abadi";
    _descriptionController.text =
        "Menjual berbagai macam kebutuhan elektronik dan fashion terkini dengan harga terjangkau.";
    _locationController.text = "Jakarta, Indonesia"; 
  }

  @override
  void dispose() {
    _storeNameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      if (_isEditing) {
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil disimpan!')),
        );
      }
      _isEditing = !_isEditing; // Toggle mode edit
    });
  }

  void _pickImage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Fitur ganti foto belum tersedia')),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profil Toko Saya"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        actions: [
          // Tombol untuk Edit/Simpan
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _toggleEdit,
            tooltip: _isEditing ? 'Simpan Perubahan' : 'Ubah Profil',
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Avatar Toko dengan tombol edit
            Stack(
              children: [
                const CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.black12,
                  child: Icon(
                    Icons.store,
                    size: 70,
                    color: Colors.white70,
                  ),
                ),
                // Tombol edit foto hanya muncul saat mode edit
                if (_isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 20,
                      backgroundColor: Theme.of(context).colorScheme.primary,
                      child: IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                        onPressed: _pickImage,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 24),

            // Field Nama Toko
            TextFormField(
              controller: _storeNameController,
              enabled: _isEditing,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                labelText: 'Nama Toko',
                border: _isEditing ? const UnderlineInputBorder() : InputBorder.none,
              ),
            ),
            const SizedBox(height: 12),

            // Field Deskripsi Toko
            TextFormField(
              controller: _descriptionController,
              enabled: _isEditing,
              maxLines: null,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              decoration: InputDecoration(
                labelText: 'Deskripsi Toko',
                border: _isEditing ? const UnderlineInputBorder() : InputBorder.none,
              ),
            ),
            const SizedBox(height: 32),
            const Divider(),
            const SizedBox(height: 16),

            // Field Lokasi Toko (Sekarang bisa diedit)
            TextFormField(
              controller: _locationController,
              enabled: _isEditing,
              decoration: InputDecoration(
                labelText: 'Lokasi',
                prefixIcon: const Icon(Icons.location_on),
                border: _isEditing ? const OutlineInputBorder() : InputBorder.none,
              ),
            ),
            const SizedBox(height: 12),

            // Info Tambahan (Contoh)
            _buildInfoRow(Icons.star_rate, 'Rating Toko', '4.8 (2,150 ulasan)'),
          ],
        ),
      ),
    );
  }

  // Widget helper untuk menampilkan baris informasi statis
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.grey.shade600),
        const SizedBox(width: 16),
        Text(
          '$label:',
          style: TextStyle(
              fontWeight: FontWeight.bold, color: Colors.grey.shade700),
        ),
        const Spacer(),
        Text(value),
      ],
    );
  }
}


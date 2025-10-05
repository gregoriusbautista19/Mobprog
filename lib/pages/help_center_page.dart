import 'package:flutter/material.dart';

class HelpCenterPage extends StatelessWidget {
  const HelpCenterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pusat Bantuan"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          Text(
            "Pertanyaan Umum (FAQ)",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          ExpansionTile(
            title: Text("Bagaimana cara melacak pesanan saya?"),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Anda dapat melacak pesanan Anda melalui menu 'Pesanan Saya' di halaman profil. Klik pada pesanan yang ingin Anda lacak untuk melihat status pengiriman terbarunya."),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Bagaimana cara mengembalikan produk?"),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Proses pengembalian dapat dimulai dari halaman detail pesanan di 'Riwayat Pembelian'. Pastikan produk masih dalam masa garansi pengembalian."),
              ),
            ],
          ),
          ExpansionTile(
            title: Text("Metode pembayaran apa saja yang diterima?"),
            children: [
              Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Kami menerima pembayaran melalui Virtual Account (BCA, Mandiri, BRI), E-Wallet (GoPay, OVO, DANA), dan Kartu Kredit/Debit."),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

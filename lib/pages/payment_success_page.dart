import 'package:flutter/material.dart';
import '../main.dart';
import 'purchase_history_page.dart';

class PaymentSuccessPage extends StatelessWidget {
  final double totalAmount;
  const PaymentSuccessPage({super.key, required this.totalAmount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.check_circle, color: Colors.green, size: 100),
              const SizedBox(height: 24),
              const Text(
                "Pembayaran Berhasil!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(
                "Anda telah berhasil melakukan pembayaran sebesar\nRp ${totalAmount.toStringAsFixed(0)}",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const PurchaseHistoryPage()));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Lihat Riwayat Pesanan"),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    // Kembali ke halaman utama
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (context) =>
                              const MyHomePage(title: 'OnMart')),
                      (route) => false,
                    );
                  },
                  child: const Text("Kembali ke Beranda"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


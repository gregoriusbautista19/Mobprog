import 'package:flutter/material.dart';

class SellerDashboardPage extends StatelessWidget {
  const SellerDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard Seller"),
        backgroundColor:  Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: const Center(
        child: Text(
          "Selamat Datang, Seller!",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

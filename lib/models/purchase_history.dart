import 'product.dart';

// Enum untuk menentukan jenis status pembayaran
enum PaymentStatus { lunas, tertunda, dibatalkan }

class PurchaseHistoryItem {
  final String orderId;
  final List<Product> products;
  final DateTime purchaseDate;
  final double totalPrice;
  final PaymentStatus status;
  final String paymentMethod;

  PurchaseHistoryItem({
    required this.orderId,
    required this.products,
    required this.purchaseDate,
    required this.totalPrice,
    required this.status,
    required this.paymentMethod,
  });
}

// Data contoh untuk riwayat pembelian
// Pastikan list 'dummyProducts' Anda memiliki setidaknya 3 item
List<PurchaseHistoryItem> dummyPurchaseHistory = [
  PurchaseHistoryItem(
    orderId: "INV/20251005/001",
    products: [dummyProducts[0], dummyProducts[2]], // Mengambil produk dari product.dart
    purchaseDate: DateTime(2025, 10, 4),
    totalPrice: dummyProducts[0].price + dummyProducts[2].price,
    status: PaymentStatus.lunas,
    paymentMethod: "Virtual Account BCA",
  ),
  PurchaseHistoryItem(
    orderId: "INV/20251002/007",
    products: [dummyProducts[4]], // Mengambil produk dari product.dart
    purchaseDate: DateTime(2025, 10, 2),
    totalPrice: dummyProducts[4].price,
    status: PaymentStatus.lunas,
    paymentMethod: "GoPay",
  ),
];


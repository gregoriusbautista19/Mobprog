import 'package:flutter/material.dart';

// Enum untuk menentukan jenis notifikasi
enum NotificationType { order, promotion, system, campaign }

class NotificationItem {
  final String id;
  final NotificationType type;
  final String title;
  final String subtitle;
  final String time;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.type,
    required this.title,
    required this.subtitle,
    required this.time,
    this.isRead = false,
  });

  // Getter untuk mendapatkan ikon berdasarkan tipe notifikasi
  IconData get icon {
    switch (type) {
      case NotificationType.order:
        return Icons.shopping_cart_outlined;
      case NotificationType.promotion:
        return Icons.local_offer_outlined;
      case NotificationType.system:
        return Icons.settings_outlined;
      case NotificationType.campaign:
        return Icons.campaign_outlined;
      // TIDAK PERLU DEFAULT KARENA SEMUA KEMUNGKINAN SUDAH ADA
    }
  }
}

// Data contoh untuk notifikasi
List<NotificationItem> dummyNotifications = [
  NotificationItem(
    id: '1',
    type: NotificationType.order,
    title: "Pesanan Baru Diterima!",
    subtitle: "Pesanan #12345 untuk 'Sepatu Sneakers' telah dibayar.",
    time: "10 menit lalu",
  ),
  NotificationItem(
    id: '2',
    type: NotificationType.promotion,
    title: "Promo Spesial 10.10!",
    subtitle: "Daftarkan produk Anda untuk ikut campaign Flash Sale 10.10 sekarang juga!",
    time: "2 jam lalu",
    isRead: true,
  ),
   NotificationItem(
    id: '3',
    type: NotificationType.system,
    title: "Pembaruan Kebijakan Privasi",
    subtitle: "Kami telah memperbarui kebijakan privasi kami. Silakan tinjau.",
    time: "1 hari lalu",
  ),
   NotificationItem(
    id: '4',
    type: NotificationType.campaign,
    title: "Campaign Gajian Sale Akan Datang",
    subtitle: "Jangan lewatkan kesempatan untuk meningkatkan penjualan Anda bulan ini.",
    time: "3 hari lalu",
    isRead: true,
  ),
];


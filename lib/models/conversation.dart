// Model untuk satu pesan
class Message {
  final String text;
  final DateTime timestamp;
  final bool isSentByMe; // true jika dikirim oleh penjual, false oleh pembeli

  Message({
    required this.text,
    required this.timestamp,
    required this.isSentByMe,
  });
}

// Model untuk satu percakapan (dengan satu pembeli)
class Conversation {
  final String id;
  final String buyerName;
  final String buyerImageUrl;
  final String lastMessage;
  final DateTime timestamp;
  final int unreadCount;
  final List<Message> messages; // Daftar semua pesan dalam percakapan ini

  Conversation({
    required this.id,
    required this.buyerName,
    required this.buyerImageUrl,
    required this.lastMessage,
    required this.timestamp,
    required this.unreadCount,
    required this.messages,
  });
}

// Data contoh untuk percakapan
List<Conversation> dummyConversations = [
  Conversation(
    id: 'conv1',
    buyerName: 'Budi Santoso',
    buyerImageUrl: 'assets/banner/man.png', // Ganti dengan path gambar profil jika ada
    lastMessage: 'Halo, apakah barang ini masih ada?',
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
    unreadCount: 2,
    messages: [
      Message(text: 'Halo, apakah barang ini masih ada?', timestamp: DateTime.now().subtract(const Duration(minutes: 5)), isSentByMe: false),
      Message(text: 'Halo, iya masih ada kak. Silakan diorder.', timestamp: DateTime.now().subtract(const Duration(minutes: 4)), isSentByMe: true),
    ],
  ),
  Conversation(
    id: 'conv2',
    buyerName: 'Citra Lestari',
    buyerImageUrl: 'assets/banner/women.png',
    lastMessage: 'Terima kasih banyak!',
    timestamp: DateTime.now().subtract(const Duration(hours: 2)),
    unreadCount: 0,
    messages: [
       Message(text: 'Baik kak, sudah saya proses ya pesanannya.', timestamp: DateTime.now().subtract(const Duration(hours: 2, minutes: 2)), isSentByMe: true),
       Message(text: 'Terima kasih banyak!', timestamp: DateTime.now().subtract(const Duration(hours: 2)), isSentByMe: false),
    ],
  ),
];

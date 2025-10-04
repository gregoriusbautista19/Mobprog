class StoreProfile {
  String name;
  String description;
  String location;
  final double rating;

  StoreProfile({
    required this.name,
    required this.description,
    required this.location,
    required this.rating,
  });
}

// Data contoh yang akan kita gunakan di seluruh aplikasi
// Ini bertindak sebagai database sementara kita
final storeProfileData = StoreProfile(
  name: "Toko Jaya Abadi",
  description: "Menjual berbagai macam kebutuhan elektronik dan fashion terkini dengan harga terjangkau.",
  location: "Jakarta, Indonesia",
  rating: 4.8,
);


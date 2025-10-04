// File ini adalah cetak biru (blueprint) untuk data profil toko.
class StoreProfile {
  String name;
  String description;
  String location;
  String profileImageUrl;
  double rating;

  StoreProfile({
    required this.name,
    required this.description,
    required this.location,
    required this.profileImageUrl,
    required this.rating,
  });
}

// Ini adalah data sementara kita (seperti database kecil)
// yang akan digunakan oleh seluruh aplikasi.
var storeProfileData = StoreProfile(
  name: "Toko Jaya Abadi",
  description: "Menjual berbagai macam kebutuhan elektronik dan fashion terkini dengan harga terjangkau.",
  location: "Jakarta Pusat, Indonesia",
  profileImageUrl: "assets/banner/store_logo.png", // Ganti dengan path gambar yang sesuai jika ada
  rating: 4.8,
);


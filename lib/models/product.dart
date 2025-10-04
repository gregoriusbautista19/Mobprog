// File ini adalah cetak biru untuk setiap produk di aplikasi kita.
class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;
  final int sold;
  final String category;
  int quantity;
  final int stock;      // <-- WAJIB ADA
  final String sellerId; // <-- WAJIB ADA

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.sold,
    required this.category,
    this.quantity = 1,
    required this.stock,     // <-- WAJIB ADA
    required this.sellerId,  // <-- WAJIB ADA
  });
}

// Dummy data yang sudah LENGKAP dengan stock & sellerId
List<Product> dummyProducts = [
  Product(id: "1", name: "Sepatu Sneakers", price: 3500000, imageUrl: "assets/product/nikedunk.png", description: "Sneakers Nike Dunk Low Retro White Black", rating: 4.8, sold: 150, category: "shoes", stock: 50, sellerId: "seller001"),
  Product(id: "18", name: "Casual Vans", price: 1500000, imageUrl: "assets/product/vans.png", description: "Casual Shoes Vans Old Skool Black White", rating: 4.8, sold: 150, category: "shoes", stock: 30, sellerId: "seller001"),
  Product(id: "2", name: "Kaos Polos", price: 100000, imageUrl: "assets/product/baju1.png", description: "Kaos Polos Cotton Combed 30s", rating: 4.5, sold: 500, category: "Men_fashion", stock: 100, sellerId: "seller002"),
  Product(id: "9", name: "Kaos PML", price: 1500000, imageUrl: "assets/product/men1.png", description: "Kaos PML Pcamy Cotton 50s", rating: 4.5, sold: 500, category: "Men_fashion", stock: 20, sellerId: "seller002"),
  Product(id: "10", name: "Kaos Luoqing", price: 6000000, imageUrl: "assets/product/men2.png", description: "Kaos Luoqing Based Limitid", rating: 4.5, sold: 500, category: "Men_fashion", stock: 5, sellerId: "seller002"),
  Product(id: "11", name: "Kaos Correvry NBA", price: 3000000, imageUrl: "assets/product/men3.png", description: "Kaos Correvry NBA Boston Celtics", rating: 4.6, sold: 500, category: "Men_fashion", stock: 15, sellerId: "seller002"),
  Product(id: "12", name: "Kaos HR Super", price: 2000000, imageUrl: "assets/product/men4.png", description: "Kaos HR Super star white", rating: 4.8, sold: 200, category: "Men_fashion", stock: 25, sellerId: "seller002"),
  Product(id: "13", name: "Kaos BMW M3", price: 5500000, imageUrl: "assets/product/men4.png", description: "Kaos BMW M3 Motorrad Limited Edition", rating: 4.9, sold: 40, category: "Men_fashion", stock: 8, sellerId: "seller002"),
  Product(id: "14", name: "Kaos 90 Red", price: 1130000, imageUrl: "assets/product/women1.png", description: "Kaos 90 Red Girl Compact", rating: 4.5, sold: 300, category: "Women_fashion", stock: 40, sellerId: "seller003"),
  Product(id: "15", name: "Kaos Pink Drick", price: 1130000, imageUrl: "assets/product/women2.png", description: "Kaos Pink Drick Girl Compact", rating: 4.6, sold: 300, category: "Women_fashion", stock: 35, sellerId: "seller003"),
  Product(id: "16", name: "Kaos Addidas Sun Flower", price: 2000000, imageUrl: "assets/product/women3.png", description: "Kaos Addidas Sun Flower Pitcher", rating: 4.7, sold: 150, category: "Women_fashion", stock: 22, sellerId: "seller003"),
  Product(id: "17", name: "Hoodie Yankee Black Original", price: 4500000, imageUrl: "assets/product/women4.png", description: "Hoodie Yankee Black Original Girl", rating: 4.8, sold: 100, category: "Women_fashion", stock: 18, sellerId: "seller003"),
  Product(id: "3", name: "Tas Ransel", price: 250000, imageUrl: "assets/product/ransel.png", description: "Tas Ransel Laptop Waterproof", rating: 4.6, sold: 200, category: "accessories", stock: 60, sellerId: "seller004"),
  Product(id: "4", name: "Jam Tangan", price: 5000000, imageUrl: "assets/product/jam.png", description: "Smartwatch Series 6 40mm", rating: 4.7, sold: 300, category: "accessories", stock: 25, sellerId: "seller004"),
  Product(id: "5", name: "Keyboard ROG", price: 450000, imageUrl: "assets/product/keyboard.png", description: "Mechanical Gaming Keyboard ROG", rating: 4.9, sold: 100, category: "electronics", stock: 45, sellerId: "seller005"),
  Product(id: "6", name: "Mouse ROG", price: 155000, imageUrl: "assets/product/mouse.png", description: "Gaming Mouse ROG", rating: 4.5, sold: 400, category: "electronics", stock: 80, sellerId: "seller005"),
  Product(id: "7", name: "Monitor Gaming", price: 2500000, imageUrl: "assets/product/monitor.png", description: "27 Inch 144Hz Gaming Monitor", rating: 4.8, sold: 150, category: "electronics", stock: 33, sellerId: "seller005"),
  Product(id: "8", name: "Headphone", price: 1500000, imageUrl: "assets/product/headphone.png", description: "Wireless Noise Cancelling Headphone", rating: 4.6, sold: 200, category: "electronics", stock: 28, sellerId: "seller005"),
];


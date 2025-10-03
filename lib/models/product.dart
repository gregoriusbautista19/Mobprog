class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;
  final String description;
  final double rating;
  final int sold;
  int quantity;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.description,
    required this.rating,
    required this.sold,
    this.quantity = 1,
  });
}

// Dummy data
List<Product> dummyProducts = [
  Product(
    id: "1",
    name: "Sepatu Sneakers",
    price: 3500000,
    imageUrl: "assets/product/nikedunk.png",
    description: "Sneakers Nike Dunk Low Retro White Black",
    rating: 4.8,
    sold: 150,
  ),

  Product(
    id: "2",
    name: "Kaos Polos",
    price: 100000,
    imageUrl: "assets/product/baju1.png",
    description: "Kaos Polos Cotton Combed 30s",
    rating: 4.5,
    sold: 500,
  ),

  Product(
    id: "3",
    name: "Tas Ransel",
    price: 250000,
    imageUrl: "assets/product/ransel.png",
    description: "Tas Ransel Laptop Waterproof",
    rating: 4.6,
    sold: 200,
  ),

  Product(
    id: "4",
    name: "Jam Tangan",
    price: 5000000,
    imageUrl: "assets/product/jam.png",
    description: "Smartwatch Series 6 40mm",
    rating: 4.7,
    sold: 300,
  ),

  Product(
    id: "5",
    name: "Keyboard ROG",
    price: 450000,
    imageUrl: "assets/product/keyboard.png",
    description: "Mechanical Gaming Keyboard ROG",
    rating: 4.9,
    sold: 100,
  ),

  Product(
    id: "6",
    name: "Mouse ROG",
    price: 155000,
    imageUrl: "assets/product/mouse.png",
    description: "Gaming Mouse ROG",
    rating: 4.5,
    sold: 400,
  ),

  Product(
    id: "7",
    name: "Monitor Gaming",
    price: 2500000,
    imageUrl: "assets/product/monitor.png",
    description: "27 Inch 144Hz Gaming Monitor",
    rating: 4.8,
    sold: 150,
  ),

  Product(
    id: "8",
    name: "Headphone",
    price: 1500000,
    imageUrl: "assets/product/headphone.png",
    description: "Wireless Noise Cancelling Headphone",
    rating: 4.6,
    sold: 200,
  ),
];

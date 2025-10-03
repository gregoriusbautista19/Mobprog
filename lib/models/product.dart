class Product {
  final String id;
  final String name;
  final double price;
  final String imageUrl;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

// Dummy data
List<Product> dummyProducts = [
  Product(
    id: "1",
    name: "Sepatu Sneakers",
    price: 3500000,
    imageUrl: "assets/product/nikedunk.png",
  ),

  Product(
    id: "2",
    name: "Kaos Polos",
    price: 100000,
    imageUrl: "assets/product/baju1.png",
  ),

  Product(
    id: "3",
    name: "Tas Ransel",
    price: 250000,
    imageUrl: "assets/product/ransel.png",
  ),

  Product(
    id: "4",
    name: "Jam Tangan",
    price: 5000000,
    imageUrl: "assets/product/jam.png",
  ),

  Product(
    id: "5",
    name: "Keyboard ROG",
    price: 450000,
    imageUrl: "assets/product/keyboard.png",
  ),

  Product(
    id: "6",
    name: "Mouse ROG",
    price: 155000,
    imageUrl: "assets/product/mouse.png",
  ),

  Product(
    id: "7",
    name: "Monitor Gaming",
    price: 2500000,
    imageUrl: "assets/product/monitor.png",
  ),

  Product(
    id: "8",
    name: "Headphone",
    price: 1500000,
    imageUrl: "assets/product/headphone.png",
  ),
];

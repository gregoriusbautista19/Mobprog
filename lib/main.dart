import 'package:flutter/material.dart';
import 'models/product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnMart Application',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 253, 131, 10),
        ),
        useMaterial3: true, // aktifkan Material 3
      ),
      home: const MyHomePage(title: 'OnMart'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  // Widget untuk menampilkan gambar (asset / network)
  Widget buildProductImage(String imageUrl) {
    if (imageUrl.startsWith('http')) {
      return Image.network(imageUrl, fit: BoxFit.cover, width: double.infinity);
    } else {
      return Image.asset(imageUrl, fit: BoxFit.cover, width: double.infinity);
    }
  }

  // halaman dummy untuk demo
  static final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();

    // isi _pages
    _pages.addAll([
      // Home Page: Grid Produk
      GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: dummyProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // 2 kolom
          childAspectRatio: 0.7,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) {
          final product = dummyProducts[i];
          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(12),
                    ),
                    child: buildProductImage(product.imageUrl),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    product.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Text("Rp ${product.price.toStringAsFixed(0)}"),
                ),
                const SizedBox(height: 6),
              ],
            ),
          );
        },
      ),

      // Halaman Favorite
      const Center(
        child: Text(" Favorite Page", style: TextStyle(fontSize: 20)),
      ),

      // Halaman Cart
      const Center(child: Text(" Cart Page", style: TextStyle(fontSize: 20))),

      // Halaman Profile
      const Center(
        child: Text(" Profile Page", style: TextStyle(fontSize: 20)),
      ),
    ]);
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // NAVBAR ATAS
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(widget.title),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.search), onPressed: () {})],
      ),

      // BODY
      body: _pages[_selectedIndex],

      // NAVIGATION BAR BAWAH (Material 3)
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.favorite_border),
            selectedIcon: Icon(Icons.favorite),
            label: "Favorite",
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            selectedIcon: Icon(Icons.shopping_cart),
            label: "Cart",
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}

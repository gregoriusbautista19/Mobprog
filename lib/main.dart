import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/product.dart';
import 'pages/product_detail_page.dart';
import 'pages/login_page.dart';
import 'pages/electronics_page.dart';
import 'pages/women_fashion_page.dart';
import 'pages/men_fashion_page.dart';
import 'pages/shoes_page.dart';

List<Product> cartItems = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'OnMart',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 253, 131, 10),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final int initialIndex;

  const MyHomePage({super.key, required this.title, this.initialIndex = 0});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  // Home Page
  Widget buildHomePage(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Search in OnMart...",
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // Banner
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/banner/nike.png",
              height: 160,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 12),

          // Menu cepat
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildQuickMenu(
                  Icons.local_fire_department,
                  "Todays Deal",
                  Colors.red,
                ),
                _buildQuickMenu(Icons.flash_on, "Flash Deal", Colors.orange),
                _buildQuickMenu(Icons.store, "Brands", Colors.blue),
                _buildQuickMenu(Icons.star, "Top Picks", Colors.green),
              ],
            ),
          ),
          const SizedBox(height: 20),

          //Featured Categories
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Featured Categories",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              children: [
                _buildCategoryCard(
                  context,
                  "Women Fashion",
                  "assets/banner/women.png",
                  Colors.pink.shade50,
                ),
                _buildCategoryCard(
                  context,
                  "Electronics",
                  "assets/banner/computer.png",
                  Colors.blue.shade50,
                ),
                _buildCategoryCard(
                  context,
                  "Men Fashion",
                  "assets/banner/man.png",
                  Colors.green.shade50,
                ),
                _buildCategoryCard(
                  context,
                  "Shoes Lifestyle",
                  "assets/banner/shoes.png",
                  Colors.yellow.shade50,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),

          // Flash Sale
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              "Flash Sale",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: dummyProducts.length,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.7,
            ),
            itemBuilder: (ctx, i) {
              final product = dummyProducts[i];
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    ctx,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailPage(product: product),
                    ),
                  );
                },
                child: Card(
                  elevation: 3,
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
                          child: Image.asset(
                            product.imageUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          product.name,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Rp ${product.price.toStringAsFixed(0)}",
                          style: const TextStyle(
                            color: Colors.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // Widget builders
  Widget _buildQuickMenu(IconData icon, String title, Color color) {
    return Column(
      children: [
        CircleAvatar(
          radius: 24,
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color, size: 28),
        ),
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildCategoryCard(
    BuildContext context,
    String title,
    String image,
    Color bgColor,
  ) {
    return GestureDetector(
      onTap: () {
        if (title == "Electronics") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Electronics()),
          );
        } else if (title == "Women Fashion") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const WomenFashionPage()),
          );
        } else if (title == "Men Fashion") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MenFashionPage()),
          );
        } else if (title == "Shoes Lifestyle") {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ShoesPage()),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Kategori $title belum tersedia")),
          );
        }
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(image, height: 50),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  // pages for bottom navigation
  List<Widget> get _pages => [
    buildHomePage(context),
    const Center(child: Text("Favorite Page", style: TextStyle(fontSize: 20))),
    CartPage(),
    FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final prefs = snapshot.data!;
        final name = prefs.getString('name') ?? "Guest";
        final email = prefs.getString('email') ?? "Tidak ada email";

        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 40,
                child: Icon(Icons.person, size: 50),
              ),
              const SizedBox(height: 20),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(email, style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 30),
              ElevatedButton.icon(
                onPressed: () async {
                  await prefs.clear();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text("Logout"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: Text(widget.title),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
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

// cart page
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return cartItems.isEmpty
        ? const Center(child: Text("Cart kosong"))
        : ListView.builder(
            padding: const EdgeInsets.all(10),
            itemCount: cartItems.length,
            itemBuilder: (ctx, i) {
              final product = cartItems[i];
              return Card(
                child: ListTile(
                  leading: Image.asset(
                    product.imageUrl,
                    width: 50,
                    fit: BoxFit.cover,
                  ),
                  title: Text(product.name),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Harga satuan: Rp ${product.price.toStringAsFixed(0)}",
                      ),
                      Text(
                        "Total: Rp ${(product.price * product.quantity).toStringAsFixed(0)}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.orange,
                        ),
                      ),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove_circle_outline),
                        onPressed: () {
                          setState(() {
                            if (product.quantity > 1) {
                              product.quantity--;
                            } else {
                              cartItems.removeAt(i);
                            }
                          });
                        },
                      ),
                      Text("${product.quantity}"),
                      IconButton(
                        icon: const Icon(Icons.add_circle_outline),
                        onPressed: () {
                          setState(() {
                            product.quantity++;
                          });
                        },
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Berhasil membeli ${product.name} x${product.quantity} "
                                "Total Rp ${(product.price * product.quantity).toStringAsFixed(0)}",
                              ),
                            ),
                          );
                        },
                        child: const Text("Beli"),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}

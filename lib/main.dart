import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/product.dart';
import 'pages/product_detail_page.dart';
import 'pages/login_page.dart';
import 'pages/electronics_page.dart';
import 'pages/women_fashion_page.dart';
import 'pages/men_fashion_page.dart';
import 'pages/shoes_page.dart';
import 'pages/checkout_page.dart';
import 'pages/purchase_history_page.dart';
import 'pages/settings_page.dart';
import 'pages/help_center_page.dart';

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
        scaffoldBackgroundColor: Colors.grey[100],
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

  // --- WIDGET HALAMAN UTAMA (TIDAK DIUBAH) ---
  Widget buildHomePage(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchBar(),
            const SizedBox(height: 16),
            _buildBanner(),
            const SizedBox(height: 16),
            _buildQuickMenuRow(),
            const SizedBox(height: 24),
            const Text("Featured Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            _buildCategoryList(context),
            const SizedBox(height: 24),
            const Text("Flash Sale", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: dummyProducts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 0.7,
              ),
              itemBuilder: (ctx, i) {
                return _buildProductCard(context, dummyProducts[i]);
              },
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET HELPER (TIDAK DIUBAH) ---
  Widget _buildSearchBar() => TextField(
      decoration: InputDecoration(
        hintText: "Search in OnMart...",
        prefixIcon: const Icon(Icons.search),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide.none),
      ),
    );

  Widget _buildBanner() => ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Image.asset("assets/banner/nike.png", height: 160, width: double.infinity, fit: BoxFit.cover),
    );

  Widget _buildQuickMenuRow() => Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildQuickMenu(Icons.local_fire_department, "Todays Deal", Colors.red),
        _buildQuickMenu(Icons.flash_on, "Flash Deal", Colors.orange),
        _buildQuickMenu(Icons.store, "Brands", Colors.blue),
        _buildQuickMenu(Icons.star, "Top Picks", Colors.green),
      ],
    );

  Widget _buildCategoryList(BuildContext context) => SizedBox(
      height: 110,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildCategoryCard(context, "Women Fashion", "assets/banner/women.png", Colors.pink.shade50),
          _buildCategoryCard(context, "Electronics", "assets/banner/computer.png", Colors.blue.shade50),
          _buildCategoryCard(context, "Men Fashion", "assets/banner/man.png", Colors.green.shade50),
          _buildCategoryCard(context, "Shoes Style", "assets/banner/shoes.png", Colors.yellow.shade50),
        ],
      ),
    );

  Widget _buildProductCard(BuildContext context, Product product) => GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetailPage(product: product))),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(product.imageUrl, fit: BoxFit.cover, width: double.infinity),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text("Rp ${product.price.toStringAsFixed(0)}", style: TextStyle(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600)),
                  const SizedBox(height: 4),
                  Row(children: [
                    Icon(Icons.star, color: Colors.amber.shade700, size: 14),
                    const SizedBox(width: 4),
                    Text("${product.rating} | ${product.sold} terjual", style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                  ]),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  Widget _buildQuickMenu(IconData icon, String title, Color color) => Column(
      children: [
        CircleAvatar(radius: 24, backgroundColor: color.withOpacity(0.1), child: Icon(icon, color: color, size: 28)),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500)),
      ],
    );

  Widget _buildCategoryCard(BuildContext context, String title, String image, Color bgColor) => GestureDetector(
      onTap: () {
        if (title == "Electronics") Navigator.push(context, MaterialPageRoute(builder: (context) => const Electronics()));
        else if (title == "Women Fashion") Navigator.push(context, MaterialPageRoute(builder: (context) => const WomenFashionPage()));
        else if (title == "Men Fashion") Navigator.push(context, MaterialPageRoute(builder: (context) => const MenFashionPage()));
        else if (title == "Shoes Style") Navigator.push(context, MaterialPageRoute(builder: (context) => const ShoesPage()));
      },
      child: Container(
        width: 100,
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(12), border: Border.all(color: Colors.grey.shade200)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(image, height: 50),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500), textAlign: TextAlign.center),
        ]),
      ),
    );

  // --- HALAMAN PROFIL DIKEMBALIKAN KE VERSI STABIL ---
  Widget _buildProfilePage() {
    return FutureBuilder(
      future: SharedPreferences.getInstance(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final prefs = snapshot.data!;
        final name = prefs.getString('name') ?? "Guest";
        final email = prefs.getString('email') ?? "Tidak ada email";

        // Menggunakan SingleChildScrollView agar bisa di-scroll jika kontennya panjang
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Header Profil Sederhana
                Column(
                  children: [
                    CircleAvatar(
                      radius: 45,
                      backgroundColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
                      child: Icon(Icons.person, size: 50, color: Theme.of(context).colorScheme.primary),
                    ),
                    const SizedBox(height: 16),
                    Text(name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text(email, style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
                  ],
                ),
                const SizedBox(height: 32),

                // Menu Opsi dalam Card
                Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    children: [
                      _buildProfileMenuItem(
                        icon: Icons.history,
                        title: "Riwayat Pembelian",
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const PurchaseHistoryPage()));
                        },
                      ),
                      _buildProfileMenuItem(
                        icon: Icons.settings_outlined,
                        title: "Pengaturan Akun",
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsPage()));
                        },
                      ),
                       _buildProfileMenuItem(
                        icon: Icons.help_outline,
                        title: "Pusat Bantuan",
                        onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context) => const HelpCenterPage()));
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Tombol Logout
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await prefs.clear();
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginPage()),
                          (route) => false,
                      );
                    },
                    icon: const Icon(Icons.logout),
                    label: const Text("Logout"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade400,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  
  // Helper untuk menu item di profil
  Widget _buildProfileMenuItem({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey.shade700),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  // Halaman untuk bottom navigation
  List<Widget> get _pages => [
    buildHomePage(context),
    const Center(child: Text("Favorite Page", style: TextStyle(fontSize: 20))),
    CartPage(),
    _buildProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        title: const Text('OnMart'),
        centerTitle: true,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onItemTapped,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: "Home"),
          NavigationDestination(icon: Icon(Icons.favorite_border), selectedIcon: Icon(Icons.favorite), label: "Favorite"),
          NavigationDestination(icon: Icon(Icons.shopping_cart_outlined), selectedIcon: Icon(Icons.shopping_cart), label: "Cart"),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// Cart page
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double get _totalPrice {
    double total = 0;
    for (var item in cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: cartItems.isEmpty
              ? const Center(child: Text("Keranjang Anda masih kosong."))
              : ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: cartItems.length,
                  itemBuilder: (ctx, i) {
                    final product = cartItems[i];
                    return Card(
                      child: ListTile(
                        leading: Image.asset(product.imageUrl, width: 50, fit: BoxFit.cover),
                        title: Text(product.name),
                        subtitle: Text("Rp ${product.price.toStringAsFixed(0)}"),
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
                              onPressed: () => setState(() => product.quantity++),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
        ),
        if (cartItems.isNotEmpty)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total Harga:"),
                    Text("Rp ${_totalPrice.toStringAsFixed(0)}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CheckoutPage(cartItems: cartItems, totalPrice: _totalPrice)));
                  },
                  child: const Text("Checkout"),
                ),
              ],
            ),
          ),
      ],
    );
  }
}


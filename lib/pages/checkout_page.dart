import 'package:flutter/material.dart';
import '../models/product.dart';
import '../models/purchase_history.dart';
import 'payment_success_page.dart';

// Kelas untuk data opsi pengiriman
class ShippingOption {
  final String name;
  final String estimate;
  final double cost;
  final IconData icon;

  ShippingOption({
    required this.name,
    required this.estimate,
    required this.cost,
    required this.icon,
  });
}

class CheckoutPage extends StatefulWidget {
  final List<Product> cartItems;
  final double totalPrice;

  const CheckoutPage({
    super.key,
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  // State untuk data alamat
  String _recipientName = "John Doe";
  String _recipientPhone = "(+62) 812-3456-7890";
  String _recipientAddress = "Jl. Jenderal Sudirman No. Kav. 52-53, Jakarta Selatan";
  String _addressCoordinates = "-6.2249, 106.8093";


  // State untuk melacak pilihan pengguna
  String? _selectedPaymentMethod;
  String? _selectedBank;
  ShippingOption? _selectedShipping;
  
  // Controllers untuk input fields
  final _phoneController = TextEditingController();
  final _ccNumberController = TextEditingController();
  final _ccExpiryController = TextEditingController();
  final _ccCvvController = TextEditingController();


  // Daftar data
  final List<String> _paymentMethods = ["Virtual Account", "GoPay", "OVO", "DANA", "Credit/Debit Card"];
  final List<String> _banks = ["BCA", "Mandiri", "BRI"];
  final List<ShippingOption> _shippingOptions = [
    ShippingOption(name: "Prioritas", estimate: "1-2 Hari", cost: 25000, icon: Icons.flash_on),
    ShippingOption(name: "Normal", estimate: "2-4 Hari", cost: 15000, icon: Icons.local_shipping),
    ShippingOption(name: "Hemat", estimate: "5-7 Hari", cost: 8000, icon: Icons.shield_moon),
  ];
  
  // --- PERUBAHAN UTAMA: KALKULASI DINAMIS ---
  double get _subtotal {
    double total = 0;
    for (var item in widget.cartItems) {
      total += item.price * item.quantity;
    }
    return total;
  }
  double get _shippingCost => _selectedShipping?.cost ?? 0;
  double get _discount => -5000; // Contoh diskon statis
  double get _ppn => (_subtotal + _shippingCost) * 0.11; // PPN 11%
  double get _grandTotal => _subtotal + _shippingCost + _discount + _ppn;


  @override
  void dispose() {
    _phoneController.dispose();
    _ccNumberController.dispose();
    _ccExpiryController.dispose();
    _ccCvvController.dispose();
    super.dispose();
  }

  void _processPayment() {
    // Validasi input
    if (_selectedShipping == null) {
      _showError("Silakan pilih metode pengiriman.");
      return;
    }
    String paymentDetail = _selectedPaymentMethod ?? "";
    if (paymentDetail.isEmpty) {
      _showError("Silakan pilih metode pembayaran.");
      return;
    }
    if (paymentDetail == "Virtual Account") {
      if (_selectedBank == null) {
        _showError("Silakan pilih bank untuk Virtual Account.");
        return;
      }
      paymentDetail = "VA $_selectedBank";
    } else if (paymentDetail == "Credit/Debit Card") {
        if (_ccNumberController.text.isEmpty || _ccExpiryController.text.isEmpty || _ccCvvController.text.isEmpty) {
            _showError("Silakan lengkapi detail kartu Anda.");
            return;
        }
        paymentDetail = "Kartu Kredit";
    }
    else {
      if (_phoneController.text.isEmpty) {
        _showError("Silakan masukkan nomor HP Anda.");
        return;
      }
      paymentDetail = "$paymentDetail (${_phoneController.text})";
    }

    // Lanjutkan proses
    final newPurchase = PurchaseHistoryItem(
      orderId: "INV/${DateTime.now().millisecondsSinceEpoch}",
      products: List.from(widget.cartItems),
      purchaseDate: DateTime.now(),
      totalPrice: _grandTotal,
      status: PaymentStatus.lunas,
      paymentMethod: paymentDetail,
    );
    dummyPurchaseHistory.insert(0, newPurchase);
    widget.cartItems.clear();

    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(
        builder: (context) => PaymentSuccessPage(totalAmount: _grandTotal),
      ),
      (route) => route.isFirst,
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void _showEditAddressSheet() {
    final nameController = TextEditingController(text: _recipientName);
    final phoneController = TextEditingController(text: _recipientPhone);
    final addressController = TextEditingController(text: _recipientAddress);
    
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(ctx).viewInsets.bottom,
          top: 20, left: 20, right: 20
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Ubah Alamat Pengiriman", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextFormField(controller: nameController, decoration: const InputDecoration(labelText: "Nama Penerima", border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextFormField(controller: phoneController, decoration: const InputDecoration(labelText: "Nomor Telepon", border: OutlineInputBorder())),
              const SizedBox(height: 12),
              TextFormField(controller: addressController, decoration: const InputDecoration(labelText: "Alamat Lengkap", border: OutlineInputBorder()), maxLines: 3),
              const SizedBox(height: 12),
              OutlinedButton.icon(
                icon: const Icon(Icons.map_outlined),
                label: const Text("Pilih Lokasi di Peta"),
                onPressed: () {
                    // Simulasi memilih lokasi, di aplikasi nyata akan membuka Google Maps
                    setState(() {
                        _addressCoordinates = "-6.2251, 106.8099"; // Contoh koordinat baru
                    });
                    ScaffoldMessenger.of(ctx).showSnackBar(const SnackBar(content: Text("Lokasi berhasil dipasang!"), backgroundColor: Colors.green,));
                },
              ),
              Text("Koordinat: $_addressCoordinates", style: const TextStyle(color: Colors.grey, fontSize: 12)),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: const Text("Simpan Alamat"),
                  onPressed: () {
                    setState(() {
                      _recipientName = nameController.text;
                      _recipientPhone = phoneController.text;
                      _recipientAddress = addressController.text;
                    });
                    Navigator.of(ctx).pop();
                  },
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Checkout"),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildAddressCard(),
            _buildProductSummary(),
            const SizedBox(height: 24),
            const Text("Pilihan Pengiriman", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ..._shippingOptions.map((option) => _buildShippingTile(option)),
            const SizedBox(height: 24),
            const Text("Pilih Metode Pembayaran", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ..._paymentMethods.map((method) => _buildPaymentMethodTile(method)),
            if (_selectedPaymentMethod != null) _buildConditionalInput(),
            const SizedBox(height: 24),
            _buildCostSummary(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomButton(),
    );
  }

  // --- WIDGET HELPER ---

  Widget _buildAddressCard() {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: _showEditAddressSheet,
        borderRadius: BorderRadius.circular(4),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.location_on, color: Theme.of(context).colorScheme.primary, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Alamat Penerima", style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text("$_recipientName ($_recipientPhone)\n$_recipientAddress"),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey),
            ],
          ),
        ),
      ),
    );
  }

   // --- PERUBAHAN UTAMA: TAMPILAN PRODUK DENGAN KUANTITAS ---
   Widget _buildProductSummary() {
    return Card(
      margin: const EdgeInsets.only(top: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("${widget.cartItems.length} Produk di Keranjang", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
            const Divider(),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                return _buildProductItem(widget.cartItems[index]);
              },
              separatorBuilder: (context, index) => const Divider(height: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildProductItem(Product product) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.asset(product.imageUrl, width: 60, height: 60, fit: BoxFit.cover),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(product.name, maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 4),
              Text("Rp ${product.price.toStringAsFixed(0)}", style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        // Quantity Selector
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () {
                if (product.quantity > 1) {
                  setState(() {
                    product.quantity--;
                  });
                }
              },
            ),
            SizedBox(
              width: 30,
              child: Text(
                product.quantity.toString(), 
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)
              ),
            ),
            IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              icon: const Icon(Icons.add_circle_outline, color: Colors.green),
              onPressed: () {
                // Optional: check against stock if available
                setState(() {
                  product.quantity++;
                });
              },
            ),
          ],
        ),
      ],
    );
  }


  Widget _buildShippingTile(ShippingOption option) {
    final bool isSelected = _selectedShipping == option;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedShipping = option),
        borderRadius: BorderRadius.circular(8),
        child: ListTile(
          leading: Icon(
            isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: Theme.of(context).colorScheme.primary,
          ),
          title: Text(option.name, style: const TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(option.estimate),
          trailing: Text("Rp ${option.cost.toStringAsFixed(0)}"),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodTile(String method) {
    final bool isSelected = _selectedPaymentMethod == method;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6),
      elevation: isSelected ? 4 : 1,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
          width: 1.5,
        ),
      ),
      child: InkWell(
        onTap: () => setState(() => _selectedPaymentMethod = method),
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(
                isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 16),
              Text(method, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConditionalInput() {
    switch (_selectedPaymentMethod) {
      case "Virtual Account":
        return Card(
          margin: const EdgeInsets.only(top: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Pilih Bank:", style: TextStyle(fontWeight: FontWeight.bold)),
                ..._banks.map((bank) => RadioListTile<String>(
                      title: Text(bank),
                      value: bank,
                      groupValue: _selectedBank,
                      onChanged: (value) => setState(() => _selectedBank = value),
                    )),
                if (_selectedBank != null)
                  TextFormField(
                    readOnly: true,
                    initialValue: "1234 5678 9012 3456",
                    decoration: const InputDecoration(
                      labelText: "Nomor Virtual Account",
                      border: OutlineInputBorder(),
                    ),
                  ),
              ],
            ),
          ),
        );
      case "Credit/Debit Card":
        return Card(
          margin: const EdgeInsets.only(top: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
                children: [
                    TextFormField(
                        controller: _ccNumberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(labelText: "Nomor Kartu", border: OutlineInputBorder(), prefixIcon: Icon(Icons.credit_card)),
                    ),
                    const SizedBox(height: 12),
                    Row(
                        children: [
                            Expanded(
                                child: TextFormField(
                                    controller: _ccExpiryController,
                                    keyboardType: TextInputType.datetime,
                                    decoration: const InputDecoration(labelText: "MM/YY", border: OutlineInputBorder()),
                                ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                                child: TextFormField(
                                    controller: _ccCvvController,
                                    keyboardType: TextInputType.number,
                                    decoration: const InputDecoration(labelText: "CVV", border: OutlineInputBorder()),
                                ),
                            ),
                        ],
                    ),
                ],
            ),
          ),
        );
      case "GoPay":
      case "OVO":
      case "DANA":
        return Card(
          margin: const EdgeInsets.only(top: 12),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Nomor HP Terdaftar di $_selectedPaymentMethod",
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.phone_android),
              ),
            ),
          ),
        );
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _buildCostSummary() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildCostRow("Subtotal Produk", _subtotal),
            _buildCostRow("Ongkos Kirim", _shippingCost),
            _buildCostRow("Diskon", _discount, isDiscount: true),
            _buildCostRow("PPN (11%)", _ppn),
            const Divider(),
            _buildCostRow("Total Pembayaran", _grandTotal, isTotal: true),
          ],
        ),
      ),
    );
  }
  
  Widget _buildCostRow(String label, double amount, {bool isTotal = false, bool isDiscount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(fontSize: isTotal ? 16 : 14, fontWeight: isTotal ? FontWeight.bold : FontWeight.normal)),
          Text(
            "${isDiscount ? '-' : ''}Rp ${amount.abs().toStringAsFixed(0)}",
            style: TextStyle(
              fontSize: isTotal ? 16 : 14,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isDiscount ? Colors.green : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButton() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.1), spreadRadius: 0, blurRadius: 10)
        ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Total Bayar", style: TextStyle(color: Colors.grey)),
              Text(
                "Rp ${_grandTotal.toStringAsFixed(0)}",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.primary),
              ),
            ],
          ),
          ElevatedButton(
            onPressed: _processPayment,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Colors.white,
              textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            child: const Text("Bayar Sekarang"),
          ),
        ],
      ),
    );
  }
}


// Model untuk satu titik data di grafik
class SalesData {
  final String day;
  final double sales;

  SalesData(this.day, this.sales);
}

// Model untuk produk terlaris
class TopProduct {
  final String name;
  final String imageUrl;
  final int sold;
  final double revenue;

  TopProduct({
    required this.name,
    required this.imageUrl,
    required this.sold,
    required this.revenue,
  });
}


// Data contoh untuk analitik
class AnalyticsData {
  final double totalRevenue;
  final int totalVisitors;
  final double conversionRate;
  final List<SalesData> weeklySales;
  final List<TopProduct> topProducts;

  AnalyticsData({
    required this.totalRevenue,
    required this.totalVisitors,
    required this.conversionRate,
    required this.weeklySales,
    required this.topProducts,
  });
}

// Data contoh yang akan kita gunakan
final dummyAnalyticsData = AnalyticsData(
  totalRevenue: 7520000.0,
  totalVisitors: 1230,
  conversionRate: 3.5,
  weeklySales: [
    SalesData('Sen', 850000),
    SalesData('Sel', 1200000),
    SalesData('Rab', 950000),
    SalesData('Kam', 1500000),
    SalesData('Jum', 1100000),
    SalesData('Sab', 1870000),
    SalesData('Min', 50000),
  ],
  topProducts: [
    TopProduct(name: 'Sepatu Sneakers', imageUrl: 'assets/product/nikedunk.png', sold: 50, revenue: 3500000),
    TopProduct(name: 'Kaos Polos', imageUrl: 'assets/product/baju1.png', sold: 150, revenue: 1500000),
    TopProduct(name: 'Casual Vans', imageUrl: 'assets/product/vans.png', sold: 25, revenue: 1000000),
  ],
);


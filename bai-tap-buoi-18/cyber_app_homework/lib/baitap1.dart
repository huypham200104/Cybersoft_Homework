import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Đường cong phía dưới phần nền xanh
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
      size.width / 2, size.height,
      size.width, size.height - 80,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(BottomCurveClipper oldClipper) => false;
}

// Hiển thị số dư và avatar người dùng
class BalanceCard extends StatelessWidget {
  final String balance;
  final Color avatarColor;

  const BalanceCard({
    super.key,
    required this.balance,
    this.avatarColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Your Balance', style: TextStyle(fontSize: 12, color: Colors.grey)),
            Text(balance, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ],
        ),
        CircleAvatar(radius: 20, backgroundColor: avatarColor),
      ],
    );
  }
}

// Hiển thị banner khuyến mãi
class PromoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color backgroundColor;

  const PromoCard({
    super.key,
    required this.title,
    required this.subtitle,
    this.backgroundColor = Colors.green,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
      ),
      alignment: Alignment.bottomLeft,
      padding: const EdgeInsets.all(16),
      child: Text(
        '$title\n$subtitle',
        style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Hiển thị một ô danh mục (icon + tên) trong lưới 2 cột
class CategoryGridItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  const CategoryGridItem({
    super.key,
    required this.title,
    required this.icon,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(color: backgroundColor, borderRadius: BorderRadius.circular(12)),
              child: Icon(icon, color: Colors.white, size: 30),
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

// Hiển thị một dòng sản phẩm (ảnh, tên, giá, yêu thích)
class ProductListItem extends StatelessWidget {
  final String name;
  final String price;
  final String stock;

  const ProductListItem({
    super.key,
    required this.name,
    required this.price,
    required this.stock,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.green[400],
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text(stock, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                const SizedBox(height: 4),
                Text(price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Icon(Icons.favorite_border, color: Colors.grey[400]),
        ],
      ),
    );
  }
}

// Màn hình giới thiệu ứng dụng
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipPath(
              clipper: BottomCurveClipper(),
              child: Container(height: 420, color: Colors.green),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
              color: Colors.white,
              child: Column(
                children: [
                  const Text(
                    'Complete your grocery need easily',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.to(() => const HomeScreen()),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Text('Get Started', style: TextStyle(color: Colors.white)),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Màn hình chính: số dư, promo, lưới danh mục
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const BalanceCard(balance: '\$1,700.00'),
              const SizedBox(height: 12),
              const PromoCard(title: 'Buy Orange 10 Kg', subtitle: 'Get discount 25%'),
              const SizedBox(height: 16),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('For you', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                children: [
                  CategoryGridItem(title: 'Fruit',     icon: Icons.apple,        backgroundColor: Colors.orange,         onTap: () => Get.to(() => const OrangeScreen())),
                  CategoryGridItem(title: 'Vegetable', icon: Icons.eco,          backgroundColor: Colors.green,          onTap: () => Get.to(() => const OrangeScreen())),
                  CategoryGridItem(title: 'Cookies',   icon: Icons.cookie,       backgroundColor: Colors.brown.shade300, onTap: () => Get.to(() => const OrangeScreen())),
                  CategoryGridItem(title: 'Meat',      icon: Icons.lunch_dining, backgroundColor: Colors.red.shade200,   onTap: () => Get.to(() => const OrangeScreen())),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Màn hình danh sách sản phẩm trái cây
class OrangeScreen extends StatelessWidget {
  const OrangeScreen({super.key});

  static const List<Map<String, String>> _products = [
    {'name': 'Orange', 'price': '\$15', 'stock': '1000 ready stock'},
    {'name': 'Apple',  'price': '\$20', 'stock': '1000 ready stock'},
    {'name': 'Banana', 'price': '\$5',  'stock': '1000 ready stock'},
    {'name': 'Mango',  'price': '\$15', 'stock': '1000 ready stock'},
    {'name': 'Orange', 'price': '\$10', 'stock': '1000 ready stock'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) => ProductListItem(
                name: _products[index]['name']!,
                price: _products[index]['price']!,
                stock: _products[index]['stock']!,
              ),
              childCount: _products.length,
            ),
          ),
        ],
      ),
    );
  }
}

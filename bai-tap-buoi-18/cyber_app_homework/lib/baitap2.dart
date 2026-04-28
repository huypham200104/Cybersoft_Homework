import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

// Màn hình chứa BottomNavigationBar để chuyển giữa Explore và Shop
class Baitap2Screen extends StatefulWidget {
  const Baitap2Screen({super.key});

  @override
  State<Baitap2Screen> createState() => _Baitap2ScreenState();
}

class _Baitap2ScreenState extends State<Baitap2Screen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = const [
    ExploreScreen(),
    ShopScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _screens),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        selectedItemColor: const Color(0xFF4B7B8F),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explore'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Shop'),
        ],
      ),
    );
  }
}

// Tiêu đề "Explore" và avatar cam góc phải
class ExploreHeader extends StatelessWidget {
  const ExploreHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Explore', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
              Text('Find products easier here', style: TextStyle(fontSize: 12, color: Colors.white70)),
            ],
          ),
        ),
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(color: Colors.orange, borderRadius: BorderRadius.circular(14)),
        ),
      ],
    );
  }
}

// Hiển thị card sản phẩm (ảnh lớn + tên) trên nền tối
class ExploreProductCard extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const ExploreProductCard({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 150,
            decoration: const BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            child: const Center(child: Icon(Icons.image, size: 60, color: Colors.white54)),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

// Hiển thị lời chào tên người dùng và icon giỏ hàng
class HeaderSection extends StatelessWidget {
  final String userName;
  final VoidCallback? onCartTap;

  const HeaderSection({super.key, required this.userName, this.onCartTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome back,', style: TextStyle(fontSize: 13, color: Colors.grey[600])),
            Text(userName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
          ],
        ),
        GestureDetector(
          onTap: onCartTap,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
            ),
            child: const Icon(Icons.shopping_cart_outlined, color: Color(0xFF1F2937)),
          ),
        ),
      ],
    );
  }
}

// Hiển thị thanh tìm kiếm có nút bộ lọc
class SearchBarWidget extends StatelessWidget {
  final String hintText;
  final VoidCallback? onFilterTap;

  const SearchBarWidget({super.key, this.hintText = 'Searching item', this.onFilterTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
          suffixIcon: GestureDetector(
            onTap: onFilterTap,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: const Color(0xFF4B7B8F), borderRadius: BorderRadius.circular(8)),
              child: const Icon(Icons.tune, color: Colors.white, size: 20),
            ),
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
    );
  }
}

// Hiển thị carousel banner tự động kèm dot indicator
class CarouselSection extends StatefulWidget {
  final List<String> items;
  final Function(int)? onPageChanged;

  const CarouselSection({super.key, required this.items, this.onPageChanged});

  @override
  State<CarouselSection> createState() => _CarouselSectionState();
}

class _CarouselSectionState extends State<CarouselSection> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          options: CarouselOptions(
            height: 180,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 0.92,
            onPageChanged: (index, _) {
              setState(() => _currentIndex = index);
              widget.onPageChanged?.call(index);
            },
          ),
          items: widget.items.map((item) {
            return Container(
              decoration: BoxDecoration(color: const Color(0xFF4B7B8F), borderRadius: BorderRadius.circular(16)),
              child: Center(
                child: Text(item, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.items.length, (index) {
            return AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: _currentIndex == index ? 14 : 8,
              height: 8,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              decoration: BoxDecoration(
                color: _currentIndex == index ? const Color(0xFFE8A04C) : Colors.grey[300],
                borderRadius: BorderRadius.circular(4),
              ),
            );
          }),
        ),
      ],
    );
  }
}

class CategoryItem {
  final String name;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  CategoryItem({required this.name, required this.icon, required this.color, required this.onTap});
}

// Hiển thị lưới 4 cột các danh mục (icon + tên)
class CategoriesGrid extends StatelessWidget {
  final List<CategoryItem> categories;

  const CategoriesGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 12,
      childAspectRatio: 0.85,
      children: categories.map((cat) {
        return GestureDetector(
          onTap: cat.onTap,
          child: Column(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(color: cat.color.withOpacity(0.15), borderRadius: BorderRadius.circular(14)),
                child: Icon(cat.icon, color: cat.color, size: 26),
              ),
              const SizedBox(height: 6),
              Text(cat.name,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w500)),
            ],
          ),
        );
      }).toList(),
    );
  }
}

// Hiển thị tiêu đề section kèm nút "See All"
class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onSeeAll;

  const SectionHeader({super.key, required this.title, this.onSeeAll});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF1F2937))),
        GestureDetector(
          onTap: onSeeAll,
          child: const Text('See All', style: TextStyle(fontSize: 13, color: Color(0xFFEA580C), fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}

class BestSellingItem {
  final String name;
  final String rating;
  final IconData icon;
  final Color backgroundColor;
  final VoidCallback onTap;

  BestSellingItem({required this.name, required this.rating, required this.icon, required this.backgroundColor, required this.onTap});
}

// Hiển thị danh sách ngang các sản phẩm bán chạy
class BestSellingSection extends StatelessWidget {
  final List<BestSellingItem> items;

  const BestSellingSection({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 180,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final item = items[index];
          return GestureDetector(
            onTap: item.onTap,
            child: Container(
              width: 140,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, offset: const Offset(0, 2))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 100,
                    decoration: BoxDecoration(
                      color: item.backgroundColor.withOpacity(0.2),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                    ),
                    child: Icon(item.icon, color: item.backgroundColor, size: 44),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(item.name, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.star, size: 12, color: Color(0xFFE8A04C)),
                            const SizedBox(width: 3),
                            Text(item.rating, style: const TextStyle(fontSize: 10)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

// Màn hình danh sách sản phẩm trên nền tối
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C4255),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const ExploreHeader(),
            const SizedBox(height: 20),
            ExploreProductCard(title: 'Lamp', onTap: () {}),
            const SizedBox(height: 16),
            ExploreProductCard(title: 'Car', onTap: () {}),
            const SizedBox(height: 16),
            ExploreProductCard(title: 'Plant', onTap: () {}),
          ],
        ),
      ),
    );
  }
}

// Màn hình shop: header, search, carousel, categories, best sellers
class ShopScreen extends StatefulWidget {
  const ShopScreen({super.key});

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  final List<String> _slides = ['Slide 1', 'Slide 2', 'Slide 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HeaderSection(userName: 'Samantha William', onCartTap: () {}),
              const SizedBox(height: 20),
              const SearchBarWidget(),
              const SizedBox(height: 20),
              CarouselSection(items: _slides),
              const SizedBox(height: 24),
              SectionHeader(title: 'Categories', onSeeAll: () {}),
              const SizedBox(height: 14),
              CategoriesGrid(
                categories: [
                  CategoryItem(name: 'Music',      icon: Icons.music_note,      color: Colors.blue,   onTap: () {}),
                  CategoryItem(name: 'Property',   icon: Icons.home,            color: Colors.green,  onTap: () {}),
                  CategoryItem(name: 'Game',       icon: Icons.sports_esports,  color: Colors.purple, onTap: () {}),
                  CategoryItem(name: 'Gadget',     icon: Icons.devices,         color: Colors.orange, onTap: () {}),
                  CategoryItem(name: 'Electronic', icon: Icons.computer,        color: Colors.cyan,   onTap: () {}),
                  CategoryItem(name: 'Property',   icon: Icons.apartment,       color: Colors.red,    onTap: () {}),
                  CategoryItem(name: 'Game',       icon: Icons.sports_baseball, color: Colors.amber,  onTap: () {}),
                  CategoryItem(name: 'Book',       icon: Icons.library_books,   color: Colors.indigo, onTap: () {}),
                ],
              ),
              const SizedBox(height: 24),
              SectionHeader(title: 'Best Seller', onSeeAll: () {}),
              const SizedBox(height: 14),
              BestSellingSection(
                items: [
                  BestSellingItem(name: 'Plant', rating: '5.0', icon: Icons.local_florist, backgroundColor: Colors.green,  onTap: () {}),
                  BestSellingItem(name: 'Lamp',  rating: '5.0', icon: Icons.lightbulb,     backgroundColor: Colors.amber,  onTap: () {}),
                  BestSellingItem(name: 'Chair', rating: '5.0', icon: Icons.chair,         backgroundColor: Colors.brown,  onTap: () {}),
                ],
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}

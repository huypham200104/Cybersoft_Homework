import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Shoe Store'),
          backgroundColor: Colors.blue,
        ),
        body: MyCart()
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
class Product {
  final String name;
  final String price;
  final String imageUrl;
  int quantity;  // Thêm trường này

  Product({
    required this.name,
    required this.price,
    required this.imageUrl,
    this.quantity = 1,
  });
}
final List<Product> cartItems = [
  Product(name: 'Nike Air Max', price: '\$120', imageUrl: 'https://www.jordan1.vn/wp-content/uploads/2024/11/air-max-95-x-a-ma-mani_C3_A9re-w-y-w-s-fz8743-200-release-date.png'),
  Product(name: 'Adidas Ultraboost', price: '\$150', imageUrl: 'https://ash.vn/cdn/shop/files/42df34ce12a11df39978b159dcbf4551_540x.jpg?v=1772787468'),
  Product(name: 'Puma RS-X', price: '\$100', imageUrl: 'https://authentic-shoes.com/wp-content/uploads/2024/09/A-Ma-Maniere-Air-Jordan-4-While-1.png'),
];

class MyCart extends StatefulWidget {


  final List<Product> myCartItems = [];
    MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
    void _removeFromCart(int index) {
      setState(() {
        widget.myCartItems.removeAt(index);
      });
    }
    void _addToCart(Product product) {
      setState(() {
        // Kiểm tra xem sản phẩm đã có trong giỏ chưa
        int existingIndex = widget.myCartItems.indexWhere((item) => item.name == product.name);
        
        if (existingIndex != -1) {
          // Nếu có rồi, tăng số lượng
          widget.myCartItems[existingIndex].quantity++;
        } else {
          // Nếu chưa có, thêm mới với quantity = 1
          widget.myCartItems.add(Product(
            name: product.name,
            price: product.price,
            imageUrl: product.imageUrl,
            quantity: 1,
          ));
        }
      });
    }
    double _calculateTotal() {
      double total = 0;
      for (var product in widget.myCartItems) {
        // Loại bỏ ký tự $ và chuyển thành double
        double price = double.parse(product.price.replaceAll('\$', ''));
        total += price * product.quantity;
      }
      return total;
    }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Giỏ hàng', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          // Hiển thị danh sách giỏ hàng với chiều cao cố định
          SizedBox(
            height: 300,  // Chiều cao giỏ hàng
            child: Column(
              children: [
                Expanded(
                  child: widget.myCartItems.isEmpty
                      ? Center(child: Text('Giỏ hàng trống'))
                      : ListView.builder(
                          itemCount: widget.myCartItems.length,
                          itemBuilder: (context, index) {
                            final product = widget.myCartItems[index];
                            return _buildCartItem(
                              product.name,
                              product.price,
                              product.imageUrl,
                              product.quantity,  // Sửa từ 1 thành product.quantity
                              () => _removeFromCart(index),
                            );
                          },
                        ),
                ),
                // Hiển thị tổng tiền
                if (widget.myCartItems.isNotEmpty)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tổng tiền:', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('\$${_calculateTotal().toStringAsFixed(2)}', 
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
                      ],
                    ),
              ],
            ),
          ),
          Spacer(),  // Giữ nguyên để đẩy danh sách xuống
          SizedBox(
            height: 200,
            width: double.infinity,
            child: ProductGird(products: cartItems, onAddToCart: _addToCart),
          ),
        ],
      )
      );
  }
  Widget _buildCartItem(String name, String price, String imageUrl, int quantity, VoidCallback onDelete) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
        title: Text(name),
        subtitle: Text('Giá: $price', style: TextStyle(
          color: Colors.green,
        )),  // Thêm chữ "Giá:" ở đây
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Số lượng: $quantity', style: TextStyle(
              color: Colors.blue,
            ),),  // Hiển thị số lượng
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
class ProductGird extends StatelessWidget {
  final List<Product> products;
  final Function(Product) onAddToCart;
  ProductGird({super.key, required this.products, required this.onAddToCart});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Danh sách giày', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        SizedBox(height: 5),
        Expanded(
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,  // 3 cột
              childAspectRatio: 1,  // Tỉ lệ chiều cao/rộng
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return _buildProductCard(
                product.name,
                product.price,
                product.imageUrl,
                () => onAddToCart(product),
              );
            },
          ),
        ),
      ],
    );
  }
  Widget _buildProductCard(String name, String price, String imageUrl, VoidCallback onAddToCart) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: 150,
              child: Image.network(imageUrl, fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                Text(price, style: TextStyle(color: Colors.grey, fontSize: 12)),
                SizedBox(height: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    minimumSize: Size(double.infinity, 36),
                  ),
                  onPressed: onAddToCart,
                  child: Text('Thêm vào giỏ', style: TextStyle(fontSize: 12)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

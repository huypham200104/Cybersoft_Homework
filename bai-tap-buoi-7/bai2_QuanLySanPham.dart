import 'dart:io';

class Product {
  String name;
  double price;
  int quantity;

  Product(this.name, this.price, this.quantity);

  void displayInfo() {
    print("Name: $name");
    print("Price: $price");
    print("Quantity: $quantity");
  }
}

Product? findWithNameProduct(List<Product> products, String name) {
  for (Product product in products) {
    if (product.name == name) {
      return product;
    }
  }
  return null;
}

List<Product> sellProduct(List<Product> products, String name, int quantity) {
  Product? product = findWithNameProduct(products, name);
  if (product != null) {
    if (product.quantity >= quantity) {
      product.quantity -= quantity;
      print("Sold $quantity of $name");
    } else {
      print("Not enough quantity of $name to sell");
    }
  } else {
    print("Product $name not found");
  }
  return products;
}

void main()
{
  List<Product> products = [
    Product("Laptop", 1000.0, 10),
    Product("Smartphone", 500.0, 20),
    Product("Headphones", 100.0, 30),
  ];

  for (int i = 0; i < products.length; i++) {
    print("Product ${i + 1}:");
    products[i].displayInfo();
    print("");
  }
  findWithNameProduct(products, "Smartphone")?.displayInfo();

  String productName = "Laptop";
  int quantityToSell = 5;
  products = sellProduct(products, productName, quantityToSell);

}
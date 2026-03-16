import 'dart:io';

class Order {
  String orderName;
  int quantity;
  double pricePerUnit;
  // Constructor
  Order(this.orderName, this.quantity, this.pricePerUnit);
}

double calculateDiscount(double total) {
  if (total >= 1000000) {
    return total * 0.10; 
  } else if (total >= 500000) {
    return total * 0.05; 
  } else {
    return 0; 
  }
}

void main() {
  print('Nhập tên sản phẩm:');
  String orderName = stdin.readLineSync() ?? 'Không xác định';

  print('Nhập số lượng:');
  int quantity = int.parse(stdin.readLineSync() ?? '0');

  print('Nhập đơn giá:');
  double pricePerUnit = double.parse(stdin.readLineSync() ?? '0');

  Order order = Order(orderName, quantity, pricePerUnit);

  double total = order.quantity * order.pricePerUnit;

  double discount = calculateDiscount(total);
  double totalAfterDiscount = total - discount;

  double vat = totalAfterDiscount * 0.08;

  double finalPayment = totalAfterDiscount + vat;

  print('\n--- HÓA ĐƠN ---');
  print('Tên sản phẩm: ${order.orderName}');
  print('Số lượng: ${order.quantity}');
  print('Đơn giá: ${order.pricePerUnit}');
  print('Thành tiền: $total');
  print('Giảm giá: $discount');
  print('Thuế VAT (8%): $vat');
  print('Tổng thanh toán cuối cùng: $finalPayment');
}

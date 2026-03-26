import 'dart:io';

void main() {
	final cart = <Map<String, dynamic>>[];
	var running = true;

	while (running) {
		_showMenu();
		stdout.write('Chọn chức năng: ');
		final choice = stdin.readLineSync()?.trim();

		switch (choice) {
			case '1':
				_addProduct(cart);
				break;
			case '2':
				_editProduct(cart);
				break;
			case '3':
				_removeProduct(cart);
				break;
			case '4':
				_printCart(cart);
				break;
			case '5':
				_printTotal(cart);
				break;
			case '0':
				running = false;
				print('Tạm biệt!');
				break;
			default:
				print('Lựa chọn không hợp lệ, vui lòng thử lại.');
		}

		print('');
	}
}

void _showMenu() {
	print('===== QUẢN LÝ HÓA ĐƠN =====');
	print('1. Thêm sản phẩm vào giỏ hàng');
	print('2. Sửa sản phẩm trong giỏ hàng');
	print('3. Xóa sản phẩm khỏi giỏ hàng');
	print('4. Hiển thị giỏ hàng');
	print('5. Tính tổng tiền hóa đơn');
	print('0. Thoát chương trình');
}

void _addProduct(List<Map<String, dynamic>> cart) {
	final name = _readNonEmptyString('Nhập tên sản phẩm: ');
	final quantity = _readPositiveInt('Nhập số lượng: ');
	final price = _readPositiveDouble('Nhập giá tiền: ');

	cart.add({'name': name, 'quantity': quantity, 'price': price});
	print('Đã thêm sản phẩm "$name" vào giỏ hàng.');
}

void _editProduct(List<Map<String, dynamic>> cart) {
	if (cart.isEmpty) {
		print('Giỏ hàng hiện đang trống.');
		return;
	}

	_printCart(cart);
	final index = _readIndex(cart.length, 'Nhập số thứ tự sản phẩm cần sửa: ');
	final product = cart[index];

	final newName = _readOptionalString('Tên mới (${product['name']}): ');
	final newQuantity = _readOptionalInt('Số lượng mới (${product['quantity']}): ');
	final newPrice = _readOptionalDouble('Giá mới (${product['price']}): ');

	if (newName != null && newName.isNotEmpty) {
		product['name'] = newName;
	}
	if (newQuantity != null) {
		product['quantity'] = newQuantity;
	}
	if (newPrice != null) {
		product['price'] = newPrice;
	}

	print('Đã cập nhật sản phẩm ở vị trí ${index + 1}.');
}

void _removeProduct(List<Map<String, dynamic>> cart) {
	if (cart.isEmpty) {
		print('Giỏ hàng hiện đang trống.');
		return;
	}

	_printCart(cart);
	final index = _readIndex(cart.length, 'Nhập số thứ tự sản phẩm cần xóa: ');
	final removed = cart.removeAt(index);
	print('Đã xóa sản phẩm "${removed['name']}" khỏi giỏ hàng.');
}

void _printCart(List<Map<String, dynamic>> cart) {
	if (cart.isEmpty) {
		print('Giỏ hàng trống.');
		return;
	}

	print('===== DANH SÁCH SẢN PHẨM =====');
	for (var i = 0; i < cart.length; i++) {
		final product = cart[i];
		final totalLine = product['quantity'] * product['price'];
		print(
			'${i + 1}. ${product['name']} | SL: ${product['quantity']} | Giá: ${product['price']} | Thành tiền: $totalLine',
		);
	}
}

void _printTotal(List<Map<String, dynamic>> cart) {
	final total = cart.fold<double>(
		0,
		(sum, product) => sum + product['quantity'] * product['price'],
	);
	print('Tổng tiền hóa đơn: $total');
}

String _readNonEmptyString(String prompt) {
	while (true) {
		stdout.write(prompt);
		final input = stdin.readLineSync();
		if (input != null && input.trim().isNotEmpty) {
			return input.trim();
		}
		print('Giá trị không hợp lệ, vui lòng nhập lại.');
	}
}

int _readPositiveInt(String prompt) {
	while (true) {
		stdout.write(prompt);
		final value = int.tryParse(stdin.readLineSync() ?? '');
		if (value != null && value > 0) {
			return value;
		}
		print('Vui lòng nhập số nguyên dương.');
	}
}

double _readPositiveDouble(String prompt) {
	while (true) {
		stdout.write(prompt);
		final value = double.tryParse(stdin.readLineSync() ?? '');
		if (value != null && value > 0) {
			return value;
		}
		print('Vui lòng nhập số thực dương.');
	}
}

int _readIndex(int maxLength, String prompt) {
	while (true) {
		final index = _readPositiveInt(prompt) - 1;
		if (index >= 0 && index < maxLength) {
			return index;
		}
		print('Vị trí không tồn tại, vui lòng nhập lại.');
	}
}

String? _readOptionalString(String prompt) {
	stdout.write(prompt);
	return stdin.readLineSync()?.trim();
}

int? _readOptionalInt(String prompt) {
	stdout.write(prompt);
	final raw = stdin.readLineSync();
	if (raw == null || raw.trim().isEmpty) {
		return null;
	}
	final value = int.tryParse(raw.trim());
	if (value == null || value <= 0) {
		print('Giá trị không hợp lệ, sử dụng số cũ.');
		return null;
	}
	return value;
}

double? _readOptionalDouble(String prompt) {
	stdout.write(prompt);
	final raw = stdin.readLineSync();
	if (raw == null || raw.trim().isEmpty) {
		return null;
	}
	final value = double.tryParse(raw.trim());
	if (value == null || value <= 0) {
		print('Giá trị không hợp lệ, sử dụng số cũ.');
		return null;
	}
	return value;
}


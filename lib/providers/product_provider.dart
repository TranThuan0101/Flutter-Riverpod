import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

// Provider trả về danh sách sản phẩm
final productListProvider = Provider<List<Product>>((ref) {
  return [
    Product(id: '1', name: 'iPhone 15', price: 999.99),
    Product(id: '2', name: 'MacBook Pro', price: 1999.99),
    Product(id: '3', name: 'iPad Pro', price: 799.99),
    Product(id: '4', name: 'iMac', price: 2299.99),
  ];
});

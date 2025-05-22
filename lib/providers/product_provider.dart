import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/product.dart';

final productListProvider = Provider<List<Product>>((ref) {
  return [
    Product(
      id: '1',
      name: 'iPhone 15',
      price: 999.99,
      imageAsset: 'assets/images/iphone15.png',
    ),
    Product(
      id: '2',
      name: 'MacBook Pro',
      price: 1999.99,
      imageAsset: 'assets/images/macbookpro.jpeg',
    ),
    Product(
      id: '3',
      name: 'iPad Pro',
      price: 799.99,
      imageAsset: 'assets/images/ipadpro.png',
    ),
    Product(
      id: '4',
      name: 'iMac',
      price: 2299.99,
      imageAsset: 'assets/images/imac.png',
    ),
  ];
});

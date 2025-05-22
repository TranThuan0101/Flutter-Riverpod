import 'package:demoprovider/screens/cart_screen.dart';
import 'package:demoprovider/screens/myproffile/myprofile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final productList = ref.watch(productListProvider);
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _currentIndex == 0
              ? 'Danh sách sản phẩm'
              : _currentIndex == 1
              ? 'Giỏ hàng'
              : 'Hồ sơ của tôi',
        ),

        actions: [
          if (_currentIndex == 0) // chỉ hiện nút giỏ khi ở màn hình sản phẩm
            Stack(
              children: [
                IconButton(
                  icon: Icon(Icons.shopping_cart),
                  onPressed: () {
                    setState(() {
                      _currentIndex = 1;
                    });
                  },
                ),
                if (cart.isNotEmpty)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: AutoSizeText(
                        '${cart.length}',
                        style: TextStyle(fontSize: 12, color: Colors.white),
                        maxLines: 1,
                        minFontSize: 8,
                        maxFontSize: 12,
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
      body:
          _currentIndex == 0
              ? ListView.builder(
                itemCount: productList.length,
                itemBuilder: (context, index) {
                  final product = productList[index];
                  return ListTile(
                    leading: CircleAvatar(child: Text('${index + 1}')),
                    title: AutoSizeText(product.name, maxLines: 1),
                    subtitle: AutoSizeText(
                      '\$${product.price.toStringAsFixed(2)}',
                      maxLines: 1,
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        ref.read(cartProvider.notifier).addToCart(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              '${product.name} đã được thêm vào giỏ!',
                            ),
                          ),
                        );
                      },
                      child: Text('Thêm'),
                    ),
                  );
                },
              )
              : _currentIndex == 1
              ? CartScreen()
              : const MyProfileScreen(),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Sản phẩm'),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Giỏ hàng',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Hồ sơ'),
        ],
      ),



    );
  }
}

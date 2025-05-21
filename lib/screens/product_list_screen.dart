import 'package:demoprovider/screens/cart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../providers/product_provider.dart';
import '../providers/cart_provider.dart';

class ProductListScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productList = ref.watch(productListProvider);
    
    final cart = ref.watch(cartProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách sản phẩm'),
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CartScreen()),
                  );
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
      body: ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          final product = productList[index];
          print(productList);
          return ListTile(
                leading: CircleAvatar(child: Text('${index + 1}')),
                title: AutoSizeText(
                  product.name,
                  maxLines: 1,
                  minFontSize: 14,
                  maxFontSize: 18,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: AutoSizeText(
                  '\$${product.price.toStringAsFixed(2)}',
                  maxLines: 1,
                  minFontSize: 12,
                  maxFontSize: 16,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: ElevatedButton(
                  onPressed: () {
                    ref.read(cartProvider.notifier).addToCart(product);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: AutoSizeText(
                          '${product.name} đã được thêm vào giỏ!',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    );
                  },
                  child: AutoSizeText(
                    'Thêm',
                    maxLines: 1,
                    minFontSize: 12,
                    maxFontSize: 16,
                  ),
                ),
              )
              .animate(delay: (index * 100).ms) // Staggered effect
              .slideX(begin: 1, end: 0, duration: 400.ms)
              .fadeIn(duration: 400.ms, curve: Curves.easeIn);
        },
      ),
    );
  }
}

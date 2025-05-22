import 'package:demoprovider/components/Cart_Pie_Chart.dart';
import 'package:demoprovider/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      
      body:
          cart.isEmpty
              ? const Center(child: Text('Giỏ hàng trống'))
              : Column(
                children: [
                  const SizedBox(height: 10),
                  CartPieChart(cart: cart),
                  const SizedBox(height: 10),
                  Expanded(
                    child: ListView.builder(
                      itemCount: cart.length,
                      itemBuilder: (context, index) {
                        final item = cart[index];
                        return ListTile(
                          title: Text(item.product.name),
                          subtitle: Text(
                            '${item.quantity} x \$${item.product.price.toStringAsFixed(2)}',
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              cartNotifier.removeFromCart(item.product);
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'Tổng: \$${cartNotifier.totalPrice.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => AlertDialog(
                                    title: const Text('Thanh toán thành công!'),
                                    content: const Text(
                                      'Cảm ơn bạn đã mua hàng.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          cartNotifier.clearCart();
                                          Navigator.of(
                                            context,
                                          ).popUntil((route) => route.isFirst);
                                        },
                                        child: const Text('OK'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                          child: const Text('Thanh toán'),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder:
                                  (_) => AlertDialog(
                                    title: const Text('Thông tin chuyển khoản'),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text('Ngân hàng: Vietcombank'),
                                        const Text('Số tài khoản: 0123456789'),
                                        const Text(
                                          'Chủ tài khoản: Trần Phước Thuận',
                                        ),
                                        Text(
                                          'Nội dung: Thanh toán đơn hàng ${DateTime.now().millisecondsSinceEpoch}',
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          'Sau khi chuyển khoản, vui lòng nhấn nút "Đã chuyển khoản".',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ],
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Hủy'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                          showDialog(
                                            context: context,
                                            builder:
                                                (_) => AlertDialog(
                                                  title: const Text(
                                                    'Xác nhận thành công',
                                                  ),
                                                  content: const Text(
                                                    'Cảm ơn bạn đã chuyển khoản. Chúng tôi sẽ kiểm tra và liên hệ lại.',
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                        cartNotifier
                                                            .clearCart();
                                                        Navigator.of(
                                                          context,
                                                        ).popUntil(
                                                          (route) =>
                                                              route.isFirst,
                                                        );
                                                      },
                                                      child: const Text('OK'),
                                                    ),
                                                  ],
                                                ),
                                          );
                                        },
                                        child: const Text('Đã chuyển khoản'),
                                      ),
                                    ],
                                  ),
                            );
                          },
                          child: const Text('Chuyển khoản ngân hàng'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
    );
  }
}

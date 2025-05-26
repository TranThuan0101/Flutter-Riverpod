import 'package:demoprovider/components/Cart_Pie_Chart.dart';
import 'package:demoprovider/components/Cart_Bar_Chart.dart';
import 'package:demoprovider/components/Cart_Line_Chart.dart';
import 'package:demoprovider/components/Cart_Radar_Chart.dart';
import 'package:demoprovider/components/Cart_Scatter_Chart.dart';
import 'package:demoprovider/models/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/cart_provider.dart';

class CartScreen extends ConsumerStatefulWidget {
  const CartScreen({super.key});

  @override
  ConsumerState<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends ConsumerState<CartScreen> {
  String selectedChart = 'Pie';

  Widget _buildChart(List<CartItem> cart) {
    switch (selectedChart) {
      case 'Bar':
        return CartBarChart(cart: cart);
      case 'Line':
        final revenues =
            cart.map((item) => item.product.price * item.quantity).toList();
        final productNames = cart.map((item) => item.product.name).toList();
        return RevenueLineChart(revenues: revenues, productNames: productNames);
      case 'Radar':
        final quantities = cart.map((item) => item.quantity).toList();
        final prices =
            cart.map((item) => item.product.price.toDouble()).toList();
        final productNames = cart.map((item) => item.product.name).toList();
        return ProductRadarChart(
          prices: prices,
          quantities: quantities,
          productNames: productNames,
        );

      case 'Scatter':
        return CartScatterChart(cart: cart);


      default:
        return CartPieChart(cart: cart);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartProvider);
    final cartNotifier = ref.read(cartProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        
        actions: [
          DropdownButton<String>(
            value: selectedChart,
            items: const [
              DropdownMenuItem(value: 'Pie', child: Text('Pie')),
              DropdownMenuItem(value: 'Bar', child: Text('Bar')),
              DropdownMenuItem(value: 'Line', child: Text('Line')),
              DropdownMenuItem(value: 'Radar', child: Text('Radar')),
              DropdownMenuItem(value: 'Scatter', child: Text('Scatter')),
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedChart = value;
                });
              }
            },
          ),
        ],
      ),
      body:
          cart.isEmpty
              ? const Center(child: Text('Giỏ hàng trống'))
              : Column(
                children: [
                  const SizedBox(height: 10),
                  _buildChart(cart),
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

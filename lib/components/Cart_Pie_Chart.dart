
import 'package:demoprovider/models/cart_item.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CartPieChart extends StatelessWidget {
  final List<CartItem> cart;

  const CartPieChart({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    if (cart.isEmpty) {
      return const Center(child: Text('Chưa có dữ liệu để hiển thị biểu đồ'));
    }

    final totalQuantity = cart.fold<int>(0, (sum, item) => sum + item.quantity);

    return SizedBox(
      height: 200,
      child: PieChart(
        PieChartData(
          sections:
              cart.map((item) {
                final percent = item.quantity / totalQuantity * 100;
                return PieChartSectionData(
                  value: percent,
                  title: '${percent.toStringAsFixed(1)}%',
                  color: _getColorFor(item.product.name),
                  radius: 50,
                  titleStyle: const TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                );
              }).toList(),
          sectionsSpace: 2,
          centerSpaceRadius: 30,
        ),
      ),
    );
  }

  Color _getColorFor(String name) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.purple,
      Colors.teal,
      Colors.cyan,
    ];
    return colors[name.hashCode % colors.length];
  }
}

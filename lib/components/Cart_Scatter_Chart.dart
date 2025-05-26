import 'package:flutter/material.dart';
import 'package:demoprovider/models/cart_item.dart';
import 'package:fl_chart/fl_chart.dart';

class CartScatterChart extends StatelessWidget {
  final List<CartItem> cart;

  const CartScatterChart({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    final List<Color> colors = Colors.primaries;

    final List<ScatterSpot> spots =
        cart.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return ScatterSpot(
            item.product.price,
            item.quantity.toDouble(),
            radius: 8,
            color: colors[index % colors.length],
          );
        }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Biểu đồ Scatter: Giá vs Số lượng',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          child: ScatterChart(
            ScatterChartData(
              scatterSpots: spots,
              minX: 0,
              maxX:
                  cart
                      .map((e) => e.product.price)
                      .reduce((a, b) => a > b ? a : b) +
                  10,
              minY: 0,
              maxY:
                  cart
                      .map((e) => e.quantity)
                      .reduce((a, b) => a > b ? a : b)
                      .toDouble() +
                  5,
              borderData: FlBorderData(show: true),
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 10,
                    getTitlesWidget: (value, _) => Text('${value.toInt()}'),
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, _) => Text('${value.toInt()}'),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.grey[100], // Nền sáng
            borderRadius: BorderRadius.circular(12),
          ),
          child: Wrap(
            spacing: 12,
            runSpacing: 8,
            children:
                cart.asMap().entries.map((entry) {
                  final index = entry.key;
                  final item = entry.value;
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colors[index % colors.length],
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        item.product.name,
                        style: const TextStyle(fontSize: 13),
                      ),
                    ],
                  );
                }).toList(),
          ),
        ),
      ],
    );
  }
}

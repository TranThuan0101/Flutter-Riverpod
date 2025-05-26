import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import '../models/cart_item.dart';

class CartBarChart extends StatelessWidget {
  final List<CartItem> cart;
  const CartBarChart({super.key, required this.cart});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, _) {
                  final index = value.toInt();
                  if (index < cart.length) {
                    return Text(
                      cart[index].product.name,
                      style: const TextStyle(fontSize: 10),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ),
          barGroups:
              cart
                  .asMap()
                  .map(
                    (i, item) => MapEntry(
                      i,
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: item.quantity.toDouble(),
                            color: Colors.blue,
                          ),
                        ],
                      ),
                    ),
                  ) 
                  .values
                  .toList(),
        ),
      ),
    );
  }
}

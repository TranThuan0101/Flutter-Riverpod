import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class RevenueLineChart extends StatelessWidget {
  final List<double> revenues; // Doanh thu từng sản phẩm
  final List<String> productNames; // Tên sản phẩm tương ứng

  const RevenueLineChart({
    super.key,
    required this.revenues,
    required this.productNames,
  }) : assert(
         revenues.length == productNames.length,
         'Dữ liệu doanh thu và tên sản phẩm phải cùng độ dài',
       );

  @override
  Widget build(BuildContext context) {
    final spots =
        revenues
            .asMap()
            .entries
            .map((e) => FlSpot(e.key.toDouble(), e.value))
            .toList();

    final maxY =
        revenues.isEmpty ? 0 : revenues.reduce((a, b) => a > b ? a : b);

    return SizedBox(
      height: 250,
      child: LineChart(
        LineChartData(
          maxY: maxY * 1.2,
          minY: 0,
          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true,
              color: Colors.green,
              barWidth: 3,
              dotData: FlDotData(show: true),
            ),
          ],
          titlesData: FlTitlesData(
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: 1, // Dãn cách giữa các nhãn
                getTitlesWidget: (value, meta) {
                  final idx = value.toInt();
                  if (idx < 0 || idx >= productNames.length) {
                    return const SizedBox.shrink();
                  }
                  return SideTitleWidget(
                    axisSide: meta.axisSide,
                    space: 6,
                    child: Transform.rotate(
                      angle: -0.6, // Xoay chữ (~-34 độ)
                      child: Text(
                        productNames[idx],
                        style: const TextStyle(fontSize: 10),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  );
                },
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: FlGridData(show: true),
          borderData: FlBorderData(show: false),
        ),
      ),
    );
  }
}

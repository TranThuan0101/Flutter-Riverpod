import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class ProductRadarChart extends StatelessWidget {
  final List<double> prices; // Giá tiền sản phẩm
  final List<int> quantities; // Số lượng sản phẩm
  final List<String> productNames; // Tên sản phẩm

  const ProductRadarChart({
    super.key,
    required this.prices,
    required this.quantities,
    required this.productNames,
  });

  @override
  Widget build(BuildContext context) {
    if (prices.length < 3 || productNames.length < 3) {
      return const Center(
        child: Text(
          'Cần ít nhất 3 sản phẩm để hiển thị biểu đồ radar.',
          style: TextStyle(color: Colors.red),
        ),
      );
    }

    return SizedBox(
      height: 300,
      child: RadarChart(
        RadarChartData(
          dataSets: [
            RadarDataSet(
              dataEntries: prices.map((v) => RadarEntry(value: v)).toList(),
              borderColor: Colors.blue,
              fillColor: Colors.blue.withOpacity(0.3),
              entryRadius: 3,
              borderWidth: 2,
            ),
          ],
          radarBackgroundColor: Colors.transparent,
          radarBorderData: const BorderSide(color: Colors.transparent),
          gridBorderData: const BorderSide(color: Colors.grey),
          tickBorderData: const BorderSide(color: Colors.grey),
          ticksTextStyle: const TextStyle(color: Colors.grey, fontSize: 10),
          tickCount: 6,
          titlePositionPercentageOffset: 0.2,
          getTitle: (index, angle) {
            if (index >= 0 && index < productNames.length) {
              return RadarChartTitle(text: productNames[index]);
            } else {
              return const RadarChartTitle(text: 'N/A');
            }
          },
        ),
      ),
    );
  }
}

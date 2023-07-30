import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../constants/constants.dart';

class TraineeEnrolGraph extends StatelessWidget {
  const TraineeEnrolGraph({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SfCartesianChart(
      primaryXAxis: CategoryAxis(),
      // Chart title
      title: ChartTitle(
          text: 'Trainee Enrolled By Months',
          alignment: ChartAlignment.near,
          textStyle: const TextStyle(
            fontSize: 16,
          )),
      series: <LineSeries<SalesData, String>>[
        LineSeries<SalesData, String>(
          dataSource: <SalesData>[
            SalesData('Jan', 35),
            SalesData('Feb', 28),
            SalesData('Mar', 34),
            SalesData('Apr', 32),
            SalesData('May', 40)
          ],
          xValueMapper: (SalesData sales, _) => sales.year,
          yValueMapper: (SalesData sales, _) => sales.sales,
          // Enable data label
          dataLabelSettings: const DataLabelSettings(
            isVisible: true,
            color: kPrimaryColor,
          ),
          color: kPrimaryColor,
        )
      ],
    );
  }
}

class SalesData {
  SalesData(this.year, this.sales);
  final String year;
  final double sales;
}

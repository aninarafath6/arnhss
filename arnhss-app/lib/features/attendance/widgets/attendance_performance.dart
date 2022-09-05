import 'package:flutter/material.dart';

import 'package:arnhss/common/constants/color_constants.dart';
import 'package:arnhss/common/theme/text_theme.dart';
import 'package:arnhss/features/attendance/widgets/indication_tile.dart';
import 'package:pie_chart/pie_chart.dart';

class AttendancePerformance extends StatelessWidget {
  AttendancePerformance({
    Key? key,
  }) : super(key: key);

  Map<String, double> dataMap = {
    "Present": 5,
    "Late": 2,
    "Absent": 1,
  };
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.5),
      decoration: BoxDecoration(
        color: CustomColors.lightBgOverlay,
        borderRadius: BorderRadius.circular(
          2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Attendance performance",
            style: CustomTextTheme(context: context)
                .headLine2()
                .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 20),
          PieChart(
            dataMap: dataMap,
            chartType: ChartType.ring,
            ringStrokeWidth: 25,
            chartRadius: 120,
            centerText: "60.5%\npresent",
            colorList: [
              Colors.green.withOpacity(.6),
              Colors.orange.withOpacity(.6),
              Colors.red.withOpacity(.6),
            ],
            chartValuesOptions: const ChartValuesOptions(
              showChartValueBackground: false,
              showChartValuesInPercentage: true,
              showChartValues: false,
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          const IndicationTile(label: "Total Working Days", count: 102),
          const IndicationTile(label: "Total Present", count: 21),
          const IndicationTile(label: "Total Absent", count: 51),
        ],
      ),
    );
  }
}

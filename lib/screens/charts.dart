import 'dart:math';

import 'package:dimy/expense_controller.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/item_row.dart';

class ChartScreen extends StatefulWidget {
  final Map<String, String> total;
  const ChartScreen({super.key, required this.total});

  @override
  State<ChartScreen> createState() => _ChartScreenState();
}

class _ChartScreenState extends State<ChartScreen> {
  List<double> weeklyData = [];
  List<BarChartGroupData> barData = [];
  ExpenseController expenseController = Get.put(ExpenseController());

  double maxValy = 0.0;
  @override
  void initState() {
    super.initState();
    setState(() {
      weeklyData = getWeekly(widget.total);
      for (int i = 0; i < weeklyData.length; i++) {
        maxValy = max(maxValy, weeklyData[i]);
      }
      maxValy += pow(10, maxValy.toInt().toString().length - 1);
      int digit = int.parse(maxValy.toInt().toString()[0]);
      maxValy =
          digit.toDouble() * pow(10, maxValy.toInt().toString().length - 1);
    });
    setState(() {
      for (int i = 0; i < weeklyData.length; i++) {
        barData.add(BarChartGroupData(x: i, barRods: [
          BarChartRodData(
              fromY: 0,
              toY: maxValy,
              width: 35,
              borderRadius: BorderRadius.circular(5),
              rodStackItems: [
                BarChartRodStackItem(0, weeklyData[i], Colors.white),
                BarChartRodStackItem(weeklyData[i], maxValy, Colors.grey),
              ])
        ]));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text("Chart", style: TextStyle(color: Colors.white, fontSize: 18),),
        Padding(
          padding: const EdgeInsets.only(top: 30, right: 20),
          child: SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                maxY: maxValy,
                barGroups: barData,
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    tooltipBgColor: Colors.white,
                    tooltipMargin: -50,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String weekDay;
                      switch (group.x) {
                        case 0:
                          weekDay = 'Monday';
                          break;
                        case 1:
                          weekDay = 'Tuesday';
                          break;
                        case 2:
                          weekDay = 'Wednesday';
                          break;
                        case 3:
                          weekDay = 'Thursday';
                          break;
                        case 4:
                          weekDay = 'Friday';
                          break;
                        case 5:
                          weekDay = 'Saturday';
                          break;
                        case 6:
                          weekDay = 'Sunday';
                          break;
                        default:
                          throw Error();
                      }
                      return BarTooltipItem(
                        '$weekDay\n',
                        const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: (rod.rodStackItems[0].toY).toString(),
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: getTitles,
                      reservedSize: 38,
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                gridData: FlGridData(show: false),
              ),
            ),
          ),
        ),
        const SizedBox(height: 40),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                for (int i = 0; i < expenseController.expenseData.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30, bottom: 20),
                    child: ItemRow(
                      date: expenseController.expenseData[i][0],
                      data: expenseController.expenseData[i],
                      total: widget.total[expenseController.expenseData[i][0]]!,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  List<double> getWeekly(Map<String, String> total) {
    List<double> res = [];
    int weekNum = DateTime.now().weekday;
    DateTime startDay = DateTime.now().subtract(Duration(days: weekNum - 1));
    for (int i = 0; i < 7; i++) {
      if (total.containsKey(startDay.toString().substring(0, 10))) {
        res.add(double.parse(total[startDay.toString().substring(0, 10)]!));
      } else {
        res.add(0);
      }
      startDay = startDay.add(const Duration(days: 1));
    }
    return res;
  }

  Widget getTitles(double value, TitleMeta meta) {
    const style = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    Widget text;
    switch (value.toInt()) {
      case 0:
        text = const Text('M', style: style);
        break;
      case 1:
        text = const Text('T', style: style);
        break;
      case 2:
        text = const Text('W', style: style);
        break;
      case 3:
        text = const Text('T', style: style);
        break;
      case 4:
        text = const Text('F', style: style);
        break;
      case 5:
        text = const Text('S', style: style);
        break;
      case 6:
        text = const Text('S', style: style);
        break;
      default:
        text = const Text('', style: style);
        break;
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 16,
      child: text,
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/provider/services/graph_helper.dart';
import 'package:newsapp/provider/weather_provider.dart';
import 'package:provider/provider.dart';

class Graph extends StatelessWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Color> gradientColors = [
      GraphHelper.hexToColor("#f89ca1"),
      GraphHelper.hexToColor("#56cffe"),
      GraphHelper.hexToColor("#c24778"),
      GraphHelper.hexToColor("#493c8b")
    ];

    var GraphData = Provider.of<WP>(context).todaysWeather;
    // .sublist(, Provider.of<WP>(context).todaysWeather.length );
    return Card(
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      elevation: 15,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            borderRadius: BorderRadius.circular(10),
            color: Colors.black),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: LineChart(
            LineChartData(
              backgroundColor: GraphHelper.hexToColor("#252f37"),
              minX: 0,
              maxX: GraphData.length.toDouble() - 1,
              minY: Provider.of<WP>(context).minTemp - 273.15 - 0.3,
              maxY: Provider.of<WP>(context).maxTemp - 273.15 + 0.3,

              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipItems: (touchedSpots) {
                    return [
                      for (int i = 0; i < touchedSpots.length; i++)
                        LineTooltipItem(
                            "${GraphHelper.twelveHourTimeFormTimeStamp(GraphData[touchedSpots[i].x.toInt()].dt)}\nTemp ${GraphHelper.roundDouble(GraphData[touchedSpots[i].x.toInt()].temp - 273.15, 1)}°C${GraphHelper.emoji(GraphHelper.roundDouble(GraphData[touchedSpots[i].x.toInt()].temp - 273.15, 1))}\nFeels ${GraphHelper.roundDouble(GraphData[touchedSpots[i].x.toInt()].feels_like - 273.15, 1)}°C${GraphHelper.emoji(GraphHelper.roundDouble(GraphData[touchedSpots[i].x.toInt()].feels_like - 273.15, 1))}",
                            const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 15)),
                    ];
                  },
                  tooltipBgColor: Colors.black87,
                  tooltipPadding: const EdgeInsets.all(10),
                ),
                enabled: true,
                handleBuiltInTouches: true,
              ),
              //Grid Lines
              gridData: FlGridData(
                  show: false,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: const Color(0xff37434d),
                      strokeWidth: 1,
                    );
                  },
                  getDrawingVerticalLine: (value) {
                    return FlLine(
                      color: const Color(0xff37434d),
                      strokeWidth: 0,
                    );
                  }),

              //Border
              borderData: FlBorderData(
                border: Border.all(
                    color: const Color.fromARGB(255, 254, 254, 254), width: 1),
                show: true,
              ),

              titlesData: FlTitlesData(
                  rightTitles: AxisTitles(),
                  show: false,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                        interval: 5,
                        showTitles: false,
                        reservedSize: 70,
                        getTitlesWidget: (e, a) => SizedBox(
                              width: 50,
                              height: 20,
                              child: Text(
                                  GraphHelper.twelveHourTimeFormTimeStamp(
                                      GraphData[e.toInt()].dt)),
                            )),
                  )),
              // Line data
              lineBarsData: [
                LineChartBarData(
                  isCurved: true,
                  barWidth: 5,
                  gradient: LinearGradient(
                    colors: gradientColors,
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: gradientColors
                          .map((e) => e.withOpacity(0.4))
                          .toList(),
                    ),
                  ),
                  dotData: FlDotData(show: false),

                  spots: GraphData.map((e) => FlSpot(
                        GraphData.indexOf(e).toDouble(),
                        GraphHelper.roundDouble(e.temp - 273.15, 2),
                      )).toList(),

                  // read about it in the LineChartData section
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newsapp/provider/services/graph_helper.dart';
import 'package:newsapp/screens/widgets/weather/graph.dart';
import 'package:newsapp/screens/widgets/weather/inside_weather_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GraphHelper.hexToColor("#252f37"),
      body: SafeArea(
        child: Column(
          children: const [
            InsideWeatherWidget(),
            Expanded(child: Graph()),
          ],
        ),
      ),
    );
  }
}

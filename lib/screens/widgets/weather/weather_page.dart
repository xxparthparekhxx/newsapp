import 'package:flutter/material.dart';
import 'package:newsapp/screens/widgets/weather/graph.dart';
import 'package:newsapp/screens/widgets/weather/inside_weather_widget.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size ss = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: [
            SizedBox(width: ss.width, child: const InsideWeatherWidget()),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(height: ss.height * 0.5, child: const Graph()),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newsapp/provider/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool a = Provider.of<WP>(context).enabled;
    return Scaffold(
      body: Container(
        child: Text(a.toString()),
      ),
    );
  }
}

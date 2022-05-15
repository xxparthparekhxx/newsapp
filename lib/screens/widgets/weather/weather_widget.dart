import 'package:flutter/material.dart';
import 'package:newsapp/models/weather.dart';
import 'package:newsapp/provider/weather_provider.dart';
import 'package:provider/provider.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    weather? cr = Provider.of<WP>(context).currentweather;
    if (cr == null) {
      return Container(
        width: 200,
        height: 200,
      );
    } else {
      return Container(
        width: 200,
        height: 300,
        child: Column(
          children: [
            Text(cr.Name),
            Text(cr.temp.toString()),
            Text(cr.Icon),
            Text(cr.clouds.toString()),
            Text(cr.dew_point.toString()),
            Text(cr.feels_like.toString()),
            Text(cr.humidity.toString()),
            Text(cr.pressure.toString()),
            Text(cr.sunrise.toString()),
            Text(cr.sunset.toString()),
            Text(cr.uvi.toString()),
            Text(cr.visibility.toString()),
            Text(cr.wind_deg.toString()),
            Text(cr.wind_speed.toString()),
          ],
        ),
      );
    }
  }
}

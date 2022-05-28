import 'package:flutter/material.dart';
import 'package:newsapp/models/weather.dart';
import 'package:newsapp/provider/services/graph_helper.dart';
import 'package:newsapp/provider/weather_provider.dart';
import 'package:newsapp/styles.dart';
import 'package:provider/provider.dart';

class InsideWeatherWidget extends StatelessWidget {
  const InsideWeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // CONVERT FROM EXPANDED TO COLUMN
    weather CurrentWeather = Provider.of<WP>(context).currentweather!;
    Size ss = MediaQuery.of(context).size;
    return Column(
      children: [
        // First Row
        Container(
          height: ss.height * 0.17,
          padding: EdgeInsets.symmetric(horizontal: ss.width * 0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Center(
                child: Text(
                  (GraphHelper.convertfromKelvin(
                                  CurrentWeather.temp) // DEGREE WIDGET
                              .toInt())
                          .toString() +
                      "°",
                  style: inside_weather_textStyle,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.values[2],
                  children: [
                    Text(
                      GraphHelper.twelveHourTimeFormTimeStamp(
                          CurrentWeather.dt),
                      style: inside_weather_textStyle_small,
                    ),
                    Text(
                      "Feels Like " +
                          GraphHelper.convertfromKelvin(
                                  CurrentWeather.feels_like)
                              .toInt()
                              .toString(),
                      style: inside_weather_textStyle_small,
                    )
                  ],
                ),
              ),
              Image.network(
                "http://openweathermap.org/img/wn/${CurrentWeather.Icon}@4x.png",
                width: ss.width * 0.3,
              )
            ],
          ),
        ),

        Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          color: const Color.fromARGB(221, 25, 25, 25),
          margin: const EdgeInsets.all(15),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Center(
                  child: Column(children: [
                    const Text(
                      "Sunrise",
                      style: inside_weather_textStyle_small,
                    ),
                    Text(
                      GraphHelper.twelveHourTimeFormTimeStamp(
                          CurrentWeather.sunrise),
                      style: inside_weather_textStyle_small,
                    ),
                    Image.asset(
                      "lib/assets/sunrise.png",
                      height: ss.height * 0.09,
                      width: ss.width * 0.4,
                    )
                  ]),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: 1,
                    color: Colors.white24,
                    child: Column(),
                  ),
                ),
                Center(
                  child: Column(children: [
                    const Text(
                      "Sunset",
                      style: inside_weather_textStyle_small,
                    ),
                    Text(
                      GraphHelper.twelveHourTimeFormTimeStamp(
                              CurrentWeather.sunset)
                          .substring(5),
                      style: inside_weather_textStyle_small,
                    ),
                    Image.asset(
                      "lib/assets/Sunset.png",
                      width: ss.width * 0.4,
                      height: ss.height * 0.1,
                    )
                  ]),
                ),
              ],
            ),
          ),
        ),
        Card(
          elevation: 15,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          margin: const EdgeInsets.all(12),
          color: const Color.fromARGB(255, 31, 30, 30),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(
                    Icons.wb_sunny,
                    size: 40,
                    color: Colors.amber,
                  ),
                  const Text(
                    "UV index",
                    style: inside_weather_textStyle_small,
                  ),
                  Text(CurrentWeather.uvi.toString(), style: i_small2),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  const Icon(
                    Icons.air,
                    size: 40,
                    color: Colors.white30,
                  ),
                  const Text(
                    "wind Speed",
                    style: inside_weather_textStyle_small,
                  ),
                  Text(CurrentWeather.wind_speed.toString() + " km/h",
                      style: i_small2),
                ]),
                Column(mainAxisSize: MainAxisSize.min, children: [
                  Icon(
                    Icons.water_drop_sharp,
                    size: 40,
                    color: Colors.blue[300],
                  ),
                  const Text(
                    "Humidity",
                    style: inside_weather_textStyle_small,
                  ),
                  Text(
                    CurrentWeather.humidity.toString() + "%",
                    style: i_small2,
                  ),
                ]),
              ],
            ),
          ),
        )
      ],
    );
  }
}

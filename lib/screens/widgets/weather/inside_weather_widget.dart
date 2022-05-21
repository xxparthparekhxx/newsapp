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
    weather CurrentWeather = Provider.of<WP>(context).currentweather!;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Center(
                    child: Text(
                      (GraphHelper.convertfromKelvin(CurrentWeather.temp)
                                  .toInt())
                              .toString() +
                          "°",
                      style: inside_weather_textStyle,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.values[2],
                    children: [
                      Text(
                        "${GraphHelper.twelveHourTimeFormTimeStamp(CurrentWeather.dt)}",
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
                Expanded(
                    child: Image.network(
                        "http://openweathermap.org/img/wn/${CurrentWeather.Icon}@4x.png"))
              ],
            ),
          ),
          Expanded(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              color: Colors.black,
              margin: const EdgeInsets.all(15),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Center(
                        child: Column(children: [
                          const Expanded(
                            child: Text(
                              "Sunrise",
                              style: inside_weather_textStyle_small,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              GraphHelper.twelveHourTimeFormTimeStamp(
                                  CurrentWeather.sunrise),
                              style: inside_weather_textStyle_small,
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Image.asset("lib/assets/sunrise.png"))
                        ]),
                      ),
                    ),
                    Expanded(
                      child: Center(
                        child: Column(children: [
                          const Expanded(
                            child: Text(
                              "Sunset",
                              style: inside_weather_textStyle_small,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              GraphHelper.twelveHourTimeFormTimeStamp(
                                  CurrentWeather.sunset),
                              style: inside_weather_textStyle_small,
                            ),
                          ),
                          Expanded(
                              flex: 3,
                              child: Image.asset("lib/assets/Sunset.png"))
                        ]),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
              child: Card(
            elevation: 15,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            margin: const EdgeInsets.all(12),
            color: Colors.black,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(children: [
                      const Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.wb_sunny,
                            size: 40,
                            color: Colors.amber,
                          )),
                      const Expanded(
                          child: Text(
                        "UV index",
                        style: inside_weather_textStyle_small,
                      )),
                      Expanded(
                          child: Text(CurrentWeather.uvi.toString(),
                              style: i_small2)),
                    ]),
                  ),
                  Expanded(
                    child: Column(children: [
                      const Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.air,
                            size: 40,
                            color: Colors.white30,
                          )),
                      const Expanded(
                          child: Text(
                        "wind Speed",
                        style: inside_weather_textStyle_small,
                      )),
                      Expanded(
                          child: Text(
                              CurrentWeather.wind_speed.toString() + " km/h",
                              style: i_small2)),
                    ]),
                  ),
                  Expanded(
                    child: Column(children: [
                      Expanded(
                          flex: 2,
                          child: Icon(
                            Icons.water_drop_sharp,
                            size: 40,
                            color: Colors.blue[300],
                          )),
                      const Expanded(
                          child: Text(
                        "Humidity",
                        style: inside_weather_textStyle_small,
                      )),
                      Expanded(
                          child: Text(
                        CurrentWeather.humidity.toString() + "%",
                        style: i_small2,
                      )),
                    ]),
                  ),
                ],
              ),
            ),
          ))
        ],
      ),
    );
  }
}

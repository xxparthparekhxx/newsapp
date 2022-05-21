import 'package:flutter/material.dart';
import 'package:newsapp/models/loacation.dart';
import 'package:newsapp/models/weather.dart';
import 'package:newsapp/provider/weather_provider.dart';
import 'package:newsapp/screens/widgets/weather/weather_page.dart';
import 'package:newsapp/styles.dart';
import 'package:provider/provider.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    weather? cr = Provider.of<WP>(context).currentweather;
    Location? LD = Provider.of<WP>(context).locationDetails;
    if (cr == null || LD == null) {
      return Material(
        child: InkWell(
          onTap: () async => await Provider.of<WP>(context, listen: false)
              .getWeatherAndLocation(),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: SizedBox(
              width: 200,
              height: 100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    height: 50,
                    child: Stack(
                      children: [
                        const Icon(
                          Icons.cloud_circle,
                          size: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                  shadows: [
                                    Shadow(
                                        blurRadius: 10,
                                        offset: Offset.fromDirection(120, 1))
                                  ],
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text("Click here to enable weather"),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(4.0),
        child: Material(
          child: InkWell(
            borderRadius: BorderRadius.circular(20),
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const WeatherPage())),
            child: Container(
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.amber),
                  borderRadius: BorderRadius.circular(20)),
              width: 200,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                    Expanded(
                      flex: 4,
                      child: SizedBox(
                        child: Image.network(
                          'http://openweathermap.org/img/wn/${cr.Icon}@4x.png',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: SizedBox(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: Text(
                                    (cr.temp / 10).ceil().toString() + "°C",
                                    style: weather_textStyle,
                                  ),
                                ),
                                Text(
                                  cr.Name,
                                  style: weather_textStyle,
                                ),
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                      "${LD.name.length > 10 ? LD.name.substring(0, 10) + ".." : LD.name}, ${LD.region_code}  "),
                                  SizedBox(
                                    height: 20,
                                    width: 50,
                                    child: Image.network(
                                      LD.country_flag,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

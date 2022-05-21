import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/loacation.dart';
import 'package:newsapp/models/weather.dart';
import 'package:newsapp/provider/Secret/api_key_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_ipify/dart_ipify.dart';

class WP with ChangeNotifier {
  Future<Position> _determinePosition() async {
    LocationPermission permission;

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever ||
          permission == LocationPermission.denied ||
          permission == LocationPermission.unableToDetermine) {
        final ipv4 = await Ipify.ipv4();
        final somegeo = await Ipify.geo(KeyHandler.IPGeoKey, ip: ipv4);

        return Position(
            latitude: somegeo.location?.lat?.toDouble() ?? 0,
            longitude: somegeo.location?.lng?.toDouble() ?? 0,
            timestamp: DateTime.now(),
            accuracy: 0.0,
            speed: 69,
            heading: 0.0,
            altitude: 0.0,
            speedAccuracy: 0.0,
            floor: 0,
            isMocked: false);
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  final String _base = "https://api.openweathermap.org/data/2.5/onecall?";
  final String _apiKey = KeyHandler.weatherKey;

  weather? currentweather;
  Location? locationDetails;
  bool isLoading = false;
  List<weather> todaysWeather = [];

  double get maxTemp {
    double max = -99999999;
    for (var ele in todaysWeather) {
      if (ele.temp > max) {
        max = ele.temp;
      }
    }
    return max;
  }

  double get minTemp {
    double min = 99999999;
    for (var ele in todaysWeather) {
      if (ele.temp < min) {
        min = ele.temp;
      }
    }
    return min;
  }

  WP() {
    init();
  }

  init() async => await getWeatherAndLocation();

  Future getWeatherAndLocation() async {
    var p = await SharedPreferences.getInstance();
    var oldWeather = p.getString("weather");
    var oldLocation = p.getString("location");

    if (oldWeather != null) {
      currentweather =
          weather.fromJson((jsonDecode(oldWeather) as Map)['current']);
    }
    if (oldLocation != null) {
      locationDetails = Location.fromRes(oldLocation);
    }
    notifyListeners();
    Position pos = await _determinePosition();
    //starting the weather fetching process
    var weatherReq = http.get(
        Uri.parse("$_base&lat=${pos.latitude}&lon=${pos.longitude}$_apiKey"));

    //getting the location details from the api
    var locationReq = http.get(Uri.parse(
        "http://api.positionstack.com/v1/reverse?access_key=${KeyHandler.loactionKey}&query=${pos.latitude},${pos.longitude}"));

    // waiting for both requests to complete
    String weatherData = (await weatherReq).body;
    http.Response Locationresponse = await locationReq;

    // caching the data in shared preferences
    p.setString("weather", weatherData);
    p.setString("loaction", Locationresponse.body);
    var d = (jsonDecode(weatherData) as Map);

    //getting Todays weather
    (d['hourly'] as List)
        .map((e) => todaysWeather.add(weather.fromJson(e)))
        .toList();

    //getting current weather
    currentweather = weather.fromJson(d['current']);

    // getting the location details eg: city,state,flag....
    locationDetails = Location.fromRes(Locationresponse.body);
    notifyListeners();
  }
}

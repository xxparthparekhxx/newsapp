import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/loacation.dart';
import 'package:newsapp/models/weather.dart';
import 'package:newsapp/provider/Secret/api_key_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WP with ChangeNotifier {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }

  final String _base = "https://api.openweathermap.org/data/2.5/onecall?";
  final String _apiKey = KeyHandler.weatherKey;

  weather? currentweather;
  Location? locationDetails;
  bool isLoading = false;

  WP() {
    init();
  }

  init() async {
    bool enabled = false;

    LocationPermission value = await Geolocator.checkPermission();
    if (value == LocationPermission.always ||
        value == LocationPermission.whileInUse) {
      enabled = true;
    }
    notifyListeners();

    if (enabled) {
      await getWeatherAndLocation();
    }
  }

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

    var weatherRes = http.get(
        Uri.parse("$_base&lat=${pos.latitude}&lon=${pos.longitude}$_apiKey"));

    var locationRes = http.get(Uri.parse(
        "http://api.positionstack.com/v1/reverse?access_key=${KeyHandler.loactionKey}&query=${pos.latitude},${pos.longitude}"));

    String weatherData = (await weatherRes).body;
    http.Response Locationresponse = await locationRes;

    p.setString("weather", weatherData);
    p.setString("loaction", Locationresponse.body);
    var d = (jsonDecode(weatherData) as Map);
    print(d);
    //getting weather
    currentweather = weather.fromJson(d['current']);

    // getting the location details eg: city,state,flag....
    locationDetails = Location.fromRes(Locationresponse.body);

    notifyListeners();
  }
}

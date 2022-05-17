import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/loacation.dart';
import 'package:newsapp/models/weather.dart';
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
  final String _apiKey = '&appid=bb761635ddb3320ffc1f2148274d3436';

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
    var old_weather = p.getString("weather");
    var old_location = p.getString("location");

    if (old_weather != null) {
      currentweather =
          weather.fromJson((jsonDecode(old_weather) as Map)['current']);
    }
    if (old_location != null) {
      locationDetails = Location.fromRes(old_location);
    }
    notifyListeners();
    Position pos = await _determinePosition();

    var weather_res = http.get(
        Uri.parse("$_base&lat=${pos.latitude}&lon=${pos.longitude}$_apiKey"));

    var location_res = http.get(Uri.parse(
        "http://api.positionstack.com/v1/reverse?access_key=apikey&query=${pos.latitude},${pos.longitude}"));

    String weather_data = (await weather_res).body;
    http.Response Locationresponse = await location_res;

    p.setString("weather", weather_data);
    p.setString("loaction", Locationresponse.body);

    //getting weather
    currentweather =
        weather.fromJson((jsonDecode(weather_data) as Map)['current']);

    // getting the location details eg: city,state,flag....
    locationDetails = Location.fromRes(Locationresponse.body);

    notifyListeners();
  }
}

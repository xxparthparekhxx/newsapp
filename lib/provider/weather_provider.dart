import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/models/weather.dart';

class WP with ChangeNotifier {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
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

  bool enabled = false;

  final String _base = "https://api.openweathermap.org/data/2.5/onecall?";
  final String _apiKey = '&appid=Your api key';

  weather? currentweather;
  WP() {
    init();
  }

  init() async {
    enabled = await Geolocator.isLocationServiceEnabled();
    notifyListeners();
    if (enabled) {
      Position pos = await _determinePosition();
      var res = await http.get(
          Uri.parse("$_base&lat=${pos.latitude}&lon=${pos.longitude}$_apiKey"));
      currentweather =
          weather.fromJson((jsonDecode(res.body) as Map)['current']);
      notifyListeners();

      //show old one and fetch new and show that
    }
  }
}

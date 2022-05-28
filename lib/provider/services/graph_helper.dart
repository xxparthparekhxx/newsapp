import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

class GraphHelper {
  static twentyFourhrtimefromtimestamp(int timestamp) {
    var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return date.hour.toString() + ":" + date.minute.toString();
  }

  static String twelveHourTimeFormTimeStamp(int timestamp) {
    String twelvehrtime = DateFormat("d/M, h:mma")
        .format(DateTime.fromMillisecondsSinceEpoch(timestamp * 1000));
    return twelvehrtime;
  }

  static Color hexToColor(String code) {
    return Color(int.parse(code.substring(1, 7), radix: 16) + 0xFF000000);
  }

  static double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  static double convertfromKelvin(double kelvin) {
    return kelvin - 273.15;
  }

  static String emoji(double temp) {
    if (temp > 30) {
      return "🌞";
    } else if (temp > 25) {
      return "🌤";
    } else if (temp > 15) {
      return "⛅";
    } else if (temp > 10) {
      return "☁";
    } else if (temp > 5) {
      return "🌧";
    } else if (temp > 0) {
      return "🌨";
    } else if (temp > -5) {
      return "🌩";
    } else if (temp > -10) {
      return "🌨";
    } else if (temp > -15) {
      return "🌨";
    } else if (temp > -20) {
      return "🌨";
    } else if (temp > -25) {
      return "🌨";
    } else {
      return "🌨";
    }
  }
}

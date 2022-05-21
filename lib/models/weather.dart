class weather {
  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feels_like;
  final int pressure;
  final int humidity;
  final double dew_point;
  final num uvi;
  final int clouds;
  final int visibility;
  final double wind_speed;
  final int wind_deg;
  final String Name;
  final String Icon;

  weather(
      this.dt,
      this.sunrise,
      this.sunset,
      this.temp,
      this.feels_like,
      this.pressure,
      this.humidity,
      this.dew_point,
      this.uvi,
      this.clouds,
      this.visibility,
      this.wind_speed,
      this.wind_deg,
      this.Name,
      this.Icon);

  static weather fromJson(Object e) {
    e = e as Map;
    return weather(
      e["dt"],
      e["sunrise"] ?? 0,
      e["sunset"] ?? 0,
      double.parse(e["temp"].toString()),
      double.parse(e["feels_like"].toString()),
      e["pressure"],
      e["humidity"],
      double.parse(e["dew_point"].toString()),
      e["uvi"],
      e["clouds"],
      e["visibility"],
      double.parse(e["wind_speed"].toString()),
      e["wind_deg"],
      e['weather'][0]["main"],
      e['weather'][0]["icon"],
    );
  }

  @override
  String toString() {
    return {
      "dt": dt,
      "sunrise": sunrise,
      "sunset": sunset,
      "temp": temp,
      "feels_like": feels_like,
      "pressure": pressure,
      "humidity": humidity,
      "dew_point": dew_point,
      "uvi": uvi,
      "clouds": clouds,
      "visibility": visibility,
      "wind_speed": wind_speed,
      "wind_deg": wind_deg,
      "name": Name,
      "icon": Icon
    }.toString();
  }
}

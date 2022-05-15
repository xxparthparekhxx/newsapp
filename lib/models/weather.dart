class weather {
  final int dt;
  final int sunrise;
  final int sunset;
  final double temp;
  final double feels_like;
  final int preasure;
  final int humidity;
  final double dew_point;
  final double uvi;
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
      this.preasure,
      this.humidity,
      this.dew_point,
      this.uvi,
      this.clouds,
      this.visibility,
      this.wind_speed,
      this.wind_deg,
      this.Name,
      this.Icon);

  static fromJson(Object e) {
    e = e as Map;
    return weather(
      e["dt"],
      e["sunrise"],
      e["sunset"],
      e["temp"],
      e["feels_like"],
      e["preasure"],
      e["humidity"],
      e["dew_point"],
      e["uvi"],
      e["clouds"],
      e["visibility"],
      e["wind_speed"],
      e["wind_deg"],
      e['weather'][0]["main"],
      e['weather'][0]["icon"],
    );
  }
}

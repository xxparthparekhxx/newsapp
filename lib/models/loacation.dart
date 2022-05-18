import 'dart:convert';

class Location {
  final String name; //place name
  final String locality; //city
  final String region_code; //state
  final String country;
  final String country_code;
  final String country_flag;

  Location(
    this.name,
    this.locality,
    this.region_code,
    this.country,
    this.country_code,
    this.country_flag,
  );

  static Location fromRes(String re) {
    var data = jsonDecode(re)['data'][0];

    return Location(
      data["name"],
      data["locality"],
      data["region_code"],
      data["country"],
      data["country_code"],
      "https://flagcdn.com/256x192/${data['country_code'].toString().toLowerCase().substring(0, 2)}.png",
    );
  }
}

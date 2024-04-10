// To parse this JSON data, do
//
//     final sunriseSunsetModel = sunriseSunsetModelFromJson(jsonString);

import 'dart:convert';

SunriseSunsetModel sunriseSunsetModelFromJson(String str) => SunriseSunsetModel.fromJson(json.decode(str));

String sunriseSunsetModelToJson(SunriseSunsetModel data) => json.encode(data.toJson());

class SunriseSunsetModel {
  Results results;
  String status;

  SunriseSunsetModel({
    required this.results,
    required this.status,
  });

  factory SunriseSunsetModel.fromJson(Map<String, dynamic> json) => SunriseSunsetModel(
    results: Results.fromJson(json["results"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "results": results.toJson(),
    "status": status,
  };
}

class Results {
  DateTime date;
  String sunrise;
  String sunset;
  String firstLight;
  String lastLight;
  String dawn;
  String dusk;
  String solarNoon;
  String goldenHour;
  String dayLength;
  String timezone;
  int utcOffset;

  Results({
    required this.date,
    required this.sunrise,
    required this.sunset,
    required this.firstLight,
    required this.lastLight,
    required this.dawn,
    required this.dusk,
    required this.solarNoon,
    required this.goldenHour,
    required this.dayLength,
    required this.timezone,
    required this.utcOffset,
  });

  factory Results.fromJson(Map<String, dynamic> json) => Results(
    date: DateTime.parse(json["date"]),
    sunrise: json["sunrise"],
    sunset: json["sunset"],
    firstLight: json["first_light"],
    lastLight: json["last_light"],
    dawn: json["dawn"],
    dusk: json["dusk"],
    solarNoon: json["solar_noon"],
    goldenHour: json["golden_hour"],
    dayLength: json["day_length"],
    timezone: json["timezone"],
    utcOffset: json["utc_offset"],
  );

  Map<String, dynamic> toJson() => {
    "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    "sunrise": sunrise,
    "sunset": sunset,
    "first_light": firstLight,
    "last_light": lastLight,
    "dawn": dawn,
    "dusk": dusk,
    "solar_noon": solarNoon,
    "golden_hour": goldenHour,
    "day_length": dayLength,
    "timezone": timezone,
    "utc_offset": utcOffset,
  };
}

import 'dart:convert';

CountryTimezoneModel countryTimezoneModelFromJson(String str) => CountryTimezoneModel.fromJson(json.decode(str));

String countryTimezoneModelToJson(CountryTimezoneModel data) => json.encode(data.toJson());

class CountryTimezoneModel {
  CountryTimezoneModel({
      this.results, 
      this.status,});

  CountryTimezoneModel.fromJson(dynamic json) {
    results = json['results'] != null ? Results.fromJson(json['results']) : null;
    status = json['status'];
  }
  Results? results;
  String? status;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (results != null) {
      map['results'] = results?.toJson();
    }
    map['status'] = status;
    return map;
  }

}

class Results {
  Results({
      this.date, 
      this.sunrise, 
      this.sunset, 
      this.firstLight, 
      this.lastLight, 
      this.dawn, 
      this.dusk, 
      this.solarNoon, 
      this.goldenHour, 
      this.dayLength, 
      this.timezone, 
      this.utcOffset,});

  Results.fromJson(dynamic json) {
    date = json['date'];
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    firstLight = json['first_light'];
    lastLight = json['last_light'];
    dawn = json['dawn'];
    dusk = json['dusk'];
    solarNoon = json['solar_noon'];
    goldenHour = json['golden_hour'];
    dayLength = json['day_length'];
    timezone = json['timezone'];
    utcOffset = json['utc_offset'];
  }
  String? date;
  String? sunrise;
  String? sunset;
  String? firstLight;
  String? lastLight;
  String? dawn;
  String? dusk;
  String? solarNoon;
  String? goldenHour;
  String? dayLength;
  String? timezone;
  num? utcOffset;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['date'] = date;
    map['sunrise'] = sunrise;
    map['sunset'] = sunset;
    map['first_light'] = firstLight;
    map['last_light'] = lastLight;
    map['dawn'] = dawn;
    map['dusk'] = dusk;
    map['solar_noon'] = solarNoon;
    map['golden_hour'] = goldenHour;
    map['day_length'] = dayLength;
    map['timezone'] = timezone;
    map['utc_offset'] = utcOffset;
    return map;
  }

}
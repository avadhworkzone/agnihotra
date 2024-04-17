import 'dart:convert';

FutureSunriseSunsetTimeModel  futureSunriseSunsetModelFromJson(String str) => FutureSunriseSunsetTimeModel.fromJson(json.decode(str));

String futureSunriseSunsetModelToJson(FutureSunriseSunsetTimeModel data) => json.encode(data.toJson());

class FutureSunriseSunsetTimeModel {
  FutureSunriseSunsetTimeModel({
      this.results, 
      this.status, 
      this.tzid,});

  FutureSunriseSunsetTimeModel.fromJson(dynamic json) {
    results = json['results'] != null ? Results.fromJson(json['results']) : null;
    status = json['status'];
    tzid = json['tzid'];
  }
  Results? results;
  String? status;
  String? tzid;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (results != null) {
      map['results'] = results?.toJson();
    }
    map['status'] = status;
    map['tzid'] = tzid;
    return map;
  }

}

class Results {
  Results({
      this.sunrise, 
      this.sunset, 
      this.solarNoon, 
      this.dayLength, 
      this.civilTwilightBegin, 
      this.civilTwilightEnd, 
      this.nauticalTwilightBegin, 
      this.nauticalTwilightEnd, 
      this.astronomicalTwilightBegin, 
      this.astronomicalTwilightEnd,});

  Results.fromJson(dynamic json) {
    sunrise = json['sunrise'];
    sunset = json['sunset'];
    solarNoon = json['solar_noon'];
    dayLength = json['day_length'];
    civilTwilightBegin = json['civil_twilight_begin'];
    civilTwilightEnd = json['civil_twilight_end'];
    nauticalTwilightBegin = json['nautical_twilight_begin'];
    nauticalTwilightEnd = json['nautical_twilight_end'];
    astronomicalTwilightBegin = json['astronomical_twilight_begin'];
    astronomicalTwilightEnd = json['astronomical_twilight_end'];
  }
  String? sunrise;
  String? sunset;
  String? solarNoon;
  num? dayLength;
  String? civilTwilightBegin;
  String? civilTwilightEnd;
  String? nauticalTwilightBegin;
  String? nauticalTwilightEnd;
  String? astronomicalTwilightBegin;
  String? astronomicalTwilightEnd;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sunrise'] = sunrise;
    map['sunset'] = sunset;
    map['solar_noon'] = solarNoon;
    map['day_length'] = dayLength;
    map['civil_twilight_begin'] = civilTwilightBegin;
    map['civil_twilight_end'] = civilTwilightEnd;
    map['nautical_twilight_begin'] = nauticalTwilightBegin;
    map['nautical_twilight_end'] = nauticalTwilightEnd;
    map['astronomical_twilight_begin'] = astronomicalTwilightBegin;
    map['astronomical_twilight_end'] = astronomicalTwilightEnd;
    return map;
  }

}
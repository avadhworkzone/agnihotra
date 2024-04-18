import 'package:http/http.dart' as http;
import 'package:sunrise_app/model/country_timezone_model.dart';
import 'package:sunrise_app/model/future_sunrise_sunsetTime_model.dart';
import 'package:sunrise_app/model/sunrise_sunset_model.dart';
import 'package:sunrise_app/services/api_services.dart';


class SunriseSunsetApi {

  static Future getData(double lat,double lon) async {

   try{

     print("Lat Long :- $lat $lon");
     String url = 'https://api.sunrisesunset.io/json?lat=$lat&lng=$lon';
     http.Response? response = await HttpServices.getApi(url: url);

     if(response != null && response.statusCode == 200){
       print('=====Response========>${response.body}');
       return sunriseSunsetModelFromJson(response.body);
     }

   }
   catch(e){
      print(e);
      return null;
   }
  }

  static Future getFutureTime(double lat,double lon,String date,String apiKey) async {

    try{


      String url = 'https://api.sunrise-sunset.org/json?lat=$lat&lng=$lon&date=$date&formatted=0&key=$apiKey';
      http.Response? response = await HttpServices.getApi(url: url);

      if(response != null && response.statusCode == 200){
         print('=====Response getSunriseAndSunSetTime========>${response.body}');
         return futureSunriseSunsetModelFromJson(response.body);
      }
    }

    catch(e){
      print("Error :- $e");
    }

  }

  static Future getDifferentCountryTime(double lat,double lon,String date,String countryTimeZone) async {

    try{


      String url = 'https://api.sunrisesunset.io/json?lat=$lat&lng=$lon&timezone=$countryTimeZone&date=$date';
      http.Response? response = await HttpServices.getApi(url: url);

      if(response != null && response.statusCode == 200){
        print('=====Response getDifferentCountryTime========>${response.body}');
        return countryTimezoneModelFromJson(response.body);
      }
    }

    catch(e){
      print("Error :- $e");
    }

  }

}
import 'package:http/http.dart' as http;
import 'package:sunrise_app/model/country_timezone_model.dart';

import 'package:sunrise_app/services/api_services.dart';


class SunriseSunsetApi {



  static Future getDifferentCountryTime(double lat,double lon,String date,String countryTimeZone) async {

    try{

      final timeZonebody = {
        "lat":"$lat",
        "lng":"$lon",
        "timezone":countryTimeZone,
        "date":date,
      };

      print("timeZonebody :- $timeZonebody");

      String url = 'https://api.sunrisesunset.io/json?lat=$lat&lng=$lon&timezone=$countryTimeZone&date=$date';
      http.Response? response = await HttpServices.getApi(url: url);
           print("=============== RESPONSE :- $response =====================");
      if(response != null && response.statusCode == 200){
        print('=====Response getDifferentCountryTime========>${response.body}');
        return countryTimezoneModelFromJson(response.body);
      }
      else{
        print("===================================response!.statusCode ${response!.statusCode}");
      }
    }

    catch(e){
      print("Error :- $e");
    }

  }

}
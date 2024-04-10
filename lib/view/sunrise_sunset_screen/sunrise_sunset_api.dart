import 'package:http/http.dart' as http;
import 'package:sunrise_app/model/sunrise_sunset_model.dart';
import 'package:sunrise_app/services/api_services.dart';

class SunriseSunsetApi{

  static Future getData(double lat,double lon)async{
   try{
     String url = 'https://api.sunrisesunset.io/json?lat=$lat&lng=$lon';
     http.Response? response = await HttpServices.getApi(url: url);
     if (response != null && response.statusCode == 200) {
       print('=====Response========>${response.body}');
       return sunriseSunsetModelFromJson(response.body);
     }
   }catch(e){
      print(e);
      return null;
   }
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app/model/country_timezone_model.dart';
import 'package:sunrise_app/model/future_sunrise_sunsetTime_model.dart';
import 'package:sunrise_app/model/sunrise_sunset_model.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/const_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_api.dart';
import 'package:weather/weather.dart';

class SunriseSunsetController extends GetxController {

  WeatherFactory? ws;
  Rx<Weather?> weather = Rx<Weather?>(null);
  RxString currentTime = ''.obs;


  late Rx<DateTime> selectedDate = DateTime.now().obs;


  Future<void> selectDate(BuildContext context) async {


    if(PrefServices.getString('currentAddress').isNotEmpty){
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 1470)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: const ColorScheme.light().copyWith(
                primary: Colors.blue, // Adjust color as needed
              ),
            ),
            child: child!,
          );
        },

        selectableDayPredicate: (DateTime date){
          return true;
        },
      );

      if (picked != null && picked != selectedDate.value ){
        selectedDate.value = picked;

        String formatDate = DateFormat('dd MMMM yyyy').format(selectedDate.value);

        DateFormat inputFormat = DateFormat("dd MMMM yyyy");
        DateTime date = inputFormat.parse(formatDate);

        // Format the DateTime object to yyyy-MM-dd format
        DateFormat outputFormat = DateFormat("yyyy-MM-dd");
        String formattedDate = outputFormat.format(date);

        print("formattedDate:- $formattedDate");

        futureSunriseSunsetTime(latitude: PrefServices.getDouble('currentLat'),
            longitude: PrefServices.getDouble('currentLong'),
            dateTime: formattedDate);

      }
    }


  }

  void updateTime() {
    String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
    DateTime time = DateFormat.Hms().parse(formattedTime);
    currentTime.value = DateFormat.jms().format(time);
  }

  RxString sunrise = ''.obs;
  RxString sunset = ''.obs;
  RxString futureSunriseTime = ''.obs;
  RxString futureSunsetTime = ''.obs;
  RxString  formattedSunriseTime = ''.obs;
  RxString  formattedSunsetTime = ''.obs;
  RxBool isLoad = false.obs;
  RxBool isFutureLoad = false.obs;
  RxBool isCountryLoad = false.obs;
  SunriseSunsetModel? sunriseSunsetModel;
  FutureSunriseSunsetTimeModel? futureSunriseSunsetTimeModel;
  CountryTimezoneModel? countryTimezoneModel;
  RxString selectedValue = ''.obs;



 Future<void> getSunriseSunsetTime(double latitude, double longitude) async {

    isLoad.value = true;
    sunriseSunsetModel = await SunriseSunsetApi.getData(latitude, longitude);

    sunrise.value = sunriseSunsetModel?.results.sunrise ?? '';
    sunset.value = sunriseSunsetModel?.results.sunset ?? '';

    PrefServices.setValue('sunrise', sunrise.value);
    PrefServices.setValue('sunset', sunset.value);

    print("SunRise Value :- ${sunrise.value}");
    print("sunset Value :- ${sunset.value}");
    isLoad.value = false;
    update();

  }

  Future<void> countryTimeZone(double latitude, double longitude,String date,String countryTimeZone) async {

    isCountryLoad.value = true;
    countryTimezoneModel = await SunriseSunsetApi.getDifferentCountryTime(latitude, longitude,date,countryTimeZone);

    sunrise.value = countryTimezoneModel!.results?.sunrise ?? '';
    sunset.value = countryTimezoneModel?.results?.sunset ?? '';

    PrefServices.setValue('sunrise', sunrise.value);
    PrefServices.setValue('sunset', sunset.value);

    print("SunRise Value :- ${sunrise.value}");
    print("sunset Value :- ${sunset.value}");
    isCountryLoad.value = false;
    update();

  }

  Future<void> futureSunriseSunsetTime({required double latitude, required double longitude,required String dateTime}) async {

    isFutureLoad.value = true;
    futureSunriseSunsetTimeModel = await SunriseSunsetApi.getFutureTime(latitude, longitude,dateTime,ConstUtils.googleApiKey);


    futureSunriseTime.value = futureSunriseSunsetTimeModel?.results?.sunrise ?? '';
    futureSunsetTime.value = futureSunriseSunsetTimeModel?.results?.sunset ?? '';



    // Parse the UTC time string
    DateTime utcSunRiseTime = DateTime.parse(futureSunriseTime.value);
    DateTime utcSunsetTime = DateTime.parse(futureSunsetTime.value);

    // Create a DateTime object with the UTC time
    DateTime indiaSunriseTime = utcSunRiseTime.add(const Duration(hours: 5, minutes: 31,seconds: 15));
    DateTime indiaSunsetTime = utcSunsetTime.add(const Duration(hours: 5, minutes: 28,seconds: 30));

     // Format the DateTime object to 12-hour format with AM/PM
     formattedSunriseTime.value = DateFormat('hh:mm:ss a').format(indiaSunriseTime);
     formattedSunsetTime.value = DateFormat('hh:mm:ss a').format(indiaSunsetTime);

    print("Future Sun Rise Value :- ${formattedSunriseTime.value}");
    print("Future sunset Value :- ${formattedSunsetTime.value}");

    PrefServices.setValue('futureSunrise', formattedSunriseTime.value);
    PrefServices.setValue('futureSunset', formattedSunsetTime.value);

    isFutureLoad.value = false;
    update();

  }



  Future<void> clearSunriseSunsetData() async {
    sunrise.value = '';
    sunset.value = '';
    await PrefServices.removeValue('sunrise');
    await PrefServices.removeValue('sunset');
  }


}
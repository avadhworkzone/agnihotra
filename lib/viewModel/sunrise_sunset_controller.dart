import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app/model/country_timezone_model.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/const_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_api.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/weather.dart';


class SunriseSunsetController extends GetxController {

  WeatherFactory? ws;
  Rx<Weather?> weather = Rx<Weather?>(null);
  RxString currentTime = ''.obs;



  late Rx<DateTime> selectedDate = DateTime.now().obs;
  String formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  final Uri _url = Uri.parse(ConstUtils.privacyPolicyLink);

  Future<void> launchUrl() async {
    if (!await launch(_url.toString())) {
      throw 'Could not launch $_url';
    }
  }





  RxString countryTodaySunriseTimeZone = ''.obs;
  RxString countryTodaySunsetTimeZone = ''.obs;


  RxString countryTommorowSunriseTimeZone = ''.obs;
  RxString countryTomorrowSunsetTimeZone = ''.obs;



  RxBool isTodayTimeLoad = false.obs;
  RxBool isTommorowTimeLoad = false.obs;

  CountryTimezoneModel? countryTimezoneModel;
  RxString selectedValue = ''.obs;



  Future<void> selectDate(BuildContext context) async {


    if(PrefServices.getString('currentAddress').isNotEmpty){
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 1470)),
        builder: (BuildContext context, Widget? child){
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
        formattedDate = outputFormat.format(date);

        print("formattedDate :- $formattedDate");

        countryTodayTimeZone(
            PrefServices.getDouble('currentLat'),
            PrefServices.getDouble('currentLong'),
            formattedDate,
            PrefServices.getString('countryName'));


      }
    }


  }




  void updateTime(){
    String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
    DateTime time = DateFormat.Hms().parse(formattedTime);
    currentTime.value = DateFormat.jms().format(time);
  }









  Future<void> countryTodayTimeZone(double latitude, double longitude,String date,String countryTimeZone) async {

    isTodayTimeLoad.value = true;
    countryTimezoneModel = await SunriseSunsetApi.getDifferentCountryTime(latitude, longitude,date,countryTimeZone);

    countryTodaySunriseTimeZone.value = countryTimezoneModel?.results?.sunrise ?? '';
    countryTodaySunsetTimeZone.value = countryTimezoneModel?.results?.sunset ?? '';




    PrefServices.setValue('countryTodaySunriseTimeZone', countryTodaySunriseTimeZone.value);
    PrefServices.setValue('countryTodaySunsetTimeZone', countryTodaySunsetTimeZone.value);

    print("countryTodaySunriseTimeZone Value :- ${countryTodaySunriseTimeZone.value}");
    print("countryTodaySunsetTimeZone Value :- ${countryTodaySunsetTimeZone.value}");
    isTodayTimeLoad.value = false;
    update();

  }

  Future<void> countryTommorowTimeZone(double latitude, double longitude,String date,String countryTimeZone) async {

    isTommorowTimeLoad.value = true;
    countryTimezoneModel = await SunriseSunsetApi.getDifferentCountryTime(latitude, longitude,date,countryTimeZone);

    countryTommorowSunriseTimeZone.value = countryTimezoneModel?.results?.sunrise ?? '';
    countryTomorrowSunsetTimeZone.value = countryTimezoneModel?.results?.sunset ?? '';

    PrefServices.setValue('countryTommorowSunriseTimeZone', countryTommorowSunriseTimeZone.value);
    PrefServices.setValue('countryTomorrowSunsetTimeZone', countryTomorrowSunsetTimeZone.value);

    print("countryTommorowSunriseTimeZone Value :- ${countryTommorowSunriseTimeZone.value}");
    print("countryTomorrowSunsetTimeZone Value :- ${countryTomorrowSunsetTimeZone.value}");
    isTommorowTimeLoad.value = false;
    update();

  }





  Future<void> clearSunriseSunsetData() async {
    await PrefServices.removeValue('sunrise');
    await PrefServices.removeValue('sunset');
  }





}
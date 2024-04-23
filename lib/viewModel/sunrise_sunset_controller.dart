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
import 'package:sunrise_app/viewModel/settings_controller.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:weather/weather.dart';

class SunriseSunsetController extends GetxController {
 // SettingScreenController settingScreenController = Get.find<SettingScreenController>();

  WeatherFactory? ws;
  Rx<Weather?> weather = Rx<Weather?>(null);
  RxString currentTime = ''.obs;


  late Rx<DateTime> selectedDate = DateTime.now().obs;
  String formattedDate = DateFormat("yyyy-MM-dd").format(DateTime.now());
  final Uri _url = Uri.parse('https://www.freeprivacypolicy.com/live/b55e5ea0-1038-4c24-b269-7359dcad9bb2');

  Future<void> launchUrl() async {
    if (!await launch(_url.toString())) {
      throw 'Could not launch $_url';
    }
  }




  RxString countrySunriseTimeZone = ''.obs;
  RxString countrySunsetTimeZone = ''.obs;


  RxBool isCountryLoad = false.obs;
  SunriseSunsetModel? sunriseSunsetModel;
  FutureSunriseSunsetTimeModel? futureSunriseSunsetTimeModel;
  CountryTimezoneModel? countryTimezoneModel;
  RxString selectedValue = ''.obs;


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
        formattedDate = outputFormat.format(date);

        print("formattedDate :- $formattedDate");

        countryTimeZone(
            PrefServices.getDouble('currentLat'),
            PrefServices.getDouble('currentLong'),
            formattedDate,
            PrefServices.getString('countryName'));


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

  Future<void> countryTimeZone(double latitude, double longitude,String date,String countryTimeZone) async {

    isCountryLoad.value = true;
    countryTimezoneModel = await SunriseSunsetApi.getDifferentCountryTime(latitude, longitude,date,countryTimeZone);

    countrySunriseTimeZone.value = countryTimezoneModel!.results?.sunrise ?? '';
    countrySunsetTimeZone.value = countryTimezoneModel?.results?.sunset ?? '';

    PrefServices.setValue('countrySunriseTimeZone', countrySunriseTimeZone.value);
    PrefServices.setValue('countrySunsetTimeZone', countrySunsetTimeZone.value);

    print("countrySunriseTimeZone Value :- ${countrySunriseTimeZone.value}");
    print("countrySunsetTimeZone Value :- ${countrySunsetTimeZone.value}");
    isCountryLoad.value = false;

    update();

  }

  Future<void> futureSunriseSunsetTime({required double latitude, required double longitude,required String dateTime}) async {

    isFutureLoad.value = true;
    futureSunriseSunsetTimeModel = await SunriseSunsetApi.getDifferentCountryTime(latitude, longitude,dateTime,ConstUtils.googleApiKey);


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

  late RxBool isCountdownOn = false.obs;
  late RxString countdownTime = ''.obs;
  Rx<Duration> difference = Rx<Duration>(Duration.zero);

  DateTime parseTime(String timeStr) {
    // Create a DateTimeFormatter with the expected time format
    DateFormat formatter = DateFormat("hh:mm:ss a");
    print('=======>${timeStr}');
    // if(timeStr.isEmpty){
    //   return DateTime.now();
    // }
    // Parse the time string into a DateTime object
    return formatter.parse(timeStr);
  }

  String formatDuration(Duration duration) {
    // Calculate hours, minutes, and seconds
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    // Format the duration as "hh:mm:ss"
    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }


  void onCountDown(){
    DateTime now = DateTime.now();
    String sunriseTime =  PrefServices.getString('countrySunriseTimeZone');
    String sunsetTime =  PrefServices.getString('countrySunsetTimeZone');
    DateTime sunrise = parseTime(sunriseTime);
    DateTime sunset = parseTime(sunsetTime);

    DateTime sunriseTimeWithoutYear = DateTime(now.year, now.month, now.day, sunrise.hour, sunrise.minute, sunrise.second);
    DateTime sunsetTimeWithoutYear = DateTime(now.year, now.month, now.day, sunset.hour, sunset.minute, sunset.second);
    DateTime currentTimeWithoutYear = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    if (currentTimeWithoutYear.isAfter(sunriseTimeWithoutYear)) {
      if (currentTimeWithoutYear.isBefore(sunsetTimeWithoutYear)) {
        difference.value = sunsetTimeWithoutYear.difference(currentTimeWithoutYear);
        print("Time until sunset: ${formatDuration(difference.value)} hours.");
        PrefServices.setValue('timeUntilTime', formatDuration(difference.value));
      } else {
        DateTime nextDaySunrise = sunriseTimeWithoutYear.add(Duration(days: 1));
        difference.value = nextDaySunrise.difference(currentTimeWithoutYear);
        print("Time until next sunrise: ${formatDuration(difference.value)} hours.");
        PrefServices.setValue('timeUntilTime', formatDuration(difference.value));
      }
    } else {
      difference.value = sunriseTimeWithoutYear.difference(currentTimeWithoutYear);
      print("Time until sunrise: ${formatDuration(difference.value)} hours.");
      PrefServices.setValue('timeUntilTime', formatDuration(difference.value));
    }
  }
}
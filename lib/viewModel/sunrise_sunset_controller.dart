import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

    if (picked != null && picked != selectedDate.value){
      selectedDate.value = picked;

       String formatDate = DateFormat('dd MMMM yyyy').format(selectedDate.value);

      DateFormat inputFormat = DateFormat("dd MMMM yyyy");
      DateTime date = inputFormat.parse(formatDate);

      // Format the DateTime object to yyyy-MM-dd format
      DateFormat outputFormat = DateFormat("yyyy-MM-dd");
      String formattedDate = outputFormat.format(date);

      print("formattedDate:- $formattedDate");

      futureSunriseSunsetTime(latitude: PrefServices.getDouble('saveLat'),
          longitude: PrefServices.getDouble('saveLong'),
          dateTime: formattedDate);

    }
  }

  void updateTime() {
    String formattedTime = DateFormat('HH:mm:ss').format(DateTime.now());
    DateTime time = DateFormat.Hms().parse(formattedTime);
    currentTime.value = DateFormat.jms().format(time);
  }

  RxString sunrise = ''.obs;
  RxString sunset = ''.obs;
  RxBool isLoad = false.obs;
  SunriseSunsetModel? sunriseSunsetModel;
  FutureSunriseSunsetTimeModel? futureSunriseSunsetTimeModel;
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

  Future<void> futureSunriseSunsetTime({required double latitude, required double longitude,required String dateTime}) async {

    isLoad.value = true;
    futureSunriseSunsetTimeModel = await SunriseSunsetApi.getFutureTime(latitude, longitude,dateTime,ConstUtils.googleApiKey);


    sunrise.value = futureSunriseSunsetTimeModel?.results?.sunrise ?? '';
    sunset.value = futureSunriseSunsetTimeModel?.results?.sunset ?? '';

    PrefServices.setValue('futureSunrise', sunrise.value);
    PrefServices.setValue('futureSunset', sunset.value);

    print("Future SunRise Value :- ${sunrise.value}");
    print("Future sunset Value :- ${sunset.value}");
    isLoad.value = false;
    update();

  }


  Future<void> clearSunriseSunsetData() async {
    sunrise.value = '';
    sunset.value = '';
    await PrefServices.removeValue('sunrise');
    await PrefServices.removeValue('sunset');
  }
}

import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';

class SettingScreenController extends GetxController{


  RxBool on = false.obs;
  RxBool isScreenOn = false.obs;

  void toggle() => on.value = on.value ? false : true;

  RxBool on2 = false.obs;
  void toggle2() => on2.value = on2.value ? false : true;

  RxBool on4 = false.obs;
  void toggle4(){
    on4.value = on4.value ? false : true;
  }

  RxBool isCountDown = false.obs;
  Rx<Duration> difference = Rx<Duration>(Duration.zero);
  RxBool is24Hours = false.obs;
  RxString current24HourTime = ''.obs;
  RxString sunrise24HourTime = ''.obs;
  RxString sunset24HourTime = ''.obs;
  RxString countDownValue = ''.obs;

  @override
  void onInit(){
    super.onInit();
    updateTime();
    onCountDown();
    is24Hours.value = PrefServices.getBool('is24Hours');
    isCountDown.value = PrefServices.getBool('isCountDown');


  }

  DateTime parseTime(String timeStr) {
    // Create a DateTimeFormatter with the expected time format
    DateFormat formatter = DateFormat("hh:mm:ss a");

    if (timeStr.isEmpty) {
      return DateTime.now();
    }
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

  Future<String> onCountDown() async {

    Timer.periodic(const Duration(seconds: 1), (timer) async {

      DateTime now = DateTime.now();
      String sunriseTime = PrefServices.getString('countrySunriseTimeZone');
      String sunsetTime = PrefServices.getString('countrySunsetTimeZone');
      DateTime sunrise = parseTime(sunriseTime);
      DateTime sunset = parseTime(sunsetTime);

      DateTime sunriseTimeWithoutYear = DateTime(now.year, now.month, now.day,
          sunrise.hour, sunrise.minute, sunrise.second);
      DateTime sunsetTimeWithoutYear = DateTime(now.year, now.month, now.day,
          sunset.hour, sunset.minute, sunset.second);
      DateTime currentTimeWithoutYear = DateTime(
          now.year, now.month, now.day, now.hour, now.minute, now.second);

      if (currentTimeWithoutYear.isAfter(sunriseTimeWithoutYear)) {
        if (currentTimeWithoutYear.isBefore(sunsetTimeWithoutYear)) {
          difference.value =
              sunsetTimeWithoutYear.difference(currentTimeWithoutYear);
          // print(
          //     "Time until sunset: ${formatDuration(difference.value)} hours.");
          await PrefServices.setValue(
              'timeUntilTime', formatDuration(difference.value));
        } else {
          DateTime nextDaySunrise =
              sunriseTimeWithoutYear.add(const Duration(days: 1));
          difference.value = nextDaySunrise.difference(currentTimeWithoutYear);

          // print("Time until next sunrise: ${formatDuration(difference.value)} hours.");
          await PrefServices.setValue('timeUntilTime', formatDuration(difference.value));
        }
      } else {
        difference.value = sunriseTimeWithoutYear.difference(currentTimeWithoutYear);
        // print("Time until sunrise: ${formatDuration(difference.value)} hours.");
        await PrefServices.setValue(
            'timeUntilTime', formatDuration(difference.value));
      }

      countDownValue.value = PrefServices.getString('timeUntilTime');
      PrefServices.setValue('countDownValue',countDownValue.value);

      // Check if countdown has reached zero
      if (difference.value.inSeconds <= 0){
        timer.cancel(); // Stop the timer
      }

      isCountDown.value = PrefServices.getBool('isCountDown');
    });


    return countDownValue.value;

  }

  void toggleCountDown(bool value){
    isCountDown.value = value;
    PrefServices.setValue('isCountDown', value);
    if (value) {
      onCountDown();
    }
  }

  void updateTime() {
    String formattedTime =
        DateFormat(is24Hours.value ? 'HH:mm:ss' : 'h:mm:ss a')
            .format(DateTime.now());
    current24HourTime.value = formattedTime;
  }

  void toggleTimeFormat(bool value) {
    is24Hours.value = value;
    is24HourFormat.value = !is24HourFormat.value;
    updateTime();
    PrefServices.setValue('is24Hours', value);
  }

  RxBool is24HourFormat = false.obs;

  String formatTime(String time, bool is24Hour) {
    bool is24Hour = PrefServices.getBool('is24Hours');

    if (is24Hour) {
      DateTime parsedTime = DateFormat('hh:mm:ss a').parse(time);
      String formattedTime = DateFormat('kk:mm:ss').format(parsedTime);
      return formattedTime;
    }

    else {
      return time;
    }

  }
}
import 'dart:async';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';

class SettingScreenController extends GetxController {

  RxBool isScreenOn = false.obs;

   AudioPlayer? audioPlayer;
   Timer? sunriseTimer;
   Timer? sunsetTimer;
  RxBool isBellRinging = false.obs;

  RxBool on2 = false.obs;
  void toggle2() => on2.value = on2.value ? false : true;

  RxBool on4 = false.obs;

  void toggle4() => on4.value = on4.value ? false : true;
  RxBool is24HourFormat = false.obs;
  RxBool isCountDown = false.obs;
  Rx<Duration> difference = Rx<Duration>(Duration.zero);
  RxBool is24Hours = false.obs;
  RxString current24HourTime = ''.obs;
  RxString sunrise24HourTime = ''.obs;
  RxString sunset24HourTime = ''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateTime();
    is24Hours.value = PrefServices.getBool('is24Hours');
    isCountDown.value = PrefServices.getBool('isCountDown');
  }

  DateTime parseTime(String timeStr) {
    // Create a DateTimeFormatter with the expected time format
    DateFormat formatter = DateFormat("hh:mm:ss a");
    print('=======>${timeStr}');
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

  Future<void> onCountDown() async {
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
        print("Time until sunset: ${formatDuration(difference.value)} hours.");
        await PrefServices.setValue(
            'timeUntilTime', formatDuration(difference.value));
      } else {
        DateTime nextDaySunrise =
            sunriseTimeWithoutYear.add(const Duration(days: 1));
        difference.value = nextDaySunrise.difference(currentTimeWithoutYear);
        print(
            "Time until next sunrise: ${formatDuration(difference.value)} hours.");
        await    PrefServices.setValue(
            'timeUntilTime', formatDuration(difference.value));
      }
    } else {
      difference.value =
          sunriseTimeWithoutYear.difference(currentTimeWithoutYear);
      print("Time until sunrise: ${formatDuration(difference.value)} hours.");
      await PrefServices.setValue(
          'timeUntilTime', formatDuration(difference.value));
    }
    print('TIME DIFF :=>${PrefServices.getString('timeUntilTime')}');
    isCountDown.value = PrefServices.getBool('isCountDown');
  }

  void toggleCountDown(bool value) {
    isCountDown.value = value;
    PrefServices.setValue('isCountDown', value);
    print('==isCountdaom${value}');
    if (value) {
      onCountDown();
    }
  }

  void updateTime() {
    String formattedTime = DateFormat(is24Hours.value ? 'HH:mm:ss' : 'h:mm:ss a').format(DateTime.now());
    current24HourTime.value = formattedTime;
  }
  void toggleTimeFormat(bool value) {
    is24Hours.value = value;
    is24HourFormat.value = !is24HourFormat.value;
    updateTime();
    PrefServices.setValue('is24Hours', value);
  }


  String formatTime(String time, bool is24Hour) {
    bool is24Hour = PrefServices.getBool('is24Hours');
    print("===>hours===>${is24Hour}");
    print("===>time===>${time}");

    if (is24Hour) {
      // Convert to 24-hour format
      DateTime parsedTime = DateFormat('hh:mm:ss a').parse(time);
      String formattedTime = DateFormat('kk:mm:ss').format(parsedTime);
      return formattedTime;
    } else {
      return time;
    }
  }

  // void startBellForSunrise() {
  //
  // String sunriseTime = PrefServices.getString('countrySunriseTimeZone');
  // DateTime now = DateTime.now();
  // DateTime sunrise = DateFormat('hh:mm:ss a').parse(sunriseTime);
  //
  //   // Check if the scheduled time is already passed for today
  //   if (now.isAfter(sunrise)) {
  //     // If passed, schedule the bell for the next day
  //     sunrise = sunrise.add(const Duration(days: 1));
  //   }
  //
  //   // Calculate the duration until the scheduled time
  //   Duration durationUntilScheduledTime = sunrise.difference(now);
  //
  //   // Schedule the timer to ring the bell
  // sunriseTimer = Timer(durationUntilScheduledTime, () {
  //     if (isBellRinging.value) {
  //       _ringBell(); // Only ring the bell if it's currently enabled
  //     }
  //     // Reschedule the timer for the next day
  //     startBellForSunrise();
  //   });
  // }
  //
  // void startBellForSunset() {
  //
  //   String sunsetTime = PrefServices.getString('countrySunsetTimeZone');
  //   DateTime now = DateTime.now();
  //   DateTime sunset =  DateFormat('hh:mm:ss a').parse(sunsetTime);
  //
  //   // Check if the scheduled time is already passed for today
  //   if (now.isAfter(sunset)) {
  //     // If passed, schedule the bell for the next day
  //     sunset = sunset.add(const Duration(days: 1));
  //   }
  //
  //   // Calculate the duration until the scheduled time
  //   Duration durationUntilScheduledTime = sunset.difference(now);
  //
  //   // Schedule the timer to ring the bell
  //   sunsetTimer = Timer(durationUntilScheduledTime, () {
  //     if (isBellRinging.value) {
  //       _ringBell();// Only ring the bell if it's currently enabled
  //     }
  //     // Reschedule the timer for the next day
  //     startBellForSunset();
  //   });
  // }

  void startBellForSunriseOrSunset(){
    String sunrise = PrefServices.getString('countrySunriseTimeZone') ?? '';
    String sunset = PrefServices.getString('countrySunsetTimeZone') ?? '';

    if(sunrise.isNotEmpty && sunset.isNotEmpty){
      DateTime sunriseTime = DateFormat('hh:mm:ss a').parse(sunrise);
      DateTime sunsetTime = DateFormat('hh:mm:ss a').parse(sunset);

      DateTime currentTime = DateTime.now();
      if(currentTime.isCloseTo(sunriseTime,distance: const Duration(minutes: 1))||
          currentTime.isCloseTo(sunsetTime,distance: const Duration(minutes: 1))){
        _ringBell();
      }
    }
  }
  Future<void> _ringBell() async {
     audioPlayer?.setAsset('assets/audio/meditation_bell.mp3');
    await audioPlayer?.play();
  }

// void startTimer() {
  //   // Schedule the bell to ring at 12:42:00 PM

  //   DateTime now = DateTime.now();
  //   DateTime scheduledTime = DateTime(
  //     now.year,
  //     now.month,
  //     now.day,
  //     15,
  //     35,
  //     0,
  //   );
  //
  //   // Check if the scheduled time is already passed for today
  //   if (now.isAfter(scheduledTime)) {
  //     // If passed, schedule the bell for the next day
  //     scheduledTime = scheduledTime.add(const Duration(days: 1));
  //   }
  //
  //   // Calculate the duration until the scheduled time
  //   Duration durationUntilScheduledTime = scheduledTime.difference(now);
  //
  //   // Schedule the timer to ring the bell
  //   timer = Timer(durationUntilScheduledTime, () {
  //     if (isBellRinging.value) {
  //       _ringBell(); // Only ring the bell if it's currently enabled
  //     }
  //     // Reschedule the timer for the next day
  //     startTimer();
  //   });
  // }
  // void startTimer() {
  //   // Schedule the timer to ring the bell at sunrise and sunset times
  //   timer = Timer.periodic(Duration(minutes: 1), (timer) {
  //     // Get current time
  //     DateTime now = DateTime.now();
  //     // Get sunrise and sunset times from preferences
  //     String sunriseTime = PrefServices.getString('countrySunriseTimeZone');
  //     String sunsetTime = PrefServices.getString('countrySunsetTimeZone');
  //     // Parse sunrise and sunset times
  //     DateTime sunrise = DateTime.parse(sunriseTime);
  //     DateTime sunset = DateTime.parse(sunsetTime);
  //     // Check if current time is close to sunrise or sunset time (within 1 minute difference)
  //     if (now.isCloseTo(sunrise, distance: Duration(minutes: 1)) || now.isCloseTo(sunset, distance: Duration(minutes: 1))) {
  //       // Ring the bell
  //       _ringBell();
  //     }
  //   });
  // }
  // ------------------------------------
  // Future<void> _ringBell() async {
  //    audioPlayer.setAsset('assets/audio/meditation_bell.mp3');
  //   await audioPlayer.play();
  //   // You can add any additional actions here when the bell rings
  // }
  //
  // void toggleBellFormat(){
  //   startBellForSunrise();
  //   startBellForSunset();
  // }
  @override
  void onClose() {
    audioPlayer?.dispose();
    sunriseTimer?.cancel();
    sunsetTimer?.cancel();
    super.onClose();
  }

}
extension DateTimeExtension on DateTime {
  bool isCloseTo(DateTime other, {Duration distance = const Duration(minutes: 1)}) {
    return isBefore(other.add(distance)) && isAfter(other.subtract(distance));
  }
}
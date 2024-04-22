import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';

class SettingScreenController extends GetxController{
  SunriseSunsetController sunriseSunsetController = Get.find<SunriseSunsetController>();

  RxBool on = false.obs;
  void toggle() => on.value = on.value ? false : true;

  RxBool on1 = false.obs;
  void toggle1() => on1.value = on1.value ? false : true;

  RxBool on2 = false.obs;
  void toggle2() => on2.value = on2.value ? false : true;

  RxBool on3 = false.obs;
  void toggle3() => on3.value = on3.value ? false : true;

  RxBool on4 = false.obs;
  void toggle4() => on4.value = on4.value ? false : true;

  RxBool isCountDown = false.obs;
  Rx<Duration> difference = Rx<Duration>(Duration.zero);
  RxBool is24Hours = false.obs;
 // RxBool is24Hours = (PrefServices.getBool('is24Hours') ?? false).obs;

  RxString current24HourTime = ''.obs;
  RxString sunrise24HourTime = ''.obs;
  RxString sunset24HourTime = ''.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updateTime();
    onCountDown();
    is24Hours.value = PrefServices.getBool('is24Hours');
    isCountDown.value = PrefServices.getBool('isCountDown');

  }

  DateTime parseTime(String timeStr) {
    // Create a DateTimeFormatter with the expected time format
    DateFormat formatter = DateFormat("hh:mm:ss a");
    print('=======>${timeStr}');
     if(timeStr.isEmpty){
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


  void onCountDown(){
    DateTime now = DateTime.now();
    String sunriseTime =  PrefServices.getString('sunrise');
    String sunsetTime =  PrefServices.getString('sunset');
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
  void onFutureCountDown(){
    ///Start
    // Example: For demonstration purpose, I'm setting the current time as 7:59:41 PM
    DateTime now = DateTime.now();

    // Example: For demonstration purpose, I'm setting the sunrise and sunset times
    // String sunriseTime = '06:17:05 AM';
    // String sunsetTime = '06:59:05 PM';
    String sunriseTime =  PrefServices.getString('futureSunrise');
    String sunsetTime =  PrefServices.getString('futureSunset');

    // Parse the sunrise and sunset times
    DateTime sunrise = parseTime(sunriseTime);
    DateTime sunset = parseTime(sunsetTime);

    DateTime sunriseTimeWithoutYear = DateTime(now.year, now.month, now.day, sunrise.hour, sunrise.minute, sunrise.second);
    DateTime sunsetTimeWithoutYear = DateTime(now.year, now.month, now.day, sunset.hour, sunset.minute, sunset.second);
    DateTime currentTimeWithoutYear = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);

    // Check if sunrise has occurred
    if (currentTimeWithoutYear.isAfter(sunriseTimeWithoutYear)) {
      // Sunrise has occurred, calculate time until sunset
      if (currentTimeWithoutYear.isBefore(sunsetTimeWithoutYear)) {
        difference.value = sunsetTimeWithoutYear.difference(currentTimeWithoutYear);
        print("Time until sunset: ${formatDuration(difference.value)} hours.");
        PrefServices.setValue('timeUntilTime', formatDuration(difference.value));
      } else {
        // Sunset has occurred, calculate time until next sunrise
        DateTime nextDaySunrise = sunriseTimeWithoutYear.add(Duration(days: 1));
        difference.value = nextDaySunrise.difference(currentTimeWithoutYear);
        print("Time until next sunrise: ${formatDuration(difference.value)} hours.");
        PrefServices.setValue('timeUntilTime', formatDuration(difference.value));
      }
    } else {
      // Sunrise hasn't occurred yet, calculate time until sunrise
      difference.value = sunriseTimeWithoutYear.difference(currentTimeWithoutYear);
      print("Time until sunrise: ${formatDuration(difference.value)} hours.");
      PrefServices.setValue('timeUntilTime', formatDuration(difference.value));
    }

  }

  void toggleCountDown(bool value) {
    isCountDown.value = value;
    if (value) {
      onCountDown();
      onFutureCountDown();
    }
    PrefServices.setValue('isCountDown', value);
  }



  void updateTime() {
    String formattedTime = DateFormat(is24Hours.value ? 'HH:mm:ss' : 'h:mm:ss a').format(DateTime.now());
    current24HourTime.value = formattedTime;


  }

  void updateSunriseSunsetTime(){
    String sunset12Hour = PrefServices.getString('sunset');
    String sunrise12Hour = PrefServices.getString('sunrise');

    // Parse the time string to DateTime object
    var dateTimeSunset = DateFormat('h:mm:ss a').parse(sunset12Hour);
    print('Original Time sunset: $sunset12Hour');

    var dateTimeSunrise= DateFormat('h:mm:ss a').parse(sunrise12Hour);
    print('Original Time sunrise: $sunrise12Hour');
    // Format the DateTime object to 24-hour format
    String sunset24Hour = DateFormat('HH:mm:ss').format(dateTimeSunset);
    print('Time in 24-hour format sunset: $sunset24Hour');

    String sunrise24Hour = DateFormat('HH:mm:ss').format(dateTimeSunrise);
    print('Time in 24-hour format sunrise: $sunrise24Hour');

    sunrise24HourTime.value = sunrise24Hour;
    sunset24HourTime.value = sunset24Hour;
    PrefServices.setValue('sunrise24Hours', sunrise24HourTime.value);
    PrefServices.setValue('sunset24Hours', sunset24HourTime.value);
  }
  // void updateSunriseSunsetTime(){
  //   String sunset12Hour = PrefServices.getString('sunset');
  //   String sunrise12Hour = PrefServices.getString('sunrise');
  //
  //   // Parse the time string to DateTime object
  //   var dateTimeSunset = DateFormat('h:mm:ss a').parse(sunset12Hour);
  //   print( 'Original Time sunset: $sunset12Hour',);
  //
  //   var dateTimeSunrise= DateFormat('h:mm:ss a').parse(sunrise12Hour);
  //   print( 'Original Time sunrise: $sunrise12Hour',);
  //   // Format the DateTime object to 24-hour format
  //   String sunset24Hour = DateFormat('HH:mm:ss').format(dateTimeSunset);
  //   print('Time in 24-hour format sunset: $sunset24Hour');
  //
  //   String sunrise24Hour = DateFormat('HH:mm:ss').format(dateTimeSunrise);
  //   print('Time in 24-hour format sunrise: $sunrise24Hour');
  //
  //   sunrise24HourTime.value = sunrise24Hour;
  //   sunset24HourTime.value = sunset24Hour;
  //   print('======== sunrise24HourTime======>${sunrise24HourTime.value}');
  //   print('======== sunset24HourTime======>${sunset24HourTime.value}');
  // }

  // void updateFutureSunriseSunsetTime(){
  //   String sunset12Hour = PrefServices.getString('futureSunset');
  //   String sunrise12Hour = PrefServices.getString('futureSunrise');
  //
  //   // Parse the time string to DateTime object
  //   var dateTimeSunset = DateFormat('h:mm:ss a').parse(sunset12Hour);
  //   print( 'Original Time sunset: $sunset12Hour',);
  //
  //   var dateTimeSunrise= DateFormat('h:mm:ss a').parse(sunrise12Hour);
  //   print( 'Original Time sunrise: $sunrise12Hour',);
  //   // Format the DateTime object to 24-hour format
  //   String sunset24Hour = DateFormat('HH:mm:ss').format(dateTimeSunset);
  //   print( 'Time in 24-hour format sunset: $sunset24Hour');
  //
  //   String sunrise24Hour = DateFormat('HH:mm:ss').format(dateTimeSunrise);
  //   print(  'Time in 24-hour format sunrise: $sunrise24Hour');
  //
  //   sunrise24HourTime.value = sunrise24Hour;
  //   sunset24HourTime.value = sunset24Hour;
  //   PrefServices.setValue('futureSunrise24Hours', sunrise24HourTime.value);
  //   PrefServices.setValue('futureSunset24Hours', sunset24HourTime.value);
  // }

  void toggleTimeFormat(bool value) {
    is24Hours.value = value;
    updateTime();
    updateSunriseSunsetTime();
    PrefServices.setValue('is24Hours', value); // Save time format preference
  }

}
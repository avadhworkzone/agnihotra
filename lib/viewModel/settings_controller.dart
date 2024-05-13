import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sunrise_app/common_Widget/common_fluttertoast.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/timezone.dart';

class SettingScreenController extends GetxController {

  SunriseSunsetController sunriseSunsetController = Get.put(SunriseSunsetController());
  RxBool isCountDown = false.obs;
  Rx<Duration> difference = Rx<Duration>(Duration.zero);
  RxBool is24Hours = false.obs;
  RxString current24HourTime = ''.obs;
  RxString sunrise24HourTime = ''.obs;
  RxString sunset24HourTime = ''.obs;
  RxString countDownValue = ''.obs;
  GlobalKey<FormState> remainderSunsetKey = GlobalKey<FormState>();
  String scheduledFormattedDate = '';

  RxBool on = false.obs;
  RxBool isScreenOn = false.obs;
  late AudioPlayer remainderAudio;
  TextEditingController remainderTimeController = TextEditingController();

  RxString formatted12HourSunsetTime =
      PrefServices.getString('formatted12HourSunsetTime').obs;
  String sunsetTime = '';

  Future<void> ringAlarm() async {
    await Alarm.init();
  }

  void toggle() => on.value = on.value ? false : true;

  RxBool on2 = false.obs;

  void toggle2() => on2.value = on2.value ? false : true;

  RxBool on4 = PrefServices.getBool('saveRemainderToggleValue').obs;

  void remainderToggle() {
    on4.value = !on4.value;
    PrefServices.setValue('saveRemainderToggleValue', on4.value);
    print(
        "PrefServices.getBool('saveRemainderToggleValue') :- ${PrefServices.getBool('saveRemainderToggleValue')}");
    on4.value = PrefServices.getBool('saveRemainderToggleValue');
    print("Toggle .on4.value :- ${on4.value}");
  }

  /// Medition Bell
  late AudioPlayer meditionBell;

  RxBool isBellRinging = PrefServices.getBool('isBellRinging').obs;

  @override
  void onInit() {
    super.onInit();
    updateTime();
    onCountDown();
    ringAlarm();

    is24Hours.value = PrefServices.getBool('is24Hours');
    isCountDown.value = PrefServices.getBool('isCountDown');
    remainderAudio = AudioPlayer();
    meditionBell = AudioPlayer();
  }

  Future<void> sunsetMeditionBellNotification(
      String remainderSunsetTime, bool isTommorow) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'BellId', // Channel ID
      'BellName', // Channel name
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('meditation_bell'),
      priority: Priority.high,
    );

    const iosNotificatonDetail = DarwinNotificationDetails(
      sound: 'meditation_bell.mp4',
    );

    NotificationDetails platformChannelSpecifics = const NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificatonDetail);

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
        15,
        // DateTime.now().millisecond, // Notification ID
        'Medition Bell',
        '',
        // Scheduled date and time
        sunsetBellDateTime(remainderSunsetTime, isTommorow),
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  tz.TZDateTime sunsetBellDateTime(String sunSetTime, bool isTommorow) {
    String sunsetBellTime = sunSetTime;

    print("sunsetTime Medition Bell :- $sunsetBellTime");

    DateTime convertedSunsetTime =
        parseTimeString(sunsetBellTime, is24Hour: false);
    print("24 Hour Date time convertedSunsetTime :- $convertedSunsetTime");
    print("is24HourFormat.value :- ${is24HourFormat.value}");

    String formatted24HourSunsetTime =
        DateFormat('HH:mm:ss').format(convertedSunsetTime);

    print("formatted24HourSunsetTime :- $formatted24HourSunsetTime");

    List<String> parts = formatted24HourSunsetTime.split(':');

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print("Now :- $now");

    int dayOffset = isTommorow ? 1 : 0;
    int targetDay = now.day + dayOffset;
    print("targetDay :- $targetDay");

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      targetDay,

      /// 24 - hour format
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );

    print("scheduledDate for Bell :- $scheduledDate");
    print("current time for Bell :- $now");

    print("Final scheduledDate for Bell :- $scheduledDate");
    return scheduledDate;
  }

  String convert12HourTo24HourCurrentTime(String timeString) {

    try {
      // Split the time string by space to separate time and period
      List<String> timeParts = timeString.split(' ');

      // Extract the time component (e.g., "5:43:24") and the period (e.g., "PM")
      String timeComponent = timeParts[0];
      String period = timeParts[1];

      // Split the time component by ":" to extract hour, minute, and second
      List<String> timeComponents = timeComponent.split(':');

      // Extract hour, minute, and second components
      int hour = int.parse(timeComponents[0]);
      int minute = int.parse(timeComponents[1]);
      int second = int.parse(timeComponents[2]);

      // Convert hour to 24-hour format
      if (period == 'PM' && hour != 12) {
        hour += 12; // Add 12 hours for PM times (except for 12 PM)
      } else if (period == 'AM' && hour == 12) {
        hour = 0; // Handle 12 AM (midnight) as 0 hour in 24-hour format
      }

      // Format the time in 24-hour format (HH:mm:ss)
      String formattedTime =
          '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}:${second.toString().padLeft(2, '0')}';

      return formattedTime; // Return the time in 24-hour format
    } catch (e) {
      print('Error converting time: $e');
      return ''; // Return null in case of error
    }
  }

  @override
  void onClose() {
    meditionBell.dispose();

    super.onClose();
  }

  int currentAndSunsetTimeDifference(){

    String sunsetTime = formatTime(
        PrefServices.getString('countrySunsetTimeZone'), is24HourFormat.value);

    DateTime convertedSunsetTime =
        parseTimeString(sunsetTime, is24Hour: is24HourFormat.value);
    DateTime convertedCurrentTime = parseTimeString(current24HourTime.value,
        is24Hour: is24HourFormat.value);

    print("convertedCurrentTime :- $convertedCurrentTime");
    print("convertedSunsetTime :- $convertedSunsetTime");

    Duration timeDifference =
        convertedSunsetTime.difference(convertedCurrentTime);

    print("timeDifference :- ${timeDifference.inMinutes}");

    return timeDifference.inMinutes;
  }

  int remainderAndSunsetTimeDifference() {
    String sunsetTime = formatTime(
        PrefServices.getString('countrySunsetTimeZone'), is24HourFormat.value);

    DateTime convertedSunsetTime =
        parseTimeString(sunsetTime, is24Hour: is24HourFormat.value);
    print("convertedSunsetTime :- $convertedSunsetTime");

    int substractMin = int.parse(remainderTimeController.text);
    print("remainder substractMin :- $substractMin");

    DateTime newTime = subtractMinutes(convertedSunsetTime, substractMin);

    print("===========> newTime :- $newTime");

    Duration remainderTimeDifference = convertedSunsetTime.difference(newTime);

    print("remainderTimeDifference :- ${remainderTimeDifference.inMinutes}");

    return remainderTimeDifference.inMinutes;
  }

  /// Flutter Local Notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// SCHEDULE REMAINDER NOTIFICATION

  Future<void> scheduleRemainderNotification(
      String remainderTime, bool isTommorow) async {
    print("<><><><><><><><><><><><><><><><><><><>$remainderTime");
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'id', // Channel ID
      'name', // Channel name
      importance: Importance.high,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('remainder_alarm'),
      priority: Priority.high,
      showWhen: false,
    );

    const iosNotificatonDetail = DarwinNotificationDetails(
      sound: 'remainder_alarm.mp4',
    );

    NotificationDetails platformChannelSpecifics = const NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iosNotificatonDetail);

    // Schedule the notification
    await flutterLocalNotificationsPlugin.zonedSchedule(
        5,
        // DateTime.now().millisecond, // Notification ID
        'Remainders',
        '',
        scheduledRemainderDateTime(remainderTime, isTommorow),
        // Scheduled date and time
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.dateAndTime);
  }

  tz.TZDateTime scheduledRemainderDateTime(String sunSetTime, bool isTommorow) {
    sunsetTime = sunSetTime;

    print("sunsetTime :- $sunsetTime");

    // Parse the time string into a DateTime object
    DateTime convertedSunsetTime = parseTimeString(sunsetTime, is24Hour: false);

    print("convertedSunsetTime :- $convertedSunsetTime");

    print("Save value of field Remainder:- ${PrefServices.getString(StringUtils.saveRemainderTextfieldKey)}");

    int substractMin = int.parse(PrefServices.getString(StringUtils.saveRemainderTextfieldKey));

    print("============substractMin :- $substractMin");

    PrefServices.setValue(StringUtils.subStractMinuteKey, substractMin);

    int saveSubstractValue = PrefServices.getInt(StringUtils.subStractMinuteKey);

    print("saveSubstractValue :- $saveSubstractValue");

    print("==================== substractMin :- $substractMin ======================");

    // Subtract  minutes from the DateTime object
    DateTime newTime = subtractMinutes(convertedSunsetTime, saveSubstractValue);

    // Format the new time as a string in 24-hour clock format
    String formatted24HourSunsetTime = DateFormat('HH:mm:ss').format(newTime);
    formatted12HourSunsetTime.value = DateFormat('hh:mm:ss a').format(newTime);

    print(
        "formatted12HourSunsetTime.value :- ${formatted12HourSunsetTime.value}");
    PrefServices.setValue(
        'formatted12HourSunsetTime', formatted12HourSunsetTime);

    List<String> parts = formatted24HourSunsetTime.split(':');


    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    print("Now :- $now");
    print("Day :- ${now.day + (isTommorow ? 1 : 0)}");
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day + (isTommorow ? 1 : 0),

      /// 24 - hour format
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );

    print("scheduledDate :- $scheduledDate");
    print("CURRENT TIME :- $now");

    print("check condition :- ${scheduledDate.isBefore(now)}");

    // if(scheduledDate.isBefore(now)){
    //   scheduledDate = scheduledDate.add(const Duration(days: 1));
    //     print("Added days scheduledDate :- $scheduledDate");
    // }


    // getFinalScheduledDateTime(scheduledDate);

    print("Final scheduledDate :- $scheduledDate");
    return scheduledDate;
  }


  String getFinalScheduledDateTime(TZDateTime scheduledDate){

    // Parse the datetime string to DateTime object
    DateTime dateTime = DateTime.parse(scheduledDate.toString());

    // Format the DateTime object to desired date format
    scheduledFormattedDate = DateFormat('dd-MM-yyyy').format(dateTime);




    // Display the formatted date
    print('Formatted Date: $scheduledFormattedDate');

    return scheduledFormattedDate;
  }

  Future<void> cancelAllNotification() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future<void> cancelSunsetMeditionBellNotification() async {
    await flutterLocalNotificationsPlugin.cancel(15);
  }

  DateTime subtractMinutes(DateTime dateTime, int minutes){
    return dateTime.subtract(Duration(minutes: minutes));
  }

  // Function to parse a time string into a DateTime object
  DateTime parseTimeString(String timeString, {required bool is24Hour}){
    print("is24Hour :- $is24Hour");

    if (is24Hour) {
      print("====== timeString =========> $timeString");
      DateTime parsedTime = DateFormat('HH:mm:ss').parse(timeString);
      print("====== parsedTime  =========> :- $parsedTime");

      return parsedTime;
    } else {
      print("====== timeString =========> $timeString");
      DateTime parsedTime = DateFormat('h:mm:ss a').parse(timeString);
      print("parsedTime :- $parsedTime");
      return parsedTime;
    }
  }

  DateTime parsedTime(String timeStr) {
    DateFormat formatter = DateFormat("hh:mm:ss a");

    if (timeStr.isEmpty) {
      return DateTime.now();
    }

    return formatter.parse(timeStr);
  }

  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes.remainder(60);
    int seconds = duration.inSeconds.remainder(60);

    return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  Future<String> onCountDown() async {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      DateTime now = DateTime.now();
      String sunriseTime =
          PrefServices.getString('countryTodaySunriseTimeZone');
      String sunsetTime = PrefServices.getString('countryTodaySunsetTimeZone');
      DateTime sunrise = parsedTime(sunriseTime);
      DateTime sunset = parsedTime(sunsetTime);

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
          await PrefServices.setValue(
              'timeUntilTime', formatDuration(difference.value));
        }
      } else {
        difference.value =
            sunriseTimeWithoutYear.difference(currentTimeWithoutYear);
        // print("Time until sunrise: ${formatDuration(difference.value)} hours.");
        await PrefServices.setValue(
            'timeUntilTime', formatDuration(difference.value));
      }

      countDownValue.value = PrefServices.getString('timeUntilTime');
      PrefServices.setValue('countDownValue', countDownValue.value);

      // Check if countdown has reached zero
      if (difference.value.inSeconds <= 0) {
        timer.cancel(); // Stop the timer
      }

      isCountDown.value = PrefServices.getBool('isCountDown');
    });

    return countDownValue.value;
  }

  void toggleCountDown(bool value) {
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
    print("24 hour Toggle Value :- ${is24HourFormat.value}");
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
    } else {
      return time;
    }
  }

  void validateSunsetInput(String input) {
    if (input.isEmpty) {
      return; // No input, do nothing
    }

    try {
      int value = int.parse(input);

      if (value < 2 || value > 120) {
        PrefServices.setValue('saveRemainderToggleValue', false);

        on4.value = PrefServices.getBool('saveRemainderToggleValue');

        commonFlutterToastMsg(
            'Invalid value! Please enter a number between 2 and 120.');
      }
    } catch (e) {
      PrefServices.setValue('saveToggleValue', false);
      on4.value = PrefServices.getBool('saveToggleValue');
      commonFlutterToastMsg('Invalid value! Please enter a valid number.');
    }
  }

  void validateSunriseInput(String input) {
    if (input.isEmpty) {
      return; // No input, do nothing
    }

    try {
      int value = int.parse(input);

      if (value < 2 || value > 120) {
        PrefServices.setValue('saveToggleValue', false);
        // Invalid value range

        commonFlutterToastMsg(
            'Invalid value! Please enter a number between 2 and 120.');
      }
    } catch (e) {
      PrefServices.setValue('saveToggleValue', false);
      commonFlutterToastMsg('Invalid value! Please enter a valid number.');
    }
  }

  Future<void> meditionBellNotificationLogic() async {

    if (PrefServices.getBool('isBellRinging') &&
        PrefServices.getString('currentAddress').isNotEmpty) {

      /// Tommorow time API call
      await sunriseSunsetController.countryTommorowTimeZone(
          PrefServices.getDouble('currentLat'),
          PrefServices.getDouble('currentLong'),
          DateFormat("yyyy-MM-dd")
              .format(DateTime.now().add(const Duration(days: 1))),
          PrefServices.getString('countryName'));

      /// tommorow Sunset Time
      String tommorowSunset =
          sunriseSunsetController.countryTomorrowSunsetTimeZone.value;

      String tommorowDate = DateFormat("yyyy-MM-dd")
          .format(DateTime.now().add(const Duration(days: 1)));

      List<String> tomorrowSplitDate = tommorowDate.split('-');

      DateFormat twelveHourFormat = DateFormat('h:mm:ss a');
      DateFormat twentyFourHourFormat = DateFormat('HH:mm:ss');

      DateTime twelveHourTommorowSunsetTime =
          twelveHourFormat.parse(tommorowSunset);

      String twentyFourHourTommorowSunsetTime =
          twentyFourHourFormat.format(twelveHourTommorowSunsetTime);

      List<String> tomorrowSplitTime =
          twentyFourHourTommorowSunsetTime.split(':');

      DateTime now = DateTime.now();
      DateTime tommorowSunsetTime = DateTime(
        int.parse(tomorrowSplitDate[0]),
        int.parse(tomorrowSplitDate[1]),
        int.parse(tomorrowSplitDate[2]),
        int.parse(tomorrowSplitTime[0]),
        int.parse(tomorrowSplitTime[1]),
        int.parse(tomorrowSplitTime[2]),
      );

      /// today Sunset Time
      String todaySunset =
          sunriseSunsetController.countryTodaySunsetTimeZone.value;

      print("todaySunset :- $todaySunset");

      DateTime twelveHourTodaySunsetTime = twelveHourFormat.parse(todaySunset);

      String twentyFourHourTodaySunsetTime =
          twentyFourHourFormat.format(twelveHourTodaySunsetTime);

      List<String> splitTodayTime = twentyFourHourTodaySunsetTime.split(':');

      DateTime todaySunsetTime = DateTime(
        now.year,
        now.month,
        now.day,
        // 10,47,00,
        int.parse(splitTodayTime[0]),
        int.parse(splitTodayTime[1]),
        int.parse(splitTodayTime[2]),
      );

      /// today Sunrise Time
      String todaySunrise =
          sunriseSunsetController.countryTodaySunriseTimeZone.value;

      print("todaySunrise :- $todaySunrise");

      DateTime twelveHourTodaySunriseTime =
          twelveHourFormat.parse(todaySunrise);

      String twentyFourHourTodaySunriseTime =
          twentyFourHourFormat.format(twelveHourTodaySunriseTime);

      List<String> splitTodaySunriseTime =
          twentyFourHourTodaySunriseTime.split(':');

      DateTime todaySunriseTime = DateTime(
        now.year,
        now.month,
        now.day,
        // 10,40,00
        int.parse(splitTodaySunriseTime[0]),
        int.parse(splitTodaySunriseTime[1]),
        int.parse(splitTodaySunriseTime[2]),
      );

      /// tommorow Sunrise Time
      String tommorowSunrise = sunriseSunsetController.countryTommorowSunriseTimeZone.value;

      print("tommorowSunrise :- $tommorowSunrise");

      DateTime twelveHourTommorowSunriseTime =
          twelveHourFormat.parse(tommorowSunrise);

      String twentyFourHourTommorowSunriseTime =
          twentyFourHourFormat.format(twelveHourTommorowSunriseTime);

      List<String> splitTommorowSunriseTime =
          twentyFourHourTommorowSunriseTime.split(':');

      DateTime tommorowSunriseTime = DateTime(
        now.year,
        now.month,
        now.day + 1,
        // 09,56,00
        int.parse(splitTommorowSunriseTime[0]),
        int.parse(splitTommorowSunriseTime[1]),
        int.parse(splitTommorowSunriseTime[2]),
      );

      print("tommorowSunriseTime Bell :- $tommorowSunriseTime");
      print("todaySunriseTime Bell :- $todaySunriseTime");

      print("tommorowSunsetTime ===============:- $tommorowSunsetTime");

      print("todaySunsetTime ===============:- $todaySunsetTime");

      print("current time :- $now");

      if (todaySunriseTime.isBefore(todaySunsetTime) && todaySunriseTime.isAfter(now)) {
        print(
            "Today Sunrise Time====================== ${sunriseSunsetController.countryTodaySunriseTimeZone.value}");

        sunsetMeditionBellNotification(
            // '10:40:00 AM',
            sunriseSunsetController.countryTodaySunriseTimeZone.value,
            false);

      }

      else if (todaySunsetTime.isAfter(todaySunriseTime) &&
          todaySunsetTime.isAfter(now)) {

        print(
            "Today Sunset Time====================== ${sunriseSunsetController.countryTodaySunsetTimeZone.value}");

        sunsetMeditionBellNotification(
         // '10:47:00 AM',
          sunriseSunsetController.countryTodaySunsetTimeZone.value,
            false);
      }

      else if (tommorowSunriseTime.isAfter(todaySunsetTime) &&
          tommorowSunriseTime.isAfter(now)) {
        print(
            "Tommorow Sunrise Time====================== ${sunriseSunsetController.countryTommorowSunriseTimeZone.value}");

        ///FOR TOMORROW Sunrise Time

        sunsetMeditionBellNotification(
            sunriseSunsetController.countryTommorowSunriseTimeZone.value, true);
      }
      else {
        print(
            "Tommorow Sunset Time====================== ${sunriseSunsetController.countryTomorrowSunsetTimeZone.value}");

        ///FOR TOMORROW Sunset Time

        sunsetMeditionBellNotification(
            sunriseSunsetController.countryTomorrowSunsetTimeZone.value, true);
      }
    } else {
      cancelSunsetMeditionBellNotification();
    }
  }


  Future<void> remainderNotificationLogic() async {

    if (PrefServices.getBool('saveRemainderToggleValue') &&
        PrefServices.getString('currentAddress').isNotEmpty) {
      /// Today Sunset Time
      String todaySunset =
          sunriseSunsetController.countryTodaySunsetTimeZone.value;

      print("todaySunset :- $todaySunset");

      DateFormat twelveHourFormat = DateFormat('h:mm:ss a');
      DateFormat twentyFourHourFormat = DateFormat('HH:mm:ss');

      DateTime twelveHourTodaySunsetTime = twelveHourFormat.parse(todaySunset);
      print("twelveHourTodaySunsetTime :- $twelveHourTodaySunsetTime");

      String twentyFourHourTodaySunsetTime =
          twentyFourHourFormat.format(twelveHourTodaySunsetTime);

      List<String> splitTodayTime = twentyFourHourTodaySunsetTime.split(':');
      print("splitTodayTime :- $splitTodayTime");

      DateTime now = DateTime.now();

      DateTime todaySunsetTime = DateTime(
        now.year,
        now.month,
        now.day,
        // 08,15,00,
        int.parse(splitTodayTime[0]),
        int.parse(splitTodayTime[1]),
        int.parse(splitTodayTime[2]),
      );

      /// Tommorow Sunset Time
      String tommorowSunset =
          sunriseSunsetController.countryTomorrowSunsetTimeZone.value;

      print("tommorowSunset :- $tommorowSunset");

      DateTime twelveHourTommorowSunsetTime =
          twelveHourFormat.parse(tommorowSunset);
      print("twelveHourTommorowSunsetTime :- $twelveHourTommorowSunsetTime");

      String twentyFourHourTommorowSunsetTime =
          twentyFourHourFormat.format(twelveHourTommorowSunsetTime);

      List<String> splitTommorowTime =
          twentyFourHourTommorowSunsetTime.split(':');
      print("splitTommorowTime :- $splitTommorowTime");

      DateTime tommorowSunsetTime = DateTime(
        now.year,
        now.month,
        now.day + 1,
        // 09,45,00,
        int.parse(splitTommorowTime[0]),
        int.parse(splitTommorowTime[1]),
        int.parse(splitTommorowTime[2]),
      );

      /// Today Sunrise Time
      String todaySunrise =
          sunriseSunsetController.countryTodaySunriseTimeZone.value;

      print("todaySunrise :- $todaySunrise");

      DateTime twelveHourTodaySunriseTime =
          twelveHourFormat.parse(todaySunrise);
      print("twelveHourTodaySunriseTime :- $twelveHourTodaySunriseTime");

      String twentyFourHourTodaySunriseTime =
          twentyFourHourFormat.format(twelveHourTodaySunriseTime);

      List<String> splitTodaySunriseTime =
          twentyFourHourTodaySunriseTime.split(':');
      print("splitTodaySunriseTime :- $splitTodaySunriseTime");

      DateTime todaySunriseTime = DateTime(
        now.year,
        now.month,
        now.day,
        // 07,45,00,
        int.parse(splitTodaySunriseTime[0]),
        int.parse(splitTodaySunriseTime[1]),
        int.parse(splitTodaySunriseTime[2]),
      );

      /// Tommorow Sunrise Time

      String tommorowSunrise =
          sunriseSunsetController.countryTommorowSunriseTimeZone.value;

      print("tommorowSunrise :- $tommorowSunrise");

      DateTime twelveHourTommorowSunriseTime =
          twelveHourFormat.parse(tommorowSunrise);
      print("twelveHourTommorowSunriseTime :- $twelveHourTommorowSunriseTime");

      String twentyFourHourTommorowSunriseTime =
          twentyFourHourFormat.format(twelveHourTommorowSunriseTime);

      List<String> splitTommorowSunriseTime =
          twentyFourHourTommorowSunriseTime.split(':');
      print("splitTommorowSunriseTime :- $splitTommorowSunriseTime");

      DateTime tommorowSunriseTime = DateTime(
        now.year,
        now.month,
        now.day + 1,
        // 07,35,00,
        int.parse(splitTommorowSunriseTime[0]),
        int.parse(splitTommorowSunriseTime[1]),
        int.parse(splitTommorowSunriseTime[2]),
      );

      print("todaySunsetTime :- $todaySunsetTime");
      print("tommorowSunsetTime :- $tommorowSunsetTime");
      print("todaySunriseTime :- $todaySunriseTime");
      print("tommorowSunriseTime :- $tommorowSunriseTime");

      if(todaySunriseTime.isBefore(todaySunsetTime) && todaySunriseTime.isAfter(now)){

        print("Today Sunrise Time ============>:- ${sunriseSunsetController.countryTodaySunriseTimeZone.value}");

        scheduleRemainderNotification(
                // '07:45:00 AM',
                sunriseSunsetController.countryTodaySunriseTimeZone.value,
                false)
            .then((value) => Get.back());
      }
      else if (todaySunsetTime.isAfter(todaySunriseTime) &&
          todaySunsetTime.isAfter(now)) {

        print("Today SunSet Time ==========>:- ${sunriseSunsetController.countryTodaySunsetTimeZone.value}");

        scheduleRemainderNotification(
                // '08:15:00 AM',
                sunriseSunsetController.countryTodaySunsetTimeZone.value,
                false)
            .then((value) => Get.back());
      }
      else if (tommorowSunriseTime.isAfter(todaySunsetTime) &&
          tommorowSunriseTime.isAfter(now)){

        print(
            "Tommorow Sunrise Time====================== ${sunriseSunsetController.countryTommorowSunriseTimeZone.value}");

        scheduleRemainderNotification(
                sunriseSunsetController.countryTommorowSunriseTimeZone.value,
                true)
            .then((value) => Get.back());
      }
      else {

        print("Tommorow Sunset Time :- ${sunriseSunsetController.countryTomorrowSunsetTimeZone.value}");

        scheduleRemainderNotification(
                sunriseSunsetController.countryTomorrowSunsetTimeZone.value,
                true)
            .then((value) => Get.back());

      }

      Get.back();
    }
    else {
      cancelAllNotification();
    }
  }

}

import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:timezone/timezone.dart' as tz;

class SettingScreenController extends GetxController {

  RxBool on = false.obs;
  RxBool isScreenOn = false.obs;
  late AudioPlayer remainderAudio;
  TextEditingController remainderTimeController = TextEditingController();
  RxString formatted12HourSunsetTime = PrefServices.getString('formatted12HourSunsetTime').obs;

  Future<void> ringAlarm() async {
    await Alarm.init();
  }

  void toggle() => on.value = on.value ? false : true;

  RxBool on2 = false.obs;

  void toggle2() => on2.value = on2.value ? false : true;

  RxBool on4 = PrefServices.getBool('saveToggleValue').obs;

  void toggle4() {
    on4.value = !on4.value;
    PrefServices.setValue('saveToggleValue', on4.value);
    print("PrefServices.getBool('saveToggleValue') :- ${PrefServices.getBool('saveToggleValue')}");
    on4.value = PrefServices.getBool('saveToggleValue');
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

  void toggleBellFormat() {
    if (PrefServices.getString('currentAddress').isNotEmpty) {
      startBellForSunrise();
      startBellForSunset();
    }
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
      return 'Om'; // Return null in case of error
    }
  }

  Future<void> startBellForSunrise() async {
    String sunriseTime = formatTime(PrefServices.getString('countrySunriseTimeZone'), is24HourFormat.value);


    DateTime currentTime = DateTime.now();

    DateFormat formatter = DateFormat('h:mm:ss a');

    String formattedCurrentTime = formatter.format(currentTime);
    // print("===== formattedCurrentTime :- $formattedCurrentTime");

    if (is24HourFormat.value) {
      DateFormat formatter = DateFormat('hh:mm:ss a');
      String formatted12HourCurrentTime = formatter.format(currentTime);
      String currentHour24Time =
          convert12HourTo24HourCurrentTime(formatted12HourCurrentTime);

      if (sunriseTime == currentHour24Time) {
        meditionBell.setAsset(AssetUtils.meditionBellAudio);
        meditionBell.play();
      }
    } else if (sunriseTime == formattedCurrentTime) {
      meditionBell.setAsset(AssetUtils.meditionBellAudio);
      meditionBell.play();
    }
  }

  void startBellForSunset(){

    String sunsetTime = formatTime(PrefServices.getString('countrySunsetTimeZone'), is24HourFormat.value);

    DateTime currentTime = DateTime.now();

    DateFormat formatter = DateFormat('h:mm:ss a');

    String formattedCurrentTime = formatter.format(currentTime);

    if (is24HourFormat.value) {
      DateFormat formatter = DateFormat('hh:mm:ss a');
      String formatted12HourCurrentTime = formatter.format(currentTime);
      String currentHour24Time =
          convert12HourTo24HourCurrentTime(formatted12HourCurrentTime);

      if (sunsetTime == currentHour24Time){
        meditionBell.setAsset(AssetUtils.meditionBellAudio);
        meditionBell.play();
      }
    } else if (sunsetTime == formattedCurrentTime) {
      meditionBell.setAsset(AssetUtils.meditionBellAudio);
      meditionBell.play();
    }
  }

  @override
  void onClose() {
    meditionBell.dispose();

    super.onClose();
  }


  /// Flutter Local Notification
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// scheduleDaily Notification

  Future<void> scheduleDailyNotification() async {

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
        0, // Notification ID
        'Remainders',
        '',
        _nextInstanceOfTenAM(), // Scheduled date and time
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);

  }

  Future<void> cancelNotification() async {
    await flutterLocalNotificationsPlugin.cancel(0);
  }



  tz.TZDateTime _nextInstanceOfTenAM(){

    String sunsetTime = formatTime(PrefServices.getString('countrySunsetTimeZone'), is24HourFormat.value);
    // String sunsetTime = "5:40:00 PM";
    print("sunsetTime :- $sunsetTime");

    // Parse the time string into a DateTime object
    DateTime convertedSunsetTime = parseTimeString(sunsetTime);
    print("convertedSunsetTime :- $convertedSunsetTime");

    int substractMin = int.parse(remainderTimeController.text.toString());
    print("substractMin :- $substractMin");

    // Subtract 14 minutes from the DateTime object
    DateTime newTime = subtractMinutes(convertedSunsetTime,substractMin);

    print("==================>New Time :- $newTime");


    // Format the new time as a string in 24-hour clock format
    String formatted24HourSunsetTime = DateFormat('HH:mm:ss').format(newTime);
    formatted12HourSunsetTime.value = DateFormat('hh:mm:ss a').format(newTime);
    print("formatted12HourSunsetTime :- $formatted12HourSunsetTime");
    PrefServices.setValue('formatted12HourSunsetTime',formatted12HourSunsetTime);

    print("formattedNewTime :- $formatted24HourSunsetTime");
    print("Original Sunset Time :- $sunsetTime");

    List<String> parts = formatted24HourSunsetTime.split(':');

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
/// 24 - hour format
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
   );

    // if (scheduledDate.isAfter(now)){
    //   scheduledDate = scheduledDate.add(const Duration(days: 1));
    // }

    print("scheduledDate :- $scheduledDate");
    return scheduledDate;
  }

  DateTime subtractMinutes(DateTime dateTime, int minutes){
    return dateTime.subtract(Duration(minutes: minutes));
  }


  RxBool isCountDown = false.obs;
  Rx<Duration> difference = Rx<Duration>(Duration.zero);
  RxBool is24Hours = false.obs;
  RxString current24HourTime = ''.obs;
  RxString sunrise24HourTime = ''.obs;
  RxString sunset24HourTime = ''.obs;
  RxString countDownValue = ''.obs;

  // Function to parse a time string into a DateTime object
  DateTime parseTimeString(String timeString) {
    // Create a DateFormat object with the expected time format
    DateFormat format = DateFormat('h:mm:ss a');

    // Parse the time string into a DateTime object
    return format.parse(timeString);
  }

  DateTime parsedTime(String timeStr){
    DateFormat formatter = DateFormat("hh:mm:ss a");

    if (timeStr.isEmpty){
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
      String sunriseTime = PrefServices.getString('countrySunriseTimeZone');
      String sunsetTime = PrefServices.getString('countrySunsetTimeZone');
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
}

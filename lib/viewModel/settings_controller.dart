import 'dart:async';
import 'package:alarm/alarm.dart';
import 'package:alarm/model/alarm_settings.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:timezone/timezone.dart' as tz;

class SettingScreenController extends GetxController {


  RxBool on = false.obs;
  RxBool isScreenOn = false.obs;
  late AudioPlayer remainderAudio;

  @override
  void onInit() {
    super.onInit();
    updateTime();
    onCountDown();
    ringAlarm();

    is24Hours.value = PrefServices.getBool('is24Hours');
    isCountDown.value = PrefServices.getBool('isCountDown');
    remainderAudio = AudioPlayer();
  }

  Future<void> ringAlarm() async {
    await Alarm.init();
  }


  void toggle() => on.value = on.value ? false : true;

  RxBool on2 = false.obs;

  void toggle2() => on2.value = on2.value ? false : true;

  RxBool on4 = PrefServices
      .getBool('saveToggleValue')
      .obs;

  void toggle4() {
    on4.value = !on4.value;
    PrefServices.setValue('saveToggleValue', on4.value);
    print("PrefServices.getBool('saveToggleValue') :- ${PrefServices.getBool(
        'saveToggleValue')}");
    on4.value = PrefServices.getBool('saveToggleValue');
    print("Toggle .on4.value :- ${on4.value}");
  }

  Future<void> remainderAlarm() async {
    String selectedTime = PrefServices.getString('selectedAlarmTime');
    print("Selected Time: $selectedTime");

    // Parse the selected time string (e.g., '1:00 AM')
    DateTime selectedDateTime = DateFormat.jm().parse(selectedTime);

    // Get the current date and time
    DateTime now = DateTime.now();


    DateTime alarmDateTime = DateTime(
      now.year,
      now.month,
      now.day,
      selectedDateTime.hour,
      selectedDateTime.minute,
    );

    // Check if the alarm time has already passed today
    if (alarmDateTime.isBefore(now)) {
      // If the alarm time has passed, schedule it for the next day
      alarmDateTime = alarmDateTime.add(const Duration(days: 1));
    }

    print("Scheduled Alarm DateTime: $alarmDateTime");

    // Define the alarm settings
    final alarmSettings = AlarmSettings(
      id: 42,
      dateTime: alarmDateTime,
      assetAudioPath: AssetUtils.remainderAlarmAudio,
      loopAudio: false,
      vibrate: false,
      volume: 0.2,
      fadeDuration: 3.0,
      notificationTitle: 'Reminders',
      notificationBody: '',
      enableNotificationOnKill: true,
    );

    // Set the alarm using the defined settings
    await Alarm.set(alarmSettings: alarmSettings);
  }


  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// show a simple notification
  //  Future showSimpleNotification({
  //   required String title,
  //   required String body,
  //   required String payload,
  // }) async {
  //   const AndroidNotificationDetails androidNotificationDetails =
  //   AndroidNotificationDetails('your channel id', 'your channel name',
  //       channelDescription: 'your channel description',
  //       importance: Importance.max,
  //       priority: Priority.high,
  //       ticker: 'ticker');
  //
  //   const NotificationDetails notificationDetails =
  //   NotificationDetails(android: androidNotificationDetails);
  //   await flutterLocalNotificationsPlugin
  //       .show(0, title, body, notificationDetails, payload: payload);
  // }

  /// Zone Schedule




  Future<void> scheduleDailyTenAMNotification() async {

    await flutterLocalNotificationsPlugin.zonedSchedule(
        0,
        'daily scheduled notification title',
        'daily scheduled notification body',

        _nextInstanceOfTenAM(),
        const NotificationDetails(
          android: AndroidNotificationDetails('daily notification channel id',
              'daily notification channel name',
              channelDescription: 'daily notification description'),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time);
  }

  // PrefServices.getString('selectedAlarmTime')
  tz.TZDateTime _nextInstanceOfTenAM(){

    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);
    tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      18,
      03,
    );

    print("scheduledDate :- $scheduledDate");

    if(scheduledDate.isBefore(now)){
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;

  }

  RxBool isCountDown = false.obs;
  Rx<Duration> difference = Rx<Duration>(Duration.zero);
  RxBool is24Hours = false.obs;
  RxString current24HourTime = ''.obs;
  RxString sunrise24HourTime = ''.obs;
  RxString sunset24HourTime = ''.obs;
  RxString countDownValue = ''.obs;


  DateTime parseTime(String timeStr){

  DateFormat formatter = DateFormat("hh:mm:ss a");

  if (timeStr.isEmpty){
  return DateTime.now();
  }

  return formatter.parse(timeStr);
  }

  String formatDuration(Duration duration){

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

  void updateTime(){
  String formattedTime = DateFormat(is24Hours.value ? 'HH:mm:ss' : 'h:mm:ss a').format(DateTime.now());
  current24HourTime.value = formattedTime;
  }

  void toggleTimeFormat(bool value) {
  is24Hours.value = value;
  is24HourFormat.value = !is24HourFormat.value;
  updateTime();
  PrefServices.setValue('is24Hours', value);
  }

  RxBool is24HourFormat = false.obs;

  String formatTime(String time, bool is24Hour){
  bool is24Hour = PrefServices.getBool('is24Hours');

  if (is24Hour){
  DateTime parsedTime = DateFormat('hh:mm:ss a').parse(time);
  String formattedTime = DateFormat('kk:mm:ss').format(parsedTime);
  return formattedTime;
  }

  else {
  return time;
  }

  }
}
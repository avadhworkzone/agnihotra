import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/localization/translations.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:sunrise_app/services/local_notification.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/view/splashScreen/splash_screen.dart';
import 'package:sunrise_app/viewModel/agnihotra_mantra_controller.dart';
import 'package:sunrise_app/viewModel/enter_manually_location_controller.dart';
import 'package:sunrise_app/viewModel/forgot_password_controller.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';
import 'package:sunrise_app/viewModel/help_controller.dart';
import 'package:sunrise_app/viewModel/login_controller.dart';
import 'package:sunrise_app/viewModel/profile_controller.dart';
import 'package:sunrise_app/viewModel/settings_controller.dart';
import 'package:sunrise_app/viewModel/sign_up_controller.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();
    await initializeService();
  await LocalNotification.init();
  await PrefServices.init();
  runApp(MyApp());
}


Future<void> initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      isForegroundMode: true,
      // notificationChannelId: 'my_foreground',
      // initialNotificationContent: 'running',
      foregroundServiceNotificationId: 888,
    ),
    iosConfiguration: IosConfiguration(
      autoStart: true,
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
}


@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });
    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  // // bring to foreground
  Timer.periodic(const Duration(seconds: 1), (timer) async {
    if (service is AndroidServiceInstance) {
      if (await service.isForegroundService()) {
        flutterLocalNotificationsPlugin.show(
          0, 'This is foreground', '${DateTime.now()}',
          const NotificationDetails(
            android: AndroidNotificationDetails(
              "notificationChannelId",
              'MY FOREGROUND SERVICE',
              icon: 'ic_bg_service_small',
              ongoing: true,
            ),
          ),
        );
      }
    }
  });
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
}

class MyApp extends StatelessWidget {
  MyApp({super.key});


  @override
  Widget build(BuildContext context) {

    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        translations: Translation(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale: Locale(PrefServices.getString('language').isEmpty
            ? "en_US"
            : PrefServices.getString('language')),
        fallbackLocale: const Locale('en_US'),
        home : const SplashScreen(),
         // home: const ProfileScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }

  SettingScreenController settingScreenController = Get.put(SettingScreenController());
  SunriseSunsetController sunriseSunsetController = Get.put(SunriseSunsetController());
  GoogleController googleController = Get.put(GoogleController());
  EnterManuallyLocationController enterManuallyLocationController = Get.put(EnterManuallyLocationController());
  AgnihotraMantraController agnihotraMantraController = Get.put(AgnihotraMantraController());
  HelpScreenController helpScreenController = Get.put(HelpScreenController());
  LoginController loginController = Get.put(LoginController());
  SignUpController signUpController = Get.put(SignUpController());
  ForgotPasswordController forgotPasswordController = Get.put(ForgotPasswordController());
  ProfileController profileController = Get.put(ProfileController());

}
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/localization/translations.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/view/login_screen/login_screen.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/view/welcome_screen/welcome_screen.dart';
import 'package:sunrise_app/viewModel/agnihotra_mantra_controller.dart';
import 'package:sunrise_app/viewModel/enter_manually_location_controller.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';
import 'package:sunrise_app/viewModel/help_controller.dart';
import 'package:sunrise_app/viewModel/settings_controller.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'view/splashScreen/splash_screen.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();

  await PrefServices.init();
  runApp(MyApp());
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String? timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName!));
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
        home:PrefServices.getString('language').isEmpty ? const WelcomeScreen() : const SplashScreen(),
     //   home: MeditationScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
  SettingScreenController settingScreenController = Get.put(SettingScreenController());

  SunriseSunsetController sunriseSunsetController =
      Get.put(SunriseSunsetController());
  SettingScreenController settingScreenController =
      Get.put(SettingScreenController());
  GoogleController googleController = Get.put(GoogleController());
  LocationController locationController = Get.put(LocationController());
  AgnihotraMantraController agnihotraMantraController = Get.put(AgnihotraMantraController());
  HelpScreenController helpScreenController = Get.put(HelpScreenController());

}


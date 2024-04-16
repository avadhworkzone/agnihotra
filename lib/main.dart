import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/localization/translations.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/view/welcome_screen/welcome_screen.dart';
import 'package:sunrise_app/viewModel/enter_location_controller.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';
import 'package:sunrise_app/viewModel/settings_controller.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PrefServices.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key) {

  }

  @override
  Widget build(BuildContext context) {
   print('language========>${PrefServices.getString('language')}');
   log('languageSelect========>${PrefServices.getString('language')}');
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      child: GetMaterialApp(
        translations: Translation(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        locale:  Locale(PrefServices.getString('language').isEmpty?"en_US":PrefServices.getString('language')),
        fallbackLocale: const Locale('en_US'),
        home:PrefServices.getString('language').isEmpty ? WelcomeScreen():SunriseSunetScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
  SunriseSunsetController sunriseSunsetController = Get.put(SunriseSunsetController());
  GoogleController googleController = Get.put(GoogleController());
  LocationController locationController = Get.put(LocationController());
  SettingScreenController settingScreenController = Get.put(SettingScreenController());
}


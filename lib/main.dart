import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/localization/translations.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:sunrise_app/services/local_notification.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/view/auth/forgot_password_screen.dart';
import 'package:sunrise_app/view/auth/login_screen.dart';
import 'package:sunrise_app/view/auth/profile/edit_profile_screen.dart';
import 'package:sunrise_app/view/auth/reset_password_screen.dart';
import 'package:sunrise_app/view/auth/sign_up_screen.dart';
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

import 'view/auth/profile/profile_screen.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();
  await LocalNotification.init();
  await PrefServices.init();
  runApp(MyApp());
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
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
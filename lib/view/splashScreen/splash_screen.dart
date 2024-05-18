import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:sunrise_app/animation/slide_transition_animation.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/view/welcome_screen/welcome_screen.dart';
import 'package:sunrise_app/viewModel/enter_manually_location_controller.dart';
import 'package:sunrise_app/viewModel/settings_controller.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';

import '../../utils/string_utils.dart';

class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  EnterManuallyLocationController locationController = Get.find<EnterManuallyLocationController>();
  SettingScreenController settingScreenController =   Get.find<SettingScreenController>();
  SunriseSunsetController sunriseSunsetController = Get.find<SunriseSunsetController>();

  @override
  void initState(){

    super.initState();

    print("sunriseSunsetController.formattedDate========> :- ${sunriseSunsetController.formattedDate}");


    remainderAndBellNotification();
    _loadPreferences().then((value){

      Future.delayed(const Duration(milliseconds: 5500))
          .then((value) => SlideTransitionAnimation.rightToLeftAnimationOff(PrefServices.getString('language').isEmpty ? const WelcomeScreen() :  SunriseSunetScreen()));
    });


    settingScreenController.isScreenOn.value = PrefServices.getBool('keepScreenOn');
    print("settingScreenController.isScreenOn.value :- ${settingScreenController.isScreenOn.value}");
    if(settingScreenController.isScreenOn.value){
      KeepScreenOn.turnOn();
    }
    locationController.getCurrentLocation();
  }

  Future<void> remainderAndBellNotification() async {

    await sunriseSunsetController.countryTodayTimeZone(
        PrefServices.getDouble('currentLat'),
        PrefServices.getDouble('currentLong'),
        sunriseSunsetController.formattedDate,
        PrefServices.getString('countryName'));

    await sunriseSunsetController.countryTommorowTimeZone(
        PrefServices.getDouble('currentLat'),
        PrefServices.getDouble('currentLong'),
        DateFormat("yyyy-MM-dd").format(
            DateTime.now().add(const Duration(days: 1))),
        PrefServices.getString('countryName'));





      settingScreenController.remainderNotificationLogic();
      settingScreenController.meditionBellNotificationLogic();

  }

  int _currentIndex = 0;

  List imageUrl = [
    (AssetUtils.splashImage1),
    (AssetUtils.splashImage2),


  ];



  Future<void> _loadPreferences() async {
    _currentIndex = PrefServices.getInt('currentIndex');


    _currentIndex = (_currentIndex + 1);

    _savePreferences(_currentIndex);
    setState(() {});
  }

  Future<void> _savePreferences(int index) async {
    await PrefServices.setValue('currentIndex', index);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.amberAccent,
      body: Center(
        child: LocalAssets(
          imagePath: imageUrl[_currentIndex % imageUrl.length],

          fit: BoxFit.cover,
          height: Get.height,
          width: Get.width,


        ),
      ),
    );
  }
}
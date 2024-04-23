import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _loadPreferences().then((value){

      Future.delayed(const Duration(seconds: 3))
          .then((value) => Get.to(SunriseSunetScreen()));
    });

  }


  int _currentIndex = 0;

  List imageUrl = [
    "assets/images/splashImage1.svg",
    "assets/images/splashImage2.svg",
    // "assets/images/splashImages3.jpg",
    // "assets/images/splashImages4.jpg",
    //
    // "assets/images/splashImages5.jpg",
    // "assets/images/splashImages6.jpg",
    // "assets/images/splashImages7.jpg",
    // "assets/images/splashImages8.jpg",
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
      body: Center(
        child: LocalAssets(
          imagePath: imageUrl[_currentIndex % imageUrl.length],
          fit: BoxFit.cover,
          height: Get.height / 2,
        ),
      ),
    );
  }
}

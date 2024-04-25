import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/viewModel/enter_location_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  LocationController locationController = Get.find<LocationController>();

  @override
  void initState() {
    super.initState();
    _loadPreferences().then((value) {
      locationController.getCurrentLocation();

      Future.delayed(const Duration(seconds: 3))
          .then((value) => Get.to(SunriseSunetScreen()));
    });
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
      body: Center(
        child: LocalAssets(
          imagePath: imageUrl[_currentIndex % imageUrl.length],
          fit: BoxFit.fill,
          height: Get.height,
          width: Get.width,
        ),
      ),
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sunrise_app/common_Widget/common_assets.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/common_Widget/common_textfield.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/enter_location_screen/enter_location_screen.dart';
import 'package:sunrise_app/view/google_map_screen/integrate_google_map.dart';
import 'package:sunrise_app/view/mantra_menu_screen/mantra_menu_screen.dart';
import 'package:sunrise_app/view/setting_screen/setting_screen.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';
import 'package:sunrise_app/viewModel/settings_controller.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';

class SunriseSunetScreen extends StatefulWidget {
  double? latitude;
  double? longitude;
  String? address;
  bool? value;

  SunriseSunetScreen(
      {Key? key, this.latitude, this.longitude, this.address, this.value})
      : super(key: key) {}

  @override
  State<SunriseSunetScreen> createState() => _SunriseSunetScreenState();
}

class _SunriseSunetScreenState extends State<SunriseSunetScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  SunriseSunsetController sunriseSunsetController =
      Get.find<SunriseSunsetController>();
  GoogleController googleController = Get.find<GoogleController>();
  SettingScreenController settingScreenController = Get.find<
      SettingScreenController>();

  String formatAddress(){
    if (address == null || (latitude == 0 && longitude == 0)) {
      return StringUtils.locationSetTxt;
    }
    List<String> addressParts = address!.split(',').map((part) => part.trim()).toList();
    addressParts.removeWhere((part) => part.isEmpty);

    return addressParts.join(', ');
  }

  String formateLatitudeLongitude(double value) {
    String formattedValue = value.toStringAsFixed(4);
    return formattedValue;
  }

  @override
  void initState(){

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){

      PrefServices.getString('saveAddress');
    sunriseSunsetController.getSunriseSunsetTime(
          PrefServices.getDouble('saveLat'),
          PrefServices.getDouble('saveLong'));

      print("selectedDate :- ${sunriseSunsetController.selectedDate}");



      sunriseSunsetController.selectedDate.value = DateTime.now();
      Timer.periodic(const Duration(seconds: 1), (timer) {
        sunriseSunsetController.updateTime();
      });
    });

    PrefServices.getString('language');
  }

  Future<void> _clearData() async {
    await PrefServices.removeValue('address');
    await PrefServices.removeValue('latitude');
    await PrefServices.removeValue('longitude');
    await PrefServices.removeValue('locationList');
  }

  double? latitude;
  double? longitude;
  String? address;

  // DateTime parseTime(String timeStr) {
  //   // Create a DateTimeFormatter with the expected time format
  //   DateFormat formatter = DateFormat("hh:mm:ss a");
  //
  //   // Parse the time string into a DateTime object
  //   return formatter.parse(timeStr);
  // }
  //
  // String formatDuration(Duration duration) {
  //   // Calculate hours, minutes, and seconds
  //   int hours = duration.inHours;
  //   int minutes = duration.inMinutes.remainder(60);
  //   int seconds = duration.inSeconds.remainder(60);
  //
  //   // Format the duration as "hh:mm:ss"
  //   return "${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  // }

  @override
  Widget build(BuildContext context){

    print("latitude :- ${widget.latitude}");
    print("longitude :-  ${widget.longitude}");
    print("address :- ${widget.address}");
    print("googleController.address.value :- ${googleController.address.value}");
    ///Start
    // Example: For demonstration purpose, I'm setting the current time as 7:59:41 PM
    // DateTime now = DateTime.now();
    //
    // // Example: For demonstration purpose, I'm setting the sunrise and sunset times
    // // String sunriseTime = '06:17:05 AM';
    // // String sunsetTime = '06:59:05 PM';
    // String sunriseTime =  PrefServices.getString('sunrise');
    // String sunsetTime =  PrefServices.getString('sunset');
    //
    // // Parse the sunrise and sunset times
    // DateTime sunrise = parseTime(sunriseTime);
    // DateTime sunset = parseTime(sunsetTime);
    //
    // DateTime sunriseTimeWithoutYear = DateTime(now.year, now.month, now.day, sunrise.hour, sunrise.minute, sunrise.second);
    // DateTime sunsetTimeWithoutYear = DateTime(now.year, now.month, now.day, sunset.hour, sunset.minute, sunset.second);
    // DateTime currentTimeWithoutYear = DateTime(now.year, now.month, now.day, now.hour, now.minute, now.second);
    //
    // // Check if sunrise has occurred
    // if (currentTimeWithoutYear.isAfter(sunriseTimeWithoutYear)) {
    //   // Sunrise has occurred, calculate time until sunset
    //   if (currentTimeWithoutYear.isBefore(sunsetTimeWithoutYear)) {
    //     Duration difference = sunsetTimeWithoutYear.difference(currentTimeWithoutYear);
    //     print("Time until sunset: ${formatDuration(difference)} hours.");
    //   } else {
    //     // Sunset has occurred, calculate time until next sunrise
    //     DateTime nextDaySunrise = sunriseTimeWithoutYear.add(Duration(days: 1));
    //     Duration difference = nextDaySunrise.difference(currentTimeWithoutYear);
    //     print("Time until next sunrise: ${formatDuration(difference)} hours.");
    //   }
    // } else {
    //   // Sunrise hasn't occurred yet, calculate time until sunrise
    //   Duration difference = sunriseTimeWithoutYear.difference(currentTimeWithoutYear);
    //   print("Time until sunrise: ${formatDuration(difference)} hours.");
    // }

    ///End



    return Scaffold(
        key: _scaffoldKey,
        endDrawer: Drawer(
          width: 250.w,
          shape: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(28.r)),
          ),
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w),
            child: Column(
              children: [
                SizedBox(
                  height: 100.h,
                ),
                InkWell(
                  onTap: () {
                    Get.to(const SettingsScreen());
                  },
                  child: Row(
                    children: [
                      const Icon(
                        AssetUtils.seetingIcon,
                        color: ColorUtils.orange,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        StringUtils.SettingsScreenTxt,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: ColorUtils.black,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    LocalAssets(
                      imagePath: AssetUtils.contactsImages,
                      height: 20.h,
                      fit: BoxFit.fitHeight,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                      StringUtils.contactsTxt,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                      color: ColorUtils.black,
                    ),
                  ],
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Get.dialog(
                      AlertDialog(
                        content: SizedBox(
                          height: 250.h,
                          child: Obx(
                            () => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const CustomText(
                                  StringUtils.languageChooseTxt,
                                  color: ColorUtils.black,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      StringUtils.hinTxt,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorUtils.black,
                                    ),
                                    Radio(
                                      value: 'Hindi',
                                      groupValue: sunriseSunsetController
                                          .selectedValue.value,
                                      onChanged: (value) {
                                        sunriseSunsetController.selectedValue
                                            .value = value.toString();
                                      },
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => ColorUtils.orange),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      StringUtils.engTxt,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorUtils.black,
                                    ),
                                    Radio(
                                      value: 'English',
                                      groupValue: sunriseSunsetController
                                          .selectedValue.value,
                                      onChanged: (value) {
                                        sunriseSunsetController.selectedValue
                                            .value = value.toString();
                                      },
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => ColorUtils.orange),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomText(
                                      StringUtils.gujTxt,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w600,
                                      color: ColorUtils.black,
                                    ),
                                    Radio(
                                      value: 'Gujarati',
                                      groupValue: sunriseSunsetController
                                          .selectedValue.value,
                                      onChanged: (value) {
                                        sunriseSunsetController.selectedValue
                                            .value = value.toString();
                                      },
                                      fillColor: MaterialStateColor.resolveWith(
                                          (states) => ColorUtils.orange),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20.h,
                                ),
                                CustomBtn(
                                  height: 50.h,
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColorUtils.gridentColor1,
                                      ColorUtils.gridentColor2,
                                    ],
                                    begin: AlignmentDirectional.topEnd,
                                    end: AlignmentDirectional.bottomEnd,
                                  ),
                                  onTap: () async {
                                    switch (sunriseSunsetController
                                        .selectedValue.value) {
                                      case 'Hindi':
                                        Get.updateLocale(const Locale('hi'));
                                        await PrefServices.setValue(
                                            'language', 'hi');
                                        break;
                                      case 'English':
                                        Get.updateLocale(const Locale('en_US'));
                                        await PrefServices.setValue(
                                            'language', 'en_US');
                                        break;
                                      case 'Gujarati':
                                        Get.updateLocale(const Locale('gu'));
                                        await PrefServices.setValue(
                                            'language', 'gu');
                                        break;
                                      default:
                                        break;
                                    }
                                    Get.back();
                                  },
                                  title: StringUtils.submitBtnTxt,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      LocalAssets(
                        imagePath: AssetUtils.languageImages,
                        height: 25.h,
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        StringUtils.languageTxt,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: ColorUtils.black,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  children: [
                    const Icon(
                      AssetUtils.aboutIcon,
                      color: ColorUtils.orange,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                      StringUtils.aboutTxt,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                      color: ColorUtils.black,
                    ),
                  ],
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                GestureDetector(
                  onTap: () {
                  sunriseSunsetController.launchUrl();
                  },
                  child: Row(
                    children: [
                      LocalAssets(
                        imagePath: AssetUtils.privacyPolicyImages,
                        height: 25.h,
                        fit: BoxFit.fitHeight,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        StringUtils.privacyPolicyTxt,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: ColorUtils.black,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),
                InkWell(
                  onTap: () {
                    Share.share(
                        'https://play.google.com/store/apps/details?id=com.example.sunrise_app');
                  },
                  child: Row(
                    children: [
                      const Icon(
                        AssetUtils.shareIcon,
                        color: ColorUtils.orange,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      CustomText(
                        StringUtils.shareTxt,
                        fontWeight: FontWeight.w500,
                        fontSize: 15.sp,
                        color: ColorUtils.black,
                      ),
                    ],
                  ),
                ),
                const Divider(),
                SizedBox(
                  height: 10.h,
                ),

                Row(
                  children: [
                    const Icon(
                      AssetUtils.helpIcon,
                      color: ColorUtils.orange,
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    CustomText(
                      StringUtils.helpTxt,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.sp,
                      color: ColorUtils.black,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    AssetUtils.backgroundImages,
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 70.h,
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ///  MANTRA TXT
                        InkWell(
                          onTap: () {
                            Get.to(const MantraMenuScreen());
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 10.h),
                            decoration: BoxDecoration(
                              color: ColorUtils.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(24.r)),
                            ),
                            child: Row(
                              children: [
                                Image.asset(
                                  AssetUtils.mantraImages,
                                ),
                                SizedBox(
                                  width: 8.w,
                                ),
                                CustomText(
                                  StringUtils.mantraTxt,
                                  fontSize: 11.sp,
                                  fontWeight: FontWeight.w500,
                                  color: ColorUtils.black,
                                ),
                              ],
                            ),
                          ),
                        ),

                        /// MENU ICON
                        InkWell(
                          onTap: () {
                            _scaffoldKey.currentState?.openEndDrawer();
                          },
                          child: CircleAvatar(
                            radius: 17.r,
                            backgroundColor: ColorUtils.white,
                            child: const Icon(
                              AssetUtils.menuIcon,
                              color: ColorUtils.orange,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),

                  /// CALENDAR ICON
                  InkWell(
                    onTap: () async {
                      sunriseSunsetController.selectDate(context);
                    },
                    child: const CircleAvatar(
                      backgroundColor: ColorUtils.white,
                      child: Icon(
                        AssetUtils.calendarIcon,
                        color: ColorUtils.orange,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10.h,
                  ),

                  /// Selected Date of Calender
                  Obx(() => CustomText(
                        DateFormat('dd MMMM yyyy').format(sunriseSunsetController.selectedDate.value),
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      )),

                  SizedBox(
                    height: 10.h,
                  ),

                  /// CURRENT TIME
                  // Obx(() => Container(
                  //       padding: EdgeInsets.symmetric(
                  //           horizontal: 18.w, vertical: 5.h),
                  //       decoration: BoxDecoration(
                  //         borderRadius: BorderRadius.all(Radius.circular(6.r)),
                  //         border: Border.all(color: ColorUtils.borderColor),
                  //         boxShadow: [
                  //           BoxShadow(
                  //             color: ColorUtils.white,
                  //             blurRadius: 200.w,
                  //           ),
                  //         ],
                  //       ),
                  //       child: CustomText(
                  //         sunriseSunsetController.currentTime().toString(),
                  //         fontWeight: FontWeight.w500,
                  //         fontSize: 20.sp,
                  //       ),
                  //     ),),
                   Obx(() {
                     if(settingScreenController.isCountDown.value){
                       return CustomText(
                         settingScreenController.difference != null
                             ? settingScreenController.formatDuration(settingScreenController.difference!.value):'',

                     fontWeight: FontWeight.w500,
                         fontSize: 20.sp,
                       );
                     }else{
                       return Container(
                         padding: EdgeInsets.symmetric(
                             horizontal: 18.w, vertical: 5.h),
                         decoration: BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(6.r)),
                           border: Border.all(color: ColorUtils.borderColor),
                           boxShadow: [
                             BoxShadow(
                               color: ColorUtils.white,
                               blurRadius: 200.w,
                             ),
                           ],
                         ),
                         child: settingScreenController.is24Hours.value?CustomText(
                            // settingScreenController.current24HourTime().toString(),
                           PrefServices.getString('settingTime'),
                           fontWeight: FontWeight.w500,
                           fontSize: 20.sp,
                         ):CustomText(
                           sunriseSunsetController.currentTime().toString(),
                           fontWeight: FontWeight.w500,
                           fontSize: 20.sp,
                         ),
                       );
                     }
                   }),
                  SizedBox(
                    height: 90.h,
                  ),

                  /// SUNRISE and Sunset Time
                  Obx(
                    () => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        /// SUNRISE
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 23.h),
                              child: Container(
                                height: 79.13.h,
                                width: 137.53.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.r)),
                                  border: Border.all(
                                    color: ColorUtils.borderColor,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorUtils.white,
                                      blurRadius: 300.w,
                                    )
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 25.h),
                                  child: sunriseSunsetController.isLoad.value
                                      ? const CircularProgressIndicator(
                                          color: ColorUtils.white,
                                        )
                                      : (PrefServices.getDouble('saveLat') == 0.0 &&
                                              PrefServices.getDouble('saveLong') == 0.0)
                                          ? CustomText(
                                              '',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp,
                                            )
                                          :settingScreenController.is24Hours.value?
                                      CustomText(
                                       //settingScreenController.sunrise24HourTime.toString(),
                                        PrefServices.getString('sunrise24Hours'),

                                        fontWeight: FontWeight.w500,
                                        fontSize: 20.sp,
                                      ):
                                     CustomText(
                                       PrefServices.getString('sunrise'),
                                       fontWeight: FontWeight.w500,
                                       fontSize: 20.sp,
                                            ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40.w,
                              child: CircleAvatar(
                                backgroundColor: ColorUtils.white,
                                radius: 27.r,
                                child: LocalAssets(
                                    imagePath: AssetUtils.sunriseImages),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(
                          width: 20.w,
                        ),

                        /// SUNSET
                        Stack(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 23.h),
                              child: Container(
                                height: 79.13.h,
                                width: 137.53.w,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(6.r)),
                                  border: Border.all(
                                    color: ColorUtils.borderColor,
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: ColorUtils.white,
                                      blurRadius: 200.w,
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: EdgeInsets.only(top: 25.h),
                                  child: sunriseSunsetController.isLoad.value
                                      ? const CircularProgressIndicator(
                                          color: ColorUtils.white,
                                        )
                                      : (PrefServices.getDouble('saveLat') ==
                                                  0.0 &&
                                              PrefServices.getDouble(
                                                      'saveLong') ==
                                                  0.0)
                                          ? CustomText(
                                              '',
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp,
                                            )
                                          : settingScreenController.is24Hours.value?
                                  CustomText(
                                     // settingScreenController.sunset24HourTime.toString(),
                                    PrefServices.getString('sunset24Hours'),

                                    fontWeight: FontWeight.w500,
                                    fontSize: 20.sp,
                                  ):
                                  CustomText(
                                              PrefServices.getString('sunset'),
                                              fontWeight: FontWeight.w500,
                                              fontSize: 20.sp,
                                            ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 40.w,
                              child: CircleAvatar(
                                backgroundColor: ColorUtils.white,
                                radius: 27.r,
                                child: LocalAssets(
                                  imagePath: AssetUtils.sunsetImages,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 130.h,
                  ),

                  /// ADD LOCATION
                  Stack(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 23.h),
                        child: Container(
                          width: 287.83.w,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: ColorUtils.white,
                            borderRadius:
                                BorderRadius.all(Radius.circular(52.r)),
                            border: Border.all(
                              color: ColorUtils.borderColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              if (PrefServices.getString('saveAddress')
                                  .isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 20.w, top: 30.h),
                                  child: CustomText(
                                    PrefServices.getString('saveAddress'),
                                    textAlign: TextAlign.center,
                                    color: ColorUtils.black,
                                  ),
                                ),
                              if (PrefServices.getString('saveAddress').isEmpty)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 20.w, top: 30.h),
                                  child: const CustomText(
                                    StringUtils.locationSetTxt,
                                    textAlign: TextAlign.center,
                                    color: ColorUtils.black,
                                  ),
                                ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 120.w,
                        child: InkWell(
                          onTap: () {
                            _showLocationDialog();
                          },
                          child: Container(
                            width: 50.29.w,
                            height: 50.29.h,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  ColorUtils.gridentColor1,
                                  ColorUtils.gridentColor2,
                                ],
                                begin: AlignmentDirectional.topEnd,
                                end: AlignmentDirectional.bottomEnd,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              AssetUtils.locationIcon,
                              color: ColorUtils.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(
                    height: 20.h,
                  ),

                  ///EDIT LOCATION
                  Container(
                    height: 40.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            title: SizedBox(
                              height: 120.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TextButton(
                                    onPressed: () async {
                                      await _clearData();
                                      sunriseSunsetController
                                          .clearSunriseSunsetData();

                                      final containIndex = googleController
                                          .locationList
                                          .indexWhere(
                                              (element) => element == address);
                                      setState(() {
                                        address = '';
                                        latitude = 0;
                                        longitude = 0;
                                        googleController.locationList
                                            .removeAt(containIndex);
                                      });
                                      Get.back();
                                    },
                                    child: const CustomText(
                                      StringUtils.deleteLocationBtnTxt,
                                      fontWeight: FontWeight.w500,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                  const Divider(),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      String newAddress = address ?? '';
                                      double? newLatitude = latitude;
                                      double? newLongitude = longitude;
                                      Get.dialog(AlertDialog(
                                        title: const CustomText(
                                          StringUtils.enterLocationTxt,
                                          color: ColorUtils.black,
                                        ),
                                        content: CommonTextField(
                                          initialValue: newAddress,
                                          onChange: (value) {
                                            newAddress = value;
                                          },
                                        ),
                                        actions: [
                                          Row(
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  Get.back();
                                                },
                                                child: const CustomText(
                                                  StringUtils.cancleTxt,
                                                  color: ColorUtils.black,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () async {
                                                  print(
                                                      "==========Address====>${address!}");
                                                  print(
                                                      "==========AddressList====>${googleController.locationList}");
                                                  final containIndex =
                                                      googleController
                                                          .locationList
                                                          .indexWhere(
                                                              (element) =>
                                                                  element ==
                                                                  address);
                                                  List locations =
                                                      await locationFromAddress(
                                                          newAddress);
                                                  if (locations.isNotEmpty) {
                                                    newLatitude = locations
                                                        .first.latitude;
                                                    newLongitude = locations
                                                        .first.longitude;
                                                  }
                                                  setState(() {
                                                    address = newAddress;
                                                    latitude = newLatitude;
                                                    longitude = newLongitude;
                                                    googleController
                                                                .locationList[
                                                            containIndex] =
                                                        newAddress;
                                                  });
                                                  if (address != null &&
                                                      latitude != null &&
                                                      longitude != null) {
                                                    PrefServices.setValue(
                                                        'address', address!);
                                                    PrefServices.setValue(
                                                        'latitude', latitude!);
                                                    PrefServices.setValue(
                                                        'longitude',
                                                        longitude!);
                                                    await PrefServices.setValue(
                                                        'locationList',
                                                        googleController
                                                            .locationList);
                                                  }
                                                  Get.back();
                                                },
                                                child: const CustomText(
                                                  StringUtils
                                                      .renameLocationBtnTxt,
                                                  color: ColorUtils.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ));
                                    },
                                    child: const CustomText(
                                      StringUtils.renameLocationTxt,
                                      fontWeight: FontWeight.w500,
                                      color: ColorUtils.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                      icon: ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (Rect bounds) => const RadialGradient(
                          center: Alignment.topCenter,
                          colors: [
                            ColorUtils.gridentColor1,
                            ColorUtils.gridentColor2,
                          ],
                        ).createShader(bounds),
                        child: const Icon(
                          AssetUtils.seetingIcon,
                          size: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ));
  }

  void _showLocationDialog() {
    Get.dialog(
      AlertDialog(
        title: SizedBox(
          height: googleController.locationList.isNotEmpty ? null : 120.h,
          child: Column(
            children: [
              googleController.locationList.isNotEmpty
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        googleController.locationList.isNotEmpty
                            ? SizedBox(
                                height:
                                    googleController.locationList.length * 40.0,
                                width: Get.width,
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount:
                                      googleController.locationList.length,
                                  itemBuilder: (context, index) {
                                    return CustomText(
                                      googleController.locationList[index],
                                      color: ColorUtils.black,
                                    );
                                  },
                                ),
                              )
                            : const CustomText(
                                'Location name not found',
                                color: ColorUtils.black,
                              ),

                        const Divider(),

                        /// Delete All location
                        TextButton(
                          onPressed: () {
                            googleController.clearLocationList();
                            googleController.address.value = '';
                            sunriseSunsetController.sunset.value = '';
                            sunriseSunsetController.sunrise.value = '';

                            PrefServices.setValue('saveAddress', '');
                            PrefServices.setValue('sunrise', '');
                            PrefServices.setValue('sunset', '');

                            PrefServices.setValue('saveLat', 0.0);
                            PrefServices.setValue('saveLong', 0.0);

                            setState(() {});
                            Get.back(result: false);
                          },
                          child: const CustomText(
                            StringUtils.deleteLocationTxt,
                            color: ColorUtils.black,
                          ),
                        ),
                        const Divider(),
                        TextButton(
                          onPressed: () {
                            Get.back();
                            Get.dialog(
                              AlertDialog(
                                title: SizedBox(
                                  height: 120.h,
                                  child: Column(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Get.off(IntegrateGoogleMap());
                                        },
                                        child: const CustomText(
                                          StringUtils.usgMapTxt,
                                          color: ColorUtils.black,
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Get.off(const LocationScreen());
                                        },
                                        child: const CustomText(
                                          StringUtils.usgManuallyTxt,
                                          color: ColorUtils.black,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          child: const CustomText(
                            StringUtils.addLocationTxt,
                            color: ColorUtils.black,
                          ),
                        ),
                      ],
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            Get.off(IntegrateGoogleMap());
                          },
                          child: const CustomText(
                            StringUtils.usgMapTxt,
                            color: ColorUtils.black,
                          ),
                        ),
                        const Divider(),
                        TextButton(
                          onPressed: () {
                            Get.off(const LocationScreen());
                          },
                          child: const CustomText(
                            StringUtils.usgManuallyTxt,
                            color: ColorUtils.black,
                          ),
                        ),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

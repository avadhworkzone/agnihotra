import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
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
import 'package:sunrise_app/viewModel/enter_location_controller.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';
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
  LocationController locationController = Get.find<LocationController>();

  SunriseSunsetController sunriseSunsetController =
      Get.find<SunriseSunsetController>();
  GoogleController googleController = Get.find<GoogleController>();

  String formatAddress() {
    if (address == null || (latitude == 0 && longitude == 0)) {
      return StringUtils.locationSetTxt;
    }

    List<String> addressParts =
        address!.split(',').map((part) => part.trim()).toList();
    addressParts.removeWhere((part) => part.isEmpty);

    return addressParts.join(', ');
  }

  String formateLatitudeLongitude(double value) {
    String formattedValue = value.toStringAsFixed(4);
    return formattedValue;
  }

  String coordinates = "No Location found";
  String currentAddress = 'No Address found';
  bool scanning = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      PrefServices.getString('saveAddress');

      sunriseSunsetController.countryTimeZone(
          PrefServices.getDouble('currentLat'),
          PrefServices.getDouble('currentLong'),
          sunriseSunsetController.formattedDate,
          PrefServices.getString('countryName'));

      locationController.getCurrentLocation();

      sunriseSunsetController.selectedDate.value = DateTime.now();
      Timer.periodic(const Duration(seconds: 1), (timer) {
       // sunriseSunsetController.updateTime();
        settingScreenController.updateTime();
      });
    });

    PrefServices.getString('language');
  }

  double? latitude;
  double? longitude;
  String? address;

  String newAddress = '';

  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
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
                    _openDrawer();
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
                GestureDetector(
                  onTap: () {
                    _openDrawer();
                    _aboutDialog();
                  },
                  child: Row(
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
                                  width: 18.w,
                                  height: 16.h,
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
                  Obx(() {
                    if(settingScreenController.isCountDown.value){
                      return CustomText(
                        // settingScreenController.difference != null
                        //     ? settingScreenController.formatDuration(settingScreenController.difference.value):'',
                        PrefServices.getString('timeUntilTime'),
                        fontWeight: FontWeight.w500,
                        fontSize: 20.sp,
                      );
                    }else{
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 5.h),
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
                        child:CustomText(
                          // sunriseSunsetController.currentTime().toString(),
                          settingScreenController.current24HourTime.value,
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
                                    child: sunriseSunsetController.isCountryLoad.value
                                        ? const CircularProgressIndicator(
                                      color: ColorUtils.white,
                                    )
                                        : (PrefServices.getDouble('currentLat') == 0.0 && PrefServices.getDouble('currentLong') == 0.0)
                                        ? CustomText(
                                      '',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp,
                                    )
                                        : CustomText(
                                      ' ${settingScreenController.is24Hours.value ? PrefServices.getString('formattedSunriseTime') : settingScreenController.formatTime(PrefServices.getString('countrySunriseTimeZone'), false)}',
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
                                    imagePath: AssetUtils.sunriseImages,
                                  height: 30.63,
                                  width: 30.63,
                                ),
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
                                    child: sunriseSunsetController.isCountryLoad.value
                                        ? const CircularProgressIndicator(
                                      color: ColorUtils.white,
                                    )
                                        : (PrefServices.getDouble('currentLat') == 0.0 && PrefServices.getDouble('currentLong') == 0.0)
                                        ? CustomText(
                                      '',
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20.sp,
                                    )
                                        :
                                    CustomText(
                                      ' ${settingScreenController.is24Hours.value ? PrefServices.getString('formattedSunsetTime') : settingScreenController.formatTime(PrefServices.getString('countrySunsetTimeZone'), false)}',
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
                                  height: 30.63,
                                  width: 30.63,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),),

                  SizedBox(
                    height: 130.h,
                  ),

                  /// ADD LOCATION
                  Stack(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.only(top: 23.h, left: 30.w, right: 30.w),
                        child: Container(
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
                              ///  CURRENT ADDRESS
                              if (PrefServices.getString('currentAddress')
                                  .isNotEmpty)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 20.w, top: 30.h),
                                  child: CustomText(
                                    PrefServices.getString('currentAddress'),
                                    textAlign: TextAlign.center,
                                    color: ColorUtils.black,
                                  ),
                                ),

                              if (PrefServices.getString('currentAddress')
                                  .isEmpty)
                                Padding(
                                  padding: EdgeInsets.only(
                                      left: 20.w, right: 20.w, top: 30.h),
                                  child: const CustomText(
                                    StringUtils.locationSetTxt,
                                    textAlign: TextAlign.center,
                                    color: ColorUtils.black,
                                  ),
                                ),

                              /// Lat Long
                              SizedBox(height: 4.h),

                              if (PrefServices.getDouble('currentLat') != 0.0 &&
                                  PrefServices.getDouble('currentLong') != 0.0)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CustomText(
                                      "(${PrefServices.getDouble('currentLat').toStringAsFixed(4)},${PrefServices.getDouble('currentLong').toStringAsFixed(4)})",
                                      textAlign: TextAlign.center,
                                      color: ColorUtils.black,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),

                                    /// Indian Time Zone
                                    if (PrefServices.getString('countryName')
                                        .isNotEmpty)
                                      CustomText(
                                        PrefServices.getString('countryName'),
                                        textAlign: TextAlign.center,
                                        color: ColorUtils.black,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                    if (PrefServices.getString('countryName')
                                        .isEmpty)
                                      const CustomText(
                                        StringUtils.indiaStdTime,
                                        textAlign: TextAlign.center,
                                        color: ColorUtils.black,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                  ],
                                ),
                              SizedBox(height: 7.h),
                            ],
                          ),
                        ),
                      ),

                      /// Delete All Location Dialog
                      InkWell(
                        onTap: () {
                          _showLocationDialog();
                        },
                        child: Center(
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

                  /// Delete and  Rename Current LOCATION
                  Container(
                    height: 40.h,
                    width: 60.w,
                    decoration: BoxDecoration(
                      color: ColorUtils.white,
                      borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (PrefServices.getString('currentAddress')
                            .isNotEmpty) {
                          Get.dialog(
                            AlertDialog(
                              shape: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(7.r),
                                  borderSide: BorderSide.none),
                              titlePadding: EdgeInsets.zero,
                              title: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// Delete Current location Address,lat ,lon
                                  TextButton(
                                    onPressed: () {
                                      deleteCurrentLocation();
                                    },
                                    child: CustomText(
                                      StringUtils.deleteLocationBtnTxt,
                                      fontWeight: FontWeight.w500,
                                      color: ColorUtils.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),

                                  Divider(
                                    height: 0.h,
                                    thickness: 1.h,
                                    indent: 12.w,
                                    endIndent: 12.w,
                                    color: ColorUtils.black00.withOpacity(0.14),
                                  ),

                                  /// Rename this location Text
                                  TextButton(
                                    onPressed: () {
                                      renameAddress();
                                    },
                                    child: CustomText(
                                      StringUtils.renameLocationTxt,
                                      fontWeight: FontWeight.w500,
                                      color: ColorUtils.black,
                                      fontSize: 14.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
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
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(7.r), // Customize this value as needed
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        child: PrefServices.getStringList("locationList").isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.only(left: 12.w, top: 15.h),
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount:
                          PrefServices.getStringList("locationList").length,
                      itemBuilder: (context, index) {
                        return CustomText(
                          PrefServices.getStringList("locationList")[index],
                          color: ColorUtils.black,
                        );
                      },
                    ),

                    SizedBox(
                      height: 10.h,
                    ),
                    Divider(
                      height: 0.h,
                      thickness: 1.h,
                      indent: 10.w,
                      endIndent: 10.w,
                      color: ColorUtils.black00.withOpacity(0.14),
                    ),

                    /// Delete All location Text
                    TextButton(
                      onPressed: () {
                        _deleteAllLocationDialog();
                      },
                      child: const CustomText(
                        StringUtils.deleteLocationTxt,
                        color: ColorUtils.black,
                      ),
                    ),

                    Divider(
                      height: 0.h,
                      thickness: 1.h,
                      indent: 10.w,
                      endIndent: 10.w,
                      color: ColorUtils.black00.withOpacity(0.14),
                    ),

                    /// Add Location Text
                    TextButton(
                      onPressed: () {
                        Get.back();
                        Get.dialog(
                          AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  7.r), // Customize this value as needed
                            ),
                            titlePadding: EdgeInsets.zero,
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Get.off(IntegrateGoogleMap(
                                      address: locationController.address.value,
                                      longitude:
                                          locationController.longitude.value,
                                      latitude:
                                          locationController.latitude.value,
                                    ));
                                  },
                                  child: CustomText(
                                    StringUtils.usgMapTxt,
                                    color: ColorUtils.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Divider(
                                  height: 0.h,
                                  thickness: 1.h,
                                  indent: 12.w,
                                  endIndent: 12.w,
                                  color: ColorUtils.black00.withOpacity(0.14),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Get.off(const LocationScreen());
                                  },
                                  child: CustomText(
                                    StringUtils.usgManuallyTxt,
                                    color: ColorUtils.black,
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
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
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton(
                    onPressed: () {
                      Get.off(IntegrateGoogleMap(
                        latitude: locationController.currentLat,
                        longitude: locationController.currentLong,
                        address: locationController.currentAddress,
                      ));
                    },
                    child: CustomText(
                      StringUtils.usgMapTxt,
                      color: ColorUtils.black,
                      fontSize: 14.sp,
                    ),
                  ),
                  Divider(
                    height: 0.h,
                    thickness: 1.h,
                    indent: 12.w,
                    endIndent: 12.w,
                    color: ColorUtils.black00.withOpacity(0.14),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.off(const LocationScreen());
                    },
                    child: CustomText(
                      StringUtils.usgManuallyTxt,
                      color: ColorUtils.black,
                      fontSize: 14.sp,
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Future _aboutDialog() {
    return Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(7.r), // Customize this value as needed
        ),
        insetPadding: EdgeInsets.symmetric(
          horizontal: 30.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 16.h,
            ),
            Center(
              child: LocalAssets(
                imagePath: AssetUtils.bgRemoveAboutIcon,
                fit: BoxFit.contain,
                height: 50.r,
                width: 50.r,
              ),
            ),
            SizedBox(
              height: 2.h,
            ),

            const Center(
              child: CustomText(
                StringUtils.appName,
                color: ColorUtils.grey73,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(
              height: 15.h,
            ),

            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: const CustomText(
                StringUtils.inspiration,
                color: ColorUtils.grey73,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: const CustomText(
                StringUtils.guruName,
                color: ColorUtils.grey73,
                fontWeight: FontWeight.w300,
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
          ],
        ),
      ),
    );
  }

  checkPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    print(serviceEnabled);

    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    permission = await Geolocator.checkPermission();

    print(permission);

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Request Denied !');
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Denied Forever !');
      return;
    }

    getLocation();
  }

  getLocation() async {
    setState(() {
      scanning = true;
    });

    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      coordinates =
          'Latitude : ${position.latitude} \nLongitude : ${position.longitude}';

      List<Placemark> result =
          await placemarkFromCoordinates(position.latitude, position.longitude);

      if (result.isNotEmpty) {
        address =
            '${result[0].name}, ${result[0].locality} ${result[0].administrativeArea}';
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }

    setState(() {
      scanning = false;
    });
  }

  Future<void> _deleteAllLocationDialog() async {
    Get.back();
    return Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.r), // Change border radius
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 11.h,
          ),
          CustomText(
            StringUtils.deleteAllLocation,
            fontWeight: FontWeight.w600,
            color: ColorUtils.black,
            textAlign: TextAlign.left,
            fontSize: 15.sp,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: CustomText(
                  StringUtils.cancleTxt,
                  fontWeight: FontWeight.w600,
                  color: ColorUtils.orange,
                  textAlign: TextAlign.center,
                  fontSize: 13.sp,
                ),
              ),

              SizedBox(
                width: 10.w,
              ),

              /// Proceed
              InkWell(
                onTap: () {
                  googleController.clearLocationList();
                  googleController.address.value = '';

                  widget.address = '';

                  PrefServices.setValue('currentAddress', '');
                  PrefServices.setValue('countryName', '');
                  PrefServices.setValue('currentLat', 0.0);
                  PrefServices.setValue('currentLong', 0.0);

                  setState(() {});
                  Get.back(result: false);
                },
                child: CustomText(
                  StringUtils.proceedTxt,
                  fontWeight: FontWeight.w600,
                  color: ColorUtils.orange,
                  textAlign: TextAlign.center,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    ));
  }

  Future<void> deleteCurrentLocation() {
    Get.back();
    return Get.dialog(AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7.r), // Change border radius
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 11.h,
          ),
          Align(
            alignment: Alignment.topLeft,
            child: CustomText(
              StringUtils.deleteThisLocation,
              fontWeight: FontWeight.w600,
              color: ColorUtils.black,
              textAlign: TextAlign.left,
              fontSize: 15.sp,
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// No Button
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: CustomText(
                  StringUtils.noTxt,
                  fontWeight: FontWeight.w600,
                  color: ColorUtils.orange,
                  textAlign: TextAlign.center,
                  fontSize: 13.sp,
                ),
              ),

              SizedBox(
                width: 25.w,
              ),

              /// Yes Button
              InkWell(
                onTap: () {
                  setState(() {
                    googleController.locationList.removeLast();
                    PrefServices.setValue('currentAddress', '');
                    PrefServices.setValue('currentLat', 0.0);
                    PrefServices.setValue('currentLong', 0.0);
                    PrefServices.setValue('countryName', '');
                    PrefServices.setValue(
                        "locationList", googleController.locationList);
                  });
                  Get.back();
                },
                child: CustomText(
                  StringUtils.yesTxt,
                  fontWeight: FontWeight.w600,
                  color: ColorUtils.orange,
                  textAlign: TextAlign.center,
                  fontSize: 13.sp,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16.h,
          ),
        ],
      ),
    ));
  }

  Future renameAddress() {
    Get.back();
    return Get.dialog(AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: BorderSide.none),
      title: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Padding(
            padding: EdgeInsets.only(left: 13.w),
            child: CustomText(
              StringUtils.enterLocationTxt,
              color: ColorUtils.black00,
              fontWeight: FontWeight.w500,
              fontSize: 15.sp,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5.w),
            child: CommonTextField(
              onChange: (value) {
                newAddress = value;
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              /// cancel button
              TextButton(
                onPressed: () {
                  Get.back();
                },
                child: CustomText(
                  StringUtils.cancleTxt,
                  color: ColorUtils.orange,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),

              /// Rename button
              TextButton(
                onPressed: () async {
                  final currentAddress =
                      PrefServices.getString('currentAddress');

                  final containIndex = googleController.locationList
                      .indexWhere((element) => element == currentAddress);

                  googleController.locationList[containIndex] = newAddress;

                  String renameElement =
                      googleController.locationList[containIndex];
                  setState(() {});

                  PrefServices.setValue('currentAddress', renameElement);

                  PrefServices.setValue(
                      "locationList", googleController.locationList);

                  PrefServices.getStringList("locationList");

                  Get.back();
                },
                child: CustomText(
                  StringUtils.renameLocationBtnTxt,
                  color: ColorUtils.orange,
                  fontWeight: FontWeight.w500,
                  fontSize: 12.sp,
                ),
              ),
            ],
          ),
        ],
      ),
    ));
  }
}

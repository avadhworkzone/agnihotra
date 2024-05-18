import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:sunrise_app/common_Widget/common_back_arrow.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_fluttertoast.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/common_Widget/common_textfield.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/viewModel/google_map_controller.dart';
import 'package:sunrise_app/viewModel/settings_controller.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:sunrise_app/viewModel/sunrise_sunset_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SeetingScreenState();
}

class _SeetingScreenState extends State<SettingsScreen> {

  SettingScreenController settingScreenController = Get.find<SettingScreenController>();
  GoogleController googleController = Get.find<GoogleController>();
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  Orientation? orientation;
  TextDirection textDirection = TextDirection.ltr;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = false;
  late AudioPlayer meditionBell;
  SunriseSunsetController sunriseSunsetController = Get.find<SunriseSunsetController>();

  @override
  void initState() {
    super.initState();

    meditionBell = AudioPlayer();
    print("PrefServices.getBool('saveToggleValue') :- ${PrefServices.getBool('saveToggleValue')}");
    print("settingScreenController.on4.value :- ${settingScreenController.on4.value}");
    print("settingScreenController.formatted12HourSunsetTime.value :- ${settingScreenController.formatted12HourSunsetTime.value}");

    WidgetsBinding.instance.addPostFrameCallback((_){

      // settingScreenController.scheduleDailyNotification();
      /// Keep Screen On
      settingScreenController.isScreenOn.value = PrefServices.getBool('keepScreenOn');

      if (settingScreenController.isScreenOn.value){
        KeepScreenOn.turnOn();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  String substractSunsetTime = '';
  String substractSunriseTime = '';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => Stack(
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
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 15.w),
                    const CommonBackArrow(),
                    SizedBox(width: 100.w),
                    CustomText(
                      StringUtils.settingsScreenTxt,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.sp,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 110.h),
              child: ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w),
                    child: Container(
                      width: Get.width,
                      decoration: BoxDecoration(
                        color: ColorUtils.white,
                        borderRadius: BorderRadius.all(Radius.circular(10.r)),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.w, right: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),

                            Center(
                              child: CustomText(
                                StringUtils.checkTimeTxt,
                                fontWeight: FontWeight.w600,
                                fontSize: 24.sp,
                                color: ColorUtils.orange,
                              ),
                            ),

                            SizedBox(
                              height: 30.h,
                            ),

                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  CustomText(
                                    StringUtils.screenOnTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController
                                          .isScreenOn.value,
                                      onChanged: (value) {
                                        settingScreenController
                                            .isScreenOn.value = value;
                                        PrefServices.setValue(
                                            'keepScreenOn',
                                            settingScreenController
                                                .isScreenOn.value);
                                        if (settingScreenController
                                            .isScreenOn.value) {
                                          KeepScreenOn.turnOn();
                                        } else {
                                          KeepScreenOn.turnOff();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomText(
                              StringUtils.screenKeepTxt,
                              color: ColorUtils.black1F,
                              fontWeight: FontWeight.w500,
                              fontSize: 15.sp,
                            ),

                            SizedBox(
                              height: 20.h,
                            ),

                            /// 24 hour clock
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  CustomText(
                                    StringUtils.hoursTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController
                                          .is24Hours.value,
                                      onChanged: (value) {
                                        settingScreenController
                                            .toggleTimeFormat(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomText(
                              StringUtils.timeTxt,
                              color: ColorUtils.black1F,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),

                            SizedBox(
                              height: 20.h,
                            ),

                            /// Medition Bell

                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [

                                  CustomText(
                                    StringUtils.meditationTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),

                                  const Spacer(),

                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController
                                          .isBellRinging.value,
                                      onChanged: (value) async {

                                        settingScreenController.isBellRinging.value = value;
                                        PrefServices.setValue(
                                            'isBellRinging',
                                            settingScreenController
                                                .isBellRinging.value);

                                        settingScreenController
                                            .isBellRinging.value =
                                            PrefServices.getBool(
                                                'isBellRinging');

                                        print("settingScreenController.isBellRinging.value :- ${settingScreenController.isBellRinging.value}");
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomText(
                              StringUtils.ringsTxt,
                              color: ColorUtils.black1F,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),

                            SizedBox(
                              height: 20.h,
                            ),

                            /// Display CountDown
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  CustomText(
                                    StringUtils.countDownTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController
                                          .isCountDown.value,
                                      onChanged: (value) {
                                        settingScreenController
                                            .toggleCountDown(value);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomText(
                              StringUtils.countDownClockTxt,
                              color: ColorUtils.black1F,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),

                            SizedBox(
                              height: 20.h,
                            ),

                            /// Remainder for sunrise
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  CustomText(
                                    StringUtils.sunriseReminderTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController.on5.value,
                                      onChanged: (value) async {
                                        settingScreenController.sunriseRemainderToggle();

                                        if (PrefServices.getBool('saveSunriseToggleValue')){
                                          sunriseRemainderDialog();
                                        }
                                        else {
                                          print("==========CANCEL NOTIFICATION========");
                                          settingScreenController.cancelNotification();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomText(
                              StringUtils.setReminderTxt,
                              color: ColorUtils.black1F,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),

                            if (PrefServices.getBool('saveSunsetToggleValue'))
                              CustomText(
                                '${StringUtils.ringAlarmTxt.tr} ',
                                color: ColorUtils.black1F,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),

                            SizedBox(
                              height: 20.h,
                            ),

                            /// Remainder for sunset
                            SizedBox(
                              height: 30.h,
                              child: Row(
                                children: [
                                  CustomText(
                                    StringUtils.sunsetReminderTxt,
                                    color: ColorUtils.orange,
                                    fontSize: 17.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  const Spacer(),
                                  Transform.scale(
                                    scale: 0.8,
                                    child: Switch(
                                      value: settingScreenController.on4.value,
                                      onChanged: (value) async {
                                        settingScreenController.toggle4();

                                        if (PrefServices.getBool(
                                            'saveToggleValue')) {
                                          sunsetRemainderDialog();
                                        } else {
                                          print(
                                              "==========CANCEL NOTIFICATION========");
                                          settingScreenController
                                              .cancelNotification();
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            CustomText(
                              StringUtils.setReminderTxt,
                              color: ColorUtils.black1F,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.w500,
                            ),

                            if (PrefServices.getBool('saveToggleValue'))
                              Obx(() => CustomText(
                                '${StringUtils.ringAlarmTxt.tr} ${settingScreenController.formatted12HourSunsetTime.value}',
                                color: ColorUtils.black1F,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              )),

                            SizedBox(
                              height: 20.h,
                            ),

                            /// Reset Button
                            Center(
                              child: Padding(
                                padding:
                                EdgeInsets.symmetric(horizontal: 110.w),
                                child: CustomBtn(
                                  height: 45.h,
                                  gradient: const LinearGradient(
                                    colors: [
                                      ColorUtils.gridentColor1,
                                      ColorUtils.gridentColor2,
                                    ],
                                    begin: AlignmentDirectional.topEnd,
                                    end: AlignmentDirectional.bottomEnd,
                                  ),
                                  onTap: () async {
                                    resetButtonDialog();
                                  },
                                  title: StringUtils.resetBtnTxt,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ),

                            SizedBox(
                              height: 10.h,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future resetButtonDialog() {
    return Get.dialog(AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.zero,
      actionsPadding: EdgeInsets.zero,
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(7.r),
          borderSide: BorderSide.none),
      title: Padding(
        padding: EdgeInsets.only(left: 13.w, right: 10.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            CustomText(
              StringUtils.alertTxt,
              color: ColorUtils.black00,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
            ),
            CustomText(
              StringUtils.resetButtonNotice,
              color: ColorUtils.black00,
              fontWeight: FontWeight.w400,
              fontSize: 15.sp,
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
                    StringUtils.cancleCapitalTxt,
                    color: ColorUtils.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),

                /// Proceed
                TextButton(
                  onPressed: () {
                    googleController.clearLocationList();
                    googleController.address.value = '';
                    PrefServices.setValue('currentAddress', '');
                    PrefServices.setValue('countryName', '');
                    PrefServices.setValue('currentLat', 0.0);
                    PrefServices.setValue('currentLong', 0.0).then((value) {
                      Fluttertoast.showToast(msg: StringUtils.resetMsg.tr);
                    });

                    Get.back();
                  },
                  child: CustomText(
                    StringUtils.proceedTxt,
                    color: ColorUtils.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }

  Future sunsetRemainderDialog(){
    settingScreenController.remainderSunsetTimeController.clear();
    return Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.r),
            borderSide: BorderSide.none),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 15.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: CustomText(
                StringUtils.enterTimeInMinText,
                color: ColorUtils.black1F,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            CommonTextFormField(
              onChange: (value) {
                substractSunsetTime = value;
              },
              height: 25.sp,
              contentPadding: EdgeInsets.only(bottom: 11.h),
              keyBoardType: TextInputType.number,
              textEditController:
              settingScreenController.remainderSunsetTimeController,
            ),
            SizedBox(
              height: 25.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                /// CANCEL Textbutton
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CustomText(
                    StringUtils.cancleCapitalTxt,
                    color: ColorUtils.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),

                SizedBox(
                  width: 20.w,
                ),

                /// OK Textbutton
                InkWell(
                  onTap: () {
                    settingScreenController.validateSunsetInput(substractSunsetTime);

                    if (settingScreenController
                        .currentAndSunsetTimeDifference() <
                        settingScreenController
                            .remainderAndSunsetTimeDifference()){
                      print(
                          "settingScreenController.currentAndSunsetTimeDifference() :- ${settingScreenController.currentAndSunsetTimeDifference()}");
                      print(
                          "settingScreenController.remainderAndSunsetTimeDifference() :- ${settingScreenController.remainderAndSunsetTimeDifference()}");

                      PrefServices.setValue('saveToggleValue', false);
                      settingScreenController.on4.value =
                          PrefServices.getBool('saveToggleValue');
                      print(
                          "settingScreenController.on4.value :- ${settingScreenController.on4.value}");
                      commonFlutterToastMsg(
                          'Invalid Value!, Your current time and sunset time difference is less than ${settingScreenController.currentAndSunsetTimeDifference()} min');
                      Get.back();
                    } else {
                      PrefServices.setValue('saveToggleValue', true);

                      print(
                          "Get Value Remainder:- ${PrefServices.getBool('saveToggleValue')}");
                      settingScreenController.on4.value =
                          PrefServices.getBool('saveToggleValue');
                      print(
                          "settingScreenController.on4.value :- ${settingScreenController.on4.value}");

                      settingScreenController
                          .scheduleDailySunsetNotification()
                          .then((value) => Get.back());
                    }
                  },
                  child: CustomText(
                    StringUtils.okTxt,
                    color: ColorUtils.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),

                SizedBox(
                  width: 15.w,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        ),
      ),
    );
  }

  Future sunriseRemainderDialog(){

    settingScreenController.remainderSunRiseTimeController.clear();

    print("current Lat :- ${PrefServices.getDouble('currentLat')}");
    print("current Long :- ${PrefServices.getDouble('currentLong')}");
    print("Date :- ${DateTime.now().add(const Duration(days: 1))}");
    print("PrefServices.getString('countryName') :- ${PrefServices.getString('countryName')}");

    sunriseSunsetController.countryTimeZone(
        PrefServices.getDouble('currentLat'),
        PrefServices.getDouble('currentLong'),
        DateTime.now().add(const Duration(days: 1)).toString(),
        PrefServices.getString('countryName'));

    print("sunriseSunsetController.countrySunriseTimeZone :- ${sunriseSunsetController.countrySunriseTimeZone}");
    print("sunriseSunsetController.countrySunsetTimeZone :- ${sunriseSunsetController.countrySunsetTimeZone}");

    return Get.dialog(
      barrierDismissible: false,
      AlertDialog(
        contentPadding: EdgeInsets.zero,
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3.r),
            borderSide: BorderSide.none),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 15.h,
            ),

            Padding(
              padding: EdgeInsets.only(left: 20.w),
              child: CustomText(
                StringUtils.enterTimeInMinText,
                color: ColorUtils.black1F,
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
              ),
            ),

            CommonTextFormField(
              onChange: (value){
                substractSunriseTime = value;
              },
              height: 25.sp,
              contentPadding: EdgeInsets.only(bottom: 11.h),
              keyBoardType: TextInputType.number,
              textEditController: settingScreenController.remainderSunRiseTimeController,
            ),

            SizedBox(
              height: 25.h,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [

                /// CANCEL Textbutton
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: CustomText(
                    StringUtils.cancleCapitalTxt,
                    color: ColorUtils.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),

                SizedBox(
                  width: 20.w,
                ),

                /// OK Textbutton
                InkWell(
                  onTap: () {

                    settingScreenController.validateSunriseInput(substractSunriseTime);

                    // if (settingScreenController
                    //     .currentAndSunsetTimeDifference() <
                    //     settingScreenController
                    //         .remainderAndSunsetTimeDifference()){
                    //   print(
                    //       "settingScreenController.currentAndSunsetTimeDifference() :- ${settingScreenController.currentAndSunsetTimeDifference()}");
                    //   print(
                    //       "settingScreenController.remainderAndSunsetTimeDifference() :- ${settingScreenController.remainderAndSunsetTimeDifference()}");
                    //
                    //   PrefServices.setValue('saveSunriseToggleValue', false);
                    //   settingScreenController.on5.value = PrefServices.getBool('saveSunriseToggleValue');
                    //   print(
                    //       "settingScreenController.on5.value :- ${settingScreenController.on5.value}");
                    //   commonFlutterToastMsg(
                    //       'Invalid Value!, Your current time and sunset time difference is less than ${settingScreenController.currentAndSunsetTimeDifference()} min');
                    //   Get.back();
                    // } else {
                    //   PrefServices.setValue('saveSunriseToggleValue', true);

                    print("saveSunriseToggleValue Get Value Remainder:- ${PrefServices.getBool('saveSunriseToggleValue')}");

                    settingScreenController.on4.value = PrefServices.getBool('saveSunriseToggleValue');

                    print("settingScreenController.on5.value :- ${settingScreenController.on5.value}");

                    settingScreenController
                        .scheduleDailySunsetNotification()
                        .then((value) => Get.back());
                    // }
                  },
                  child: CustomText(
                    StringUtils.okTxt,
                    color: ColorUtils.orange,
                    fontWeight: FontWeight.w500,
                    fontSize: 12.sp,
                  ),
                ),

                SizedBox(
                  width: 15.w,
                ),

              ],
            ),

            SizedBox(
              height: 10.h,
            ),

          ],
        ),
      ),
    );
  }

}

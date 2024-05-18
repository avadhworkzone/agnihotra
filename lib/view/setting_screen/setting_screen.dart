import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
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
  SettingScreenController settingScreenController =
      Get.find<SettingScreenController>();
  GoogleController googleController = Get.find<GoogleController>();
  TimePickerEntryMode entryMode = TimePickerEntryMode.dial;
  Orientation? orientation;
  MaterialTapTargetSize tapTargetSize = MaterialTapTargetSize.padded;
  bool use24HourTime = false;
  late AudioPlayer meditionBell;
  SunriseSunsetController sunriseSunsetController =
      Get.find<SunriseSunsetController>();

  @override
  void initState() {
    super.initState();

    meditionBell = AudioPlayer();

    WidgetsBinding.instance.addPostFrameCallback((_) async {

    WidgetsBinding.instance.addPostFrameCallback((_){



      /// Keep Screen On
      settingScreenController.isScreenOn.value =
          PrefServices.getBool('keepScreenOn');

      if (settingScreenController.isScreenOn.value) {
        KeepScreenOn.turnOn();
      }
      print("Remaidner Toggle Value :- ${settingScreenController.on4.value}");

      await sunriseSunsetController.countryTommorowTimeZone(
          PrefServices.getDouble('currentLat'),
          PrefServices.getDouble('currentLong'),
          DateFormat("yyyy-MM-dd").format(
              DateTime.now().add(const Duration(days: 1))),
          PrefServices.getString('countryName'));


      // settingScreenController.remainderNotificationLogic();
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
                     CommonBackArrow(
                       onPressed: () {
                         Get.to(SunriseSunetScreen());
                       },
                     ),
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
                scrollDirection : Axis.vertical,
                physics : const NeverScrollableScrollPhysics(),
                children : [

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

                            /// Screen Always on
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
                                        print("value :- $value");
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
                                        if (googleController
                                            .locationList.isEmpty) {
                                          commonFlutterToastMsg(
                                              'Please Add Location');
                                        } else {
                                          settingScreenController
                                              .isBellRinging.value = value;
                                        }

                                        PrefServices.setValue(
                                            'isBellRinging',
                                            settingScreenController
                                                .isBellRinging.value);

                                        settingScreenController
                                                .isBellRinging.value =
                                            PrefServices.getBool(
                                                'isBellRinging');

                                        print(
                                            "settingScreenController.isBellRinging.value :- ${settingScreenController.isBellRinging.value}");

                                        settingScreenController
                                            .meditionBellNotificationLogic();
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



                            /// Remainder
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

                                        if (googleController
                                            .locationList.isEmpty) {
                                          commonFlutterToastMsg(
                                              'Please Add Location');
                                        } else {
                                          settingScreenController
                                              .remainderToggle();


                                        }

                                        if (PrefServices.getBool(
                                            'saveRemainderToggleValue')) {
                                          remainderDialog();
                                        } else {
                                          print(
                                              "==========CANCEL NOTIFICATION========");
                                          settingScreenController
                                              .cancelAllNotification();
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

                            if (PrefServices.getBool('saveRemainderToggleValue'))
                              Obx(() => CustomText(
                                    "${StringUtils.ringAlarmTxt.tr}\t${settingScreenController.formatted12HourSunsetTime.value}",
                                // , ${settingScreenController.scheduledFormattedDate}
                                    color: ColorUtils.black1F,
                                    fontSize: 15.sp,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    fontWeight: FontWeight.w500,
                                  )),

                            SizedBox(
                              height: 20.h,
                            ),

                            SizedBox(
                              height: 10.h,
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
                  onPressed: (){

                    googleController.clearLocationList();
                    googleController.address.value = '';
                    PrefServices.setValue('currentAddress', '');
                    PrefServices.setValue('countryName', '');
                    PrefServices.setValue('currentLat', 0.0);
                    PrefServices.setValue('keepScreenOn', false);
                    PrefServices.setValue('is24Hours', false);
                    PrefServices.setValue('isBellRinging', false);
                    PrefServices.setValue('isCountDown', false);
                    PrefServices.setValue('saveRemainderToggleValue', false);

                    settingScreenController.on4.value = PrefServices.getBool('saveRemainderToggleValue');
                    settingScreenController.isCountDown.value =
                        PrefServices.getBool('isCountDown');
                    settingScreenController.isBellRinging.value =
                        PrefServices.getBool('isBellRinging');
                    settingScreenController.is24Hours.value =
                        PrefServices.getBool('is24Hours');
                    settingScreenController.isScreenOn.value =
                        PrefServices.getBool('keepScreenOn');
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

  Future<Object> remainderDialog() async {
    settingScreenController.remainderTimeController.clear();


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
                PrefServices.setValue(StringUtils.saveRemainderTextfieldKey,settingScreenController.remainderTimeController.text);
                settingScreenController.remainderTimeController.text =  PrefServices.getString(StringUtils.saveRemainderTextfieldKey);

                print("Save value of field:- ${PrefServices.getString(StringUtils.saveRemainderTextfieldKey)}");
              },
              height: 25.sp,
              contentPadding: EdgeInsets.only(bottom: 11.h),
              keyBoardType: TextInputType.number,
              textEditController: settingScreenController.remainderTimeController,
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
                    PrefServices.setValue('saveToggleValue', false);
                    settingScreenController.on4.value =
                        PrefServices.getBool('saveToggleValue');
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
                  onTap: () async {

                    if (int.parse(substractSunsetTime) < 2 ||
                        int.parse(substractSunsetTime) > 120) {
                      settingScreenController.validateSunsetInput(substractSunsetTime);
                      Get.back();
                    }

                    // else if (settingScreenController
                    //             .currentAndSunsetTimeDifference() <
                    //         settingScreenController
                    //             .remainderAndSunsetTimeDifference() &&
                    //     (!settingScreenController
                    //         .currentAndSunsetTimeDifference()
                    //         .isNegative)) {
                    //   print(
                    //       "settingScreenController.currentAndSunsetTimeDifference() :- ${settingScreenController.currentAndSunsetTimeDifference()}");
                    //   print(
                    //       "settingScreenController.remainderAndSunsetTimeDifference() :- ${settingScreenController.remainderAndSunsetTimeDifference()}");
                    //
                    //   PrefServices.setValue('saveToggleValue', false);
                    //   settingScreenController.on4.value =
                    //       PrefServices.getBool('saveToggleValue');
                    //   print(
                    //       "Set Invalid Value :- ${settingScreenController.on4.value}");
                    //   commonFlutterToastMsg(
                    //       'Invalid Value!, Your current time and sunset time difference is less than ${settingScreenController.currentAndSunsetTimeDifference()} min');
                    //   Get.back();
                    // }

                    else {
                      PrefServices.setValue('saveRemainderToggleValue', true);

                      print("Get Value Remainder:- ${PrefServices.getBool('saveRemainderToggleValue')}");
                      settingScreenController.on4.value = PrefServices.getBool('saveRemainderToggleValue');


                      print("settingScreenController.on4.value :- ${settingScreenController.on4.value}");

                      print(
                          "Tommorow time body :- ${DateFormat("yyyy-MM-dd").format(DateTime.now().add(const Duration(days: 1)))}");

                        settingScreenController.remainderNotificationLogic();

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

}

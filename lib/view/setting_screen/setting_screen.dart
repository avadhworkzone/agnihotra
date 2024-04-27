import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:keep_screen_on/keep_screen_on.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
import 'package:sunrise_app/services/prefServices.dart';
import 'package:sunrise_app/utils/color_utils.dart';
import 'package:sunrise_app/utils/image_utils.dart';
import 'package:sunrise_app/utils/string_utils.dart';
import 'package:sunrise_app/view/sunrise_sunset_screen/sunrise_sunset_screen.dart';
import 'package:sunrise_app/viewModel/settings_controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SeetingScreenState();
}

class _SeetingScreenState extends State<SettingsScreen> {

  SettingScreenController settingScreenController = Get.find<SettingScreenController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    settingScreenController.isScreenOn.value =  PrefServices.getBool('keepScreenOn');
    if ( settingScreenController.isScreenOn.value) {
      KeepScreenOn.turnOn();
    }
    settingScreenController.audioPlayer = AudioPlayer();
    settingScreenController. isBellRinging.value = PrefServices.getBool('isBellRinging') ?? false;
    // settingScreenController.startBellForSunriseOrSunset();

    if ( settingScreenController.isBellRinging.value) {
      settingScreenController.startBellForSunriseOrSunset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() =>
          Stack(
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
              Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 12.w),
                      child: CircleAvatar(
                        backgroundColor: ColorUtils.white,
                        radius: 23.r,
                        child: IconButton(
                          onPressed: () {
                            Get.off(SunriseSunetScreen());
                          },
                          icon: const Icon(
                            AssetUtils.backArrowIcon,
                            color: ColorUtils.orange,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 90.h),
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
                                        value: settingScreenController.isScreenOn.value,
                                        onChanged: (value) {
                                          settingScreenController.isScreenOn.value = value;
                                          PrefServices.setValue('keepScreenOn',  settingScreenController.isScreenOn.value);
                                          if (settingScreenController.isScreenOn.value) {
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
                                color: ColorUtils.black,
                                fontWeight: FontWeight.w500,
                                fontSize: 15.sp,
                              ),
                              SizedBox(height: 20.h,),
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
                                        value: settingScreenController.is24Hours.value,
                                        onChanged: (value) {
                                          // setState(() {
                                          settingScreenController.toggleTimeFormat(value);
                                          // });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                StringUtils.timeTxt,
                                color: ColorUtils.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 20.h,),
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
                                        value: settingScreenController.isBellRinging.value,
                                        onChanged: (value) {
                                          settingScreenController.isBellRinging.value = value;
                                          PrefServices.setValue('isBellRinging', settingScreenController.isBellRinging.value);
                                          if (settingScreenController.isBellRinging.value) {
                                            settingScreenController.startBellForSunriseOrSunset();
                                          } else {
                                            settingScreenController.sunriseTimer?.cancel();
                                            settingScreenController.sunsetTimer?.cancel();
                                          }
                                        },
                                        // onChanged: (value) {
                                        //   settingScreenController.isBellRinging.value = value;
                                        //   PrefServices.setValue('isBellRinging', settingScreenController.isBellRinging.value);
                                        //   if (settingScreenController.isBellRinging.value) {
                                        //     settingScreenController.toggleBellFormat();
                                        //   } else {
                                        //     settingScreenController.sunriseTimer.cancel();
                                        //     settingScreenController.sunsetTimer.cancel();
                                        //     }
                                        //   },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                StringUtils.ringsTxt,
                                color: ColorUtils.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 20.h,),
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
                                        value: settingScreenController.isCountDown.value,
                                        onChanged: (value) {
                                          settingScreenController.toggleCountDown(value);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                StringUtils.countDownClockTxt,
                                color: ColorUtils.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 20.h,),
                              SizedBox(
                                height: 30.h,
                                child: Row(
                                  children: [
                                    CustomText(
                                      StringUtils.reminderTxt,
                                      color: ColorUtils.orange,
                                      fontSize: 17.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    const Spacer(),
                                    Transform.scale(
                                      scale: 0.8,
                                      child: Switch(
                                        value: settingScreenController.on4
                                            .value,
                                        onChanged: (value) {
                                          //  setState(() {
                                          settingScreenController.toggle4();
                                          // });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              CustomText(
                                StringUtils.setReminderTxt,
                                color: ColorUtils.black,
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500,
                              ),
                              SizedBox(height: 20.h,),
                              Center(
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 110.w),
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
                                    onTap: () async {},
                                    title: StringUtils.resetBtnTxt,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h,),
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
}
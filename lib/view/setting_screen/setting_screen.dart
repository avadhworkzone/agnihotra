import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sunrise_app/common_Widget/common_button.dart';
import 'package:sunrise_app/common_Widget/common_text.dart';
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

  SettingScreenController settingScreenController = Get.find<
      SettingScreenController>();

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
                              Center(
                                child: SizedBox(
                                  width: 300.w,
                                  child: CustomText(
                                    StringUtils.checkDeviceTimeTxt,
                                    color: ColorUtils.black,
                                    maxLines: 5,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15.sp,
                                    textAlign: TextAlign.center,
                                  ),
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
                                        value: settingScreenController.on.value,
                                        onChanged: (value) {
                                          //setState(() {
                                          settingScreenController.toggle();
                                          // });
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
                                        value: settingScreenController.on2
                                            .value,
                                        onChanged: (value) {
                                          // setState(() {
                                          settingScreenController.toggle2();
                                          // });
                                        },
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